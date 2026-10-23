package com.profitness.dsa;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

/**
 * Central singleton repository and persistence coordinator for all custom Data Structure
 * instances powering the Pro-Fitness Gym Management System.
 * <p>
 * <b>Architectural Role:</b><br>
 * Acts as the single source of truth across the web application. Holds persistent
 * in-memory instances of:
 * <ul>
 *   <li>{@link MemberLinkedList}: Dynamic member profiles and registration list.</li>
 *   <li>{@link CheckInStack}: Real-time gym floor occupancy and LIFO arrival audit.</li>
 *   <li>{@link AppointmentQueue}: Chronological FIFO trainer booking request pipeline.</li>
 *   <li>{@link WorkoutBinaryTree}: Hierarchical workout plan taxonomy and curriculum.</li>
 *   <li>{@link MemberBST}: O(log N) indexed search tree for fast member ID lookups.</li>
 *   <li>{@link GymGraph}: Facility zone topology and pathway connectivity network.</li>
 * </ul>
 * </p>
 * <p>
 * <b>Data Persistence:</b><br>
 * Provides robust CSV file-based serialization and deserialization using
 * {@link BufferedReader} and {@link BufferedWriter}. If CSV data files do not yet exist,
 * it automatically generates realistic sample data so the application is instantly functional.
 * </p>
 * <p>
 * <b>Thread Safety:</b><br>
 * Implements the double-checked locking singleton pattern with thread-safe data directory configuration.
 * </p>
 */
public class DataStore {

    /**
     * Default base directory for persistent CSV data storage.
     * Can be dynamically reconfigured by servlets via {@link #setDataDir(String)}.
     */
    private static volatile String DATA_DIR = "data/";

    private static volatile DataStore instance;

    // Core Data Structures
    private MemberLinkedList members;
    private CheckInStack checkInStack;
    private AppointmentQueue appointmentQueue;
    private WorkoutBinaryTree workoutTree;
    private MemberBST memberBST;
    private GymGraph gymGraph;

    /**
     * Private constructor initializing all data structures and loading stored state.
     */
    private DataStore() {
        this.members = new MemberLinkedList();
        this.checkInStack = new CheckInStack();
        this.appointmentQueue = new AppointmentQueue();
        this.workoutTree = new WorkoutBinaryTree();
        this.memberBST = new MemberBST();
        this.gymGraph = new GymGraph();

        initializeAll();
    }

    /**
     * Retrieves the global singleton instance of DataStore.
     *
     * @return the active DataStore instance
     */
    public static DataStore getInstance() {
        if (instance == null) {
            synchronized (DataStore.class) {
                if (instance == null) {
                    instance = new DataStore();
                }
            }
        }
        return instance;
    }

    /**
     * Configures the physical directory path where CSV files are saved and loaded.
     * Servlets can invoke this in their init() methods using getServletContext().getRealPath("/data/").
     *
     * @param path The absolute or relative filesystem directory path
     */
    public static synchronized void setDataDir(String path) {
        if (path != null && !path.trim().isEmpty()) {
            String clean = path.trim().replace('\\', '/');
            if (!clean.endsWith("/")) {
                clean += "/";
            }
            DATA_DIR = clean;
            File dir = new File(DATA_DIR);
            if (!dir.exists()) {
                dir.mkdirs();
            }
        }
    }

    /**
     * @return current active CSV data directory path
     */
    public static String getDataDir() {
        return DATA_DIR;
    }

    /**
     * Ensures the configured data directory exists on the filesystem.
     */
    private void ensureDataDirectory() {
        File dir = new File(DATA_DIR);
        if (!dir.exists()) {
            dir.mkdirs();
        }
    }

