// Products are now managed by StoreEngine (store-engine.js)
let products = StoreEngine.getProducts();

// Check Auth State
// Check Auth State
const currentUser = StoreEngine.getCurrentUser();
const profileDropdown = document.getElementById('profile-dropdown');

if (profileDropdown) {
    if (currentUser) {
        // User Logged In
        profileDropdown.innerHTML = `
            <div class="profile-name">Hi, ${currentUser.name.split(' ')[0]}</div>
            <a href="#">My Orders</a>
            <a href="#" onclick="StoreEngine.logoutUser(); window.location.reload();" style="color: #ef4444;">Logout</a>
        `;
    } else {
        // Guest
        profileDropdown.innerHTML = `
             <a href="login.html" class="btn-login">Login</a>
             <a href="signup.html">Create Account</a>
        `;
    }
}

    // Scroll Animation Observer Shared Instance
    const observerOptions = { threshold: 0.1, rootMargin: "0px 0px -50px 0px" };
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('active');
                entry.target.classList.add('show');
                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);

    const grid = document.getElementById('product-grid');
    const cartCountEl = document.querySelector('.cart-count');
    let cartCount = 0; 
    let currentCategory = 'All';
    let searchQuery = '';

    // Catalog update logic
    window.setCategory = (cat) => {
        currentCategory = cat;
        // Update chip UI
        document.querySelectorAll('.chip').forEach(chip => {
            chip.classList.toggle('active', chip.textContent === cat);
        });
        window.refreshProducts();
    };

    window.handleCatalogUpdate = () => {
        searchQuery = document.getElementById('product-search').value.toLowerCase();
        window.refreshProducts();
    };

    // Function to render products dynamically
    window.refreshProducts = () => {
        // Load fresh from Engine
        let allProducts = StoreEngine.getProducts();
        
        // Apply Filters
        products = allProducts.filter(p => {
            const matchesCategory = currentCategory === 'All' || p.category === currentCategory;
            const matchesSearch = p.name.toLowerCase().includes(searchQuery) || 
                                 (p.description && p.description.toLowerCase().includes(searchQuery));
            return matchesCategory && matchesSearch;
        });
        
        if (grid) {
            grid.innerHTML = '';
            products.forEach((product, index) => {
                const card = document.createElement('div');
                card.className = 'product-card';
                // Stagger animation setup
                card.style.transitionDelay = `${(index % 5) * 0.1}s`;

                card.innerHTML = `
                    <div style="overflow: hidden; cursor: pointer;" onclick="window.location.href='product-detail.html?id=${product.id}'">
                        <img src="${product.image}" alt="${product.name}" class="product-image" loading="lazy">
                    </div>
                    <div class="product-info">
                        <h3 class="product-name" style="cursor: pointer;" onclick="window.location.href='product-detail.html?id=${product.id}'">${product.name}</h3>
                        <div class="product-price">₹${product.price ? product.price.toLocaleString('en-IN') : '0'}</div>
                        <button class="add-to-cart-btn" onclick="addToCart(${product.id})">Add to Cart</button>
                    </div>
                `;
                grid.appendChild(card);
                
                // Observe for animation if observer exists
                if (typeof observer !== 'undefined') observer.observe(card);
            });
        }
    }

    // Initial Render
    window.refreshProducts();

    // Global Cart Logic
    let cart = JSON.parse(localStorage.getItem('cart')) || [];

    // Toggle Cart Sidebar
    window.toggleCart = () => {
        const sidebar = document.getElementById('cart-sidebar');
        const overlay = document.getElementById('cart-overlay');
        sidebar.classList.toggle('open');
        overlay.classList.toggle('open');
    }

    // Toggle Mobile Menu
    window.toggleMobileMenu = () => {
        const overlay = document.getElementById('mobile-nav-overlay');
        if (overlay) {
            overlay.classList.toggle('active');
        }
    }

    // Add to Cart Logic
    window.addToCart = (id) => {
        const product = products.find(p => p.id === id);
        if (product) {
            cart.push(product);
            saveCart();
            updateCartUI();

            // Visual feedback on button
            const btn = event.target;
            const originalText = btn.textContent;
            btn.textContent = "Added!";
            btn.style.backgroundColor = "var(--primary-color)";
            btn.style.color = "white";

            setTimeout(() => {
                btn.textContent = originalText;
                btn.style.backgroundColor = "transparent";
                btn.style.color = "var(--primary-color)";
            }, 1000);

            // Auto open cart on first add
            if (cart.length === 1) {
                window.toggleCart();
            }
        }
    }

    // Remove from Cart
    window.removeFromCart = (index) => {
        cart.splice(index, 1);
        saveCart();
        updateCartUI();
    }

    function saveCart() {
        localStorage.setItem('cart', JSON.stringify(cart));
    }

    function updateCartUI() {
        // Update Count
        if (cartCountEl) cartCountEl.textContent = cart.length;

        // Render Items
        const cartItemsContainer = document.getElementById('cart-items');
        const totalPriceEl = document.getElementById('cart-total-price');

        if (cart.length === 0) {
            if (cartItemsContainer) cartItemsContainer.innerHTML = '<p class="empty-cart-msg">Your cart is empty.</p>';
            if (totalPriceEl) totalPriceEl.textContent = '₹0';
            return;
        }

        let total = 0;
        if (cartItemsContainer) {
            cartItemsContainer.innerHTML = cart.map((item, index) => {
                total += item.price;
                return `
                    <div class="cart-item">
                        <img src="${item.image}" alt="${item.name}">
                        <div class="cart-item-info">
                            <div class="cart-item-title">${item.name}</div>
                            <div class="cart-item-price">₹${item.price.toLocaleString('en-IN')}</div>
                        </div>
                        <button class="remove-item" onclick="removeFromCart(${index})">Remove</button>
                    </div>
                `;
            }).join('');
        }

        if (totalPriceEl) totalPriceEl.textContent = '₹' + total.toLocaleString('en-IN');

        const checkoutBtn = document.querySelector('.checkout-btn');
        if (checkoutBtn) {
            checkoutBtn.onclick = () => window.location.href = 'checkout.html';
        }
    }

    // Initialize Cart UI on load
    updateCartUI();

    // Observe general sections (using global observer)
    document.querySelectorAll('.reveal').forEach(el => observer.observe(el));

