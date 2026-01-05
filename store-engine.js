/**
 * Store Engine - Centralized Product & Cart Logic
 * Handles Data Persistence and CRUD operations
 */

const StoreEngine = (() => {
    const STORAGE_KEY = 'repo_products';
    const CART_KEY = 'cart';

    const defaultProducts = [
        { id: 1, name: "Cyber-Drone X1", price: 12500, category: "Drones", image: "images/product-1.jpg", description: "High-performance racing drone with 4K camera and 2km range." },
        { id: 2, name: "Retro-Future Mech", price: 8500, category: "Robots", image: "images/product-2.jpg", description: "Articulable robot build kit with magnetic joints and LED modules." },
        { id: 3, name: "Nebula Projector Pro", price: 4200, category: "Space", image: "images/product-3.jpg", description: "Laser technology nebula and star projector." },
        { id: 4, name: "Quantum Chess Set", price: 15000, category: "Educational", image: "images/product-4.jpg", description: "Holographic chess board with AI-driven pieces." },
        { id: 5, name: "Mars Rover RC", price: 9800, category: "Space", image: "images/product-5.jpg", description: "Scale model Mars Rover with 6-wheel suspension and camera." },
        { id: 6, name: "Alpha Bot 3000", price: 12000, category: "Robots", image: "images/product-6.jpg", description: "Smart AI companion robot that learns and speaks." },
        { id: 7, name: "Astro-Suit VR", price: 18500, category: "Space", image: "images/product-7.jpg", description: "Immersive VR headset with space exploration modules." },
        { id: 8, name: "Gravity Boots", price: 5500, category: "Robots", image: "images/product-8.jpg", description: "Magnetic footwear for safe 'spacewalking' on metal surfaces." },
        { id: 9, name: "Titan Builder Kit", price: 7200, category: "Robots", image: "images/product-9.jpg", description: "Heavy-duty construction robot kit for young engineers." },
        { id: 10, name: "Solar System Glow", price: 3500, category: "Educational", image: "images/product-10.jpg", description: "Accurate scale model of the solar system with fiber optic lighting." }
    ];

    // --- Product Methods ---

    const getProducts = () => {
        const stored = localStorage.getItem(STORAGE_KEY);
        if (!stored) {
            localStorage.setItem(STORAGE_KEY, JSON.stringify(defaultProducts));
            return [...defaultProducts];
        }
        return JSON.parse(stored);
    };

    const saveProducts = (products) => {
        localStorage.setItem(STORAGE_KEY, JSON.stringify(products));
    };

    const addProduct = (product) => {
        const products = getProducts();
        const newId = products.length > 0 ? Math.max(...products.map(p => p.id)) + 1 : 1;
        const newProduct = { ...product, id: newId };
        products.push(newProduct);
        saveProducts(products);
        return newProduct;
    };

    const updateProduct = (id, updatedData) => {
        const products = getProducts();
        const index = products.findIndex(p => p.id === id);
        if (index !== -1) {
            products[index] = { ...products[index], ...updatedData, id }; // Ensure ID stays same
            saveProducts(products);
            return true;
        }
        return false;
    };

    const deleteProduct = (id) => {
        const products = getProducts();
        const filtered = products.filter(p => p.id !== id);
        saveProducts(filtered);
        return true;
    };

    const resetDefaults = () => {
        localStorage.removeItem(STORAGE_KEY);
        return getProducts();
    };

    // --- Cart Methods ---

    const getCart = () => {
        return JSON.parse(localStorage.getItem(CART_KEY)) || [];
    };

    const saveCart = (cart) => {
        localStorage.setItem(CART_KEY, JSON.stringify(cart));
    };

    // --- Auth Methods ---

    const USERS_KEY = 'repo_users';
    const CURRENT_USER_KEY = 'repo_current_user';

    const getUsers = () => {
        const stored = localStorage.getItem(USERS_KEY);
        if (!stored) {
            // Default Admin
            const admin = { 
                id: 'admin_001', 
                name: 'Administrator', 
                email: 'admin', // Changed to username 'admin'
                password: 'amaan000', 
                isAdmin: true 
            };
            localStorage.setItem(USERS_KEY, JSON.stringify([admin]));
            return [admin];
        }
        return JSON.parse(stored);
    };

    const getCurrentUser = () => {
        return JSON.parse(sessionStorage.getItem(CURRENT_USER_KEY)); // Use SessionStorage for session
    };

    const registerUser = (name, email, password) => {
        const users = getUsers();
        if (users.find(u => u.email === email)) {
            return { success: false, message: "Email already registered." };
        }
        const newUser = {
            id: 'user_' + Date.now(),
            name,
            email,
            password,
            isAdmin: false
        };
        users.push(newUser);
        localStorage.setItem(USERS_KEY, JSON.stringify(users));
        
        // Auto-login
        sessionStorage.setItem(CURRENT_USER_KEY, JSON.stringify(newUser));
        return { success: true, user: newUser };
    };

    const loginUser = (email, password) => {
        const users = getUsers();
        const user = users.find(u => u.email === email && u.password === password);
        if (user) {
            sessionStorage.setItem(CURRENT_USER_KEY, JSON.stringify(user));
            return { success: true, user };
        }
        return { success: false, message: "Invalid email or password." };
    };

    const logoutUser = () => {
        sessionStorage.removeItem(CURRENT_USER_KEY);
    };

    return {
        getProducts,
        addProduct,
        updateProduct,
        deleteProduct,
        resetDefaults,
        getCart,
        saveCart,
        // Auth Exports
        getCurrentUser,
        registerUser,
        loginUser,
        logoutUser
    };
})();

// Export globally for script.js and admin.html
window.StoreEngine = StoreEngine;
