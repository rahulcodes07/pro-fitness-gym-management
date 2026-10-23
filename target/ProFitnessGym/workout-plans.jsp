<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Workout Plans (Binary Tree) | Pro-Fitness Gym</title>
    
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
        /* CSS Hierarchy Tree Styling */
        .tree-wrapper {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 2rem 1rem;
            overflow-x: auto;
        }

        .tree-node-box {
            background: rgba(22, 28, 48, 0.9);
            border: 1px solid var(--border-light);
            border-radius: var(--radius-md);
            padding: 0.65rem 1.1rem;
            color: #ffffff;
            font-weight: 600;
            font-size: 0.85rem;
            text-align: center;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            cursor: pointer;
            min-width: 110px;
        }

        .tree-node-box.active-traversal {
            border-color: var(--secondary);
            background: rgba(0, 212, 255, 0.25);
            box-shadow: 0 0 20px rgba(0, 212, 255, 0.6);
            transform: scale(1.1);
        }

        .tree-node-box.root-box {
            border-color: var(--primary);
            background: linear-gradient(135deg, rgba(255, 107, 53, 0.2), rgba(26, 32, 53, 0.95));
            box-shadow: 0 0 15px rgba(255, 107, 53, 0.3);
        }

        .tree-branch {
            display: flex;
            justify-content: center;
            gap: 2rem;
            position: relative;
            margin-top: 1.5rem;
        }

        .connector-vertical {
            width: 2px;
            height: 20px;
            background: rgba(255, 255, 255, 0.2);
            margin: 0 auto;
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
                <a href="${pageContext.request.contextPath}/workout-plans.jsp" class="sidebar-link active">
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
        <header class="app-header">
            <div class="header-left">
                <button class="sidebar-toggle-btn" aria-label="Toggle Sidebar">
                    <i class="fa-solid fa-bars"></i>
                </button>
                <div class="page-breadcrumb">
                    <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
                    <i class="fa-solid fa-chevron-right" style="font-size: 0.7rem;"></i>
                    <span style="color: var(--text-primary); font-weight: 500;">Workout Plans</span>
                </div>
            </div>

            <div class="header-right">
                <div class="server-badge">
                    <span class="live-dot"></span>
                    <span>Binary Tree Engine Active</span>
                </div>
            </div>
        </header>

        <div class="app-content">
            <div class="module-header" data-aos="fade-down">
                <div>
                    <h1 class="module-title">Workout Plans</h1>
                    <div class="module-subtitle">
                        <i class="fa-solid fa-sitemap"></i> Powered by Binary Tree &mdash; Hierarchical Traversals
                    </div>
                </div>
            </div>

            <!-- Graphical Tree Visualization Card -->
            <div class="glass-card mb-4" data-aos="fade-up" style="margin-bottom: 2rem;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
                    <h3 style="font-size: 1.15rem;">
                        <i class="fa-solid fa-network-wired" style="color: var(--primary); margin-right: 8px;"></i>
                        Exercise Hierarchy Binary Tree
                    </h3>
                    <span class="badge badge-ds">Hierarchical Non-Linear Structure</span>
                </div>

                <div class="tree-wrapper">
                    <!-- Level 0: Root -->
                    <div class="tree-node-box root-box" id="node-workout">
                        <i class="fa-solid fa-dumbbell" style="color: var(--primary); margin-right: 5px;"></i>
                        Workout Plans (Root)
                    </div>
                    <div class="connector-vertical"></div>

                    <!-- Level 1: Cardio vs Strength -->
                    <div class="tree-branch" style="gap: 12rem;">
                        <!-- Left Subtree -->
                        <div style="display:flex; flex-direction:column; align-items:center;">
                            <div class="tree-node-box" id="node-cardio">
                                <i class="fa-solid fa-heart-pulse" style="color: var(--secondary); margin-right: 5px;"></i>
                                Cardio
                            </div>
                            <div class="connector-vertical"></div>

                            <!-- Level 2 Left: HIIT & Running -->
                            <div class="tree-branch" style="gap: 2rem;">
                                <div class="tree-node-box" id="node-hiit">
                                    <i class="fa-solid fa-stopwatch-20"></i> HIIT
                                </div>
                                <div class="tree-node-box" id="node-running">
                                    <i class="fa-solid fa-person-running"></i> Running
                                </div>
                            </div>
                        </div>

                        <!-- Right Subtree -->
                        <div style="display:flex; flex-direction:column; align-items:center;">
                            <div class="tree-node-box" id="node-strength">
                                <i class="fa-solid fa-weight-hanging" style="color: var(--primary); margin-right: 5px;"></i>
                                Strength
                            </div>
                            <div class="connector-vertical"></div>

                            <!-- Level 2 Right: Upper Body & Lower Body -->
                            <div class="tree-branch" style="gap: 3rem;">
                                <!-- Upper Body and its Children -->
                                <div style="display:flex; flex-direction:column; align-items:center;">
                                    <div class="tree-node-box" id="node-upper">Upper Body</div>
                                    <div class="connector-vertical"></div>
                                    <!-- Level 3 -->
                                    <div class="tree-branch" style="gap: 1rem;">
                                        <div class="tree-node-box" id="node-chest">Chest</div>
                                        <div class="tree-node-box" id="node-shoulders">Shoulders</div>
                                    </div>
                                </div>

                                <!-- Lower Body and its Children -->
                                <div style="display:flex; flex-direction:column; align-items:center;">
                                    <div class="tree-node-box" id="node-lower">Lower Body</div>
                                    <div class="connector-vertical"></div>
                                    <div class="tree-branch">
                                        <div class="tree-node-box" id="node-legs">Legs</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Primary Traversal Clarification Callout -->
            <div class="glass-panel mb-4" data-aos="fade-up" style="margin-bottom: 1.5rem; border-left: 4px solid var(--accent-green);">
                <div style="display: flex; align-items: flex-start; gap: 1rem;">
                    <i class="fa-solid fa-circle-check" style="color: var(--accent-green); font-size: 1.4rem; margin-top: 3px;"></i>
                    <div>
                        <h4 style="font-size: 1rem; color: #fff; margin-bottom: 0.25rem;">
                            Primary Operational Traversal: In-Order Traversal (Left &rarr; Root &rarr; Right)
                        </h4>
                        <p style="font-size: 0.88rem; color: var(--text-secondary); margin: 0; line-height: 1.6;">
                            In our gym curriculum engine, <strong>In-Order Traversal</strong> is the core operational method because it traverses sub-disciplines before major parent categories, presenting an intuitive bottom-up progressive training path. 
                            <strong>Pre-Order</strong> and <strong>Post-Order</strong> traversals are fully implemented and showcased below for academic comparison and structural evaluation.
                        </p>
                    </div>
                </div>
            </div>

            <!-- Traversal Control Actions -->
            <div class="glass-card mb-4" data-aos="fade-up" style="margin-bottom: 2rem;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                    <h3 style="font-size: 1.15rem; margin: 0;">
                        <i class="fa-solid fa-route" style="color: var(--secondary); margin-right: 8px;"></i>
                        Execute Binary Tree Traversals
                    </h3>
                    <span class="badge badge-success">In-Order = Active System Traversal</span>
                </div>

                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1rem;">
                    <form action="${pageContext.request.contextPath}/workout-plans" method="POST" style="margin: 0;">
                        <input type="hidden" name="traversal" value="inorder">
                        <button type="button" class="btn btn-primary" style="width: 100%; justify-content: flex-start; padding: 1.1rem; border: 2px solid var(--accent-green);" onclick="runTraversal('inorder')">
                            <i class="fa-solid fa-star" style="color: #ffd700;"></i>
                            <div style="text-align: left;">
                                <div style="font-weight: 700; color: #fff;">In-Order Traversal <span class="badge badge-paid" style="font-size: 0.65rem; margin-left: 6px;">PRIMARY</span></div>
                                <div style="font-size: 0.75rem; color: rgba(255,255,255,0.85);">Left &rarr; Root &rarr; Right (Operational Curriculum)</div>
                            </div>
                        </button>
                    </form>

                    <form action="${pageContext.request.contextPath}/workout-plans" method="POST" style="margin: 0;">
                        <input type="hidden" name="traversal" value="preorder">
                        <button type="button" class="btn btn-outline" style="width: 100%; justify-content: flex-start; padding: 1.1rem;" onclick="runTraversal('preorder')">
                            <i class="fa-solid fa-arrow-down-long" style="color: var(--primary);"></i>
                            <div style="text-align: left;">
                                <div style="font-weight: 700; color: #fff;">Pre-Order Traversal <span class="badge badge-basic" style="font-size: 0.65rem; margin-left: 6px;">DEMO</span></div>
                                <div style="font-size: 0.75rem; color: var(--text-muted);">Root &rarr; Left &rarr; Right (Top-down Showcase)</div>
                            </div>
                        </button>
                    </form>

                    <form action="${pageContext.request.contextPath}/workout-plans" method="POST" style="margin: 0;">
                        <input type="hidden" name="traversal" value="postorder">
                        <button type="button" class="btn btn-outline" style="width: 100%; justify-content: flex-start; padding: 1.1rem;" onclick="runTraversal('postorder')">
                            <i class="fa-solid fa-arrow-up-long" style="color: var(--secondary);"></i>
                            <div style="text-align: left;">
                                <div style="font-weight: 700; color: #fff;">Post-Order Traversal <span class="badge badge-basic" style="font-size: 0.65rem; margin-left: 6px;">DEMO</span></div>
                                <div style="font-size: 0.75rem; color: var(--text-muted);">Left &rarr; Right &rarr; Root (Bottom-up Cleanup)</div>
                            </div>
                        </button>
                    </form>
                </div>
            </div>

            <!-- Traversal Output & Step Log -->
            <div class="glass-card" data-aos="fade-up" style="margin-bottom: 2rem;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                    <h3 style="font-size: 1.15rem;">
                        <i class="fa-solid fa-list-ol" style="color: var(--accent-green); margin-right: 8px;"></i>
                        Traversal Output Sequence
                    </h3>
                    <span id="currentTraversalType" class="badge badge-paid">In-Order Sequence (Primary Operational)</span>
                </div>

                <!-- Sequence Pills Display -->
                <div id="sequencePills" style="display: flex; gap: 0.5rem; flex-wrap: wrap; padding: 1rem; background: rgba(14, 18, 32, 0.7); border-radius: var(--radius-md); margin-bottom: 1.5rem; border: 1px solid var(--border-subtle);">
                    <!-- Default In-order sequence -->
                    <span class="badge badge-basic">HIIT</span> &rarr;
                    <span class="badge badge-basic">Cardio</span> &rarr;
                    <span class="badge badge-basic">Running</span> &rarr;
                    <span class="badge badge-vip">Workout Plans (Root)</span> &rarr;
                    <span class="badge badge-basic">Chest</span> &rarr;
                    <span class="badge badge-basic">Upper Body</span> &rarr;
                    <span class="badge badge-basic">Shoulders</span> &rarr;
                    <span class="badge badge-basic">Strength</span> &rarr;
                    <span class="badge badge-basic">Legs</span> &rarr;
                    <span class="badge badge-basic">Lower Body</span>
                </div>

                <!-- Step Log Container -->
                <h4 style="font-size: 0.95rem; text-transform: uppercase; color: var(--secondary); letter-spacing: 0.05em; margin-bottom: 0.75rem;">
                    Step-by-Step Recursive Visits
                </h4>
                <div id="traversalStepsContainer" class="step-container animate-steps">
                    <div class="step-item">
                        <span class="step-num">Step 1</span>
                        <div class="step-desc">Recursed to leftmost leaf node <strong>HIIT</strong>.</div>
                    </div>
                    <div class="step-item">
                        <span class="step-num">Step 2</span>
                        <div class="step-desc">Visited parent node <strong>Cardio</strong>.</div>
                    </div>
                    <div class="step-item">
                        <span class="step-num">Step 3</span>
                        <div class="step-desc">Visited right child <strong>Running</strong>.</div>
                    </div>
                    <div class="step-item">
                        <span class="step-num">Step 4</span>
                        <div class="step-desc">Visited root node <strong>Workout Plans</strong>.</div>
                    </div>
                </div>
            </div>

            <!-- DS Info Box -->
            <div class="ds-info-box" data-aos="fade-up">
                <i class="fa-solid fa-circle-info ds-info-icon"></i>
                <div>
                    <h4 class="ds-info-title">Data Structure Mechanics: Binary Tree Hierarchies & Traversal Selection</h4>
                    <p class="ds-info-desc">
                        Each node contains up to two children (left and right pointer references). Tree traversals are recursive depth-first search strategies visiting every node exactly once:
                        <br><strong>In-order (Primary Operation):</strong> Visits left subtree, root, then right. In this gym system, it presents progressive workout routines where foundational sub-exercises precede broader program categories.
                        <br><strong>Pre-order (Demonstration):</strong> Visits root first; showcased to illustrate hierarchical curriculum cloning and top-down serialization.
                        <br><strong>Post-order (Demonstration):</strong> Visits children before root; showcased to illustrate memory deallocation and bottom-up metric rollups.
                    </p>
                    <div class="ds-complexity-tags">
                        <span class="badge badge-complexity">Time Complexity: O(n)</span>
                        <span class="badge badge-complexity">Auxiliary Stack Space: O(h) [Height]</span>
                        <span class="badge badge-complexity">Primary: In-Order</span>
                        <span class="badge badge-complexity">Demo: Pre & Post</span>
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
const traversals = {
    preorder: {
        name: 'Pre-Order Traversal (Root → Left → Right)',
        nodes: ['workout', 'cardio', 'hiit', 'running', 'strength', 'upper', 'chest', 'shoulders', 'lower', 'legs'],
        labels: ['Workout Plans', 'Cardio', 'HIIT', 'Running', 'Strength', 'Upper Body', 'Chest', 'Shoulders', 'Lower Body', 'Legs']
    },
    inorder: {
        name: 'In-Order Traversal (Left → Root → Right)',
        nodes: ['hiit', 'cardio', 'running', 'workout', 'chest', 'upper', 'shoulders', 'strength', 'legs', 'lower'],
        labels: ['HIIT', 'Cardio', 'Running', 'Workout Plans', 'Chest', 'Upper Body', 'Shoulders', 'Strength', 'Legs', 'Lower Body']
    },
    postorder: {
        name: 'Post-Order Traversal (Left → Right → Root)',
        nodes: ['hiit', 'running', 'cardio', 'chest', 'shoulders', 'upper', 'legs', 'lower', 'strength', 'workout'],
        labels: ['HIIT', 'Running', 'Cardio', 'Chest', 'Shoulders', 'Upper Body', 'Legs', 'Lower Body', 'Strength', 'Workout Plans']
    }
};

function runTraversal(type) {
    var data = traversals[type];
    if (!data) return;

    document.getElementById('currentTraversalType').innerText = data.name;

    // Reset visual highlights
    document.querySelectorAll('.tree-node-box').forEach(function(el) { el.classList.remove('active-traversal'); });

    // Render sequence pills
    var pills = document.getElementById('sequencePills');
    pills.innerHTML = data.labels.map(function(lbl, i) {
        return '<span class="badge ' + (i===0?'badge-vip':'badge-basic') + '">' + lbl + '</span>';
    }).join(' &rarr; ');

    // Render step by step
    var stepsContainer = document.getElementById('traversalStepsContainer');
    stepsContainer.innerHTML = '';

    data.nodes.forEach(function(nodeId, idx) {
        setTimeout(function() {
            // Highlight node in visual tree
            document.querySelectorAll('.tree-node-box').forEach(function(el) { el.classList.remove('active-traversal'); });
            var el = document.getElementById('node-' + nodeId);
            if (el) el.classList.add('active-traversal');

            // Append step
            var div = document.createElement('div');
            div.className = 'step-item';
            div.innerHTML = '<span class="step-num">Step ' + (idx + 1) + '</span><div class="step-desc">Visited node: <strong>' + data.labels[idx] + '</strong> [ID: <code>' + nodeId + '</code>]</div>';
            stepsContainer.appendChild(div);
        }, idx * 450);
    });

    showToast('Executing ' + data.name + '...', 'info');
}
</script>
</body>
</html>


