<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Session Tracking (Stack LIFO) | Pro-Fitness Gym</title>
    
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
                <a href="${pageContext.request.contextPath}/checkin.jsp" class="sidebar-link active">
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
                    <span style="color: var(--text-primary); font-weight: 500;">Session Tracking</span>
                </div>
            </div>

            <div class="header-right">
                <div class="server-badge">
                    <span class="live-dot"></span>
                    <span>Stack LIFO Active</span>
                </div>
            </div>
        </header>

        <div class="app-content">
            <div class="module-header" data-aos="fade-down">
                <div>
                    <h1 class="module-title">Session Tracking</h1>
                    <div class="module-subtitle">
                        <i class="fa-solid fa-layer-group"></i> Powered by Stack (`CheckInStack`) &mdash; LIFO Principle
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

            <!-- Grid Layout: Left Controls & Peek, Right Visual Stack -->
            <div style="display: grid; grid-template-columns: 1.1fr 0.9fr; gap: 2rem; margin-bottom: 2rem;">
                
                <!-- Left: Controls & Peek Section -->
                <div>
                    <!-- Push Operation Card -->
                    <div class="glass-card" data-aos="fade-right" style="margin-bottom: 1.5rem;">
                        <h3 style="font-size: 1.15rem; margin-bottom: 1rem;">
                            <i class="fa-solid fa-arrow-down-to-bracket" style="color: var(--primary); margin-right: 8px;"></i>
                            Member Check-In (Push Operation)
                        </h3>
                        <p style="font-size: 0.88rem; color: var(--text-secondary); margin-bottom: 1.25rem;">
                            Pushes a new <code>CheckInNode</code> onto the top of the stack. Requires an active registered Member ID.
                        </p>

                        <form action="${pageContext.request.contextPath}/checkin" method="POST" data-validate>
                            <input type="hidden" name="action" value="checkin">
                            <div class="form-group">
                                <label class="form-label" for="memberID">Registered Member ID</label>
                                <div style="display: flex; gap: 0.75rem;">
                                    <input type="number" id="memberID" name="memberID" class="form-control" placeholder="e.g. 101" required min="1">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fa-solid fa-arrow-down"></i> Check In (Push)
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Pop Operation Card -->
                    <div class="glass-card" data-aos="fade-right" data-aos-delay="100" style="margin-bottom: 1.5rem;">
                        <h3 style="font-size: 1.15rem; margin-bottom: 1rem;">
                            <i class="fa-solid fa-arrow-up-from-bracket" style="color: var(--accent-red); margin-right: 8px;"></i>
                            Member Check-Out (Pop Operation)
                        </h3>
                        <p style="font-size: 0.88rem; color: var(--text-secondary); margin-bottom: 1.25rem;">
                            Removes and returns the most recently checked-in member situated at the top of the stack.
                        </p>

                        <form action="${pageContext.request.contextPath}/checkin" method="POST">
                            <input type="hidden" name="action" value="checkout">
                            <button type="submit" class="btn btn-danger" style="width: 100%;">
                                <i class="fa-solid fa-arrow-up"></i> Check Out Most Recent (Pop)
                            </button>
                        </form>
                    </div>

                    <!-- Peek Display Card -->
                    <div class="glass-card" data-aos="fade-right" data-aos-delay="200">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                            <h3 style="font-size: 1.15rem;">
                                <i class="fa-solid fa-eye" style="color: var(--secondary); margin-right: 8px;"></i>
                                Top of Stack (Peek Inspection)
                            </h3>
                            <span class="badge badge-premium">O(1) Inspection</span>
                        </div>

                        <c:choose>
                            <c:when test="${not empty latestCheckIn}">
                                <div class="glass-panel" style="background: rgba(0, 212, 255, 0.08); border-color: var(--secondary);">
                                    <div style="display: flex; justify-content: space-between; align-items: center;">
                                        <div>
                                            <div style="font-weight: 700; font-size: 1.1rem; color: #fff;">
                                                #${latestCheckIn.memberID} - ${latestCheckIn.memberName}
                                            </div>
                                            <div style="font-size: 0.82rem; color: var(--text-secondary); margin-top: 4px;">
                                                <i class="fa-regular fa-clock" style="color: var(--secondary);"></i> Checked in at: 
                                                <span style="color: #fff; font-family: var(--font-mono);">${latestCheckIn.checkInTime}</span>
                                            </div>
                                        </div>
                                        <span class="badge badge-paid"><i class="fa-solid fa-signal"></i> CURRENT TOP</span>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="glass-panel" style="background: rgba(0, 212, 255, 0.08); border-color: var(--secondary);">
                                    <div style="display: flex; justify-content: space-between; align-items: center;">
                                        <div>
                                            <div style="font-weight: 700; font-size: 1.1rem; color: #fff;">
                                                #103 - Vikram Singh
                                            </div>
                                            <div style="font-size: 0.82rem; color: var(--text-secondary); margin-top: 4px;">
                                                <i class="fa-regular fa-clock" style="color: var(--secondary);"></i> Checked in at: 
                                                <span style="color: #fff; font-family: var(--font-mono);">15:45 PM (Today)</span>
                                            </div>
                                        </div>
                                        <span class="badge badge-paid"><i class="fa-solid fa-signal"></i> CURRENT TOP</span>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Right: Visual Vertical Stack Container -->
                <div class="glass-card" data-aos="fade-left">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                        <h3 style="font-size: 1.15rem;">
                            <i class="fa-solid fa-cubes-stacked" style="color: var(--primary); margin-right: 8px;"></i>
                            Live Gym Floor Stack
                        </h3>
                        <span class="badge badge-complexity">LIFO Memory Chamber</span>
                    </div>

                    <!-- Vertical Stack Chamber -->
                    <div class="stack-container">
                        <div class="stack-top-indicator">
                            <i class="fa-solid fa-arrow-down"></i> TOP OF STACK (LIFO)
                        </div>

                        <c:choose>
                            <c:when test="${not empty checkInList}">
                                <c:forEach items="${checkInList}" var="c" varStatus="loop">
                                    <div class="stack-card ${loop.first ? 'is-top' : ''}">
                                        <div>
                                            <div style="font-weight: 700; color: #fff; font-size: 0.95rem;">
                                                #${c.memberID} - ${c.memberName}
                                            </div>
                                            <div style="font-size: 0.78rem; color: var(--text-muted); margin-top: 2px;">
                                                <i class="fa-regular fa-clock"></i> ${c.checkInTime}
                                            </div>
                                        </div>
                                        <div>
                                            <c:if test="${loop.first}">
                                                <span class="badge badge-paid" style="font-size: 0.7rem;">TOP</span>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <!-- Sample stack items when previewing -->
                                <div class="stack-card is-top">
                                    <div>
                                        <div style="font-weight: 700; color: #fff; font-size: 0.95rem;">
                                            #103 - Vikram Singh
                                        </div>
                                        <div style="font-size: 0.78rem; color: var(--text-muted); margin-top: 2px;">
                                            <i class="fa-regular fa-clock"></i> 15:45 PM
                                        </div>
                                    </div>
                                    <span class="badge badge-paid" style="font-size: 0.7rem;">TOP</span>
                                </div>

                                <div class="stack-card">
                                    <div>
                                        <div style="font-weight: 700; color: #fff; font-size: 0.95rem;">
                                            #102 - Priya Sharma
                                        </div>
                                        <div style="font-size: 0.78rem; color: var(--text-muted); margin-top: 2px;">
                                            <i class="fa-regular fa-clock"></i> 15:10 PM
                                        </div>
                                    </div>
                                </div>

                                <div class="stack-card">
                                    <div>
                                        <div style="font-weight: 700; color: #fff; font-size: 0.95rem;">
                                            #101 - Rahul Raj
                                        </div>
                                        <div style="font-size: 0.78rem; color: var(--text-muted); margin-top: 2px;">
                                            <i class="fa-regular fa-clock"></i> 14:30 PM
                                        </div>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <div style="width: 100%; border-top: 2px solid var(--border-subtle); padding-top: 0.75rem; text-align: center; font-size: 0.78rem; color: var(--text-dim);">
                            STACK BOTTOM &bull; BASE ADDRESS
                        </div>
                    </div>
                </div>

            </div>

            <!-- DS Info Box -->
            <div class="ds-info-box" data-aos="fade-up">
                <i class="fa-solid fa-circle-info ds-info-icon"></i>
                <div>
                    <h4 class="ds-info-title">Data Structure Mechanics: LIFO Stack</h4>
                    <p class="ds-info-desc">
                        A linked-list backed Last-In-First-Out (LIFO) stack. Each check-in creates a new <code>CheckInNode</code> referencing the former top node. All insertions (push), deletions (pop), and lookups (peek) operate in strict constant time without iterating elements.
                    </p>
                    <div class="ds-complexity-tags">
                        <span class="badge badge-complexity">Push: O(1) Time</span>
                        <span class="badge badge-complexity">Pop: O(1) Time</span>
                        <span class="badge badge-complexity">Peek: O(1) Time</span>
                        <span class="badge badge-complexity">Space: O(n)</span>
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
