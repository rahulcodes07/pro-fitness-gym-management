<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zone Navigation (Graph Adjacency List) | Pro-Fitness Gym</title>
    
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
        .zone-canvas {
            position: relative;
            width: 100%;
            height: 480px;
            background: radial-gradient(circle at center, rgba(22, 28, 48, 0.75) 0%, rgba(10, 10, 15, 0.95) 100%);
            border: 1px solid var(--border-subtle);
            border-radius: var(--radius-lg);
            overflow: hidden;
        }

        .zone-node {
            position: absolute;
            width: 110px;
            height: 110px;
            border-radius: 50%;
            background: rgba(20, 26, 44, 0.95);
            border: 2px solid var(--border-accent);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 0.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.5);
            transform: translate(-50%, -50%);
            z-index: 5;
        }

        .zone-node:hover, .zone-node.highlighted {
            border-color: var(--secondary);
            box-shadow: 0 0 25px rgba(0, 212, 255, 0.6);
            transform: translate(-50%, -50%) scale(1.1);
        }

        .zone-node.current-visit {
            border-color: var(--accent-green) !important;
            box-shadow: 0 0 30px rgba(0, 230, 118, 0.8) !important;
            transform: translate(-50%, -50%) scale(1.15) !important;
        }

        .zone-node i {
            font-size: 1.4rem;
            color: var(--primary);
            margin-bottom: 0.2rem;
            transition: color 0.3s ease;
        }

        .zone-node.highlighted i, .zone-node.current-visit i {
            color: var(--secondary);
        }

        .zone-node .node-title {
            font-size: 0.75rem;
            font-weight: 700;
            color: #ffffff;
            line-height: 1.2;
        }

        .svg-connections {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
            pointer-events: none;
        }

        .svg-connections line {
            stroke: rgba(255, 255, 255, 0.15);
            stroke-width: 2;
            stroke-dasharray: 4;
            transition: stroke 0.3s ease;
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
                <a href="${pageContext.request.contextPath}/zones.jsp" class="sidebar-link active">
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
                    <span style="color: var(--text-primary); font-weight: 500;">Zone Navigation</span>
                </div>
            </div>

            <div class="header-right">
                <div class="server-badge">
                    <span class="live-dot"></span>
                    <span>Graph Engine Active &bull; O(V + E)</span>
                </div>
            </div>
        </header>

        <div class="app-content">
            <div class="module-header" data-aos="fade-down">
                <div>
                    <h1 class="module-title">Gym Zone Navigation</h1>
                    <div class="module-subtitle">
                        <i class="fa-solid fa-circle-nodes"></i> Powered by Graph (Adjacency List) &mdash; BFS & DFS Path Traversals
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

            <!-- Graph Visual Canvas -->
            <div class="glass-card mb-4" data-aos="fade-up" style="margin-bottom: 2rem;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                    <h3 style="font-size: 1.15rem;">
                        <i class="fa-solid fa-map" style="color: var(--primary); margin-right: 8px;"></i>
                        Facility Zone Network Map
                    </h3>
                    <span class="badge badge-ds">6 Vertices &bull; 8 Undirected Edges</span>
                </div>

                <div class="zone-canvas" id="zoneCanvas">
                    <!-- SVG Edge Lines Layer -->
                    <svg class="svg-connections" id="svgConnections" viewBox="0 0 1000 480" preserveAspectRatio="none">
                        <!-- Reception to Cardio, Stretching, Weight -->
                        <line x1="500" y1="65" x2="200" y2="200" />
                        <line x1="500" y1="65" x2="500" y2="220" />
                        <line x1="500" y1="65" x2="800" y2="200" />

                        <!-- Cardio to Locker, Stretching -->
                        <line x1="200" y1="200" x2="500" y2="220" />
                        <line x1="200" y1="200" x2="300" y2="390" />

                        <!-- Weight to Stretching, Steam -->
                        <line x1="800" y1="200" x2="500" y2="220" />
                        <line x1="800" y1="200" x2="700" y2="390" />

                        <!-- Locker to Steam -->
                        <line x1="300" y1="390" x2="700" y2="390" />
                    </svg>

                    <!-- Zone 1: Reception (center-top) -->
                    <div class="zone-node" id="node-reception" style="top: 15%; left: 50%;">
                        <i class="fa-solid fa-bell-concierge"></i>
                        <span class="node-title">Reception</span>
                    </div>

                    <!-- Zone 2: Cardio Zone (left-middle) -->
                    <div class="zone-node" id="node-cardio" style="top: 45%; left: 20%;">
                        <i class="fa-solid fa-person-running"></i>
                        <span class="node-title">Cardio Zone</span>
                    </div>

                    <!-- Zone 3: Stretching Area (center) -->
                    <div class="zone-node" id="node-stretching" style="top: 50%; left: 50%;">
                        <i class="fa-solid fa-person-praying"></i>
                        <span class="node-title">Stretching Area</span>
                    </div>

                    <!-- Zone 4: Weight Zone (right-middle) -->
                    <div class="zone-node" id="node-weight" style="top: 45%; left: 80%;">
                        <i class="fa-solid fa-dumbbell"></i>
                        <span class="node-title">Weight Zone</span>
                    </div>

                    <!-- Zone 5: Locker Room (left-bottom) -->
                    <div class="zone-node" id="node-locker" style="top: 82%; left: 30%;">
                        <i class="fa-solid fa-door-closed"></i>
                        <span class="node-title">Locker Room</span>
                    </div>

                    <!-- Zone 6: Steam Room (right-bottom) -->
                    <div class="zone-node" id="node-steam" style="top: 82%; left: 70%;">
                        <i class="fa-solid fa-hot-tub-person"></i>
                        <span class="node-title">Steam Room</span>
                    </div>
                </div>
            </div>

            <!-- Two-Column Controls & Adjacency List -->
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-bottom: 2rem;">
                
                <!-- Traversal Triggers Card -->
                <div class="glass-card" data-aos="fade-right">
                    <h3 style="font-size: 1.15rem; margin-bottom: 1.25rem;">
                        <i class="fa-solid fa-compass" style="color: var(--secondary); margin-right: 8px;"></i>
                        Run Graph Traversals
                    </h3>

                    <div class="form-group">
                        <label class="form-label" for="startZone">Select Source Vertex (Starting Zone)</label>
                        <select id="startZone" class="form-select">
                            <option value="reception" selected>Reception (Vertex 0)</option>
                            <option value="cardio">Cardio Zone (Vertex 1)</option>
                            <option value="stretching">Stretching Area (Vertex 2)</option>
                            <option value="weight">Weight Zone (Vertex 3)</option>
                            <option value="locker">Locker Room (Vertex 4)</option>
                            <option value="steam">Steam Room (Vertex 5)</option>
                        </select>
                    </div>

                    <div class="form-actions" style="margin-top: 1.5rem;">
                        <button type="button" class="btn btn-primary" onclick="runGraphTraversal('bfs')">
                            <i class="fa-solid fa-layer-group"></i> Breadth-First Search (BFS)
                        </button>
                        <button type="button" class="btn btn-secondary" onclick="runGraphTraversal('dfs')">
                            <i class="fa-solid fa-stairs"></i> Depth-First Search (DFS)
                        </button>
                    </div>
                </div>

                <!-- Adjacency List Representation Display -->
                <div class="glass-card" data-aos="fade-left">
                    <h3 style="font-size: 1.15rem; margin-bottom: 1rem;">
                        <i class="fa-solid fa-list-nodes" style="color: var(--primary); margin-right: 8px;"></i>
                        Adjacency List Memory Representation
                    </h3>

                    <div style="display: flex; flex-direction: column; gap: 0.6rem; font-size: 0.85rem;">
                        <div class="glass-panel" style="padding: 0.6rem 0.9rem;">
                            <strong style="color: var(--primary);">Reception</strong> &rarr; 
                            <span class="badge badge-basic">Cardio</span>
                            <span class="badge badge-basic">Stretching</span>
                            <span class="badge badge-basic">Weight Zone</span>
                        </div>
                        <div class="glass-panel" style="padding: 0.6rem 0.9rem;">
                            <strong style="color: var(--secondary);">Cardio Zone</strong> &rarr; 
                            <span class="badge badge-basic">Reception</span>
                            <span class="badge badge-basic">Stretching</span>
                            <span class="badge badge-basic">Locker Room</span>
                        </div>
                        <div class="glass-panel" style="padding: 0.6rem 0.9rem;">
                            <strong style="color: #fff;">Stretching Area</strong> &rarr; 
                            <span class="badge badge-basic">Reception</span>
                            <span class="badge badge-basic">Cardio</span>
                            <span class="badge badge-basic">Weight Zone</span>
                        </div>
                        <div class="glass-panel" style="padding: 0.6rem 0.9rem;">
                            <strong style="color: var(--accent-green);">Weight Zone</strong> &rarr; 
                            <span class="badge badge-basic">Reception</span>
                            <span class="badge badge-basic">Stretching</span>
                            <span class="badge badge-basic">Steam Room</span>
                        </div>
                        <div class="glass-panel" style="padding: 0.6rem 0.9rem;">
                            <strong style="color: var(--accent-purple);">Locker Room</strong> &rarr; 
                            <span class="badge badge-basic">Cardio</span>
                            <span class="badge badge-basic">Steam Room</span>
                        </div>
                        <div class="glass-panel" style="padding: 0.6rem 0.9rem;">
                            <strong style="color: var(--accent-amber);">Steam Room</strong> &rarr; 
                            <span class="badge badge-basic">Weight Zone</span>
                            <span class="badge badge-basic">Locker Room</span>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Traversal Results Card -->
            <div class="glass-card mb-4" data-aos="fade-up" style="margin-bottom: 2rem;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                    <h3 style="font-size: 1.15rem;">
                        <i class="fa-solid fa-flag-checkered" style="color: var(--accent-green); margin-right: 8px;"></i>
                        Zone Traversal Diagnostics
                    </h3>
                    <span id="traversalBadge" class="badge badge-paid">BFS Queue Traversal</span>
                </div>

                <div style="margin-bottom: 1.5rem;">
                    <div style="font-size: 0.8rem; text-transform: uppercase; color: var(--text-muted); font-weight: 700; margin-bottom: 0.5rem;">
                        Visit Sequence:
                    </div>
                    <div id="zoneVisitPills" style="display: flex; gap: 0.6rem; align-items: center; flex-wrap: wrap; padding: 1rem; background: rgba(14, 18, 32, 0.7); border-radius: var(--radius-md); border: 1px solid var(--border-subtle);">
                        <span class="badge badge-vip">Reception (Start)</span> &rarr;
                        <span class="badge badge-basic">Cardio Zone</span> &rarr;
                        <span class="badge badge-basic">Stretching Area</span> &rarr;
                        <span class="badge badge-basic">Weight Zone</span> &rarr;
                        <span class="badge badge-basic">Locker Room</span> &rarr;
                        <span class="badge badge-basic">Steam Room</span>
                    </div>
                </div>

                <h4 style="font-size: 0.95rem; text-transform: uppercase; color: var(--secondary); letter-spacing: 0.05em; margin-bottom: 0.75rem;">
                    Step-by-Step Graph Exploration Log
                </h4>
                <div id="zoneStepsContainer" class="step-container animate-steps">
                    <div class="step-item">
                        <span class="step-num">Step 1</span>
                        <div class="step-desc">Starting vertex <strong>Reception</strong> enqueued/visited. Mark visited = true.</div>
                    </div>
                    <div class="step-item">
                        <span class="step-num">Step 2</span>
                        <div class="step-desc">Explored neighboring vertex <strong>Cardio Zone</strong>.</div>
                    </div>
                    <div class="step-item">
                        <span class="step-num">Step 3</span>
                        <div class="step-desc">Explored neighboring vertex <strong>Stretching Area</strong>.</div>
                    </div>
                </div>
            </div>

            <!-- DS Info Box -->
            <div class="ds-info-box" data-aos="fade-up">
                <i class="fa-solid fa-circle-info ds-info-icon"></i>
                <div>
                    <h4 class="ds-info-title">Data Structure Mechanics: Graph Adjacency List</h4>
                    <p class="ds-info-desc">
                        A collection of linked lists where each node represents a facility zone and points to its adjacent reachable neighbors.
                        <strong>Breadth-First Search (BFS)</strong> uses a FIFO Queue to discover zones layer by layer, guaranteeing the shortest path in unweighted networks.
                        <strong>Depth-First Search (DFS)</strong> uses a LIFO Call Stack/Recursion to explore deeply along each branch before backtracking.
                    </p>
                    <div class="ds-complexity-tags">
                        <span class="badge badge-complexity">Graph Traversal: O(V + E)</span>
                        <span class="badge badge-complexity">Adjacency List Space: O(V + E)</span>
                        <span class="badge badge-complexity">BFS (Queue) vs DFS (Stack)</span>
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
const graphData = {
    reception: ['cardio', 'stretching', 'weight'],
    cardio: ['reception', 'stretching', 'locker'],
    stretching: ['reception', 'cardio', 'weight'],
    weight: ['reception', 'stretching', 'steam'],
    locker: ['cardio', 'steam'],
    steam: ['weight', 'locker']
};

const zoneNames = {
    reception: 'Reception',
    cardio: 'Cardio Zone',
    stretching: 'Stretching Area',
    weight: 'Weight Zone',
    locker: 'Locker Room',
    steam: 'Steam Room'
};

function runGraphTraversal(type) {
    const start = document.getElementById('startZone').value;
    const badge = document.getElementById('traversalBadge');
    const pills = document.getElementById('zoneVisitPills');
    const stepsContainer = document.getElementById('zoneStepsContainer');

    badge.className = type === 'bfs' ? 'badge badge-paid' : 'badge badge-premium';
    badge.innerText = type === 'bfs' ? 'BFS (Queue Level-Order)' : 'DFS (Stack Depth-First)';

    var visited = [];
    var steps = [];

    if (type === 'bfs') {
        var queue = [start];
        var seen = new Set([start]);

        while (queue.length > 0) {
            var curr = queue.shift();
            visited.push(curr);
            steps.push('Dequeued <strong>' + zoneNames[curr] + '</strong>. Inspecting incident edges in adjacency list.');

            for (var ni = 0; ni < graphData[curr].length; ni++) {
                var neighbor = graphData[curr][ni];
                if (!seen.has(neighbor)) {
                    seen.add(neighbor);
                    queue.push(neighbor);
                    steps.push('Discovered unvisited neighbor <strong>' + zoneNames[neighbor] + '</strong> &rarr; Enqueued.');
                }
            }
        }
    } else {
        // DFS
        var seen = new Set();
        function dfs(curr) {
            seen.add(curr);
            visited.push(curr);
            steps.push('Pushed/Recursed into <strong>' + zoneNames[curr] + '</strong>.');

            for (var ni = 0; ni < graphData[curr].length; ni++) {
                var neighbor = graphData[curr][ni];
                if (!seen.has(neighbor)) {
                    dfs(neighbor);
                }
            }
        }
        dfs(start);
    }

    // Render Pills
    pills.innerHTML = visited.map(function(k, i) {
        return '<span class="badge ' + (i===0?'badge-vip':'badge-basic') + '">' + zoneNames[k] + '</span>';
    }).join(' &rarr; ');

    // Render Steps
    stepsContainer.innerHTML = '';
    steps.forEach(function(s, i) {
        var div = document.createElement('div');
        div.className = 'step-item';
        div.innerHTML = '<span class="step-num">Step ' + (i + 1) + '</span><div class="step-desc">' + s + '</div>';
        stepsContainer.appendChild(div);
    });

    // Animate Graph Nodes Visually
    document.querySelectorAll('.zone-node').forEach(function(n) { n.classList.remove('current-visit', 'highlighted'); });
    visited.forEach(function(zoneKey, i) {
        setTimeout(function() {
            var el = document.getElementById('node-' + zoneKey);
            if (el) {
                el.classList.add('current-visit');
                setTimeout(function() {
                    el.classList.remove('current-visit');
                    el.classList.add('highlighted');
                }, 400);
            }
        }, i * 450);
    });

    showToast('Ran ' + type.toUpperCase() + ' from ' + zoneNames[start] + '!', 'info');
}
</script>
</body>
</html>
