/**
 * Pro-Fitness Gym Management System
 * Core Client-side Scripts
 */

document.addEventListener('DOMContentLoaded', () => {
    // 1. Initialize AOS (Animate On Scroll) if loaded
    if (typeof AOS !== 'undefined') {
        AOS.init({
            duration: 800,
            easing: 'ease-in-out',
            once: true,
            mirror: false
        });
    }

    // 2. Mobile Sidebar & Landing Nav Toggles
    initNavigation();

    // 3. Counter Animations
    initCounters();

    // 4. Tab Switchers
    initTabs();

    // 5. Step-by-Step Algorithm Sequential Reveal
    initStepAnimation();

    // 6. Form Validations
    initFormValidation();

    // 7. Auto-dismiss Alerts
    initAlerts();

    // 8. Sticky Nav Scroll Effect
    initScrollEffects();
});

/**
 * Navigation & Sidebar Logic
 */
function initNavigation() {
    // Sidebar toggle (for dashboard layout)
    const sidebarToggle = document.querySelector('.sidebar-toggle-btn');
    const sidebar = document.querySelector('.app-sidebar');

    if (sidebarToggle && sidebar) {
        sidebarToggle.addEventListener('click', (e) => {
            e.stopPropagation();
            sidebar.classList.toggle('open');
        });

        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', (e) => {
            if (window.innerWidth <= 1024 && sidebar.classList.contains('open') && !sidebar.contains(e.target)) {
                sidebar.classList.remove('open');
            }
        });
    }

    // Landing nav toggle
    const navToggle = document.querySelector('.nav-toggle');
    const navMenu = document.querySelector('.nav-menu');

    if (navToggle && navMenu) {
        navToggle.addEventListener('click', () => {
            navMenu.style.display = navMenu.style.display === 'flex' ? 'none' : 'flex';
            if (navMenu.style.display === 'flex') {
                navMenu.style.flexDirection = 'column';
                navMenu.style.position = 'absolute';
                navMenu.style.top = '70px';
                navMenu.style.left = '0';
                navMenu.style.width = '100%';
                navMenu.style.background = '#0a0a0f';
                navMenu.style.padding = '1.5rem';
                navMenu.style.borderBottom = '1px solid rgba(255,255,255,0.1)';
            }
        });
    }

    // Highlight current page in sidebar
    const currentPath = window.location.pathname;
    const sidebarLinks = document.querySelectorAll('.sidebar-link');
    sidebarLinks.forEach(link => {
        const href = link.getAttribute('href');
        if (href && (currentPath.endsWith(href) || (href !== 'index.jsp' && currentPath.includes(href.replace('.jsp', ''))))) {
            link.classList.add('active');
        }
    });
}

/**
 * Navbar background effect on scroll
 */
function initScrollEffects() {
    const navbar = document.querySelector('.landing-nav');
    if (!navbar) return;

    window.addEventListener('scroll', () => {
        if (window.scrollY > 40) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });
}

/**
 * Animated number counters
 */
function initCounters() {
    const counters = document.querySelectorAll('.counter-val');
    if (!counters.length) return;

    const observer = new IntersectionObserver((entries, obs) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const target = parseInt(entry.target.getAttribute('data-target') || entry.target.innerText, 10);
                if (!isNaN(target)) {
                    animateValue(entry.target, 0, target, 1500);
                }
                obs.unobserve(entry.target);
            }
        });
    }, { threshold: 0.5 });

    counters.forEach(c => observer.observe(c));
}

function animateValue(element, start, end, duration) {
    let startTimestamp = null;
    const step = (timestamp) => {
        if (!startTimestamp) startTimestamp = timestamp;
        const progress = Math.min((timestamp - startTimestamp) / duration, 1);
        element.innerText = Math.floor(progress * (end - start) + start);
        if (progress < 1) {
            window.requestAnimationFrame(step);
        } else {
            element.innerText = end;
        }
    };
    window.requestAnimationFrame(step);
}

