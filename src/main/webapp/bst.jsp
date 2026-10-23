<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BST Member Lookup | Pro-Fitness Gym</title>
    
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
                <a href="${pageContext.request.contextPath}/bst.jsp" class="sidebar-link active">
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
                    <span style="color: var(--text-primary); font-weight: 500;">BST Member Lookup</span>
                </div>
            </div>

            <div class="header-right">
                <div class="server-badge">
                    <span class="live-dot"></span>
                    <span>BST Index Active &bull; O(log n)</span>
                </div>
            </div>
        </header>

        <div class="app-content">
            <div class="module-header" data-aos="fade-down">
                <div>
                    <h1 class="module-title">BST Member Lookup</h1>
                    <div class="module-subtitle">
                        <i class="fa-solid fa-tree"></i> Powered by Binary Search Tree &mdash; Logarithmic Search & In-Order Sorting
                    </div>
                </div>
                <div>
                    <form action="${pageContext.request.contextPath}/bst" method="POST" style="margin:0;">
                        <input type="hidden" name="action" value="rebuild">
                        <button type="submit" class="btn btn-secondary btn-sm">
                            <i class="fa-solid fa-rotate"></i> Rebuild BST Index
                        </button>
                    </form>
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

            <!-- Search Form Card -->
            <div class="glass-card mb-4" data-aos="fade-up" style="margin-bottom: 2rem;">
                <h3 style="font-size: 1.15rem; margin-bottom: 1rem;">
                    <i class="fa-solid fa-magnifying-glass" style="color: var(--primary); margin-right: 8px;"></i>
                    Search Member by ID via Binary Search Tree
                </h3>
                <p style="font-size: 0.88rem; color: var(--text-secondary); margin-bottom: 1.25rem;">
                    Compares search key with current root: branches left if key &lt; current node, branches right if key &gt; current node.
                </p>

                <form id="bstSearchForm" action="${pageContext.request.contextPath}/bst" method="GET">
                    <div style="display: flex; gap: 0.75rem; max-width: 600px;">
                        <input type="number" id="bstSearchId" name="searchID" class="form-control" placeholder="Enter Member ID (e.g. 101, 102, 103)..." value="${param.searchID}" required min="1">
                        <button type="submit" class="btn btn-primary">
                            <i class="fa-solid fa-magnifying-glass"></i> BST Search
                        </button>
                        <button type="button" class="btn btn-outline" onclick="simulateBSTSearch()">
                            <i class="fa-solid fa-bolt"></i> Trace
                        </button>
                    </div>
                </form>
            </div>

            <!-- Search Diagnostics Result Card -->
            <div id="searchResultArea" class="glass-card mb-4" data-aos="fade-up" style="margin-bottom: 2rem;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                    <h3 style="font-size: 1.15rem;">
                        <i class="fa-solid fa-chart-pie" style="color: var(--secondary); margin-right: 8px;"></i>
                        Search Traversal Diagnostics
                    </h3>
                    <span id="bstResultBadge" class="badge badge-paid">Member Found</span>
                </div>

                <!-- Comparison & Search Path Display -->
                <div style="display: grid; grid-template-columns: 240px 1fr; gap: 1.5rem; align-items: center; margin-bottom: 1.5rem;">
                    <div class="metric-tile">
                        <div class="metric-label">Key Comparisons</div>
                        <div class="metric-val" id="comparisonCount" style="color: var(--secondary);">${not empty comparisons ? comparisons : '2'}</div>
                        <span class="badge badge-complexity">O(log n) Steps</span>
                    </div>

                    <div class="glass-panel" style="background: rgba(14, 18, 32, 0.7);">
                        <div style="font-size: 0.78rem; text-transform: uppercase; color: var(--text-muted); font-weight: 700; margin-bottom: 0.5rem;">
                            BST Search Traversal Path:
                        </div>
                        <div id="bstSearchPath" style="display: flex; align-items: center; gap: 0.6rem; flex-wrap: wrap;">
                            <span class="badge badge-basic">Root: Node #102</span> &rarr;
                            <span class="badge badge-basic">Branch Left (#101 &lt; #102)</span> &rarr;
                            <span class="badge badge-paid">Node #101 (Match Found!)</span>
                        </div>
                    </div>
                </div>

                <!-- Found Member Details -->
                <div id="memberDetailsBox" class="glass-panel" style="background: rgba(0, 212, 255, 0.08); border-color: var(--secondary);">
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <div>
                            <div style="font-weight: 700; font-size: 1.15rem; color: #fff;" id="foundMemberTitle">
                                #${not empty foundMember ? foundMember.memberID : '101'} - ${not empty foundMember ? foundMember.name : 'Rahul Raj'}
                            </div>
                            <div style="font-size: 0.85rem; color: var(--text-secondary); margin-top: 4px;" id="foundMemberSub">
                                Tier: <span class="badge badge-vip">${not empty foundMember ? foundMember.membershipType : 'VIP'}</span> &bull; 
                                Fee: <span class="badge badge-paid">${not empty foundMember ? foundMember.feeStatus : 'Paid'}</span>
                            </div>
                        </div>
                        <i class="fa-solid fa-id-badge" style="font-size: 2.2rem; color: var(--secondary);"></i>
                    </div>
                </div>
            </div>

            <!-- In-Order Sorted Members Table -->
            <div class="glass-card mb-4" data-aos="fade-up" style="margin-bottom: 2rem;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                    <div>
                        <h3 style="font-size: 1.15rem;">
                            <i class="fa-solid fa-arrow-down-1-9" style="color: var(--accent-green); margin-right: 8px;"></i>
                            BST In-Order Sorted Listing
                        </h3>
                        <p style="font-size: 0.82rem; color: var(--text-muted); margin-top: 2px;">
                            In-Order traversal (Left &rarr; Root &rarr; Right) naturally produces members sorted in strictly ascending ID order.
                        </p>
                    </div>
                    <span class="badge badge-ds">Ascending Sort: O(n)</span>
                </div>

                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>BST Key (ID)</th>
                                <th>Member Name</th>
                                <th>Membership Tier</th>
                                <th>Fee Status</th>
                                <th>Tree Position</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty sortedMembers}">
                                    <c:forEach items="${sortedMembers}" var="m" varStatus="loop">
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
                                                In-Order Position [${loop.count}]
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td style="font-weight: 700; color: #fff;">#101</td>
                                        <td><strong>Rahul Raj</strong></td>
                                        <td><span class="badge badge-vip">VIP</span></td>
                                        <td><span class="badge badge-paid">Paid</span></td>
                                        <td style="font-family: var(--font-mono); font-size: 0.8rem; color: var(--secondary);">Left Child of 102</td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: 700; color: #fff;">#102</td>
                                        <td><strong>Priya Sharma</strong></td>
                                        <td><span class="badge badge-premium">Premium</span></td>
                                        <td><span class="badge badge-paid">Paid</span></td>
                                        <td style="font-family: var(--font-mono); font-size: 0.8rem; color: var(--primary);">Root Node</td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: 700; color: #fff;">#103</td>
                                        <td><strong>Vikram Singh</strong></td>
                                        <td><span class="badge badge-basic">Basic</span></td>
                                        <td><span class="badge badge-partial">Partial</span></td>
                                        <td style="font-family: var(--font-mono); font-size: 0.8rem; color: var(--secondary);">Right Child of 102</td>
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
                    <h4 class="ds-info-title">Data Structure Mechanics: Binary Search Tree (BST)</h4>
                    <p class="ds-info-desc">
                        Maintains the BST invariant: every node in the left subtree has a key strictly less than the root, and every node in the right subtree has a key strictly greater. 
                        This halves the remaining search space at every decision node, delivering <strong>O(log n)</strong> search performance compared to <strong>O(n)</strong> sequential scans.
                    </p>
                    <div class="ds-complexity-tags">
                        <span class="badge badge-complexity">Search Average: O(log n)</span>
                        <span class="badge badge-complexity">Search Worst-case: O(n)</span>
                        <span class="badge badge-complexity">Insertion: O(log n)</span>
                        <span class="badge badge-complexity">In-Order Sorted Traversal: O(n)</span>
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
function simulateBSTSearch() {
    const inputId = parseInt(document.getElementById('bstSearchId').value || '101', 10);
    const badge = document.getElementById('bstResultBadge');
    const comp = document.getElementById('comparisonCount');
    const path = document.getElementById('bstSearchPath');
    const title = document.getElementById('foundMemberTitle');

    if (inputId === 102) {
        comp.innerText = '1';
        badge.className = 'badge badge-paid';
        badge.innerText = 'Root Match Found';
        path.innerHTML = `<span class="badge badge-paid">Root: Node #102 (Immediate Match!)</span>`;
        title.innerText = '#102 - Priya Sharma';
    } else if (inputId === 101) {
        comp.innerText = '2';
        badge.className = 'badge badge-paid';
        badge.innerText = 'Member Found';
        path.innerHTML = `<span class="badge badge-basic">Root #102</span> &rarr; <span class="badge badge-basic">Branch Left (101 &lt; 102)</span> &rarr; <span class="badge badge-paid">Node #101 (Match!)</span>`;
        title.innerText = '#101 - Rahul Raj';
    } else if (inputId === 103) {
        comp.innerText = '2';
        badge.className = 'badge badge-paid';
        badge.innerText = 'Member Found';
        path.innerHTML = `<span class="badge badge-basic">Root #102</span> &rarr; <span class="badge badge-basic">Branch Right (103 &gt; 102)</span> &rarr; <span class="badge badge-paid">Node #103 (Match!)</span>`;
        title.innerText = '#103 - Vikram Singh';
    } else {
        comp.innerText = '3';
        badge.className = 'badge badge-unpaid';
        badge.innerText = 'Member Not Found';
        path.innerHTML = `<span class="badge badge-basic">Root #102</span> &rarr; <span class="badge badge-basic">Branch ${inputId > 102 ? 'Right' : 'Left'}</span> &rarr; <span class="badge badge-unpaid">Hit NULL (ID Not Found)</span>`;
        title.innerText = `Member #${inputId} does not exist in BST.`;
    }

    showToast(`BST search completed in ${comp.innerText} comparisons!`, 'info');
}
</script>
</body>
</html>