    /**
     * Initializes all data structures by loading CSV files from disk.
     * If data files are missing or empty, seeds realistic default sample records
     * and synchronizes trees and graphs.
     */
    public synchronized void initializeAll() {
        ensureDataDirectory();

        // 1. Load or seed gym members
        loadMembers();
        if (members.isEmpty()) {
            seedDefaultMembers();
            saveMembers();
        }

        // 2. Synchronize BST index from loaded member list
        memberBST.buildFromMemberList(members);

        // 3. Load or seed real-time check-in stack
        loadCheckIns();
        if (checkInStack.isEmpty()) {
            seedDefaultCheckIns();
            saveCheckIns();
        }

        // 4. Load or seed trainer appointments queue
        loadAppointments();
        if (appointmentQueue.isEmpty()) {
            seedDefaultAppointments();
            saveAppointments();
        }

        // 5. Initialize workout curriculum binary tree
        if (workoutTree == null) {
            workoutTree = new WorkoutBinaryTree();
        } else {
            workoutTree.buildDefaultTree();
        }

        // 6. Initialize gym floor connectivity layout graph
        if (gymGraph == null) {
            gymGraph = new GymGraph();
        } else {
            gymGraph.buildDefaultGymLayout();
        }
    }

    // =========================================================================
    // Members CSV Persistence (memberID,name,membershipType,feeStatus)
    // =========================================================================