/**
 * Generic Tab Component
 */
function initTabs() {
    const tabButtons = document.querySelectorAll('.tab-btn');
    tabButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            const tabTarget = btn.getAttribute('data-tab');
            const parent = btn.closest('.tab-container') || document;

            // Remove active from all tabs in this group
            parent.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
            parent.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));

            // Activate clicked tab
            btn.classList.add('active');
            const targetPane = parent.querySelector(`#${tabTarget}`);
            if (targetPane) {
                targetPane.classList.add('active');
            }
        });
    });
}

/**
 * Sequential step reveal for algorithm runs
 */
function initStepAnimation() {
    const stepContainers = document.querySelectorAll('.step-container.animate-steps');
    stepContainers.forEach(container => {
        const steps = container.querySelectorAll('.step-item');
        steps.forEach((step, index) => {
            step.style.opacity = '0';
            step.style.transform = 'translateY(10px)';
            step.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
            setTimeout(() => {
                step.style.opacity = '1';
                step.style.transform = 'translateY(0)';
            }, index * 200);
        });
    });
}

/**
 * Toast Notifications
 */
function showToast(message, type = 'info', duration = 4000) {
    let container = document.getElementById('toast-container');
    if (!container) {
        container = document.createElement('div');
        container.id = 'toast-container';
        document.body.appendChild(container);
    }

    const toast = document.createElement('div');
    toast.className = `toast toast-${type}`;

    let icon = 'fa-info-circle';
    if (type === 'success') icon = 'fa-check-circle';
    if (type === 'error' || type === 'danger') icon = 'fa-exclamation-triangle';

    toast.innerHTML = `
        <div style="display: flex; align-items: center; gap: 0.75rem;">
            <i class="fa-solid ${icon}"></i>
            <span>${message}</span>
        </div>
        <button style="background:none; border:none; color:inherit; cursor:pointer;" onclick="this.parentElement.remove()">
            <i class="fa-solid fa-xmark"></i>
        </button>
    `;

    container.appendChild(toast);

    setTimeout(() => {
        toast.style.opacity = '0';
        toast.style.transform = 'translateX(50px)';
        toast.style.transition = 'all 0.3s ease';
        setTimeout(() => toast.remove(), 300);
    }, duration);
}

/**
 * Delete Confirmation Helper
 */
function confirmDelete(event, itemName = 'this item') {
    if (!confirm(`Are you sure you want to remove ${itemName}? This operation modifies the data structure.`)) {
        event.preventDefault();
        return false;
    }
    return true;
}

/**
 * Auto-dismiss alerts after 5 seconds
 */
function initAlerts() {
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        const closeBtn = alert.querySelector('.alert-close');
        if (closeBtn) {
            closeBtn.addEventListener('click', () => alert.remove());
        }
        setTimeout(() => {
            if (alert.parentNode) {
                alert.style.opacity = '0';
                alert.style.transform = 'translateY(-10px)';
                alert.style.transition = 'all 0.3s ease';
                setTimeout(() => alert.remove(), 300);
            }
        }, 5000);
    });
}

/**
 * Basic Form Validation
 */
function initFormValidation() {
    const forms = document.querySelectorAll('form[data-validate]');
    forms.forEach(form => {
        form.addEventListener('submit', (e) => {
            let isValid = true;
            const requiredInputs = form.querySelectorAll('[required]');

            requiredInputs.forEach(input => {
                if (!input.value.trim()) {
                    isValid = false;
                    input.style.borderColor = 'var(--accent-red)';
                } else {
                    input.style.borderColor = 'var(--border-subtle)';
                }
            });

            if (!isValid) {
                e.preventDefault();
                showToast('Please fill out all required fields correctly.', 'error');
            }
        });
    });
}

// Global helpers accessible to onclick attributes
window.showToast = showToast;
window.confirmDelete = confirmDelete;
