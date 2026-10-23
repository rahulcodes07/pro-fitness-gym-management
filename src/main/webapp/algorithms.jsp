<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Greedy Scheduler | Pro-Fitness Gym</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;600;700;800&family=Fira+Code:wght@400;600&display=swap" rel="stylesheet">
    
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

        .greedy-rationale {
            background: rgba(0, 212, 255, 0.06);
            border: 1px solid rgba(0, 212, 255, 0.25);
            border-left: 4px solid var(--secondary);
            border-radius: var(--radius-md);
            padding: 1.25rem 1.5rem;
            margin-bottom: 2rem;
            font-size: 0.88rem;
            color: var(--text-secondary);
            line-height: 1.7;
        }

        .greedy-rationale strong {
            color: var(--secondary);
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
                    <span>Home &amp; Overview</span>
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

            <li class="sidebar-heading">Trees &amp; Non-Linear</li>
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
                    <span>Search &amp; Sort Lab</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/algorithms.jsp" class="sidebar-link active">
                    <i class="fa-solid fa-brain"></i>
                    <span>Greedy Scheduler</span>
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
                    <span style="color: var(--text-primary); font-weight: 500;">Greedy Scheduler</span>
                </div>
            </div>

            <div class="header-right">
                <div class="server-badge">
                    <span class="live-dot"></span>
                    <span>Algorithm Engine Active</span>
                </div>
            </div>
        </header>

        <div class="app-content">
            <div class="module-header" data-aos="fade-down">
                <div>
                    <h1 class="module-title">Advanced Algorithm Lab</h1>
                    <div class="module-subtitle">
                        <i class="fa-solid fa-brain"></i> Greedy Activity Selection &mdash; Optimal Trainer Scheduling
                    </div>
                </div>
            </div>

            <!-- Greedy Rationale Label -->
            <div class="greedy-rationale" data-aos="fade-up">
                <i class="fa-solid fa-lightbulb" style="color: var(--secondary); margin-right: 6px;"></i>
                <strong>Why Greedy?</strong> &mdash;
                This module uses the <strong>Greedy Algorithm</strong> paradigm because the trainer scheduling problem maps to the classic
                <strong>Activity Selection Problem</strong> &mdash; choosing the session that finishes earliest always leaves maximum remaining
                time for subsequent sessions, guaranteeing a globally optimal schedule.
            </div>

            <c:if test="${not empty message}">
                <div class="alert alert-success" data-aos="fade-down" style="margin-bottom: 1.5rem;">
                    <div class="alert-content">
                        <i class="fa-solid fa-circle-check"></i>
                        <span>${message}</span>
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger" data-aos="fade-down" style="margin-bottom: 1.5rem;">
                    <div class="alert-content">
                        <i class="fa-solid fa-triangle-exclamation"></i>
                        <span>${errorMessage}</span>
                    </div>
                </div>
            </c:if>

            <!-- ==================== GREEDY SCHEDULER ==================== -->
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
                            <i class="fa-solid fa-sliders"></i> Configure Trainer Capacity
                        </h4>
                        <form action="${pageContext.request.contextPath}/algorithms" method="POST">
                            <input type="hidden" name="action" value="greedy">
                            <div class="form-group">
                                <label class="form-label" for="numTrainers">Trainers On Duty</label>
                                <select name="numTrainers" id="numTrainers" class="form-select">
                                    <option value="1" ${selectedTrainerCount == 1 ? 'selected' : ''}>1 Trainer (Single Resource Maximize)</option>
                                    <option value="2" ${selectedTrainerCount == 2 ? 'selected' : ''}>2 Trainers (Arjun, Priya)</option>
                                    <option value="3" ${selectedTrainerCount == 3 ? 'selected' : ''}>3 Trainers (Arjun, Priya, Vikram)</option>
                                    <option value="4" ${selectedTrainerCount == 4 ? 'selected' : ''}>4 Trainers (+ Neha)</option>
                                    <option value="5" ${selectedTrainerCount == 5 || selectedTrainerCount == null ? 'selected' : ''}>5 Trainers (Full Staff: + Karthik)</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary" style="width: 100%;">
                                <i class="fa-solid fa-bolt"></i> Execute Live Greedy Scheduler
                            </button>
                        </form>
                    </div>

                    <div class="glass-panel" style="display: flex; flex-direction: column; justify-content: center; align-items: flex-start;">
                        <h4 style="font-size: 0.95rem; margin-bottom: 0.5rem; color: var(--secondary);">
                            <i class="fa-solid fa-circle-nodes"></i> How the Engine Solves It
                        </h4>
                        <p style="font-size: 0.82rem; color: var(--text-secondary); margin-bottom: 0.75rem; line-height: 1.5;">
                            1. Incoming sessions are sorted by finish time via custom scratch merge-sort.<br>
                            2. Scans greedily to assign the earliest-finishing request to the earliest free trainer.<br>
                            3. Maximizes gym throughput with zero resource overlaps.
                        </p>
                        <span class="badge badge-paid">Guaranteed Global Optimum</span>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${not empty scheduleResult}">
                        <!-- Live Results from Java Backend -->
                        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 1rem; margin-bottom: 1.5rem;">
                            <div class="metric-tile" style="background: rgba(14, 18, 32, 0.7); border: 1px solid var(--border-subtle); padding: 1rem; border-radius: var(--radius-md); text-align: center;">
                                <div style="font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase;">Total Requests</div>
                                <div style="font-size: 1.7rem; font-weight: 800; color: #fff;">${scheduleResult.totalSessionsRequested}</div>
                            </div>
                            <div class="metric-tile" style="background: rgba(14, 18, 32, 0.7); border: 1px solid rgba(0, 230, 118, 0.3); padding: 1rem; border-radius: var(--radius-md); text-align: center;">
                                <div style="font-size: 0.75rem; color: var(--accent-green); text-transform: uppercase;">Scheduled</div>
                                <div style="font-size: 1.7rem; font-weight: 800; color: var(--accent-green);">${scheduleResult.totalSessionsScheduled}</div>
                            </div>
                            <div class="metric-tile" style="background: rgba(14, 18, 32, 0.7); border: 1px solid rgba(255, 51, 102, 0.3); padding: 1rem; border-radius: var(--radius-md); text-align: center;">
                                <div style="font-size: 0.75rem; color: var(--accent-red); text-transform: uppercase;">Unscheduled (Conflicts)</div>
                                <div style="font-size: 1.7rem; font-weight: 800; color: var(--accent-red);">${scheduleResult.unscheduledSessions.size()}</div>
                            </div>
                        </div>

                        <!-- Scheduled Table -->
                        <h4 style="font-size: 0.95rem; text-transform: uppercase; color: var(--accent-green); letter-spacing: 0.05em; margin-bottom: 0.75rem;">
                            <i class="fa-solid fa-list-check"></i> Confirmed Personal Training Slots
                        </h4>
                        <div class="table-responsive mb-4" style="margin-bottom: 1.5rem;">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Member Name</th>
                                        <th>Assigned Trainer</th>
                                        <th>Time Interval</th>
                                        <th>Duration</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${scheduleResult.scheduledSessions}" var="s" varStatus="st">
                                        <tr>
                                            <td><strong>${st.count}</strong></td>
                                            <td style="color: #fff; font-weight: 600;">${s.memberName}</td>
                                            <td><span class="badge badge-paid">${s.trainerName}</span></td>
                                            <td style="font-family: var(--font-mono); color: var(--secondary);">${s.formattedStartTime} &ndash; ${s.formattedEndTime}</td>
                                            <td>${s.duration} mins</td>
                                            <td><span class="badge badge-success"><i class="fa-solid fa-check"></i> Booked</span></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Step Trace -->
                        <h4 style="font-size: 0.95rem; text-transform: uppercase; color: var(--primary); letter-spacing: 0.05em; margin-bottom: 0.75rem;">
                            <i class="fa-solid fa-terminal"></i> Java Greedy Execution Trace
                        </h4>
                        <div class="step-container animate-steps">
                            <c:forEach items="${scheduleResult.steps}" var="stMsg" varStatus="st">
                                <div class="step-item">
                                    <span class="step-num">Step ${st.count}</span>
                                    <div class="step-desc">${stMsg}</div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <!-- Visual 24h Trainer Schedule Timeline -->
                        <div style="font-size: 0.85rem; font-weight: 700; text-transform: uppercase; color: var(--secondary); letter-spacing: 0.05em;">
                            Trainer Slot Allocation Preview Timeline (06:00 - 22:00)
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
                                <div class="step-desc">Sorted 8 incoming requests by earliest finish time <code>f[i]</code>. First activity [09:00 - 10:00 AM] selected greedily.</div>
                            </div>
                            <div class="step-item">
                                <span class="step-num">Step 2</span>
                                <div class="step-desc">Checked request [09:30 - 10:30 AM]: Assigned to free Trainer Priya.</div>
                            </div>
                            <div class="step-item">
                                <span class="step-num">Step 3</span>
                                <div class="step-desc">Checked request [10:00 - 11:00 AM]: Trainer Arjun is now free (previous ended 10:00) &rarr; Greedily assigned!</div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
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
    </main>
</div>

<!-- Scripts -->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="${pageContext.request.contextPath}/js/app.js"></script>

</body>
</html>

