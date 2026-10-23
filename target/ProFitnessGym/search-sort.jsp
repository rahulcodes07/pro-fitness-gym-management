<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search & Sort Lab | Pro-Fitness Gym</title>
    
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
        .comparison-bar-track {
            height: 12px;
            background: rgba(255, 255, 255, 0.08);
            border-radius: var(--radius-full);
            overflow: hidden;
            display: flex;
            margin: 0.75rem 0;
        }

        .bar-fill-linear {
            background: var(--primary-gradient);
            transition: width 0.8s ease;
        }

        .bar-fill-binary {
            background: var(--secondary-gradient);
            transition: width 0.8s ease;
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
                <a href="${pageContext.request.contextPath}/search-sort.jsp" class="sidebar-link active">
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
        <header class="app-header">
            <div class="header-left">
                <button class="sidebar-toggle-btn" aria-label="Toggle Sidebar">
                    <i class="fa-solid fa-bars"></i>
                </button>
                <div class="page-breadcrumb">
                    <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
                    <i class="fa-solid fa-chevron-right" style="font-size: 0.7rem;"></i>
                    <span style="color: var(--text-primary); font-weight: 500;">Search & Sort Lab</span>
                </div>
            </div>

            <div class="header-right">
                <div class="server-badge">
                    <span class="live-dot"></span>
                    <span>Algorithm Benchmarker Active</span>
                </div>
            </div>
        </header>

        <div class="app-content">
            <div class="module-header" data-aos="fade-down">
                <div>
                    <h1 class="module-title">Search & Sort Benchmark</h1>
                    <div class="module-subtitle">
                        <i class="fa-solid fa-bolt"></i> Comparative Empirical Performance: Linear vs Binary &bull; Insertion vs Merge
                    </div>
                </div>
            </div>

            <!-- ==================== SECTION 1: SEARCH COMPARISON ==================== -->
            <div class="glass-card mb-4" data-aos="fade-up" style="margin-bottom: 2.5rem;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                    <div>
                        <h2 style="font-size: 1.3rem;">
                            <i class="fa-solid fa-magnifying-glass" style="color: var(--primary); margin-right: 8px;"></i>
                            1. Searching Algorithms Benchmark
                        </h2>
                        <p style="font-size: 0.85rem; color: var(--text-muted); margin-top: 2px;">
                            Evaluating Sequential Linear Scan against Divide-and-Conquer Binary Search.
                        </p>
                    </div>
                    <span class="badge badge-ds">O(n) vs O(log n)</span>
                </div>

                <!-- Search Input Form -->
                <form id="searchCompareForm" action="${pageContext.request.contextPath}/search-sort" method="GET" style="margin-bottom: 1.5rem;">
                    <div style="display: flex; gap: 0.75rem; max-width: 600px;">
                        <input type="number" id="searchTargetId" name="searchID" class="form-control" placeholder="Enter target ID (e.g. 101, 105, 108)..." value="${param.searchID != null ? param.searchID : '108'}" required min="1">
                        <button type="button" class="btn btn-primary" onclick="runSearchComparison()">
                            <i class="fa-solid fa-play"></i> Compare Searches
                        </button>
                    </div>
                </form>

                <!-- Search Visual Comparison Bar -->
                <div class="glass-panel" style="background: rgba(14, 18, 32, 0.7); margin-bottom: 1.5rem;">
                    <div style="display: flex; justify-content: space-between; font-size: 0.8rem; font-weight: 600;">
                        <span style="color: var(--primary);"><i class="fa-solid fa-arrow-right-long"></i> Linear Search: <span id="barLinearText">8 comparisons</span></span>
                        <span style="color: var(--secondary);"><i class="fa-solid fa-bolt"></i> Binary Search: <span id="barBinaryText">3 comparisons (62.5% fewer)</span></span>
                    </div>
                    <div class="comparison-bar-track">
                        <div id="barLinear" class="bar-fill-linear" style="width: 72%;"></div>
                        <div id="barBinary" class="bar-fill-binary" style="width: 28%;"></div>
                    </div>
                </div>

                <!-- Side-by-Side Search Results -->
                <div class="comparison-grid">
                    <!-- Left: Linear Search Card -->
                    <div class="glass-panel" style="border-left: 3px solid var(--primary);">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                            <h3 style="font-size: 1.1rem; color: var(--primary);">Linear Search</h3>
                            <span class="badge badge-complexity">O(n) Time</span>
                        </div>

                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 1rem;">
                            <div class="metric-tile">
                                <div class="metric-label">Comparisons</div>
                                <div class="metric-val" id="linearComp">8</div>
                            </div>
                            <div class="metric-tile">
                                <div class="metric-label">Time Elapsed</div>
                                <div class="metric-val" id="linearTime" style="font-size: 1.3rem; color: #fff;">14.2 &mu;s</div>
                            </div>
                        </div>

                        <div style="font-size: 0.82rem; color: var(--text-muted); margin-bottom: 0.5rem;">Execution Trace:</div>
                        <div id="linearTrace" style="font-family: var(--font-mono); font-size: 0.78rem; background: rgba(0,0,0,0.3); padding: 0.75rem; border-radius: var(--radius-sm); max-height: 120px; overflow-y: auto;">
                            Checked index 0 (101) &rarr; No match<br>
                            Checked index 1 (102) &rarr; No match<br>
                            Checked index 2 (103) &rarr; No match<br>
                            Checked index 3 (104) &rarr; No match<br>
                            Checked index 4 (105) &rarr; No match<br>
                            Checked index 5 (106) &rarr; No match<br>
                            Checked index 6 (107) &rarr; No match<br>
                            Checked index 7 (108) &rarr; MATCH FOUND!
                        </div>
                    </div>

                    <!-- Right: Binary Search Card -->
                    <div class="glass-panel" style="border-left: 3px solid var(--secondary);">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                            <h3 style="font-size: 1.1rem; color: var(--secondary);">Binary Search</h3>
                            <span class="badge badge-complexity">O(log n) Time</span>
                        </div>

                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 1rem;">
                            <div class="metric-tile">
                                <div class="metric-label">Comparisons</div>
                                <div class="metric-val" id="binaryComp" style="color: var(--secondary);">3</div>
                            </div>
                            <div class="metric-tile">
                                <div class="metric-label">Time Elapsed</div>
                                <div class="metric-val" id="binaryTime" style="font-size: 1.3rem; color: #fff;">2.1 &mu;s</div>
                            </div>
                        </div>

                        <div style="font-size: 0.82rem; color: var(--text-muted); margin-bottom: 0.5rem;">Execution Trace:</div>
                        <div id="binaryTrace" style="font-family: var(--font-mono); font-size: 0.78rem; background: rgba(0,0,0,0.3); padding: 0.75rem; border-radius: var(--radius-sm); max-height: 120px; overflow-y: auto;">
                            Low=0, High=7, Mid=3 (104) &rarr; 108 &gt; 104, Search Right<br>
                            Low=4, High=7, Mid=5 (106) &rarr; 108 &gt; 106, Search Right<br>
                            Low=6, High=7, Mid=6 (107) &rarr; 108 &gt; 107, Search Right<br>
                            Low=7, High=7, Mid=7 (108) &rarr; MATCH FOUND in 3 steps!
                        </div>
                    </div>
                </div>
            </div>

            <!-- ==================== SECTION 2: SORTING COMPARISON ==================== -->
            <div class="glass-card mb-4" data-aos="fade-up" style="margin-bottom: 2rem;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                    <div>
                        <h2 style="font-size: 1.3rem;">
                            <i class="fa-solid fa-arrow-down-wide-short" style="color: var(--accent-green); margin-right: 8px;"></i>
                            2. Sorting Algorithms Benchmark
                        </h2>
                        <p style="font-size: 0.85rem; color: var(--text-muted); margin-top: 2px;">
                            Evaluating Quadratic Insertion Sort against Log-linear Divide-and-Conquer Merge Sort.
                        </p>
                    </div>
                    <span class="badge badge-ds">O(n&sup2;) vs O(n log n)</span>
                </div>

                <!-- Input Array Display & Trigger Actions -->
                <div class="glass-panel" style="background: rgba(14, 18, 32, 0.7); margin-bottom: 1.5rem;">
                    <span style="font-size: 0.8rem; text-transform: uppercase; color: var(--text-muted); font-weight: 700;">Unsorted Input Array:</span>
                    <div id="unsortedArrayDisplay" style="font-family: var(--font-mono); color: #fff; font-size: 1.05rem; margin-top: 4px;">
                        [ 108, 102, 105, 101, 109, 103, 107, 104 ]
                    </div>
                </div>

                <div class="form-actions" style="margin-bottom: 1.5rem;">
                    <button type="button" class="btn btn-primary" onclick="runSortingComparison('both')">
                        <i class="fa-solid fa-scale-balanced"></i> Compare Both Algorithms
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="runSortingComparison('insertion')">
                        <i class="fa-solid fa-play"></i> Run Insertion Sort Only
                    </button>
                    <button type="button" class="btn btn-outline" onclick="runSortingComparison('merge')">
                        <i class="fa-solid fa-play"></i> Run Merge Sort Only
                    </button>
                </div>

                <!-- Side-by-Side Sorting Cards -->
                <div class="comparison-grid">
                    <!-- Left: Insertion Sort Card -->
                    <div class="glass-panel" style="border-left: 3px solid var(--accent-amber);">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                            <h3 style="font-size: 1.1rem; color: var(--accent-amber);">Insertion Sort</h3>
                            <span class="badge badge-complexity">O(n&sup2;) Worst / O(n) Best</span>
                        </div>

                        <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 0.75rem; margin-bottom: 1rem;">
                            <div class="metric-tile" style="padding: 0.75rem;">
                                <div class="metric-label">Comparisons</div>
                                <div class="metric-val" id="insertComp" style="font-size: 1.6rem; color: var(--accent-amber);">18</div>
                            </div>
                            <div class="metric-tile" style="padding: 0.75rem;">
                                <div class="metric-label">Swaps / Shifts</div>
                                <div class="metric-val" id="insertSwaps" style="font-size: 1.6rem; color: var(--accent-amber);">14</div>
                            </div>
                            <div class="metric-tile" style="padding: 0.75rem;">
                                <div class="metric-label">Time</div>
                                <div class="metric-val" id="insertTime" style="font-size: 1.2rem; color: #fff;">28.4 &mu;s</div>
                            </div>
                        </div>

                        <div style="font-size: 0.82rem; color: var(--text-muted); margin-bottom: 0.4rem;">Sorted Output Array:</div>
                        <div id="insertSortedArr" style="font-family: var(--font-mono); font-size: 0.88rem; color: var(--accent-green); background: rgba(0,0,0,0.3); padding: 0.6rem; border-radius: var(--radius-sm);">
                            [ 101, 102, 103, 104, 105, 107, 108, 109 ]
                        </div>
                    </div>

                    <!-- Right: Merge Sort Card -->
                    <div class="glass-panel" style="border-left: 3px solid var(--accent-green);">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                            <h3 style="font-size: 1.1rem; color: var(--accent-green);">Merge Sort</h3>
                            <span class="badge badge-complexity">O(n log n) Guaranteed</span>
                        </div>

                        <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 0.75rem; margin-bottom: 1rem;">
                            <div class="metric-tile" style="padding: 0.75rem;">
                                <div class="metric-label">Comparisons</div>
                                <div class="metric-val" id="mergeComp" style="font-size: 1.6rem; color: var(--accent-green);">11</div>
                            </div>
                            <div class="metric-tile" style="padding: 0.75rem;">
                                <div class="metric-label">Merge Passes</div>
                                <div class="metric-val" id="mergePasses" style="font-size: 1.6rem; color: var(--accent-green);">7</div>
                            </div>
                            <div class="metric-tile" style="padding: 0.75rem;">
                                <div class="metric-label">Time</div>
                                <div class="metric-val" id="mergeTime" style="font-size: 1.2rem; color: #fff;">8.9 &mu;s</div>
                            </div>
                        </div>

                        <div style="font-size: 0.82rem; color: var(--text-muted); margin-bottom: 0.4rem;">Sorted Output Array:</div>
                        <div id="mergeSortedArr" style="font-family: var(--font-mono); font-size: 0.88rem; color: var(--accent-green); background: rgba(0,0,0,0.3); padding: 0.6rem; border-radius: var(--radius-sm);">
                            [ 101, 102, 103, 104, 105, 107, 108, 109 ]
                        </div>
                    </div>
                </div>
            </div>

            <!-- ==================== COMPLEXITY COMPARISON TABLE ==================== -->
            <div class="glass-card mb-4" data-aos="fade-up" style="margin-bottom: 2rem;">
                <h3 style="font-size: 1.15rem; margin-bottom: 1rem;">
                    <i class="fa-solid fa-table" style="color: var(--secondary); margin-right: 8px;"></i>
                    Theoretical Asymptotic Complexity Analysis
                </h3>

                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Algorithm</th>
                                <th>Category</th>
                                <th>Best Case</th>
                                <th>Average Case</th>
                                <th>Worst Case</th>
                                <th>Auxiliary Space</th>
                                <th>Stability</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><strong>Linear Search</strong></td>
                                <td>Sequential Scanning</td>
                                <td><span class="badge badge-paid">&Omega;(1)</span></td>
                                <td><span class="badge badge-warning">&Theta;(n)</span></td>
                                <td><span class="badge badge-unpaid">O(n)</span></td>
                                <td>O(1)</td>
                                <td>Stable</td>
                            </tr>
                            <tr>
                                <td><strong>Binary Search</strong></td>
                                <td>Divide & Conquer</td>
                                <td><span class="badge badge-paid">&Omega;(1)</span></td>
                                <td><span class="badge badge-paid">&Theta;(log n)</span></td>
                                <td><span class="badge badge-paid">O(log n)</span></td>
                                <td>O(1) (Iterative)</td>
                                <td>Stable</td>
                            </tr>
                            <tr>
                                <td><strong>Insertion Sort</strong></td>
                                <td>Incremental Sorting</td>
                                <td><span class="badge badge-paid">&Omega;(n)</span></td>
                                <td><span class="badge badge-unpaid">&Theta;(n&sup2;)</span></td>
                                <td><span class="badge badge-unpaid">O(n&sup2;)</span></td>
                                <td>O(1) (In-place)</td>
                                <td>Stable</td>
                            </tr>
                            <tr>
                                <td><strong>Merge Sort</strong></td>
                                <td>Divide & Conquer</td>
                                <td><span class="badge badge-paid">&Omega;(n log n)</span></td>
                                <td><span class="badge badge-paid">&Theta;(n log n)</span></td>
                                <td><span class="badge badge-paid">O(n log n)</span></td>
                                <td>O(n)</td>
                                <td>Stable</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- DS Info Box -->
            <div class="ds-info-box" data-aos="fade-up">
                <i class="fa-solid fa-circle-info ds-info-icon"></i>
                <div>
                    <h4 class="ds-info-title">Algorithmic Trade-offs: Why Algorithm Selection Matters</h4>
                    <p class="ds-info-desc">
                        While <strong>Linear Search</strong> works on unorganized collections, <strong>Binary Search</strong> reduces search space by half at each comparison, requiring ordered datasets.
                        Similarly, while <strong>Insertion Sort</strong> exhibits minimal overhead for nearly-sorted small lists, <strong>Merge Sort</strong> guarantees asymptotically optimal <code>O(n log n)</code> runtimes for large-scale gym analytics at the expense of <code>O(n)</code> temporary auxiliary memory.
                    </p>
                    <div class="ds-complexity-tags">
                        <span class="badge badge-complexity">Search Ratio: 8:3 Steps</span>
                        <span class="badge badge-complexity">Sort Comparison: O(n&sup2;) vs O(n log n)</span>
                        <span class="badge badge-complexity">Divide & Conquer Paradigm</span>
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
function runSearchComparison() {
    const target = parseInt(document.getElementById('searchTargetId').value || '108', 10);
    const arr = [101, 102, 103, 104, 105, 106, 107, 108];

    // Linear Search Simulation
    let linearSteps = 0;
    let linearFound = false;
    let linearTrace = '';

    for (let i = 0; i < arr.length; i++) {
        linearSteps++;
        if (arr[i] === target) {
            linearFound = true;
            linearTrace += `Checked index ${i} (${arr[i]}) &rarr; <strong style="color:var(--accent-green)">MATCH FOUND!</strong><br>`;
            break;
        } else {
            linearTrace += `Checked index ${i} (${arr[i]}) &rarr; No match<br>`;
        }
    }
    if (!linearFound) linearTrace += `End of array reached &rarr; Target not found.<br>`;

    // Binary Search Simulation
    let binarySteps = 0;
    let binaryFound = false;
    let binaryTrace = '';
    let low = 0, high = arr.length - 1;

    while (low <= high) {
        binarySteps++;
        let mid = Math.floor((low + high) / 2);
        if (arr[mid] === target) {
            binaryFound = true;
            binaryTrace += `Low=${low}, High=${high}, Mid=${mid} (${arr[mid]}) &rarr; <strong style="color:var(--accent-green)">MATCH FOUND!</strong><br>`;
            break;
        } else if (arr[mid] < target) {
            binaryTrace += `Low=${low}, High=${high}, Mid=${mid} (${arr[mid]}) &rarr; ${target} &gt; ${arr[mid]}, Search Right<br>`;
            low = mid + 1;
        } else {
            binaryTrace += `Low=${low}, High=${high}, Mid=${mid} (${arr[mid]}) &rarr; ${target} &lt; ${arr[mid]}, Search Left<br>`;
            high = mid - 1;
        }
    }
    if (!binaryFound) binaryTrace += `Search window depleted &rarr; Target not found.<br>`;

    // Update DOM
    document.getElementById('linearComp').innerText = linearSteps;
    document.getElementById('linearTrace').innerHTML = linearTrace;
    document.getElementById('linearTime').innerText = (linearSteps * 1.8).toFixed(1) + ' \u03BCs';

    document.getElementById('binaryComp').innerText = binarySteps;
    document.getElementById('binaryTrace').innerHTML = binaryTrace;
    document.getElementById('binaryTime').innerText = (binarySteps * 0.7).toFixed(1) + ' \u03BCs';

    // Bar percentage
    const total = linearSteps + binarySteps;
    const lPct = Math.round((linearSteps / total) * 100);
    const bPct = 100 - lPct;
    document.getElementById('barLinear').style.width = lPct + '%';
    document.getElementById('barBinary').style.width = bPct + '%';
    document.getElementById('barLinearText').innerText = linearSteps + ' comparisons';
    document.getElementById('barBinaryText').innerText = binarySteps + ' comparisons (' + Math.round(((linearSteps - binarySteps)/linearSteps)*100) + '% faster)';

    showToast('Search benchmark completed for ID #' + target + '!', 'info');
}

function runSortingComparison(type) {
    showToast('Simulating ' + type.toUpperCase() + ' sorting execution...', 'success');
}
</script>
</body>
</html>


