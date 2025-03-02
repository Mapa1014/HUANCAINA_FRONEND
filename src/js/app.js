function loadComponent(componentId, componentPath) {
    fetch(componentPath)
        .then(response => response.text())
        .then(data => {
            document.getElementById(componentId).innerHTML = data;
            // Add event listeners to the navbar links after loading the navbar
            if (componentId === 'navbar-content') {
                const navLinks = document.querySelectorAll('#navbar-content a');
                navLinks.forEach(link => {
                    link.addEventListener('click', (event) => {
                        event.preventDefault();
                        const page = event.target.getAttribute('href');
                        loadPage(page);
                        // Update the URL in the browser
                        history.pushState(null, '', page);
                    });
                });
            }
        })
        .catch(error => console.error('Error loading component:', error));
}

function loadPage(page) {
    fetch(`src/views/${page}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.text();
        })
        .then(data => {
            document.getElementById('main-content').innerHTML = data;
            // Reinitialize Bootstrap components if needed
            var script = document.createElement('script');
            script.src = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js";
            document.body.appendChild(script);
        })
        .catch(error => console.error('Error loading page:', error));
}

// Handle back/forward navigation
window.addEventListener('popstate', () => {
    const path = window.location.pathname.split('/').pop();
    loadPage(path || 'home.html');
});

// Load the navbar and footer when the page loads
document.addEventListener('DOMContentLoaded', () => {
    loadComponent('navbar-content', 'src/components/navbar.html');
    loadComponent('footer-content', 'src/components/footer.html');
    const path = window.location.pathname.split('/').pop();
    loadPage(path || 'home.html'); // Load the home page by default
});