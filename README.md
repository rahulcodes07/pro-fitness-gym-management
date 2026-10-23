# Pro-Fitness Gym Management System
> **MCA Semester 1 — Core Data Structures & Algorithms Project**  
> **Student:** Rahul Raj | **Register Number:** 26MCAB57 | **Class:** MCA - B  
> **Faculty Guides:** Prof. Abhinaya S & Prof. Bharathi Mam  
> **Institution:** Kristu Jayanti Institute of Technology  

---

## 🏋️‍♂️ Project Overview

The **Pro-Fitness Gym Management System** is a full-featured Java web application designed to demonstrate the real-world application of foundational Data Structures and Algorithms. Built from scratch without using Java's built-in collection classes (`java.util.LinkedList`, `java.util.Stack`, etc.), it models daily gym operations across four distinct academic phases:

1. **Linear Data Structures:** Dynamic Member CRUD (Singly Linked List), Session Check-In Tracking (Stack LIFO), Trainer Booking (Queue FIFO), and Workout Formula Bracket Validation (Character Stack).
2. **Hierarchical & Graph Structures:** Workout Plan Taxonomy (Binary Tree with Pre/In/Post-order traversals), Fast Member Lookup by ID (Binary Search Tree with decision path logging), and Facility Floor Plan Navigation (Graph using Adjacency List with BFS & DFS).
3. **Searching & Sorting Benchmarks:** Empirical performance comparison between Linear Search ($O(n)$) and Binary Search ($O(\log n)$), and between Insertion Sort ($O(n^2)$) and Merge Sort ($O(n \log n)$).
4. **Algorithmic Problem Solving:** 
   - **Greedy Technique:** Interval Scheduling / Activity Selection maximizing non-overlapping trainer sessions.
   - **Dynamic Programming:** 0/1 Knapsack selecting the optimal exercise routine within a fixed time budget.
   - **Backtracking:** Constraint Satisfaction matching members to specialized trainers without time conflicts.

---

## 🚀 Quick Start Guide

### Prerequisites
- **Java Development Kit (JDK):** Version 17 or higher (tested on JDK 23)
- **Apache Maven:** 3.9+ (located at `C:\maven\apache-maven-3.9.9\`)
- **Apache Tomcat:** 10.1+ (located at `C:\tomcat\apache-tomcat-10.1.60\`)

### 1-Click Launchers (Windows)
- **`run.bat`**: Compiles the project, deploys the WAR to Tomcat, starts the server, and automatically opens the browser.
- **`stop.bat`**: Gracefully stops the Apache Tomcat server.
- **`test.bat`**: Executes the 10-module comprehensive DSA assertion test suite in the terminal.

### Manual Launch via Terminal
```powershell
# 1. Build WAR package
$env:PATH = "C:\maven\apache-maven-3.9.9\bin;$env:PATH"
mvn package -DskipTests

# 2. Deploy to Tomcat
copy target\ProFitnessGym.war C:\tomcat\apache-tomcat-10.1.60\webapps\

# 3. Start Tomcat
$env:CATALINA_HOME = "C:\tomcat\apache-tomcat-10.1.60"
& "$env:CATALINA_HOME\bin\startup.bat"
```
Once started, navigate to:  
👉 **`http://localhost:8090/ProFitnessGym/`**

---

## 🌐 Application Navigation & Live Endpoints

| Module | Data Structure / Algorithm | URL Endpoint | Description |
| :--- | :--- | :--- | :--- |
| **Landing Page** | Web Portal & System Architecture | `/` | Hero section, scroll animations, module cards |
| **Member Management** | Singly Linked List | `/members` | Add, Find, Update, Delete, Display all records |
| **Session Tracking** | Stack (LIFO) | `/checkin` | Live gym floor check-in, pop check-out, peek top |
| **Trainer Appointments** | Queue (FIFO) | `/appointments` | Chronological personal training booking queue |
| **Formula Validator** | Custom Character Stack | `/expression` | Bracket validation `{Sets * (Reps + Weight)}` |
| **Workout Plans** | Binary Tree | `/workout-plans` | Graphical tree hierarchy with Pre/In/Post order |
| **Member Lookup** | Binary Search Tree (BST) | `/bst` | $O(\log n)$ search with visual comparison steps |
| **Zone Navigation** | Graph (Adjacency List) | `/zones` | 6 gym zones map with interactive BFS & DFS |
| **Search & Sort Lab** | Linear/Binary & Merge/Insertion | `/search-sort` | Side-by-side empirical performance metrics |
| **Algorithm Lab** | Greedy, DP, Backtracking | `/algorithms` | Real-time solver for scheduling, knapsack & CSP |

---

## 📊 Complexity Analysis Summary

| Data Structure / Operation | Best Case | Average Case | Worst Case | Space Complexity |
| :--- | :---: | :---: | :---: | :---: |
| **Linked List: Insert (Head)** | $O(1)$ | $O(1)$ | $O(1)$ | $O(1)$ |
| **Linked List: Search / Delete** | $O(1)$ | $O(n)$ | $O(n)$ | $O(1)$ |
| **Stack: Push / Pop / Peek** | $O(1)$ | $O(1)$ | $O(1)$ | $O(1)$ auxiliary |
| **Queue: Enqueue / Dequeue** | $O(1)$ | $O(1)$ | $O(1)$ | $O(1)$ auxiliary |
| **BST: Search / Insert** | $O(1)$ | $O(\log n)$ | $O(n)$ | $O(n)$ total |
| **Binary Tree Traversals** | $O(n)$ | $O(n)$ | $O(n)$ | $O(h)$ call stack |
| **Graph Traversal (BFS / DFS)** | $O(V + E)$ | $O(V + E)$ | $O(V + E)$ | $O(V)$ auxiliary |
| **Linear Search** | $O(1)$ | $O(n)$ | $O(n)$ | $O(1)$ auxiliary |
| **Binary Search (Sorted)** | $O(1)$ | $O(\log n)$ | $O(\log n)$ | $O(1)$ auxiliary |
| **Insertion Sort** | $O(n)$ | $O(n^2)$ | $O(n^2)$ | $O(1)$ auxiliary |
| **Merge Sort** | $O(n \log n)$ | $O(n \log n)$ | $O(n \log n)$ | $O(n)$ auxiliary |
| **Greedy Interval Scheduling** | $O(N \log N)$ | $O(N \log N)$ | $O(N \log N)$ | $O(N)$ auxiliary |
| **0/1 Knapsack (DP)** | $O(N \cdot W)$ | $O(N \cdot W)$ | $O(N \cdot W)$ | $O(N \cdot W)$ table |
| **Backtracking Assigner** | $O(1)$ | Pruned $O(M^N)$ | $O(M^N)$ | $O(N)$ recursion |

---

## 🧪 Testing

Run the automated assertion test suite via CLI:
```powershell
.\test.bat
```
This tests all 10 modules sequentially without requiring a browser or database connection.

---

## 💾 Data Persistence

All runtime modifications are written to and read from CSV files stored in the `data/` directory:
- `data/members.csv`
- `data/checkins.csv`
- `data/appointments.csv`

The `DataStore` singleton automatically seeds sample data if these files are missing or empty on initial boot.
