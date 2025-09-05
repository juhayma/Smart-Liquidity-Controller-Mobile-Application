// Main JavaScript file for EXIT Platform

// DOM Content Loaded
document.addEventListener('DOMContentLoaded', function() {
    // Load initial data for homepage
    if (document.getElementById('statsContainer')) {
        loadPlatformStats();
    }
    
    if (document.getElementById('startupsContainer')) {
        loadStartupsList();
    }
    
    if (document.getElementById('foundersContainer')) {
        loadFoundersList();
    }
    
    // Initialize smooth scrolling
    initSmoothScrolling();
    
    // Initialize mobile menu if exists
    initMobileMenu();
});

// Load platform statistics
async function loadPlatformStats() {
    try {
        const response = await fetch('/api/stats');
        const result = await response.json();
        
        if (result.success) {
            const stats = result.data;
            document.getElementById('totalStartups').textContent = stats.total_startups || 0;
            document.getElementById('totalFounders').textContent = stats.total_founders || 0;
            document.getElementById('upcomingEvents').textContent = stats.upcoming_events || 0;
            document.getElementById('pastEvents').textContent = stats.past_events || 0;
        }
    } catch (error) {
        console.error('Error loading platform stats:', error);
        // Set default values
        document.getElementById('totalStartups').textContent = '0';
        document.getElementById('totalFounders').textContent = '0';
        document.getElementById('upcomingEvents').textContent = '0';
        document.getElementById('pastEvents').textContent = '0';
    }
}

// Load startups list for homepage
async function loadStartupsList() {
    const container = document.getElementById('startupsContainer');
    
    try {
        const response = await fetch('/api/startups');
        const result = await response.json();
        
        if (result.success && result.data.length > 0) {
            // Show only first 6 startups on homepage
            const startups = result.data.slice(0, 6);
            displayStartupsGrid(startups, container);
        } else {
            container.innerHTML = `
                <div class="no-data">
                    <i class="fas fa-rocket" style="font-size: 3rem; color: var(--secondary-color); margin-bottom: 1rem;"></i>
                    <p>No startups available yet. Be the first to submit your startup!</p>
                    <a href="submit.html" class="btn btn-primary" style="margin-top: 1rem;">Submit Your Startup</a>
                </div>
            `;
        }
    } catch (error) {
        console.error('Error loading startups:', error);
        container.innerHTML = `
            <div class="error">
                <i class="fas fa-exclamation-triangle"></i>
                <p>Error loading startups. Please try again later.</p>
            </div>
        `;
    }
}

// Display startups in grid format
function displayStartupsGrid(startups, container) {
    const startupsHTML = startups.map(startup => `
        <div class="startup-card">
            <div class="startup-header">
                <h3>${startup.name}</h3>
                ${startup.website ? `<a href="${startup.website}" target="_blank" class="website-link"><i class="fas fa-external-link-alt"></i></a>` : ''}
            </div>
            <div class="startup-meta">
                ${startup.sector ? `<span class="badge">${startup.sector}</span>` : ''}
                ${startup.stage ? `<span class="badge stage">${startup.stage}</span>` : ''}
            </div>
            <div class="startup-info">
                <p><i class="fas fa-map-marker-alt"></i> ${startup.country || 'Not specified'}</p>
                <p><i class="fas fa-users"></i> ${startup.founder_count || 0} founder(s)</p>
                <p><i class="fas fa-calendar"></i> Joined ${new Date(startup.created_at).toLocaleDateString()}</p>
            </div>
            ${startup.program_name ? `<div class="startup-program"><i class="fas fa-graduation-cap"></i> ${startup.program_name}</div>` : ''}
        </div>
    `).join('');
    
    container.innerHTML = startupsHTML;
}

// Load founders list for homepage
async function loadFoundersList() {
    const container = document.getElementById('foundersContainer');
    
    try {
        const response = await fetch('/api/founders');
        const result = await response.json();
        
        if (result.success && result.data.length > 0) {
            // Show only first 6 founders on homepage
            const founders = result.data.slice(0, 6);
            displayFoundersGrid(founders, container);
        } else {
            container.innerHTML = `
                <div class="no-data">
                    <i class="fas fa-users" style="font-size: 3rem; color: var(--secondary-color); margin-bottom: 1rem;"></i>
                    <p>No founders available yet.</p>
                </div>
            `;
        }
    } catch (error) {
        console.error('Error loading founders:', error);
        container.innerHTML = `
            <div class="error">
                <i class="fas fa-exclamation-triangle"></i>
                <p>Error loading founders. Please try again later.</p>
            </div>
        `;
    }
}

// Display founders in grid format
function displayFoundersGrid(founders, container) {
    const foundersHTML = founders.map(founder => `
        <div class="founder-card">
            <div class="founder-header">
                <div class="founder-avatar">
                    <i class="fas fa-user-circle"></i>
                </div>
                <div class="founder-info">
                    <h3>${founder.full_name}</h3>
                    ${founder.title ? `<p class="founder-title">${founder.title}</p>` : ''}
                </div>
            </div>
            <div class="founder-meta">
                <p><i class="fas fa-rocket"></i> ${founder.startup_count || 0} startup(s)</p>
                ${founder.email ? `<p><i class="fas fa-envelope"></i> ${founder.email}</p>` : ''}
                <p><i class="fas fa-calendar"></i> Joined ${new Date(founder.created_at).toLocaleDateString()}</p>
            </div>
            ${founder.linkedin_url ? `
                <div class="founder-links">
                    <a href="${founder.linkedin_url}" target="_blank" class="social-link">
                        <i class="fab fa-linkedin"></i> LinkedIn
                    </a>
                </div>
            ` : ''}
        </div>
    `).join('');
    
    container.innerHTML = foundersHTML;
}

