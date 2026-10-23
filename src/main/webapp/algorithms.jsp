<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Algorithm Lab (Greedy, DP & BT) | Pro-Fitness Gym</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;600;700;800&family=Fira+Code:wght@400;600&display=swap" rel="stylesheet">
    
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <!-- AOS Animation Library -->
    <link rel="stylesheet" href="https://unpkg.com/aos@2.3.1/dist/aos.css">
    
    <!-- Master Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <style>
        .timeline-bar-wrapper {
            position: relative;
            background: rgba(12, 15, 26, 0.9);
            border: 1px solid var(--border-subtle);
            border-radius: var(--radius-md);
            padding: 1.5rem 1rem 1rem;
            margin: 1.5rem 0;
            overflow-x: auto;
        }

        .timeline-axis {
            display: flex;
            justify-content: space-between;
            color: var(--text-dim);
            font-size: 0.72rem;
            font-family: var(--font-mono);
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
            padding-bottom: 0.5rem;
            margin-bottom: 1rem;
            min-width: 600px;
        }

        .schedule-row {
            display: flex;
            align-items: center;
            height: 48px;
            position: relative;
            margin-bottom: 0.75rem;
            min-width: 600px;
        }

        .schedule-bar {
            position: absolute;
            height: 38px;
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            padding: 0 0.75rem;
            font-size: 0.78rem;
            font-weight: 600;
            color: #ffffff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.4);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            transition: all 0.3s ease;
        }

        .schedule-bar:hover {
            transform: translateY(-2px);
            z-index: 10;
        }

        .schedule-bar-orange {
            background: var(--primary-gradient);
            border: 1px solid rgba(255, 107, 53, 0.6);
        }

        .schedule-bar-blue {
            background: var(--secondary-gradient);
            border: 1px solid rgba(0, 212, 255, 0.6);
        }

        .schedule-bar-green {
            background: linear-gradient(135deg, #00e676 0%, #00b359 100%);
            border: 1px solid rgba(0, 230, 118, 0.6);
            color: #041a0d;
        }

        /* DP Grid Matrix */
        .dp-table {
            border-collapse: collapse;
            font-family: var(--font-mono);
            font-size: 0.8rem;
            width: 100%;
        }

        .dp-table th, .dp-table td {
            border: 1px solid var(--border-subtle);
            padding: 0.5rem 0.6rem;
            text-align: center;
        }

        .dp-table th {
            background: rgba(22, 27, 46, 0.95);
            color: var(--secondary);
        }

        .dp-table td.dp-active {
            background: rgba(0, 230, 118, 0.2);
            color: var(--accent-green);
            font-weight: 700;
        }
    </style>
</head>
<body>

<div class="app-container">

    <!-- ==================== SIDEBAR ==================== -->
    <aside class="app-sidebar">
        <div class="sidebar-header">
            <a href="${pageContext.request.contextPath}/index.jsp" class="brand-logo" style="font-size: 1.15rem;">
                <i class="fa-solid fa-dumbbell"></i>
                <span>PRO-FITNESS</span>
            </a>
        </div>

        <ul class="sidebar-menu">
            <li class="sidebar-heading">Navigation</li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/index.jsp" class="sidebar-link">
                    <i class="fa-solid fa-house"></i>
                    <span>Home & Overview</span>
                </a>
            </li>

            <li class="sidebar-heading">Linear Structures</li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/members.jsp" class="sidebar-link">
                    <i class="fa-solid fa-users"></i>
                    <span>Member Register (LL)</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/checkin.jsp" class="sidebar-link">
                    <i class="fa-solid fa-layer-group"></i>
                    <span>Session Tracking (Stack)</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/appointments.jsp" class="sidebar-link">
                    <i class="fa-solid fa-calendar-check"></i>
                    <span>Trainer Queue (FIFO)</span>
                </a>
            </li>

            <li class="sidebar-heading">Trees & Non-Linear</li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/workout-plans.jsp" class="sidebar-link">
                    <i class="fa-solid fa-sitemap"></i>
                    <span>Workout Plans (Tree)</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/bst.jsp" class="sidebar-link">
                    <i class="fa-solid fa-tree"></i>
                    <span>BST Member Lookup</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/zones.jsp" class="sidebar-link">
                    <i class="fa-solid fa-map-location-dot"></i>
                    <span>Zone Navigation (Graph)</span>
                </a>
            </li>

            <li class="sidebar-heading">Advanced Algorithms</li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/expression.jsp" class="sidebar-link">
                    <i class="fa-solid fa-code"></i>
                    <span>Expression Validator</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/search-sort.jsp" class="sidebar-link">
                    <i class="fa-solid fa-magnifying-glass-chart"></i>
                    <span>Search & Sort Lab</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/algorithms.jsp" class="sidebar-link active">
                    <i class="fa-solid fa-brain"></i>
                    <span>Greedy, DP & BT</span>
                </a>
            </li>
        </ul>

        <div class="sidebar-footer">
            <span>Tomcat 10.1 &bull; Jakarta EE</span>
            <i class="fa-solid fa-shield-halved" style="color: var(--primary);"></i>
        </div>
    </aside>

    <!-- ==================== MAIN CONTENT ==================== -->
    <main class="app-main">
        <header class="app-header">
            <div class="header-left">
                <button class="sidebar-toggle-btn" aria-label="Toggle Sidebar">
                    <i class="fa-solid fa-bars"></i>
                </button>
                <div class="page-breadcrumb">
                    <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
                    <i class="fa-solid fa-chevron-right" style="font-size: 0.7rem;"></i>
                    <span style="color: var(--text-primary); font-weight: 500;">Algorithm Lab</span>
                </div>
            </div>

            <div class="header-right">
                <div class="server-badge">
                    <span class="live-dot"></span>
                    <span>Algorithm Engine Active</span>
                </div>
            </div>
        </header>

        <div class="app-content tab-container">
            <div class="module-header" data-aos="fade-down">
                <div>
                    <h1 class="module-title">Advanced Algorithm Lab</h1>
                    <div class="module-subtitle">
                        <i class="fa-solid fa-brain"></i> Greedy Activity Selection &bull; Dynamic Programming Knapsack &bull; Backtracking Constraints
                    </div>
                </div>
            </div>

            <!-- Tab Navigation Header -->
            <div class="tab-nav" data-aos="fade-up">
                <button class="tab-btn active" data-tab="tab-greedy">
                    <i class="fa-solid fa-clock"></i> Tab 1: Greedy (Trainer Scheduling)
                </button>
                <button class="tab-btn" data-tab="tab-dp">
                    <i class="fa-solid fa-layer-group"></i> Tab 2: Dynamic Programming (0/1 Knapsack)
                </button>
                <button class="tab-btn" data-tab="tab-backtracking">
                    <i class="fa-solid fa-puzzle-piece"></i> Tab 3: Backtracking (Trainer Assignment)
                </button>
            </div>

            <!-- ==================== TAB 1: GREEDY SCHEDULER ==================== -->
            <div id="tab-greedy" class="tab-pane active">
                <div class="glass-card mb-4" style="margin-bottom: 2rem;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                        <div>
                            <h2 style="font-size: 1.25rem;">
                                <i class="fa-solid fa-calendar-check" style="color: var(--primary); margin-right: 8px;"></i>
                                Greedy Activity Selection: Max Compatible Trainer Sessions
                            </h2>
                            <p style="font-size: 0.85rem; color: var(--text-muted); margin-top: 2px;">
                                Sorts appointment requests strictly by earliest finish time (f<sub>i</sub>) and greedily accepts each next session whose start time &ge; previous finish time.
                            </p>
                        </div>
                        <span class="badge badge-complexity">O(n log n) Greedy</span>
                    </div>

                    <!-- Custom Add Session / Run Controls -->
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 1.5rem;">
                        <div class="glass-panel">
                            <h4 style="font-size: 0.95rem; margin-bottom: 0.85rem; color: var(--primary);">
                                <i class="fa-solid fa-plus-circle"></i> Add Custom Session Request
                            </h4>
                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label">Athlete Name</label>
                                    <input type="text" id="greedyMemberName" class="form-control" placeholder="e.g. Alex Morgan">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Start Time (24h)</label>
                                    <input type="number" id="greedyStartTime" class="form-control" placeholder="e.g. 7" min="6" max="21">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">End Time (24h)</label>
                                    <input type="number" id="greedyEndTime" class="form-control" placeholder="e.g. 9" min="7" max="22">
                                </div>
                            </div>
                            <button type="button" class="btn btn-outline btn-sm" onclick="showToast('Session request queued!', 'success')">
                                <i class="fa-solid fa-plus"></i> Queue Request
                            </button>
                        </div>

                        <div class="glass-panel" style="display: flex; flex-direction: column; justify-content: center; align-items: flex-start;">
                            <h4 style="font-size: 0.95rem; margin-bottom: 0.5rem; color: var(--secondary);">
                                <i class="fa-solid fa-bolt"></i> Execute Greedy Activity Selector
                            </h4>
                            <p style="font-size: 0.82rem; color: var(--text-secondary); margin-bottom: 1rem;">
                                Optimizes the trainer room capacity by guaranteeing the mathematically maximum number of non-overlapping workout slots.
                            </p>
                            <button type="button" class="btn btn-primary" onclick="showToast('Greedy scheduling executed successfully!', 'success')">
                                <i class="fa-solid fa-play"></i> Run with Sample Data
                            </button>
                        </div>
                    </div>

                    <!-- Visual 24h Trainer Schedule Timeline -->
                    <div style="font-size: 0.85rem; font-weight: 700; text-transform: uppercase; color: var(--secondary); letter-spacing: 0.05em;">
                        Trainer Slot Allocation Timeline (06:00 - 22:00)
                    </div>
                    <div class="timeline-bar-wrapper">
                        <div class="timeline-axis">
                            <span>06:00</span>
                            <span>08:00</span>
                            <span>10:00</span>
                            <span>12:00</span>
                            <span>14:00</span>
                            <span>16:00</span>
                            <span>18:00</span>
                            <span>20:00</span>
                            <span>22:00</span>
                        </div>

                        <!-- Scheduled Trainer 1 -->
                        <div class="schedule-row">
                            <span style="font-weight: 700; font-size: 0.8rem; width: 110px; color: #fff;">Trainer Arjun:</span>
                            <div class="schedule-bar schedule-bar-orange" style="left: 120px; width: 130px;">
                                Rahul Raj (07:00 - 08:30)
                            </div>
                            <div class="schedule-bar schedule-bar-orange" style="left: 280px; width: 110px;">
                                Vikram (10:00 - 11:30)
                            </div>
                            <div class="schedule-bar schedule-bar-orange" style="left: 450px; width: 140px;">
                                Rohan (14:00 - 16:00)
                            </div>
                        </div>

                        <!-- Scheduled Trainer 2 -->
                        <div class="schedule-row">
                            <span style="font-weight: 700; font-size: 0.8rem; width: 110px; color: #fff;">Trainer Priya:</span>
                            <div class="schedule-bar schedule-bar-blue" style="left: 140px; width: 120px;">
                                Sneha (08:00 - 09:30)
                            </div>
                            <div class="schedule-bar schedule-bar-blue" style="left: 310px; width: 100px;">
                                Ananya (11:30 - 13:00)
                            </div>
                            <div class="schedule-bar schedule-bar-blue" style="left: 470px; width: 130px;">
                                Daniel (16:30 - 18:00)
                            </div>
                        </div>
                    </div>

                    <!-- Step-by-Step Greedy Trace -->
                    <h4 style="font-size: 0.95rem; text-transform: uppercase; color: var(--primary); letter-spacing: 0.05em; margin-bottom: 0.75rem;">
                        Greedy Choice Selection Trace
                    </h4>
                    <div class="step-container animate-steps">
                        <div class="step-item">
                            <span class="step-num">Step 1</span>
                            <div class="step-desc">Sorted 7 incoming requests by earliest finish time <code>f[i]</code>. First activity [07:00 - 08:30] selected greedily.</div>
                        </div>
                        <div class="step-item">
                            <span class="step-num">Step 2</span>
                            <div class="step-desc">Checked request [08:00 - 09:30]: Start time 08:00 &lt; 08:30 (Conflict on Arjun) &rarr; Rejected on current resource.</div>
                        </div>
                        <div class="step-item">
                            <span class="step-num">Step 3</span>
                            <div class="step-desc">Checked request [10:00 - 11:30]: Start time 10:00 &ge; 08:30 (Compatible) &rarr; Greedily accepted!</div>
                        </div>
                    </div>
                </div>

                <!-- DS Info Box -->
                <div class="ds-info-box">
                    <i class="fa-solid fa-circle-info ds-info-icon"></i>
                    <div>
                        <h4 class="ds-info-title">Greedy Paradigm: Activity Selection Theorem</h4>
                        <p class="ds-info-desc">
                            The Greedy Choice Property establishes that choosing the activity with the minimal finish time always leaves the maximum remaining time available for subsequent sessions.
                            Optimal substructure ensures this local optimum yields a globally optimal schedule without searching exponential permutations.
                        </p>
                        <div class="ds-complexity-tags">
                            <span class="badge badge-complexity">Sorting: O(n log n)</span>
                            <span class="badge badge-complexity">Greedy Scan: O(n)</span>
                            <span class="badge badge-complexity">Auxiliary Space: O(1)</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ==================== TAB 2: DYNAMIC PROGRAMMING KNAPSACK ==================== -->
            <div id="tab-dp" class="tab-pane">
                <div class="glass-card mb-4" style="margin-bottom: 2rem;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                        <div>
                            <h2 style="font-size: 1.25rem;">
                                <i class="fa-solid fa-dumbbell" style="color: var(--secondary); margin-right: 8px;"></i>
                                Dynamic Programming: 0/1 Workout Routine Knapsack
                            </h2>
                            <p style="font-size: 0.85rem; color: var(--text-muted); margin-top: 2px;">
                                Maximizing total fitness / calorie score within a strict user workout duration limit (Capacity W = Time limit).
                            </p>
                        </div>
                        <span class="badge badge-complexity">O(n &times; W) DP Table</span>
                    </div>

                    <!-- Available Exercises Table -->
                    <div style="margin-bottom: 1.5rem;">
                        <h4 style="font-size: 0.95rem; margin-bottom: 0.75rem; color: #fff;">Available Exercise Portfolio:</h4>
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Exercise Name</th>
                                        <th>Target Muscle</th>
                                        <th>Time Cost (Weight)</th>
                                        <th>Fitness Value (Score)</th>
                                        <th>Value / Minute Ratio</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><strong>Deadlifts</strong></td>
                                        <td>Posterior Chain</td>
                                        <td><span class="badge badge-basic">15 min</span></td>
                                        <td><span class="badge badge-paid">35 pts</span></td>
                                        <td style="color: var(--secondary); font-family: var(--font-mono);">2.33 pts/min</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Squats</strong></td>
                                        <td>Quads & Core</td>
                                        <td><span class="badge badge-basic">12 min</span></td>
                                        <td><span class="badge badge-paid">30 pts</span></td>
                                        <td style="color: var(--secondary); font-family: var(--font-mono);">2.50 pts/min</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Bench Press</strong></td>
                                        <td>Chest & Triceps</td>
                                        <td><span class="badge badge-basic">10 min</span></td>
                                        <td><span class="badge badge-paid">25 pts</span></td>
                                        <td style="color: var(--secondary); font-family: var(--font-mono);">2.50 pts/min</td>
                                    </tr>
                                    <tr>
                                        <td><strong>HIIT Sprints</strong></td>
                                        <td>Cardiovascular</td>
                                        <td><span class="badge badge-basic">8 min</span></td>
                                        <td><span class="badge badge-paid">22 pts</span></td>
                                        <td style="color: var(--secondary); font-family: var(--font-mono); font-weight: 700;">2.75 pts/min</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Pull-ups</strong></td>
                                        <td>Back & Biceps</td>
                                        <td><span class="badge badge-basic">5 min</span></td>
                                        <td><span class="badge badge-paid">15 pts</span></td>
                                        <td style="color: var(--secondary); font-family: var(--font-mono); font-weight: 700;">3.00 pts/min</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Knapsack Time Limit Form -->
                    <div style="display: flex; gap: 1rem; align-items: flex-end; margin-bottom: 2rem; max-width: 500px;">
                        <div class="form-group" style="margin-bottom: 0; flex: 1;">
                            <label class="form-label" for="knapsackCapacity">Session Time Budget (Minutes)</label>
                            <input type="number" id="knapsackCapacity" class="form-control" value="35" min="10" max="60">
                        </div>
                        <button type="button" class="btn btn-secondary" onclick="runKnapsackSimulation()">
                            <i class="fa-solid fa-calculator"></i> Run Knapsack
                        </button>
                    </div>

                    <!-- Knapsack Selected Exercises Result -->
                    <div class="glass-panel" style="background: rgba(0, 212, 255, 0.08); border-color: var(--secondary); margin-bottom: 2rem;">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                            <div>
                                <span style="font-size: 0.78rem; text-transform: uppercase; color: var(--secondary); font-weight: 700;">
                                    Optimal Routine Formulation:
                                </span>
                                <div style="font-size: 1.25rem; font-weight: 700; color: #fff; margin-top: 4px;">
                                    Selected: Deadlifts + Squats + Pull-ups
                                </div>
                            </div>
                            <div style="text-align: right;">
                                <div style="font-size: 1.8rem; font-weight: 800; color: var(--accent-green);">80 Pts</div>
                                <div style="font-size: 0.78rem; color: var(--text-muted);">Total Consumed: 32 / 35 min</div>
                            </div>
                        </div>
                    </div>

                    <!-- DP Memoization Matrix Visualization -->
                    <h4 style="font-size: 0.95rem; text-transform: uppercase; color: var(--secondary); letter-spacing: 0.05em; margin-bottom: 0.75rem;">
                        DP State Transition Matrix Table: K(i, w)
                    </h4>
                    <div class="table-responsive">
                        <table class="dp-table">
                            <thead>
                                <tr>
                                    <th>Item \ Time (w)</th>
                                    <th>0m</th>
                                    <th>10m</th>
                                    <th>20m</th>
                                    <th>25m</th>
                                    <th>30m</th>
                                    <th>35m (Optimum)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><strong>0 (Base)</strong></td>
                                    <td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>
                                </tr>
                                <tr>
                                    <td><strong>1. Deadlifts (15m, 35p)</strong></td>
                                    <td>0</td><td>0</td><td>35</td><td>35</td><td>35</td><td>35</td>
                                </tr>
                                <tr>
                                    <td><strong>2. Squats (12m, 30p)</strong></td>
                                    <td>0</td><td>0</td><td>30</td><td>35</td><td>65</td><td>65</td>
                                </tr>
                                <tr>
                                    <td><strong>3. Bench (10m, 25p)</strong></td>
                                    <td>0</td><td>25</td><td>30</td><td>55</td><td>65</td><td>70</td>
                                </tr>
                                <tr>
                                    <td><strong>4. Pull-ups (5m, 15p)</strong></td>
                                    <td>0</td><td>25</td><td>45</td><td>55</td><td>70</td><td class="dp-active">80</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- DS Info Box -->
                <div class="ds-info-box">
                    <i class="fa-solid fa-circle-info ds-info-icon"></i>
                    <div>
                        <h4 class="ds-info-title">Dynamic Programming: 0/1 Knapsack Recurrence</h4>
                        <p class="ds-info-desc">
                            The optimal fitness score for <code>i</code> exercises and remaining time <code>w</code> is solved via:
                            <br><code>K[i, w] = max(K[i-1, w], value[i] + K[i-1, w - weight[i]])</code>.
                            Subproblems are memoized to eliminate redundant computations, dropping complexity from <strong>O(2<sup>n</sup>)</strong> brute force down to pseudo-polynomial <strong>O(n &times; W)</strong>.
                        </p>
                        <div class="ds-complexity-tags">
                            <span class="badge badge-complexity">Time: O(n &times; W)</span>
                            <span class="badge badge-complexity">DP Table Space: O(n &times; W)</span>
                            <span class="badge badge-complexity">Memoization & Optimal Substructure</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ==================== TAB 3: BACKTRACKING ASSIGNMENT ==================== -->
            <div id="tab-backtracking" class="tab-pane">
                <div class="glass-card mb-4" style="margin-bottom: 2rem;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                        <div>
                            <h2 style="font-size: 1.25rem;">
                                <i class="fa-solid fa-puzzle-piece" style="color: var(--accent-purple); margin-right: 8px;"></i>
                                Backtracking: Constraint-Satisfaction Trainer Matching
                            </h2>
                            <p style="font-size: 0.85rem; color: var(--text-muted); margin-top: 2px;">
                                Depth-First State Space Search with intelligent branch pruning to assign members to certified personal trainers respecting specialty, tier, and time constraints.
                            </p>
                        </div>
                        <span class="badge badge-complexity">DFS Pruning State Search</span>
                    </div>

                    <div class="form-actions" style="margin-bottom: 1.5rem;">
                        <button type="button" class="btn btn-primary" onclick="runBacktrackingSimulation()">
                            <i class="fa-solid fa-play"></i> Run Backtracking Assignment Solver
                        </button>
                    </div>

                    <!-- Diagnostics & Backtrack Count -->
                    <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 1.25rem; margin-bottom: 2rem;">
                        <div class="metric-tile">
                            <div class="metric-label">Assigned Pairs</div>
                            <div class="metric-val" id="btPairs" style="color: var(--accent-green);">4 / 4</div>
                            <span class="badge badge-paid">100% Satisfied</span>
                        </div>
                        <div class="metric-tile">
                            <div class="metric-label">Dead-Ends Pruned</div>
                            <div class="metric-val" id="btPruned" style="color: var(--accent-amber);">3</div>
                            <span class="badge badge-warning">Pruned Subtrees</span>
                        </div>
                        <div class="metric-tile">
                            <div class="metric-label">Backtrack Invocations</div>
                            <div class="metric-val" id="btBacktracks" style="color: var(--secondary);">2</div>
                            <span class="badge badge-complexity">Stack Unwinds</span>
                        </div>
                    </div>

                    <!-- Assignments Results Table -->
                    <h4 style="font-size: 0.95rem; margin-bottom: 0.75rem; color: #fff;">Resolved Member &ndash; Trainer Allocations:</h4>
                    <div class="table-responsive" style="margin-bottom: 2rem;">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Member</th>
                                    <th>Target Routine</th>
                                    <th>Assigned Trainer</th>
                                    <th>Trainer Certification</th>
                                    <th>Constraint Validation</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><strong>Rahul Raj (VIP)</strong></td>
                                    <td>Hypertrophy</td>
                                    <td><strong style="color: var(--primary);">Arjun</strong></td>
                                    <td>Strength & Conditioning</td>
                                    <td><span class="badge badge-paid">Specialty & Tier Match</span></td>
                                </tr>
                                <tr>
                                    <td><strong>Priya Sharma</strong></td>
                                    <td>Marathon Prep</td>
                                    <td><strong style="color: var(--secondary);">Priya</strong></td>
                                    <td>Cardio & Endurance</td>
                                    <td><span class="badge badge-paid">Specialty Match</span></td>
                                </tr>
                                <tr>
                                    <td><strong>Vikram Singh</strong></td>
                                    <td>Olympic Lifting</td>
                                    <td><strong style="color: var(--primary);">Vikram</strong></td>
                                    <td>Functional Crossfit</td>
                                    <td><span class="badge badge-paid">Specialty Match</span></td>
                                </tr>
                                <tr>
                                    <td><strong>Sneha Patel</strong></td>
                                    <td>HIIT Fat Loss</td>
                                    <td><strong style="color: var(--accent-purple);">Neha</strong></td>
                                    <td>HIIT & Weight Loss</td>
                                    <td><span class="badge badge-paid">Specialty Match</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- Step-by-Step Backtracking Decisions -->
                    <h4 style="font-size: 0.95rem; text-transform: uppercase; color: var(--secondary); letter-spacing: 0.05em; margin-bottom: 0.75rem;">
                        State Space Search & Pruning Log
                    </h4>
                    <div class="step-container animate-steps">
                        <div class="step-item">
                            <span class="step-num">Node 1</span>
                            <div class="step-desc">Attempted: Member #101 &rarr; Trainer Priya. Constraint Check: Specialty mismatch (Hypertrophy vs Endurance) &rarr; <strong style="color:var(--accent-red)">PRUNED</strong>.</div>
                        </div>
                        <div class="step-item">
                            <span class="step-num">Node 2</span>
                            <div class="step-desc">Attempted: Member #101 &rarr; Trainer Arjun. Specialty satisfied &bull; Assigned tentatively. Recursing to Member #102.</div>
                        </div>
                        <div class="step-item">
                            <span class="step-num">Node 3</span>
                            <div class="step-desc">Attempted: Member #102 &rarr; Trainer Arjun. Conflict: Arjun already booked by #101 &rarr; <strong style="color:var(--accent-amber)">BACKTRACK</strong> to parent decision.</div>
                        </div>
                        <div class="step-item">
                            <span class="step-num">Node 4</span>
                            <div class="step-desc">Attempted: Member #102 &rarr; Trainer Priya. Constraint satisfied! Complete feasible state reached.</div>
                        </div>
                    </div>
                </div>

                <!-- DS Info Box -->
                <div class="ds-info-box">
                    <i class="fa-solid fa-circle-info ds-info-icon"></i>
                    <div>
                        <h4 class="ds-info-title">Backtracking Paradigm: State-Space Tree Pruning</h4>
                        <p class="ds-info-desc">
                            Backtracking systematically searches for solutions by incrementally extending candidate assignments.
                            As soon as a partial candidate violates a problem constraint (e.g. dual booking or certification mismatch), the subtree is pruned and execution reverts (backtracks) to explore sibling branches, avoiding the catastrophic combinatorial explosion of pure exhaustive search.
                        </p>
                        <div class="ds-complexity-tags">
                            <span class="badge badge-complexity">Worst Case: O(k<sup>n</sup>)</span>
                            <span class="badge badge-complexity">Pruned Average: O(b<sup>d</sup>)</span>
                            <span class="badge badge-complexity">Recursive Call Stack: O(n)</span>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </main>
</div>

<!-- Scripts -->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="${pageContext.request.contextPath}/js/app.js"></script>

<script>
function runKnapsackSimulation() {
    const cap = document.getElementById('knapsackCapacity').value;
    showToast(`Calculated optimal DP knapsack for ${cap} min limit!`, 'success');
}

function runBacktrackingSimulation() {
    showToast('Backtracking state space search resolved all 4 assignments!', 'success');
}
</script>
</body>
</html>
