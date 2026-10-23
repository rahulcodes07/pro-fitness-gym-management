package com.profitness.dsa;

import java.util.ArrayList;

public class DSATest {
    public static void main(String[] args) {
        System.out.println("=== 1. TESTING MEMBER LINKED LIST ===");
        MemberLinkedList list = new MemberLinkedList();
        assert list.addMember(101, "Alice", "Annual", "Paid");
        assert list.addMember(102, "Bob", "Monthly", "Pending");
        assert list.addMember(103, "Charlie", "VIP", "Paid");
        assert !list.addMember(101, "Duplicate Alice", "Monthly", "Pending") : "Should reject duplicate ID";
        assert list.getSize() == 3;
        assert list.findMemberById(102) != null;
        assert list.findMemberById(999) == null;
        assert list.updateMember(102, "Bob Updated", "Annual", "Paid");
        assert list.findMemberById(102).getName().equals("Bob Updated");
        assert list.removeMemberById(102);
        assert list.getSize() == 2;
        assert list.findMemberById(102) == null;

        MemberNode[] arr = list.toArray();
        assert arr.length == 2;
        list.rebuildFromArray(arr);
        assert list.getSize() == 2;
        System.out.println("MemberLinkedList passed!");

        System.out.println("\n=== 2. TESTING CHECK-IN STACK ===");
        CheckInStack stack = new CheckInStack();
        stack.push(101, "Alice", "09:00");
        stack.push(103, "Charlie", "09:15");
        assert stack.getSize() == 2;
        assert stack.isMemberCheckedIn(103);
        assert stack.isMemberCheckedIn(101);
        assert !stack.isMemberCheckedIn(999);
        assert stack.peek().getMemberID() == 103;
        CheckInNode popped = stack.pop();
        assert popped.getMemberID() == 103;
        assert stack.getSize() == 1;
        assert !stack.isMemberCheckedIn(103);
        System.out.println("CheckInStack passed!");

        System.out.println("\n=== 3. TESTING APPOINTMENT QUEUE ===");
        AppointmentQueue queue = new AppointmentQueue();
        queue.enqueue(101, "Alice", "Trainer John", "10:00 AM");
        queue.enqueue(103, "Charlie", "Trainer Sarah", "11:00 AM");
        assert queue.getSize() == 2;
        assert queue.peek().getMemberID() == 101;
        AppointmentNode dequeued = queue.dequeue();
        assert dequeued.getMemberID() == 101;
        assert queue.peek().getMemberID() == 103;
        assert queue.getSize() == 1;
        System.out.println("AppointmentQueue passed!");

        System.out.println("\n=== 4. TESTING EXPRESSION VALIDATOR ===");
        ExpressionValidator validator = new ExpressionValidator();
        ValidationResult res1 = validator.validateExpression("{Sets * (Reps + Weight)}");
        assert res1.isValid() : "Expected valid formula";
        System.out.println("Valid formula message: " + res1.getMessage());

        ValidationResult res2 = validator.validateExpression("{Sets * (Reps + Weight}");
        assert !res2.isValid() : "Expected invalid formula missing closing";
        System.out.println("Invalid formula message: " + res2.getMessage());

        ValidationResult res3 = validator.validateExpression("( [ { } ] )");
        assert res3.isValid();

        ValidationResult res4 = validator.validateExpression("( [ } ] )");
        assert !res4.isValid();
        System.out.println("ExpressionValidator passed!");

        System.out.println("\n=== 5. TESTING WORKOUT BINARY TREE ===");
        WorkoutBinaryTree tree = new WorkoutBinaryTree();
        ArrayList<String> pre = tree.preorderTraversal();
        ArrayList<String> in = tree.inorderTraversal();
        ArrayList<String> post = tree.postorderTraversal();
        System.out.println("Preorder: " + pre);
        System.out.println("Inorder: " + in);
        System.out.println("Postorder: " + post);
        assert pre.contains("Workout Plans");
        assert pre.contains("HIIT");
        assert in.contains("Chest");
        assert tree.preorderSteps().size() > 5;
        System.out.println("WorkoutBinaryTree passed!");

        System.out.println("\n=== 6. TESTING MEMBER BST ===");
        MemberBST bst = new MemberBST();
        bst.insert(50, "Member 50");
        bst.insert(25, "Member 25");
        bst.insert(75, "Member 75");
        bst.insert(10, "Member 10");
        bst.insert(30, "Member 30");

        BSTSearchResult search1 = bst.search(30);
        assert search1.isFound();
        assert search1.getFound().getMemberID() == 30;
        System.out.println("Search 30 path: " + search1.getSearchPath());

        BSTSearchResult search2 = bst.search(99);
        assert !search2.isFound();
        System.out.println("Search 99 comparisons: " + search2.getComparisons());

        // Deletion tests
        assert bst.delete(10) : "Delete leaf node";
        assert !bst.search(10).isFound();
        assert bst.delete(25) : "Delete node with right child";
        assert !bst.search(25).isFound();
        assert bst.delete(50) : "Delete root with 2 children";
        assert !bst.search(50).isFound();
        assert bst.search(75).isFound();

        // Inorder sorted test
        bst.clear();
        bst.insert(40, "Fourty");
        bst.insert(20, "Twenty");
        bst.insert(60, "Sixty");
        bst.insert(10, "Ten");
        bst.insert(30, "Thirty");
        ArrayList<BSTNode> inorder = bst.inorderTraversal();
        int prev = -1;
        for (BSTNode n : inorder) {
            assert n.getMemberID() > prev;
            prev = n.getMemberID();
        }
        System.out.println("MemberBST passed!");

        System.out.println("\n=== 7. TESTING GYM GRAPH ===");
        GymGraph graph = new GymGraph();
        graph.buildDefaultGymLayout();
        assert graph.getZones().size() == 6;
        BFSResult bfs = graph.bfsTraversal("Reception");
        System.out.println("BFS order from Reception: " + bfs.getVisitOrder());
        assert bfs.getVisitOrder().size() == 6;

        DFSResult dfs = graph.dfsTraversal("Reception");
        System.out.println("DFS order from Reception: " + dfs.getVisitOrder());
        assert dfs.getVisitOrder().size() == 6;
        System.out.println("\n=== 8. TESTING SEARCHING ALGORITHMS ===");
        MemberNode[] searchArray = new MemberNode[] {
            new MemberNode(10, "Ten", "Monthly", "Paid"),
            new MemberNode(20, "Twenty", "Annual", "Paid"),
            new MemberNode(30, "Thirty", "VIP", "Paid"),
            new MemberNode(40, "Fourty", "Monthly", "Paid"),
            new MemberNode(50, "Fifty", "Annual", "Paid")
        };
        SearchResult linFound = SearchAlgorithms.linearSearch(searchArray, 30);
        assert linFound.isFound() : "Linear search should find ID 30";
        assert linFound.getComparisons() == 3 : "Linear search should take 3 comparisons";
        SearchResult linNotFound = SearchAlgorithms.linearSearch(searchArray, 99);
        assert !linNotFound.isFound() : "Linear search should not find ID 99";
        assert linNotFound.getComparisons() == 5;

        SearchResult binFound = SearchAlgorithms.binarySearch(searchArray, 30);
        assert binFound.isFound() : "Binary search should find ID 30";
        assert binFound.getComparisons() == 1 : "Binary search should find mid (index 2 = 30) in 1 comparison";
        SearchResult binNotFound = SearchAlgorithms.binarySearch(searchArray, 99);
        assert !binNotFound.isFound();
        System.out.println("SearchAlgorithms passed!");

        System.out.println("\n=== 9. TESTING SORTING ALGORITHMS ===");
        MemberNode[] unsorted = new MemberNode[] {
            new MemberNode(50, "Fifty", "A", "P"),
            new MemberNode(20, "Twenty", "A", "P"),
            new MemberNode(40, "Fourty", "A", "P"),
            new MemberNode(10, "Ten", "A", "P"),
            new MemberNode(30, "Thirty", "A", "P")
        };
        SortResult insertRes = SortAlgorithms.insertionSort(unsorted);
        MemberNode[] insSorted = insertRes.getSortedArray();
        for (int i = 0; i < insSorted.length - 1; i++) {
            assert insSorted[i].getMemberID() < insSorted[i + 1].getMemberID();
        }

        SortResult mergeRes = SortAlgorithms.mergeSort(unsorted);
        MemberNode[] mrgSorted = mergeRes.getSortedArray();
        for (int i = 0; i < mrgSorted.length - 1; i++) {
            assert mrgSorted[i].getMemberID() < mrgSorted[i + 1].getMemberID();
        }
        System.out.println("SortAlgorithms passed!");

        System.out.println("\n=== 10. TESTING GREEDY ACTIVITY SELECTION ===");
        ArrayList<TrainerSession> sessions = new ArrayList<>();
        sessions.add(new TrainerSession("Alice", "T1", 540, 600)); // 9:00 - 10:00
        sessions.add(new TrainerSession("Bob", "T1", 570, 630));   // 9:30 - 10:30 (overlaps)
        sessions.add(new TrainerSession("Charlie", "T1", 600, 660));// 10:00 - 11:00
        ScheduleResult sched = GreedyScheduler.schedule(sessions, 1);
        assert sched.getTotalSessionsScheduled() == 2 : "1 trainer should take Alice and Charlie";
        assert sched.getUnscheduledSessions().size() == 1 : "Bob should be unscheduled";
        System.out.println("GreedyScheduler passed!");

        System.out.println("\n>>> ALL 4 PHASES TESTED AND PASSED 100% SUCCESSFULLY! <<<");
    }
}