// Smooth scrolling for navigation links
function initSmoothScrolling() {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
}

// Mobile menu functionality (if needed)
function initMobileMenu() {
    const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
    const navMenu = document.querySelector('.nav-menu');
    
    if (mobileMenuBtn && navMenu) {
        mobileMenuBtn.addEventListener('click', function() {
            navMenu.classList.toggle('active');
            this.classList.toggle('active');
        });
        
        // Close menu when clicking on a link
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', function() {
                navMenu.classList.remove('active');
                mobileMenuBtn.classList.remove('active');
            });
        });
    }
}

// Form validation utilities
function validateEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

function validateURL(url) {
    try {
        new URL(url);
        return true;
    } catch {
        return false;
    }
}

// Show loading state for buttons
function setButtonLoading(button, isLoading = true) {
    if (isLoading) {
        button.dataset.originalText = button.innerHTML;
        button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Loading...';
        button.disabled = true;
    } else {
        button.innerHTML = button.dataset.originalText || button.innerHTML;
        button.disabled = false;
    }
}

// Show notification
function showNotification(message, type = 'info', duration = 5000) {
    // Remove existing notifications
    const existingNotifications = document.querySelectorAll('.notification');
    existingNotifications.forEach(notification => notification.remove());
    
    // Create notification element
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.innerHTML = `
        <div class="notification-content">
            <i class="fas fa-${getNotificationIcon(type)}"></i>
            <span>${message}</span>
            <button class="notification-close" onclick="this.parentElement.parentElement.remove()">
                <i class="fas fa-times"></i>
            </button>
        </div>
    `;
    
    // Add to page
    document.body.appendChild(notification);
    
    // Auto remove after duration
    setTimeout(() => {
        if (notification.parentElement) {
            notification.remove();
        }
    }, duration);
}

function getNotificationIcon(type) {
    switch (type) {
        case 'success': return 'check-circle';
        case 'error': return 'exclamation-circle';
        case 'warning': return 'exclamation-triangle';
        default: return 'info-circle';
    }
}

// API request wrapper with error handling
async function apiRequest(url, options = {}) {
    try {
        const response = await fetch(url, {
            headers: {
                'Content-Type': 'application/json',
                ...options.headers
            },
            ...options
        });
        
        const result = await response.json();
        
        if (!response.ok) {
            throw new Error(result.message || `HTTP ${response.status}`);
        }
        
        return result;
    } catch (error) {
        console.error('API Request Error:', error);
        throw error;
    }
}

// Debounce function for search inputs
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// Format date for display
function formatDate(dateString, locale = 'en-US') {
    const date = new Date(dateString);
    return date.toLocaleDateString(locale, {
        year: 'numeric',
        month: 'short',
        day: 'numeric'
    });
}

// Copy text to clipboard
async function copyToClipboard(text) {
    try {
        await navigator.clipboard.writeText(text);
        showNotification('Copied to clipboard!', 'success', 2000);
    } catch (error) {
        console.error('Copy failed:', error);
        showNotification('Failed to copy to clipboard', 'error');
    }
}

// Export data as CSV
function exportToCSV(data, filename) {
    if (!data || data.length === 0) {
        showNotification('No data to export', 'warning');
        return;
    }
    
    const headers = Object.keys(data[0]);
    const csvContent = [
        headers.join(','),
        ...data.map(row => 
            headers.map(header => {
                const value = row[header] || '';
                return `"${String(value).replace(/"/g, '""')}"`;
            }).join(',')
        )
    ].join('\n');
    
    const blob = new Blob([csvContent], { type: 'text/csv' });
    const url = window.URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.href = url;
    link.download = filename;
    link.click();
    window.URL.revokeObjectURL(url);
}

// Initialize tooltips (if using a tooltip library)
function initTooltips() {
    const tooltipElements = document.querySelectorAll('[data-tooltip]');
    tooltipElements.forEach(element => {
        element.addEventListener('mouseenter', showTooltip);
        element.addEventListener('mouseleave', hideTooltip);
    });
}

function showTooltip(event) {
    const tooltip = document.createElement('div');
    tooltip.className = 'tooltip';
    tooltip.textContent = event.target.dataset.tooltip;
    document.body.appendChild(tooltip);
    
    const rect = event.target.getBoundingClientRect();
    tooltip.style.left = `${rect.left + rect.width / 2}px`;
    tooltip.style.top = `${rect.top - tooltip.offsetHeight - 5}px`;
}

function hideTooltip() {
    const tooltip = document.querySelector('.tooltip');
    if (tooltip) {
        tooltip.remove();
    }
}

// Theme switcher (optional)
function initThemeSwitcher() {
    const themeToggle = document.querySelector('.theme-toggle');
    if (themeToggle) {
        themeToggle.addEventListener('click', toggleTheme);
        
        // Load saved theme
        const savedTheme = localStorage.getItem('theme');
        if (savedTheme) {
            document.documentElement.setAttribute('data-theme', savedTheme);
        }
    }
}

function toggleTheme() {
    const currentTheme = document.documentElement.getAttribute('data-theme');
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
    
    document.documentElement.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
}

// Window scroll handler for navbar
window.addEventListener('scroll', function() {
    const navbar = document.querySelector('.navbar');
    if (navbar) {
        if (window.scrollY > 100) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    }
});

// Global error handler
window.addEventListener('error', function(event) {
    console.error('Global error:', event.error);
    showNotification('An unexpected error occurred', 'error');
});

// Handle offline/online status
window.addEventListener('offline', function() {
    showNotification('You are offline. Some features may not work.', 'warning');
});

window.addEventListener('online', function() {
    showNotification('Connection restored!', 'success', 3000);
});