    /**
     * Saves all members in the linked list to {@code data/members.csv}.
     *
     * @return true if write succeeded, false on I/O error
     */
    public synchronized boolean saveMembers() {
        ensureDataDirectory();
        File file = new File(DATA_DIR, "members.csv");

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            writer.write("memberID,name,membershipType,feeStatus");
            writer.newLine();

            ArrayList<MemberNode> list = members.getAllMembersAsList();
            for (MemberNode m : list) {
                if (m != null) {
                    writer.write(String.format("%d,%s,%s,%s",
                            m.getMemberID(),
                            sanitizeCsv(m.getName()),
                            sanitizeCsv(m.getMembershipType()),
                            sanitizeCsv(m.getFeeStatus())));
                    writer.newLine();
                }
            }
            return true;
        } catch (IOException e) {
            System.err.println("Error saving members to CSV: " + e.getMessage());
            return false;
        }
    }

    /**
     * Loads members from {@code data/members.csv} into {@link MemberLinkedList}.
     * Rebuilds the {@link MemberBST} index upon successful load.
     *
     * @return true if read succeeded, false if file missing or parse error
     */
    public synchronized boolean loadMembers() {
        ensureDataDirectory();
        File file = new File(DATA_DIR, "members.csv");
        if (!file.exists() || !file.isFile()) {
            return false;
        }

        MemberLinkedList loadedList = new MemberLinkedList();

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            boolean isHeader = true;

            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (line.isEmpty()) {
                    continue;
                }

                if (isHeader) {
                    isHeader = false;
                    if (line.toLowerCase().startsWith("memberid")) {
                        continue;
                    }
                }

                String[] parts = line.split(",", -1);
                if (parts.length >= 4) {
                    try {
                        int id = Integer.parseInt(parts[0].trim());
                        String name = parts[1].trim();
                        String type = parts[2].trim();
                        String fee = parts[3].trim();
                        loadedList.addMember(id, name, type, fee);
                    } catch (NumberFormatException nfe) {
                        System.err.println("Skipping malformed member CSV line: " + line);
                    }
                }
            }

            this.members = loadedList;
            if (this.memberBST != null) {
                this.memberBST.buildFromMemberList(this.members);
            }
            return true;
        } catch (IOException e) {
            System.err.println("Error loading members from CSV: " + e.getMessage());
            return false;
        }
    }

    // =========================================================================
    // Check-in Stack CSV Persistence (memberID,memberName,checkInTime)
    // =========================================================================

    /**
     * Saves active check-in stack records to {@code data/checkins.csv}.
     * Preserves chronological LIFO integrity.
     *
     * @return true if write succeeded, false on I/O error
     */
    public synchronized boolean saveCheckIns() {
        ensureDataDirectory();
        File file = new File(DATA_DIR, "checkins.csv");

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            writer.write("memberID,memberName,checkInTime");
            writer.newLine();

            // Export as list (order is top-to-bottom, newest first)
            ArrayList<CheckInNode> list = checkInStack.getAllCheckedInAsList();
            for (CheckInNode c : list) {
                if (c != null) {
                    writer.write(String.format("%d,%s,%s",
                            c.memberID,
                            sanitizeCsv(c.memberName),
                            sanitizeCsv(c.checkInTime)));
                    writer.newLine();
                }
            }
            return true;
        } catch (IOException e) {
            System.err.println("Error saving check-ins to CSV: " + e.getMessage());
            return false;
        }
    }

    /**
     * Loads check-in records from {@code data/checkins.csv} into {@link CheckInStack}.
     * Restores exact LIFO stack ordering.
     *
     * @return true if read succeeded, false if file missing or parse error
     */
    public synchronized boolean loadCheckIns() {
        ensureDataDirectory();
        File file = new File(DATA_DIR, "checkins.csv");
        if (!file.exists() || !file.isFile()) {
            return false;
        }

        ArrayList<CheckInNode> tempNodes = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            boolean isHeader = true;

            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (line.isEmpty()) {
                    continue;
                }

                if (isHeader) {
                    isHeader = false;
                    if (line.toLowerCase().startsWith("memberid")) {
                        continue;
                    }
                }

                String[] parts = line.split(",", -1);
                if (parts.length >= 3) {
                    try {
                        int id = Integer.parseInt(parts[0].trim());
                        String name = parts[1].trim();
                        String time = parts[2].trim();
                        tempNodes.add(new CheckInNode(id, name, time));
                    } catch (NumberFormatException nfe) {
                        System.err.println("Skipping malformed checkin CSV line: " + line);
                    }
                }
            }

            // Since CSV was saved top-to-bottom (newest first), pushing in reverse restores original stack
            CheckInStack newStack = new CheckInStack();
            for (int i = tempNodes.size() - 1; i >= 0; i--) {
                CheckInNode node = tempNodes.get(i);
                newStack.push(node.memberID, node.memberName, node.checkInTime);
            }

            this.checkInStack = newStack;
            return true;
        } catch (IOException e) {
            System.err.println("Error loading check-ins from CSV: " + e.getMessage());
            return false;
        }
    }

    // =========================================================================
    // Appointments Queue CSV Persistence (memberID,memberName,trainerName,requestedTime)
    // =========================================================================

    /**
     * Saves appointment queue requests to {@code data/appointments.csv}.
     * Preserves FIFO chronological order.
     *
     * @return true if write succeeded, false on I/O error
     */
    public synchronized boolean saveAppointments() {
        ensureDataDirectory();
        File file = new File(DATA_DIR, "appointments.csv");

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            writer.write("memberID,memberName,trainerName,requestedTime");
            writer.newLine();

            // Export as list from front to rear
            ArrayList<AppointmentNode> list = appointmentQueue.getAllAppointmentsAsList();
            for (AppointmentNode a : list) {
                if (a != null) {
                    writer.write(String.format("%d,%s,%s,%s",
                            a.memberID,
                            sanitizeCsv(a.memberName),
                            sanitizeCsv(a.requestedTrainer),
                            sanitizeCsv(a.requestedTime)));
                    writer.newLine();
                }
            }
            return true;
        } catch (IOException e) {
            System.err.println("Error saving appointments to CSV: " + e.getMessage());
            return false;
        }
    }

    /**
     * Loads appointment requests from {@code data/appointments.csv} into {@link AppointmentQueue}.
     * Preserves exact FIFO queue ordering.
     *
     * @return true if read succeeded, false if file missing or parse error
     */
    public synchronized boolean loadAppointments() {
        ensureDataDirectory();
        File file = new File(DATA_DIR, "appointments.csv");
        if (!file.exists() || !file.isFile()) {
            return false;
        }

        AppointmentQueue newQueue = new AppointmentQueue();

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            boolean isHeader = true;

            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (line.isEmpty()) {
                    continue;
                }

                if (isHeader) {
                    isHeader = false;
                    if (line.toLowerCase().startsWith("memberid")) {
                        continue;
                    }
                }

                String[] parts = line.split(",", -1);
                if (parts.length >= 4) {
                    try {
                        int id = Integer.parseInt(parts[0].trim());
                        String name = parts[1].trim();
                        String trainer = parts[2].trim();
                        String time = parts[3].trim();
                        newQueue.enqueue(id, name, trainer, time);
                    } catch (NumberFormatException nfe) {
                        System.err.println("Skipping malformed appointment CSV line: " + line);
                    }
                }
            }

            this.appointmentQueue = newQueue;
            return true;
        } catch (IOException e) {
            System.err.println("Error loading appointments from CSV: " + e.getMessage());
            return false;
        }
    }

    // =========================================================================
    // Default Data Seeding
    // =========================================================================

    /**
     * Seeds initial member records if database is empty.
     */
    private void seedDefaultMembers() {
        members.addMember(101, "Rahul Sharma", "Annual", "Paid");
        members.addMember(102, "Pooja Patel", "Monthly", "Paid");
        members.addMember(103, "Amit Verma", "Quarterly", "Pending");
        members.addMember(104, "Sneha Reddy", "VIP", "Paid");
        members.addMember(105, "Rohan Das", "Monthly", "Overdue");
        members.addMember(106, "Ananya Iyer", "Annual", "Paid");
        members.addMember(107, "Vikram Malhotra", "Quarterly", "Paid");
        members.addMember(108, "Deepak Joshi", "Monthly", "Pending");
    }

    /**
     * Seeds initial check-in records if check-in stack is empty.
     */
    private void seedDefaultCheckIns() {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("hh:mm a");
        LocalDateTime now = LocalDateTime.now();

        checkInStack.push(101, "Rahul Sharma", now.minusMinutes(45).format(dtf));
        checkInStack.push(102, "Pooja Patel", now.minusMinutes(30).format(dtf));
        checkInStack.push(104, "Sneha Reddy", now.minusMinutes(15).format(dtf));
        checkInStack.push(106, "Ananya Iyer", now.minusMinutes(5).format(dtf));
    }

    /**
     * Seeds initial appointment requests if appointment queue is empty.
     */
    private void seedDefaultAppointments() {
        appointmentQueue.enqueue(103, "Amit Verma", "Arjun", "09:00 AM");
        appointmentQueue.enqueue(105, "Rohan Das", "Priya", "10:30 AM");
        appointmentQueue.enqueue(107, "Vikram Malhotra", "Vikram", "04:00 PM");
        appointmentQueue.enqueue(108, "Deepak Joshi", "Neha", "05:30 PM");
    }

    /**
     * Resets all in-memory structures to factory defaults and refreshes CSV storage.
     */
    public synchronized void resetToDefaults() {
        this.members = new MemberLinkedList();
        this.checkInStack = new CheckInStack();
        this.appointmentQueue = new AppointmentQueue();
        this.workoutTree = new WorkoutBinaryTree();
        this.memberBST = new MemberBST();
        this.gymGraph = new GymGraph();

        seedDefaultMembers();
        seedDefaultCheckIns();
        seedDefaultAppointments();

        saveMembers();
        saveCheckIns();
        saveAppointments();

        memberBST.buildFromMemberList(members);
        workoutTree.buildDefaultTree();
        gymGraph.buildDefaultGymLayout();
    }

    /**
     * Synchronizes the Member BST index with the current state of MemberLinkedList.
     */
    public synchronized void syncBST() {
        if (memberBST != null && members != null) {
            memberBST.buildFromMemberList(members);
        }
    }

    private String sanitizeCsv(String input) {
        if (input == null) return "";
        return input.replace(",", " ").trim();
    }

    // =========================================================================
    // Getters and Setters
    // =========================================================================

    public MemberLinkedList getMembers() {
        return members;
    }

    public void setMembers(MemberLinkedList members) {
        this.members = members;
        syncBST();
    }

    public CheckInStack getCheckInStack() {
        return checkInStack;
    }

    public void setCheckInStack(CheckInStack checkInStack) {
        this.checkInStack = checkInStack;
    }

    public AppointmentQueue getAppointmentQueue() {
        return appointmentQueue;
    }

    public void setAppointmentQueue(AppointmentQueue appointmentQueue) {
        this.appointmentQueue = appointmentQueue;
    }

    public WorkoutBinaryTree getWorkoutTree() {
        return workoutTree;
    }

    public void setWorkoutTree(WorkoutBinaryTree workoutTree) {
        this.workoutTree = workoutTree;
    }

    public MemberBST getMemberBST() {
        return memberBST;
    }

    public void setMemberBST(MemberBST memberBST) {
        this.memberBST = memberBST;
    }

    public GymGraph getGymGraph() {
        return gymGraph;
    }

    public void setGymGraph(GymGraph gymGraph) {
        this.gymGraph = gymGraph;
    }
}
