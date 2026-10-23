package com.profitness.dsa;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Queue;
import java.util.Set;

/**
 * Graph data structure representing the Gym Facility Layout and Zone Connectivity.
 * <p>
 * <b>Data Structure:</b> Undirected Graph implemented via an Adjacency List (Map of zone names to neighbor lists).<br>
 * <b>Vertices:</b> Facility zones (e.g., Reception, Cardio Zone, Weight Zone, Stretching Area, Locker Room, Steam Room).<br>
 * <b>Edges:</b> Bidirectional walkways and access corridors connecting adjacent zones.<br>
 * <b>Time Complexities:</b>
 * <ul>
 *   <li>Add Zone: O(1) average hash map insertion.</li>
 *   <li>Add Connection (Edge): O(1) or O(deg(V)) check and append.</li>
 *   <li>Breadth-First Search (BFS): O(V + E) exploring level-by-level using a FIFO queue.</li>
 *   <li>Depth-First Search (DFS): O(V + E) exploring deeply along branches via recursion/backtracking.</li>
 * </ul>
 * <b>Gym Application:</b> Powers interactive gym tours for prospective members, shortest-path guidance
 * between equipment zones, and rapid facility evacuation planning in emergency management.
 * </p>
 */
public class GymGraph {
    private final Map<String, ArrayList<String>> adjacencyList;

    /**
     * Constructs an empty GymGraph.
     */
    public GymGraph() {
        this.adjacencyList = new LinkedHashMap<>();
    }

    /**
     * Adds a physical zone (vertex) to the gym layout if it does not already exist.
     *
     * @param zone Name of the zone (e.g., "Cardio Zone")
     */
    public void addZone(String zone) {
        if (zone != null && !adjacencyList.containsKey(zone)) {
            adjacencyList.put(zone, new ArrayList<>());
        }
    }

    /**
     * Adds a bidirectional corridor / pathway between two gym zones.
     * Automatically registers zones if they were not previously added.
     *
     * @param zone1 The first zone
     * @param zone2 The second zone
     */
    public void addConnection(String zone1, String zone2) {
        if (zone1 == null || zone2 == null) return;

        addZone(zone1);
        addZone(zone2);

        ArrayList<String> neighbors1 = adjacencyList.get(zone1);
        if (!neighbors1.contains(zone2)) {
            neighbors1.add(zone2);
        }

        ArrayList<String> neighbors2 = adjacencyList.get(zone2);
        if (!neighbors2.contains(zone1)) {
            neighbors2.add(zone1);
        }
    }

    /**
     * Populates the standard gym floor layout and connections:
     * <ul>
     *   <li>Reception &harr; Cardio Zone, Locker Room</li>
     *   <li>Cardio Zone &harr; Reception, Weight Zone, Stretching Area</li>
     *   <li>Weight Zone &harr; Cardio Zone, Stretching Area</li>
     *   <li>Stretching Area &harr; Cardio Zone, Weight Zone, Steam Room</li>
     *   <li>Locker Room &harr; Reception, Steam Room</li>
     *   <li>Steam Room &harr; Stretching Area, Locker Room</li>
     * </ul>
     */
    public void buildDefaultGymLayout() {
        adjacencyList.clear();

        // 1. Register all primary zones in order
        addZone("Reception");
        addZone("Cardio Zone");
        addZone("Weight Zone");
        addZone("Stretching Area");
        addZone("Locker Room");
        addZone("Steam Room");

        // 2. Establish bidirectional connections
        addConnection("Reception", "Cardio Zone");
        addConnection("Reception", "Locker Room");
        addConnection("Cardio Zone", "Weight Zone");
        addConnection("Cardio Zone", "Stretching Area");
        addConnection("Weight Zone", "Stretching Area");
        addConnection("Stretching Area", "Steam Room");
        addConnection("Locker Room", "Steam Room");
    }

