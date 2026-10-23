<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Expression Validator (Stack Application) | Pro-Fitness Gym</title>
    
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
                <a href="${pageContext.request.contextPath}/expression.jsp" class="sidebar-link active">
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
                    <span style="color: var(--text-primary); font-weight: 500;">Expression Validator</span>
                </div>
            </div>

            <div class="header-right">
                <div class="server-badge">
                    <span class="live-dot"></span>
                    <span>Stack Parser Active</span>
                </div>
            </div>
        </header>

        <div class="app-content">
            <div class="module-header" data-aos="fade-down">
                <div>
                    <h1 class="module-title">Expression Validator</h1>
                    <div class="module-subtitle">
                        <i class="fa-solid fa-code"></i> Stack Application &mdash; Balanced Parentheses & Bracket Matching
                    </div>
                </div>
            </div>

            <!-- Input & Sample Presets Grid -->
            <div style="display: grid; grid-template-columns: 1.1fr 0.9fr; gap: 2rem; margin-bottom: 2rem;">
                
                <!-- Input Form -->
                <div class="glass-card" data-aos="fade-right">
                    <h3 style="font-size: 1.15rem; margin-bottom: 1rem;">
                        <i class="fa-solid fa-terminal" style="color: var(--primary); margin-right: 8px;"></i>
                        Validate Workout Formula or Algebraic Syntax
                    </h3>
                    <p style="font-size: 0.88rem; color: var(--text-secondary); margin-bottom: 1.25rem;">
                        Validates matching pairs of parentheses <code>()</code>, curly brackets <code>{}</code>, and square brackets <code>[]</code> using LIFO stack verification.
                    </p>

                    <form id="expressionForm" action="${pageContext.request.contextPath}/expression" method="POST">
                        <div class="form-group">
                            <label class="form-label" for="expressionInput">Formula Expression</label>
                            <textarea id="expressionInput" name="expression" class="form-textarea" rows="4" placeholder="Enter expression e.g. {Sets * (Reps + Weight)}" required>${not empty expression ? expression : param.expression}</textarea>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">
                                <i class="fa-solid fa-microchip"></i> Validate Expression (Server)
                            </button>
                            <button type="button" class="btn btn-secondary" onclick="validateExpressionClient()">
                                <i class="fa-solid fa-play"></i> Step-by-Step Simulation
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Example Presets Card -->
                <div class="glass-card" data-aos="fade-left">
                    <h3 style="font-size: 1.15rem; margin-bottom: 1rem;">
                        <i class="fa-solid fa-bookmark" style="color: var(--secondary); margin-right: 8px;"></i>
                        Preset Workout Formulas
                    </h3>
                    <p style="font-size: 0.88rem; color: var(--text-secondary); margin-bottom: 1rem;">
                        Click any test case below to populate the validator immediately:
                    </p>

                    <div style="display: flex; flex-direction: column; gap: 0.75rem;">
                        <button class="btn btn-outline" style="justify-content: space-between;" onclick="setExpression('{Sets * (Reps + Weight)}')">
                            <span style="font-family: var(--font-mono); font-size: 0.85rem;">{Sets * (Reps + Weight)}</span>
                            <span class="badge badge-paid">Valid</span>
                        </button>

                        <button class="btn btn-outline" style="justify-content: space-between;" onclick="setExpression('[(3 * 5) + {2 - 1}]')">
                            <span style="font-family: var(--font-mono); font-size: 0.85rem;">[(3 * 5) + {2 - 1}]</span>
                            <span class="badge badge-paid">Valid</span>
                        </button>

                        <button class="btn btn-outline" style="justify-content: space-between;" onclick="setExpression('{[()()]}')">
                            <span style="font-family: var(--font-mono); font-size: 0.85rem;">{[()()]}</span>
                            <span class="badge badge-paid">Valid</span>
                        </button>

                        <button class="btn btn-outline" style="justify-content: space-between;" onclick="setExpression('{(invalid]')">
                            <span style="font-family: var(--font-mono); font-size: 0.85rem;">{(invalid]</span>
                            <span class="badge badge-unpaid">Mismatched</span>
                        </button>

                        <button class="btn btn-outline" style="justify-content: space-between;" onclick="setExpression('((Sets + Reps)')">
                            <span style="font-family: var(--font-mono); font-size: 0.85rem;">((Sets + Reps)</span>
                            <span class="badge badge-unpaid">Unclosed</span>
                        </button>
                    </div>
                </div>

            </div>

            <!-- Dynamic Result Card -->
            <div id="resultCard" class="glass-card" data-aos="fade-up" style="margin-bottom: 2rem;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                    <h3 style="font-size: 1.15rem;">
                        <i class="fa-solid fa-square-poll-vertical" style="color: var(--primary); margin-right: 8px;"></i>
                        Validation Result & Trace Diagnostics
                    </h3>
                    <div id="resultBadgeWrapper">
                        <c:choose>
                            <c:when test="${isValid == true}">
                                <span class="badge badge-paid" style="font-size: 0.9rem;"><i class="fa-solid fa-check-circle"></i> VALID BALANCED EXPRESSION</span>
                            </c:when>
                            <c:when test="${isValid == false}">
                                <span class="badge badge-unpaid" style="font-size: 0.9rem;"><i class="fa-solid fa-xmark"></i> INVALID / UNBALANCED SYNTAX</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-paid" style="font-size: 0.9rem;"><i class="fa-solid fa-check-circle"></i> VALID BALANCED EXPRESSION</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div id="resultSummary" class="glass-panel" style="background: rgba(14, 18, 32, 0.6); margin-bottom: 1.5rem;">
                    <span style="color: var(--text-muted); font-size: 0.85rem;">Target Expression:</span>
                    <div id="displayExpression" style="font-family: var(--font-mono); font-size: 1.1rem; color: #fff; margin-top: 4px;">
                        ${not empty expression ? expression : '{Sets * (Reps + Weight)}'}
                    </div>
                </div>

                <!-- Sequential Steps Trace -->
                <h4 style="font-size: 0.95rem; text-transform: uppercase; letter-spacing: 0.05em; color: var(--secondary); margin-bottom: 0.85rem;">
                    <i class="fa-solid fa-list-check"></i> Stack Push / Pop Execution Steps
                </h4>

                <div id="stepsContainer" class="step-container animate-steps">
                    <c:choose>
                        <c:when test="${not empty steps}">
                            <c:forEach items="${steps}" var="s" varStatus="loop">
                                <div class="step-item">
                                    <span class="step-num">Step ${loop.count}</span>
                                    <div class="step-desc">${s}</div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <!-- Default illustrative simulation -->
                            <div class="step-item">
                                <span class="step-num">Step 1</span>
                                <div class="step-desc">Encountered opening bracket <code>'{'</code> &rarr; <strong>PUSH</strong> onto stack. Stack: <code>['{']</code></div>
                            </div>
                            <div class="step-item">
                                <span class="step-num">Step 2</span>
                                <div class="step-desc">Encountered identifier characters <code>"Sets * "</code> &rarr; Ignored (non-bracket).</div>
                            </div>
                            <div class="step-item">
                                <span class="step-num">Step 3</span>
                                <div class="step-desc">Encountered opening bracket <code>'('</code> &rarr; <strong>PUSH</strong> onto stack. Stack: <code>['{', '(']</code></div>
                            </div>
                            <div class="step-item">
                                <span class="step-num">Step 4</span>
                                <div class="step-desc">Encountered closing bracket <code>')'</code> &rarr; <strong>POP</strong> top <code>'('</code> &mdash; Verified matching pair! Stack: <code>['{']</code></div>
                            </div>
                            <div class="step-item">
                                <span class="step-num">Step 5</span>
                                <div class="step-desc">Encountered closing bracket <code>'}'</code> &rarr; <strong>POP</strong> top <code>'{'</code> &mdash; Verified matching pair! Stack: <code>[] (Empty)</code></div>
                            </div>
                            <div class="step-item" style="border-left-color: var(--accent-green);">
                                <span class="step-num" style="color: var(--accent-green); background: rgba(0,230,118,0.15);">Final</span>
                                <div class="step-desc"><strong style="color: var(--accent-green);">SUCCESS:</strong> All brackets paired and Stack is completely empty. Expression is balanced.</div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- DS Info Box -->
            <div class="ds-info-box" data-aos="fade-up">
                <i class="fa-solid fa-circle-info ds-info-icon"></i>
                <div>
                    <h4 class="ds-info-title">Algorithmic Principle: Stack-Based Parentheses Matching</h4>
                    <p class="ds-info-desc">
                        As the expression string is parsed character by character:
                        (1) Every opening symbol <code>{, [, (</code> is pushed onto the stack.
                        (2) When a closing symbol <code>}, ], )</code> is encountered, the stack top is popped and compared. If the stack is empty or types mismatch, the expression is invalid.
                        (3) Upon string termination, the stack must be empty for true balance.
                    </p>
                    <div class="ds-complexity-tags">
                        <span class="badge badge-complexity">Time Complexity: O(n)</span>
                        <span class="badge badge-complexity">Auxiliary Space: O(n)</span>
                        <span class="badge badge-complexity">LIFO Stack Structure</span>
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
function setExpression(expr) {
    document.getElementById('expressionInput').value = expr;
    validateExpressionClient();
}

function validateExpressionClient() {
    var expr = document.getElementById('expressionInput').value.trim();
    if (!expr) {
        showToast('Please enter an expression to validate.', 'error');
        return;
    }

    document.getElementById('displayExpression').innerText = expr;

    var stack = [];
    var steps = [];
    var isValid = true;
    var stepNum = 1;

    function stackStr() {
        return '[' + stack.map(function(c) { return "'" + c + "'"; }).join(', ') + ']';
    }

    for (var i = 0; i < expr.length; i++) {
        var ch = expr[i];
        if (ch === '{' || ch === '[' || ch === '(') {
            stack.push(ch);
            steps.push('Step ' + (stepNum++) + ': Read opening bracket <code>\'' + ch + '\'</code> &rarr; <strong>PUSH</strong> onto stack. Current Stack: <code>' + stackStr() + '</code>');
        } else if (ch === '}' || ch === ']' || ch === ')') {
            if (stack.length === 0) {
                isValid = false;
                steps.push('Step ' + (stepNum++) + ': Read closing bracket <code>\'' + ch + '\'</code>, but stack is empty! <strong style="color:var(--accent-red)">MISMATCH (Extra Closing)</strong>.');
                break;
            }
            var top = stack.pop();
            var matches = (top === '{' && ch === '}') || (top === '[' && ch === ']') || (top === '(' && ch === ')');
            if (!matches) {
                isValid = false;
                steps.push('Step ' + (stepNum++) + ': Read closing bracket <code>\'' + ch + '\'</code>, but popped <code>\'' + top + '\'</code> from stack! <strong style="color:var(--accent-red)">MISMATCH</strong>.');
                break;
            } else {
                steps.push('Step ' + (stepNum++) + ': Read closing bracket <code>\'' + ch + '\'</code> &rarr; <strong>POP</strong> <code>\'' + top + '\'</code> &mdash; Verified match! Remaining Stack: <code>' + stackStr() + '</code>');
            }
        }
    }

    if (isValid && stack.length > 0) {
        isValid = false;
        steps.push('Final Check: Expression ended, but stack still contains unmatched opening brackets: <code>' + stackStr() + '</code>! <strong style="color:var(--accent-red)">UNCLOSED BRACKETS</strong>.');
    } else if (isValid) {
        steps.push('Final Check: Stack is completely empty &mdash; <strong style="color:var(--accent-green)">EXPRESSION IS FULLY BALANCED!</strong>');
    }

    // Render Badge
    var badgeWrapper = document.getElementById('resultBadgeWrapper');
    if (isValid) {
        badgeWrapper.innerHTML = '<span class="badge badge-paid" style="font-size: 0.9rem;"><i class="fa-solid fa-check-circle"></i> VALID BALANCED EXPRESSION</span>';
    } else {
        badgeWrapper.innerHTML = '<span class="badge badge-unpaid" style="font-size: 0.9rem;"><i class="fa-solid fa-xmark"></i> INVALID / UNBALANCED SYNTAX</span>';
    }

    // Render Steps
    var container = document.getElementById('stepsContainer');
    container.innerHTML = '';
    steps.forEach(function(s, idx) {
        var div = document.createElement('div');
        div.className = 'step-item';
        div.innerHTML = '<span class="step-num">Step ' + (idx + 1) + '</span><div class="step-desc">' + s + '</div>';
        container.appendChild(div);
    });

    showToast(isValid ? 'Expression is valid!' : 'Expression syntax error detected!', isValid ? 'success' : 'error');
}
</script>
</body>
</html>
