<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trainer Appointments (Queue FIFO) | Pro-Fitness Gym</title>
    
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
                <a href="${pageContext.request.contextPath}/appointments.jsp" class="sidebar-link active">
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
                <a href="${pageContext.request.contextPath}/algorithms.jsp" class="sidebar-link">
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
                    <span style="color: var(--text-primary); font-weight: 500;">Trainer Appointments</span>
                </div>
            </div>

            <div class="header-right">
                <div class="server-badge">
                    <span class="live-dot"></span>
                    <span>Queue FIFO Active</span>
                </div>
            </div>
        </header>

        <div class="app-content">
            <div class="module-header" data-aos="fade-down">
                <div>
                    <h1 class="module-title">Trainer Appointments</h1>
                    <div class="module-subtitle">
                        <i class="fa-solid fa-calendar-check"></i> Powered by FIFO Queue (`AppointmentQueue`)
                    </div>
                </div>
            </div>

            <!-- Alerts -->
            <c:if test="${not empty param.message or not empty message}">
                <div class="alert alert-success">
                    <div class="alert-content">
                        <i class="fa-solid fa-circle-check"></i>
                        <span>${not empty message ? message : param.message}</span>
                    </div>
                    <button class="alert-close"><i class="fa-solid fa-xmark"></i></button>
                </div>
            </c:if>

            <c:if test="${not empty param.error or not empty error}">
                <div class="alert alert-error">
                    <div class="alert-content">
                        <i class="fa-solid fa-triangle-exclamation"></i>
                        <span>${not empty error ? error : param.error}</span>
                    </div>
                    <button class="alert-close"><i class="fa-solid fa-xmark"></i></button>
                </div>
            </c:if>

            <!-- Horizontal Queue Visualizer -->
            <div class="glass-card mb-4" data-aos="fade-up" style="margin-bottom: 2rem;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                    <h3 style="font-size: 1.15rem;">
                        <i class="fa-solid fa-people-line" style="color: var(--secondary); margin-right: 8px;"></i>
                        Queue Flow Conveyor (FIFO Pipeline)
                    </h3>
                    <span class="badge badge-ds">&larr; SERVICE FLOW (FRONT &larr; REAR)</span>
                </div>

                <div class="queue-container">
                    <!-- Front Marker -->
                    <div class="queue-marker marker-front">
                        <i class="fa-solid fa-angles-left" style="font-size: 1.5rem;"></i>
                        <span>FRONT (DEQUEUE)</span>
                    </div>

                    <!-- Items -->
                    <div class="queue-items-wrapper">
                        <c:choose>
                            <c:when test="${not empty appointments}">
                                <c:forEach items="${appointments}" var="a" varStatus="loop">
                                    <div class="queue-card ${loop.first ? 'is-front' : (loop.last ? 'is-rear' : '')}">
                                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.35rem;">
                                            <span style="font-weight: 700; color: #fff;">#${a.memberID}</span>
                                            <c:if test="${loop.first}">
                                                <span class="badge badge-paid" style="font-size: 0.65rem;">NEXT</span>
                                            </c:if>
                                            <c:if test="${loop.last and !loop.first}">
                                                <span class="badge badge-premium" style="font-size: 0.65rem;">REAR</span>
                                            </c:if>
                                        </div>
                                        <div style="font-size: 0.9rem; font-weight: 600; color: #fff;">${a.memberName}</div>
                                        <div style="font-size: 0.78rem; color: var(--secondary); margin-top: 4px;">
                                            <i class="fa-solid fa-dumbbell"></i> ${a.requestedTrainer}
                                        </div>
                                        <div style="font-size: 0.75rem; color: var(--text-muted); margin-top: 2px;">
                                            <i class="fa-regular fa-clock"></i> ${a.requestedTime}
                                        </div>
                                    </div>
                                    <c:if test="${!loop.last}">
                                        <div style="color: var(--secondary); font-size: 1.1rem;">&larr;</div>
                                    </c:if>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <!-- Sample Queue State for preview -->
                                <div class="queue-card is-front">
                                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.35rem;">
                                        <span style="font-weight: 700; color: #fff;">#101</span>
                                        <span class="badge badge-paid" style="font-size: 0.65rem;">NEXT</span>
                                    </div>
                                    <div style="font-size: 0.9rem; font-weight: 600; color: #fff;">Rahul Raj</div>
                                    <div style="font-size: 0.78rem; color: var(--secondary); margin-top: 4px;">
                                        <i class="fa-solid fa-dumbbell"></i> Arjun
                                    </div>
                                    <div style="font-size: 0.75rem; color: var(--text-muted); margin-top: 2px;">
                                        <i class="fa-regular fa-clock"></i> 07:00 AM
                                    </div>
                                </div>

                                <div style="color: var(--secondary); font-size: 1.1rem;">&larr;</div>

                                <div class="queue-card">
                                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.35rem;">
                                        <span style="font-weight: 700; color: #fff;">#102</span>
                                    </div>
                                    <div style="font-size: 0.9rem; font-weight: 600; color: #fff;">Priya Sharma</div>
                                    <div style="font-size: 0.78rem; color: var(--secondary); margin-top: 4px;">
                                        <i class="fa-solid fa-dumbbell"></i> Priya
                                    </div>
                                    <div style="font-size: 0.75rem; color: var(--text-muted); margin-top: 2px;">
                                        <i class="fa-regular fa-clock"></i> 08:00 AM
                                    </div>
                                </div>

                                <div style="color: var(--secondary); font-size: 1.1rem;">&larr;</div>

                                <div class="queue-card is-rear">
                                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.35rem;">
                                        <span style="font-weight: 700; color: #fff;">#103</span>
                                        <span class="badge badge-premium" style="font-size: 0.65rem;">REAR</span>
                                    </div>
                                    <div style="font-size: 0.9rem; font-weight: 600; color: #fff;">Vikram Singh</div>
                                    <div style="font-size: 0.78rem; color: var(--secondary); margin-top: 4px;">
                                        <i class="fa-solid fa-dumbbell"></i> Vikram
                                    </div>
                                    <div style="font-size: 0.75rem; color: var(--text-muted); margin-top: 2px;">
                                        <i class="fa-regular fa-clock"></i> 09:30 AM
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Rear Marker -->
                    <div class="queue-marker marker-rear">
                        <i class="fa-solid fa-arrow-left" style="font-size: 1.5rem;"></i>
                        <span>REAR (ENQUEUE)</span>
                    </div>
                </div>
            </div>

            <!-- Two Column Controls: Enqueue & Dequeue -->
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-bottom: 2rem;">
                <!-- Enqueue Card -->
                <div class="glass-card" data-aos="fade-right">
                    <h3 style="font-size: 1.15rem; margin-bottom: 1.25rem;">
                        <i class="fa-solid fa-calendar-plus" style="color: var(--primary); margin-right: 8px;"></i>
                        Request Appointment (Enqueue)
                    </h3>

                    <form action="${pageContext.request.contextPath}/appointments" method="POST" data-validate>
                        <input type="hidden" name="action" value="request">
                        
                        <div class="form-group">
                            <label class="form-label" for="memberID">Member ID</label>
                            <input type="number" id="memberID" name="memberID" class="form-control" placeholder="e.g. 101" required min="1">
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label" for="trainer">Certified Trainer</label>
                                <select id="trainer" name="trainer" class="form-select" required>
                                    <option value="Arjun">Arjun (Strength & Conditioning)</option>
                                    <option value="Priya">Priya (Cardio & Endurance)</option>
                                    <option value="Vikram">Vikram (Functional Crossfit)</option>
                                    <option value="Neha">Neha (HIIT & Weight Loss)</option>
                                    <option value="Karthik">Karthik (Flexibility & Rehab)</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="timeSlot">Time Slot</label>
                                <select id="timeSlot" name="timeSlot" class="form-select" required>
                                    <option value="06:00 AM">06:00 AM</option>
                                    <option value="07:00 AM" selected>07:00 AM</option>
                                    <option value="08:30 AM">08:30 AM</option>
                                    <option value="05:00 PM">05:00 PM</option>
                                    <option value="06:30 PM">06:30 PM</option>
                                    <option value="07:30 PM">07:30 PM</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary" style="width: 100%;">
                                <i class="fa-solid fa-plus-circle"></i> Enqueue Appointment Request
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Dequeue & Peek Card -->
                <div class="glass-card" data-aos="fade-left">
                    <h3 style="font-size: 1.15rem; margin-bottom: 1.25rem;">
                        <i class="fa-solid fa-bell-concierge" style="color: var(--secondary); margin-right: 8px;"></i>
                        Next in Line & Processing
                    </h3>

                    <c:choose>
                        <c:when test="${not empty nextAppointment}">
                            <div class="glass-panel" style="background: rgba(0, 230, 118, 0.08); border-color: var(--accent-green); margin-bottom: 1.5rem;">
                                <div style="display: flex; justify-content: space-between; align-items: center;">
                                    <div>
                                        <div style="font-size: 0.78rem; text-transform: uppercase; color: var(--accent-green); font-weight: 700; letter-spacing: 0.05em;">
                                            Current Front of Queue (Peek)
                                        </div>
                                        <div style="font-weight: 700; font-size: 1.15rem; color: #fff; margin-top: 4px;">
                                            #${nextAppointment.memberID} - ${nextAppointment.memberName}
                                        </div>
                                        <div style="font-size: 0.85rem; color: var(--text-secondary); margin-top: 4px;">
                                            Trainer: <strong style="color: #fff;">${nextAppointment.requestedTrainer}</strong> &bull; Slot: <strong style="color: #fff;">${nextAppointment.requestedTime}</strong>
                                        </div>
                                    </div>
                                    <span class="badge badge-paid">READY</span>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="glass-panel" style="background: rgba(0, 230, 118, 0.08); border-color: var(--accent-green); margin-bottom: 1.5rem;">
                                <div style="display: flex; justify-content: space-between; align-items: center;">
                                    <div>
                                        <div style="font-size: 0.78rem; text-transform: uppercase; color: var(--accent-green); font-weight: 700; letter-spacing: 0.05em;">
                                            Current Front of Queue (Peek)
                                        </div>
                                        <div style="font-weight: 700; font-size: 1.15rem; color: #fff; margin-top: 4px;">
                                            #101 - Rahul Raj
                                        </div>
                                        <div style="font-size: 0.85rem; color: var(--text-secondary); margin-top: 4px;">
                                            Trainer: <strong style="color: #fff;">Arjun</strong> &bull; Slot: <strong style="color: #fff;">07:00 AM</strong>
                                        </div>
                                    </div>
                                    <span class="badge badge-paid">READY</span>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <form action="${pageContext.request.contextPath}/appointments" method="POST">
                        <input type="hidden" name="action" value="process">
                        <button type="submit" class="btn btn-success" style="width: 100%; margin-bottom: 0.75rem;">
                            <i class="fa-solid fa-check"></i> Process & Dequeue Next Appointment
                        </button>
                    </form>
                </div>
            </div>

            <!-- DS Info Box -->
            <div class="ds-info-box" data-aos="fade-up">
                <i class="fa-solid fa-circle-info ds-info-icon"></i>
                <div>
                    <h4 class="ds-info-title">Data Structure Mechanics: FIFO Queue</h4>
                    <p class="ds-info-desc">
                        A linked First-In-First-Out (FIFO) queue utilizing separate <code>front</code> and <code>rear</code> pointers. New reservations are added at the rear, while trainers service athletes from the front. Maintains fairness without priority starvation.
                    </p>
                    <div class="ds-complexity-tags">
                        <span class="badge badge-complexity">Enqueue (Add to Rear): O(1)</span>
                        <span class="badge badge-complexity">Dequeue (Remove from Front): O(1)</span>
                        <span class="badge badge-complexity">Peek Front: O(1)</span>
                        <span class="badge badge-complexity">Auxiliary Space: O(n)</span>
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