    /**
     * Performs a Breadth-First Search (BFS) traversal starting from the specified gym zone.
     * Explores all immediate neighbors at the current distance before proceeding to the next level.
     *
     * @param startZone Starting location for the traversal
     * @return a {@link BFSResult} holding the visit order and detailed queue step logs
     */
    public BFSResult bfsTraversal(String startZone) {
        ArrayList<String> visitOrder = new ArrayList<>();
        ArrayList<String> steps = new ArrayList<>();

        if (startZone == null || !adjacencyList.containsKey(startZone)) {
            steps.add("Traversal aborted: Start zone \"" + startZone + "\" does not exist in the gym graph.");
            return new BFSResult(visitOrder, steps);
        }

        // java.util.Queue (LinkedList implementation) is strictly permitted for BFS traversal
        Queue<String> queue = new java.util.LinkedList<>();
        Set<String> visited = new HashSet<>();

        visited.add(startZone);
        queue.add(startZone);
        steps.add("Initialize BFS: Enqueue start zone [" + startZone + "] and mark as visited.");

        while (!queue.isEmpty()) {
            String current = queue.poll();
            visitOrder.add(current);
            steps.add(String.format("Step %d: Dequeue and visit [%s]. Queue after poll: %s",
                    visitOrder.size(), current, queue.toString()));

            ArrayList<String> neighbors = adjacencyList.getOrDefault(current, new ArrayList<>());
            for (String neighbor : neighbors) {
                if (!visited.contains(neighbor)) {
                    visited.add(neighbor);
                    queue.add(neighbor);
                    steps.add(String.format("  -> Discovered unvisited neighbor [%s] adjacent to [%s]. Enqueue [%s].",
                            neighbor, current, neighbor));
                } else {
                    steps.add(String.format("  -> Neighbor [%s] of [%s] has already been visited. Skip.",
                            neighbor, current));
                }
            }
        }

        steps.add("Queue is empty. BFS traversal complete. Total zones visited: " + visitOrder.size());
        return new BFSResult(visitOrder, steps);
    }

    /**
     * Performs a Depth-First Search (DFS) traversal starting from the specified gym zone.
     * Explores as far along each branch as possible before backtracking.
     *
     * @param startZone Starting location for the traversal
     * @return a {@link DFSResult} holding the visit order and detailed recursive step logs
     */
    public DFSResult dfsTraversal(String startZone) {
        ArrayList<String> visitOrder = new ArrayList<>();
        ArrayList<String> steps = new ArrayList<>();

        if (startZone == null || !adjacencyList.containsKey(startZone)) {
            steps.add("Traversal aborted: Start zone \"" + startZone + "\" does not exist in the gym graph.");
            return new DFSResult(visitOrder, steps);
        }

        Set<String> visited = new HashSet<>();
        steps.add("Initialize DFS: Begin recursive exploration starting from [" + startZone + "].");

        dfsRecursive(startZone, visited, visitOrder, steps, 0);

        steps.add("DFS traversal complete. Total zones visited: " + visitOrder.size());
        return new DFSResult(visitOrder, steps);
    }

    private void dfsRecursive(String current, Set<String> visited, ArrayList<String> visitOrder, ArrayList<String> steps, int depth) {
        visited.add(current);
        visitOrder.add(current);

        String indent = "  ".repeat(depth);
        steps.add(String.format("%sStep %d: Visit zone [%s] (Depth %d)",
                indent, visitOrder.size(), current, depth));

        ArrayList<String> neighbors = adjacencyList.getOrDefault(current, new ArrayList<>());
        for (String neighbor : neighbors) {
            if (!visited.contains(neighbor)) {
                steps.add(String.format("%s  -> Advance: [%s] -> [%s]", indent, current, neighbor));
                dfsRecursive(neighbor, visited, visitOrder, steps, depth + 1);
                steps.add(String.format("%s  <- Backtrack: [%s] -> [%s]", indent, neighbor, current));
            } else {
                steps.add(String.format("%s  -> Neighbor [%s] already visited. Skip.", indent, neighbor));
            }
        }
    }

    /**
     * Returns the full adjacency list mapping each zone to its connected neighboring zones.
     *
     * @return Map containing all gym zones and their adjacency lists
     */
    public Map<String, ArrayList<String>> getAdjacencyList() {
        return adjacencyList;
    }

    /**
     * Returns a list of all registered zone names in the gym layout.
     *
     * @return list of zone identifiers
     */
    public ArrayList<String> getZones() {
        return new ArrayList<>(adjacencyList.keySet());
    }

    /**
     * Checks if a zone exists in the graph.
     *
     * @param zone zone name
     * @return true if zone exists, false otherwise
     */
    public boolean hasZone(String zone) {
        return adjacencyList.containsKey(zone);
    }

    /**
     * Returns the degree (number of connected doors / passages) of a given zone.
     *
     * @param zone zone name
     * @return number of adjacent zones, or 0 if zone does not exist
     */
    public int getDegree(String zone) {
        ArrayList<String> neighbors = adjacencyList.get(zone);
        return neighbors != null ? neighbors.size() : 0;
    }
}
