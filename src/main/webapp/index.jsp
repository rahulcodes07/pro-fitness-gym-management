<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pro-Fitness Gym | DSA Enterprise Management System</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;600;700;800;900&family=Fira+Code:wght@400;600&display=swap" rel="stylesheet">
    
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <!-- AOS Animation Library -->
    <link rel="stylesheet" href="https://unpkg.com/aos@2.3.1/dist/aos.css">
    
    <!-- Master Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <!-- ==================== NAVIGATION BAR ==================== -->
    <nav class="landing-nav">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/index.jsp" class="brand-logo">
                <i class="fa-solid fa-dumbbell"></i>
                <span>PRO-FITNESS <span class="gradient-text-orange">GYM</span></span>
            </a>
            
            <ul class="nav-menu">
                <li><a href="#hero" class="nav-link active">Home</a></li>
                <li><a href="#modules" class="nav-link">DSA Modules</a></li>
                <li><a href="#structures" class="nav-link">Architecture</a></li>
                <li><a href="#phases" class="nav-link">Phases</a></li>
                <li><a href="#about" class="nav-link">About Project</a></li>
                <li>
                    <a href="${pageContext.request.contextPath}/members.jsp" class="btn btn-primary btn-sm">
                        <i class="fa-solid fa-arrow-right-to-bracket"></i> Launch App
                    </a>
                </li>
            </ul>

            <button class="nav-toggle" aria-label="Toggle navigation">
                <i class="fa-solid fa-bars"></i>
            </button>
        </div>
    </nav>

    <!-- ==================== HERO SECTION ==================== -->
    <header id="hero" class="hero-section">
        <div class="hero-glow-1"></div>
        <div class="hero-glow-2"></div>

        <div class="hero-container">
            <div class="hero-content" data-aos="fade-right" data-aos-duration="1000">
                <div class="hero-badge">
                    <i class="fa-solid fa-microchip"></i> MCA Data Structures & Algorithms Project
                </div>
                
                <h1 class="hero-title">
                    PRO-FITNESS <br>
                    <span class="gradient-text-orange">MANAGEMENT SYSTEM</span>
                </h1>
                
                <p class="hero-subtitle">
                    An enterprise-grade fitness center infrastructure engineered with custom 
                    <strong style="color: #fff;">Data Structures & Advanced Algorithms</strong>. Built on Jakarta EE and Tomcat 10 for peak efficiency and real-time computation.
                </p>

                <div class="hero-actions">
                    <a href="${pageContext.request.contextPath}/members.jsp" class="btn btn-primary btn-lg">
                        <i class="fa-solid fa-play"></i> Explore System
                    </a>
                    <a href="#modules" class="btn btn-secondary btn-lg">
                        <i class="fa-solid fa-cubes"></i> View All Modules
                    </a>
                </div>

                <div class="hero-stats">
                    <div class="stat-item">
                        <h3 class="counter-val" data-target="6">6</h3>
                        <p>Core DS Modules</p>
                    </div>
                    <div class="stat-item">
                        <h3 class="counter-val" data-target="4">4</h3>
                        <p>Project Phases</p>
                    </div>
                    <div class="stat-item">
                        <h3 style="color: var(--secondary);"><span class="counter-val" data-target="100">100</span>%</h3>
                        <p>Custom Algorithms</p>
                    </div>
                </div>
            </div>

            <!-- Terminal / Code Simulation Visual Card -->
            <div class="hero-visual" data-aos="zoom-in" data-aos-delay="200" data-aos-duration="1000">
                <div class="hero-card-stack">
                    <div class="floating-terminal">
                        <div class="terminal-header">
                            <span class="terminal-dot dot-red"></span>
                            <span class="terminal-dot dot-yellow"></span>
                            <span class="terminal-dot dot-green"></span>
                            <span class="terminal-title">ProFitnessDSAEngine.java</span>
                        </div>
                        <div class="terminal-body">
                            <p><span class="terminal-cyan">// Dynamic Memory Management</span></p>
                            <p><span class="terminal-highlight">MemberLinkedList</span> members = new MemberLinkedList();</p>
                            <p>members.<span class="terminal-cyan">addMember</span>(101, "Alex Morgan", "VIP", "Paid");</p>
                            <br>
                            <p><span class="terminal-cyan">// LIFO Session Tracking Stack</span></p>
                            <p><span class="terminal-highlight">CheckInStack</span> sessionStack = new CheckInStack();</p>
                            <p>sessionStack.<span class="terminal-cyan">push</span>(101, "Alex Morgan", "15:30");</p>
                            <br>
                            <p><span class="terminal-cyan">// FIFO Trainer Appointments Queue</span></p>
                            <p><span class="terminal-highlight">AppointmentQueue</span> queue = new AppointmentQueue();</p>
                            <p>queue.<span class="terminal-cyan">enqueue</span>(101, "Alex", "Arjun", "17:00");</p>
                            <br>
                            <p><span class="terminal-green">&#10004; Engine Initialized: All Data Structures Active</span></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- ==================== MODULES SHOWCASE ==================== -->
    <section id="modules" class="section">
        <div class="section-container">
            <div class="section-header" data-aos="fade-up">
                <span class="section-subtitle">System Capabilities</span>
                <h2 class="section-title">Core Data Structure Modules</h2>
                <p class="section-desc">Each gym operational workflow is mapped directly to a purpose-built data structure for optimal algorithmic performance.</p>
            </div>

            <div class="features-grid">
                <!-- Module 1: Member Management -->
                <div class="feature-card" data-aos="fade-up" data-aos-delay="100">
                    <div class="feature-icon-wrapper">
                        <i class="fa-solid fa-users"></i>
                    </div>
                    <span class="feature-ds-tag"><i class="fa-solid fa-link"></i> Singly Linked List</span>
                    <h3 class="feature-title">Member Management</h3>
                    <p class="feature-desc">Dynamic member registration, instant node insertion, and pointer-based record updates without static array resizing overhead.</p>
                    <a href="${pageContext.request.contextPath}/members.jsp" class="feature-link">
                        Open Module <i class="fa-solid fa-arrow-right"></i>
                    </a>
                </div>

                <!-- Module 2: Session Tracking -->
                <div class="feature-card" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-icon-wrapper">
                        <i class="fa-solid fa-layer-group"></i>
                    </div>
                    <span class="feature-ds-tag"><i class="fa-solid fa-arrow-up-z-a"></i> Stack (LIFO)</span>
                    <h3 class="feature-title">Session Tracking</h3>
                    <p class="feature-desc">Real-time floor check-in tracking operating on Last-In-First-Out logic with constant time O(1) Push, Pop, and Peek inspections.</p>
                    <a href="${pageContext.request.contextPath}/checkin.jsp" class="feature-link">
                        Open Module <i class="fa-solid fa-arrow-right"></i>
                    </a>
                </div>

                <!-- Module 3: Trainer Appointments -->
                <div class="feature-card" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-icon-wrapper">
                        <i class="fa-solid fa-calendar-check"></i>
                    </div>
                    <span class="feature-ds-tag"><i class="fa-solid fa-arrows-split-up-and-left"></i> Queue (FIFO)</span>
                    <h3 class="feature-title">Trainer Appointments</h3>
                    <p class="feature-desc">Fair scheduling pipeline processing personal trainer requests strictly First-In-First-Out with head and tail pointer queuing.</p>
                    <a href="${pageContext.request.contextPath}/appointments.jsp" class="feature-link">
                        Open Module <i class="fa-solid fa-arrow-right"></i>
                    </a>
                </div>

                <!-- Module 4: Workout Plans -->
                <div class="feature-card" data-aos="fade-up" data-aos-delay="400">
                    <div class="feature-icon-wrapper">
                        <i class="fa-solid fa-sitemap"></i>
                    </div>
                    <span class="feature-ds-tag"><i class="fa-solid fa-network-wired"></i> Binary Tree</span>
                    <h3 class="feature-title">Workout Plans</h3>
                    <p class="feature-desc">Hierarchical exercise routine planning traversed via Pre-Order, In-Order, and Post-Order recursive tree traversals.</p>
                    <a href="${pageContext.request.contextPath}/workout-plans.jsp" class="feature-link">
                        Open Module <i class="fa-solid fa-arrow-right"></i>
                    </a>
                </div>

                <!-- Module 5: Zone Navigation -->
                <div class="feature-card" data-aos="fade-up" data-aos-delay="500">
                    <div class="feature-icon-wrapper">
                        <i class="fa-solid fa-map-location-dot"></i>
                    </div>
                    <span class="feature-ds-tag"><i class="fa-solid fa-circle-nodes"></i> Graph (Adjacency List)</span>
                    <h3 class="feature-title">Zone Navigation</h3>
                    <p class="feature-desc">Facility layout mapping with Breadth-First Search (BFS) for shortest route exploration and Depth-First Search (DFS) for zone audits.</p>
                    <a href="${pageContext.request.contextPath}/zones.jsp" class="feature-link">
                        Open Module <i class="fa-solid fa-arrow-right"></i>
                    </a>
                </div>

                <!-- Module 6: Search & Sort Benchmark -->
                <div class="feature-card" data-aos="fade-up" data-aos-delay="600">
                    <div class="feature-icon-wrapper">
                        <i class="fa-solid fa-magnifying-glass-chart"></i>
                    </div>
                    <span class="feature-ds-tag"><i class="fa-solid fa-chart-line"></i> Algorithm Benchmarking</span>
                    <h3 class="feature-title">Search & Sort Comparison</h3>
                    <p class="feature-desc">Side-by-side performance comparison of Linear vs Binary Search, alongside Insertion Sort vs Merge Sort with metric diagnostics.</p>
                    <a href="${pageContext.request.contextPath}/search-sort.jsp" class="feature-link">
                        Open Module <i class="fa-solid fa-arrow-right"></i>
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- ==================== ARCHITECTURE & TIME COMPLEXITY ==================== -->
    <section id="structures" class="section" style="background: rgba(14, 18, 32, 0.45);">
        <div class="section-container">
            <div class="section-header" data-aos="fade-up">
                <span class="section-subtitle">Algorithmic Rigor</span>
                <h2 class="section-title">Data Structures Architecture</h2>
                <p class="section-desc">Analysis of worst-case and average-case asymptotic complexities implemented across the project.</p>
            </div>

            <div class="ds-grid">
                <div class="ds-card" data-aos="zoom-in" data-aos-delay="100">
                    <div class="ds-card-header">
                        <span class="ds-card-title"><i class="fa-solid fa-link" style="color:var(--primary); margin-right:6px;"></i> Singly Linked List</span>
                        <span class="badge badge-complexity">O(1) / O(n)</span>
                    </div>
                    <p style="font-size: 0.88rem; color: var(--text-secondary);">
                        Constant time O(1) head insertion for newly joined members; linear scan O(n) for membership search and pointer relinking upon cancellation.
                    </p>
                </div>

                <div class="ds-card" data-aos="zoom-in" data-aos-delay="200">
                    <div class="ds-card-header">
                        <span class="ds-card-title"><i class="fa-solid fa-layer-group" style="color:var(--secondary); margin-right:6px;"></i> LIFO Stack</span>
                        <span class="badge badge-complexity">O(1) Time</span>
                    </div>
                    <p style="font-size: 0.88rem; color: var(--text-secondary);">
                        Guarantees strictly O(1) time complexity for Push (check-in), Pop (check-out of latest member), and Peek operations.
                    </p>
                </div>

                <div class="ds-card" data-aos="zoom-in" data-aos-delay="300">
                    <div class="ds-card-header">
                        <span class="ds-card-title"><i class="fa-solid fa-calendar-check" style="color:var(--accent-green); margin-right:6px;"></i> FIFO Queue</span>
                        <span class="badge badge-complexity">O(1) Time</span>
                    </div>
                    <p style="font-size: 0.88rem; color: var(--text-secondary);">
                        Maintains front and rear pointers to enable O(1) enqueue and dequeue operations for equitable trainer booking.
                    </p>
                </div>

                <div class="ds-card" data-aos="zoom-in" data-aos-delay="400">
                    <div class="ds-card-header">
                        <span class="ds-card-title"><i class="fa-solid fa-tree" style="color:var(--accent-purple); margin-right:6px;"></i> Binary Search Tree</span>
                        <span class="badge badge-complexity">O(log n)</span>
                    </div>
                    <p style="font-size: 0.88rem; color: var(--text-secondary);">
                        Enables logarithmic O(log n) member ID lookups and structured in-order sorted traversal across registered athletes.
                    </p>
                </div>

                <div class="ds-card" data-aos="zoom-in" data-aos-delay="500">
                    <div class="ds-card-header">
                        <span class="ds-card-title"><i class="fa-solid fa-route" style="color:var(--primary); margin-right:6px;"></i> Zone Graph</span>
                        <span class="badge badge-complexity">O(V + E)</span>
                    </div>
                    <p style="font-size: 0.88rem; color: var(--text-secondary);">
                        Adjacency list representation connecting gym sectors; traverses vertices and edges in linear time O(V + E) with BFS and DFS.
                    </p>
                </div>

                <div class="ds-card" data-aos="zoom-in" data-aos-delay="600">
                    <div class="ds-card-header">
                        <span class="ds-card-title"><i class="fa-solid fa-brain" style="color:var(--secondary); margin-right:6px;"></i> Advanced Algorithms</span>
                        <span class="badge badge-complexity">DP & Greedy</span>
                    </div>
                    <p style="font-size: 0.88rem; color: var(--text-secondary);">
                        Greedy Activity Selection for trainer shift allocation and 0/1 Knapsack Dynamic Programming for calorie-optimized workout routines.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- ==================== PHASE OVERVIEW ==================== -->
    <section id="phases" class="section">
        <div class="section-container">
            <div class="section-header" data-aos="fade-up">
                <span class="section-subtitle">Curriculum Milestones</span>
                <h2 class="section-title">Project Implementation Phases</h2>
                <p class="section-desc">Comprehensive progression from fundamental linear structures through non-linear hierarchies to advanced algorithmic paradigms.</p>
            </div>

            <div class="timeline-grid">
                <!-- Phase 1 -->
                <div class="timeline-card" data-aos="fade-up" data-aos-delay="100">
                    <div class="phase-number">Phase 01</div>
                    <h3 class="phase-title">Linear Data Structures</h3>
                    <ul class="phase-list">
                        <li><i class="fa-solid fa-check"></i> Singly Linked List Member Register</li>
                        <li><i class="fa-solid fa-check"></i> Stack-based Session Check-in</li>
                        <li><i class="fa-solid fa-check"></i> Queue Trainer Appointments</li>
                        <li><i class="fa-solid fa-check"></i> Interactive Terminal App</li>
                    </ul>
                </div>

                <!-- Phase 2 -->
                <div class="timeline-card" data-aos="fade-up" data-aos-delay="200">
                    <div class="phase-number">Phase 02</div>
                    <h3 class="phase-title">Stack Apps & Non-Linear</h3>
                    <ul class="phase-list">
                        <li><i class="fa-solid fa-check"></i> Workout Formula Bracket Validator</li>
                        <li><i class="fa-solid fa-check"></i> Hierarchical Binary Tree Routines</li>
                        <li><i class="fa-solid fa-check"></i> Binary Search Tree (BST) Index</li>
                        <li><i class="fa-solid fa-check"></i> Recursive Tree Traversals</li>
                    </ul>
                </div>

                <!-- Phase 3 -->
                <div class="timeline-card" data-aos="fade-up" data-aos-delay="300">
                    <div class="phase-number">Phase 03</div>
                    <h3 class="phase-title">Graphs, Search & Sort</h3>
                    <ul class="phase-list">
                        <li><i class="fa-solid fa-check"></i> Facility Graph (Adjacency List)</li>
                        <li><i class="fa-solid fa-check"></i> BFS & DFS Zone Traversals</li>
                        <li><i class="fa-solid fa-check"></i> Linear vs Binary Search Engine</li>
                        <li><i class="fa-solid fa-check"></i> Insertion Sort vs Merge Sort</li>
                    </ul>
                </div>

                <!-- Phase 4 -->
                <div class="timeline-card" data-aos="fade-up" data-aos-delay="400">
                    <div class="phase-number">Phase 04</div>
                    <h3 class="phase-title">Advanced Paradigms & Web</h3>
                    <ul class="phase-list">
                        <li><i class="fa-solid fa-check"></i> Greedy Interval Trainer Scheduler</li>
                        <li><i class="fa-solid fa-check"></i> 0/1 Knapsack Dynamic Programming</li>
                        <li><i class="fa-solid fa-check"></i> Backtracking Assignment Solver</li>
                        <li><i class="fa-solid fa-check"></i> Jakarta EE 10 & Tomcat 10.1 Web UI</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <!-- ==================== ABOUT & CREDITS ==================== -->
    <section id="about" class="section">
        <div class="section-container">
            <div class="about-card" data-aos="zoom-in">
                <div>
                    <span class="section-subtitle">Academic Credentials</span>
                    <h2 style="font-size: 2.2rem; margin-bottom: 1rem;">Project Information</h2>
                    <p style="color: var(--text-secondary); line-height: 1.7;">
                        Developed as a master-level curriculum project demonstrating the practical software engineering application of classical data structures and optimization algorithms in a modern enterprise web application.
                    </p>

                    <div class="author-meta">
                        <div class="meta-box">
                            <span class="meta-label">Student Name</span>
                            <div class="meta-value">Rahul Raj</div>
                        </div>
                        <div class="meta-box">
                            <span class="meta-label">Register Number</span>
                            <div class="meta-value">26MCAB57</div>
                        </div>
                        <div class="meta-box">
                            <span class="meta-label">Degree & Section</span>
                            <div class="meta-value">MCA - Section B</div>
                        </div>
                        <div class="meta-box">
                            <span class="meta-label">Institution</span>
                            <div class="meta-value">Kristu Jayanti College</div>
                        </div>
                    </div>
                </div>

                <div style="background: rgba(10, 12, 22, 0.7); border: 1px solid var(--border-subtle); border-radius: var(--radius-lg); padding: 2rem;">
                    <h3 style="font-size: 1.25rem; margin-bottom: 1rem; color: var(--primary);">
                        <i class="fa-solid fa-server"></i> Technical Stack
                    </h3>
                    <ul style="list-style: none; display: flex; flex-direction: column; gap: 0.85rem; font-size: 0.92rem;">
                        <li><strong style="color:#fff;">Runtime Server:</strong> Apache Tomcat 10.1.60</li>
                        <li><strong style="color:#fff;">Java Platform:</strong> Java SE 23 / 17 (Jakarta EE 10)</li>
                        <li><strong style="color:#fff;">Architecture:</strong> MVC (Jakarta Servlets, JSP 3.1, JSTL)</li>
                        <li><strong style="color:#fff;">Frontend:</strong> HTML5, CSS3 Glassmorphism, Vanilla JS, AOS</li>
                        <li><strong style="color:#fff;">DSA Engine:</strong> Zero External Libraries, Pure Java Implementations</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <!-- ==================== FOOTER ==================== -->
    <footer class="landing-footer">
        <div class="footer-container">
            <div>
                <a href="${pageContext.request.contextPath}/index.jsp" class="brand-logo">
                    <i class="fa-solid fa-dumbbell"></i>
                    <span>PRO-FITNESS <span class="gradient-text-orange">GYM</span></span>
                </a>
                <p style="color: var(--text-muted); font-size: 0.88rem; margin-top: 0.5rem; max-width: 400px;">
                    MCA Data Structures & Algorithms Enterprise Gym Management System.
                </p>
            </div>

            <div style="display: flex; gap: 2rem; flex-wrap: wrap;">
                <div>
                    <h4 style="font-size: 0.95rem; margin-bottom: 0.75rem; color: #fff;">Linear Modules</h4>
                    <p style="margin-bottom: 0.35rem;"><a href="${pageContext.request.contextPath}/members.jsp">Member Management</a></p>
                    <p style="margin-bottom: 0.35rem;"><a href="${pageContext.request.contextPath}/checkin.jsp">Session Stack</a></p>
                    <p><a href="${pageContext.request.contextPath}/appointments.jsp">Trainer Queue</a></p>
                </div>
                <div>
                    <h4 style="font-size: 0.95rem; margin-bottom: 0.75rem; color: #fff;">Trees & Graphs</h4>
                    <p style="margin-bottom: 0.35rem;"><a href="${pageContext.request.contextPath}/workout-plans.jsp">Binary Tree Plans</a></p>
                    <p style="margin-bottom: 0.35rem;"><a href="${pageContext.request.contextPath}/bst.jsp">BST Lookup</a></p>
                    <p><a href="${pageContext.request.contextPath}/zones.jsp">Facility Graph</a></p>
                </div>
                <div>
                    <h4 style="font-size: 0.95rem; margin-bottom: 0.75rem; color: #fff;">Algorithms</h4>
                    <p style="margin-bottom: 0.35rem;"><a href="${pageContext.request.contextPath}/expression.jsp">Bracket Validator</a></p>
                    <p style="margin-bottom: 0.35rem;"><a href="${pageContext.request.contextPath}/search-sort.jsp">Search & Sort</a></p>
                    <p><a href="${pageContext.request.contextPath}/algorithms.jsp">Greedy, DP & BT</a></p>
                </div>
            </div>
        </div>

        <div class="footer-bottom">
            <p>&copy; 2026 Pro-Fitness Gym Management System. Designed & Implemented by Rahul Raj (26MCAB57), MCA-B, Kristu Jayanti (Deemed to be University).</p>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
