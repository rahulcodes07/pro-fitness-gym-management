<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Member Management | Pro-Fitness Gym</title>
    
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
</head>
<body>

<div class="app-container">

    <!-- ==================== SIDEBAR NAVIGATION ==================== -->
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
                <a href="${pageContext.request.contextPath}/members.jsp" class="sidebar-link active">
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
                <a href="${pageContext.request.contextPath}/algorithms.jsp" class="sidebar-link">
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
        <!-- Top Header -->
        <header class="app-header">
            <div class="header-left">
                <button class="sidebar-toggle-btn" aria-label="Toggle Sidebar">
                    <i class="fa-solid fa-bars"></i>
                </button>
                <div class="page-breadcrumb">
                    <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
                    <i class="fa-solid fa-chevron-right" style="font-size: 0.7rem;"></i>
                    <span style="color: var(--text-primary); font-weight: 500;">Member Management</span>
                </div>
            </div>

            <div class="header-right">
                <div class="server-badge">
                    <span class="live-dot"></span>
                    <span>Singly Linked List Active</span>
                </div>
            </div>
        </header>

        <!-- Main Body Content -->
        <div class="app-content">
            <!-- Header Title -->
            <div class="module-header" data-aos="fade-down">
                <div>
                    <h1 class="module-title">Member Management</h1>
                    <div class="module-subtitle">
                        <i class="fa-solid fa-link"></i> Powered by Singly Linked List (`MemberLinkedList`)
                    </div>
                </div>
                <div style="display:flex; gap:0.5rem;">
                    <a href="#addMemberForm" class="btn btn-primary btn-sm">
                        <i class="fa-solid fa-plus"></i> Add New Member
                    </a>
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

            <!-- Linked List Visualization Track -->
            <div class="glass-card mb-4" data-aos="fade-up" style="margin-bottom: 2rem;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                    <h3 style="font-size: 1.1rem; font-weight: 600;">
                        <i class="fa-solid fa-diagram-project" style="color: var(--primary); margin-right: 8px;"></i>
                        Linked List Memory Chain Visualization
                    </h3>
                    <span class="badge badge-ds">HEAD &rarr; TAIL &rarr; NULL</span>
                </div>

                <div class="linked-list-track">
                    <div style="font-weight: 700; color: var(--accent-green); font-size: 0.85rem; padding-right: 0.5rem;">
                        HEAD &rarr;
                    </div>

                    <c:choose>
                        <c:when test="${not empty members}">
                            <c:forEach items="${members}" var="m">
                                <div class="ll-node">
                                    <div class="ll-node-id">#${m.memberID}</div>
                                    <div class="ll-node-name">${m.name}</div>
                                    <div style="font-size: 0.7rem; color: var(--text-muted); margin-top: 4px;">next &rarr;</div>
                                </div>
                                <div class="ll-arrow"><i class="fa-solid fa-arrow-right-long"></i></div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <!-- Sample Visualization Nodes when viewed directly -->
                            <div class="ll-node">
                                <div class="ll-node-id">#101</div>
                                <div class="ll-node-name">Rahul Raj</div>
                                <div style="font-size: 0.7rem; color: var(--text-muted); margin-top: 4px;">next &rarr;</div>
                            </div>
                            <div class="ll-arrow"><i class="fa-solid fa-arrow-right-long"></i></div>

                            <div class="ll-node">
                                <div class="ll-node-id">#102</div>
                                <div class="ll-node-name">Priya Sharma</div>
                                <div style="font-size: 0.7rem; color: var(--text-muted); margin-top: 4px;">next &rarr;</div>
                            </div>
                            <div class="ll-arrow"><i class="fa-solid fa-arrow-right-long"></i></div>

                            <div class="ll-node">
                                <div class="ll-node-id">#103</div>
                                <div class="ll-node-name">Vikram Singh</div>
                                <div style="font-size: 0.7rem; color: var(--text-muted); margin-top: 4px;">next &rarr;</div>
                            </div>
                            <div class="ll-arrow"><i class="fa-solid fa-arrow-right-long"></i></div>
                        </c:otherwise>
                    </c:choose>

                    <div class="ll-null">NULL</div>
                </div>
            </div>

            <!-- Two-Column Form & Search Grid -->
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-bottom: 2rem;">
                
                <!-- Add Member Card -->
                <div id="addMemberForm" class="glass-card" data-aos="fade-right">
                    <h3 style="font-size: 1.15rem; margin-bottom: 1.25rem;">
                        <i class="fa-solid fa-user-plus" style="color: var(--primary); margin-right: 8px;"></i>
                        Register New Member
                    </h3>

                    <form action="${pageContext.request.contextPath}/members" method="POST" data-validate>
                        <input type="hidden" name="action" value="add">

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label" for="memberID">Member ID</label>
                                <input type="number" id="memberID" name="memberID" class="form-control" placeholder="e.g. 104" required min="1">
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="name">Full Name</label>
                                <input type="text" id="name" name="name" class="form-control" placeholder="e.g. Arjun Das" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label" for="membershipType">Membership Tier</label>
                                <select id="membershipType" name="membershipType" class="form-select" required>
                                    <option value="Basic">Basic Tier</option>
                                    <option value="Premium" selected>Premium Tier</option>
                                    <option value="VIP">VIP Tier</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="feeStatus">Fee Status</label>
                                <select id="feeStatus" name="feeStatus" class="form-select" required>
                                    <option value="Paid" selected>Paid</option>
                                    <option value="Unpaid">Unpaid</option>
                                    <option value="Partial">Partial</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">
                                <i class="fa-solid fa-plus-circle"></i> Insert Node
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Find & Update Member Card -->
                <div class="glass-card" data-aos="fade-left">
                    <h3 style="font-size: 1.15rem; margin-bottom: 1.25rem;">
                        <i class="fa-solid fa-search" style="color: var(--secondary); margin-right: 8px;"></i>
                        Search & Update Node
                    </h3>

                    <!-- Find Form -->
                    <form action="${pageContext.request.contextPath}/members" method="GET" style="margin-bottom: 1.5rem;">
                        <input type="hidden" name="action" value="find">
                        <label class="form-label">Find Member by ID (Linear Traversal)</label>
                        <div style="display: flex; gap: 0.5rem;">
                            <input type="number" name="searchID" class="form-control" placeholder="Enter Member ID..." value="${param.searchID}" required min="1">
                            <button type="submit" class="btn btn-secondary">
                                <i class="fa-solid fa-magnifying-glass"></i> Search
                            </button>
                        </div>
                    </form>

                    <!-- Found Member Banner if present -->
                    <c:if test="${not empty foundMember}">
                        <div class="glass-panel" style="background: rgba(0, 212, 255, 0.08); border-color: var(--secondary); margin-bottom: 1.5rem;">
                            <div style="font-weight: 700; color: var(--secondary); margin-bottom: 0.35rem;">
                                <i class="fa-solid fa-check-circle"></i> Member Found: #${foundMember.memberID} - ${foundMember.name}
                            </div>
                            <div style="font-size: 0.85rem; color: var(--text-secondary);">
                                Tier: <span class="badge badge-premium">${foundMember.membershipType}</span> | 
                                Fee: <span class="badge badge-paid">${foundMember.feeStatus}</span>
                            </div>
                        </div>
                    </c:if>

                    <!-- Update Form -->
                    <form action="${pageContext.request.contextPath}/members" method="POST" data-validate>
                        <input type="hidden" name="action" value="update">
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label" for="updateID">Target ID</label>
                                <input type="number" id="updateID" name="memberID" class="form-control" placeholder="ID to modify" value="${foundMember != null ? foundMember.memberID : ''}" required min="1">
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="updateName">Updated Name</label>
                                <input type="text" id="updateName" name="name" class="form-control" placeholder="New Name" value="${foundMember != null ? foundMember.name : ''}" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label" for="updateType">New Tier</label>
                                <select id="updateType" name="membershipType" class="form-select">
                                    <option value="Basic" ${foundMember.membershipType == 'Basic' ? 'selected' : ''}>Basic</option>
                                    <option value="Premium" ${foundMember.membershipType == 'Premium' ? 'selected' : ''}>Premium</option>
                                    <option value="VIP" ${foundMember.membershipType == 'VIP' ? 'selected' : ''}>VIP</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="updateFee">New Fee Status</label>
                                <select id="updateFee" name="feeStatus" class="form-select">
                                    <option value="Paid" ${foundMember.feeStatus == 'Paid' ? 'selected' : ''}>Paid</option>
                                    <option value="Unpaid" ${foundMember.feeStatus == 'Unpaid' ? 'selected' : ''}>Unpaid</option>
                                    <option value="Partial" ${foundMember.feeStatus == 'Partial' ? 'selected' : ''}>Partial</option>
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-outline" style="width: 100%;">
                            <i class="fa-solid fa-pen-to-square"></i> Update Member Node
                        </button>
                    </form>
                </div>
            </div>

            <!-- Members Table Card -->
            <div class="glass-card" data-aos="fade-up" style="margin-bottom: 2rem;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                    <h3 style="font-size: 1.2rem;">
                        <i class="fa-solid fa-address-book" style="color: var(--primary); margin-right: 8px;"></i>
                        Registered Members Directory
                    </h3>
                    <span class="badge badge-basic">Data Structure: Dynamic Singly Linked List</span>
                </div>

                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Node ID</th>
                                <th>Member Name</th>
                                <th>Membership Tier</th>
                                <th>Fee Status</th>
                                <th>Memory Link</th>
                                <th style="text-align: right;">Operations</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty members}">
                                    <c:forEach items="${members}" var="m">
                                        <tr>
                                            <td style="font-weight: 700; color: #fff;">#${m.memberID}</td>
                                            <td><strong>${m.name}</strong></td>
                                            <td>
                                                <span class="badge ${m.membershipType == 'VIP' ? 'badge-vip' : (m.membershipType == 'Premium' ? 'badge-premium' : 'badge-basic')}">
                                                    ${m.membershipType}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge ${m.feeStatus == 'Paid' ? 'badge-paid' : (m.feeStatus == 'Unpaid' ? 'badge-unpaid' : 'badge-partial')}">
                                                    ${m.feeStatus}
                                                </span>
                                            </td>
                                            <td style="font-family: var(--font-mono); font-size: 0.8rem; color: var(--secondary);">
                                                Node &rarr; next
                                            </td>
                                            <td style="text-align: right;">
                                                <form action="${pageContext.request.contextPath}/members" method="POST" style="display: inline;" onsubmit="return confirmDelete(event, '${m.name}')">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="memberID" value="${m.memberID}">
                                                    <button type="submit" class="btn btn-danger btn-sm" title="Remove Node">
                                                        <i class="fa-solid fa-trash-can"></i> Remove
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <!-- Fallback Sample Rows for direct preview -->
                                    <tr>
                                        <td style="font-weight: 700; color: #fff;">#101</td>
                                        <td><strong>Rahul Raj</strong></td>
                                        <td><span class="badge badge-vip">VIP</span></td>
                                        <td><span class="badge badge-paid">Paid</span></td>
                                        <td style="font-family: var(--font-mono); font-size: 0.8rem; color: var(--secondary);">Node &rarr; 102</td>
                                        <td style="text-align: right;">
                                            <button class="btn btn-danger btn-sm" onclick="showToast('Sample node cannot be removed in preview mode.', 'info')">
                                                <i class="fa-solid fa-trash-can"></i> Remove
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: 700; color: #fff;">#102</td>
                                        <td><strong>Priya Sharma</strong></td>
                                        <td><span class="badge badge-premium">Premium</span></td>
                                        <td><span class="badge badge-paid">Paid</span></td>
                                        <td style="font-family: var(--font-mono); font-size: 0.8rem; color: var(--secondary);">Node &rarr; 103</td>
                                        <td style="text-align: right;">
                                            <button class="btn btn-danger btn-sm" onclick="showToast('Sample node cannot be removed in preview mode.', 'info')">
                                                <i class="fa-solid fa-trash-can"></i> Remove
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: 700; color: #fff;">#103</td>
                                        <td><strong>Vikram Singh</strong></td>
                                        <td><span class="badge badge-basic">Basic</span></td>
                                        <td><span class="badge badge-partial">Partial</span></td>
                                        <td style="font-family: var(--font-mono); font-size: 0.8rem; color: var(--secondary);">Node &rarr; NULL</td>
                                        <td style="text-align: right;">
                                            <button class="btn btn-danger btn-sm" onclick="showToast('Sample node cannot be removed in preview mode.', 'info')">
                                                <i class="fa-solid fa-trash-can"></i> Remove
                                            </button>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- DS Info Box -->
            <div class="ds-info-box" data-aos="fade-up">
                <i class="fa-solid fa-circle-info ds-info-icon"></i>
                <div>
                    <h4 class="ds-info-title">Data Structure Mechanics: Singly Linked List</h4>
                    <p class="ds-info-desc">
                        A dynamic linear data structure composed of self-referential <code>MemberNode</code> elements. Unlike arrays, nodes are dynamically allocated at arbitrary memory locations connected by references.
                    </p>
                    <div class="ds-complexity-tags">
                        <span class="badge badge-complexity">Insert at Head: O(1)</span>
                        <span class="badge badge-complexity">Insert at Tail: O(n)</span>
                        <span class="badge badge-complexity">Search by ID: O(n)</span>
                        <span class="badge badge-complexity">Delete Node: O(n)</span>
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


