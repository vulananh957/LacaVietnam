/**
 * LACA VIETNAM - CHAT CLIENT LOGIC
 * Handles UI updates without page reload
 * Pure Vanilla JavaScript - No frameworks
 */

// Global state
let conversationHistory = [];

/**
 * Initialize chat functionality
 */
function initChat() {
    const sendBtn = document.getElementById('send-btn');
    const chatInput = document.getElementById('chat-input');
    
    // Send message on button click
    sendBtn.addEventListener('click', sendMessage);
    
    // Send message on Enter key
    chatInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            sendMessage();
        }
    });
    
    console.log('Chat initialized');
}

/**
 * Send message to server
 */
async function sendMessage() {
    const chatInput = document.getElementById('chat-input');
    const message = chatInput.value.trim();
    
    if (!message) {
        return;
    }
    
    // Clear input
    chatInput.value = '';
    
    // Add user message to UI
    addMessageToUI('user', message);
    
    // Show loading state
    showLoading();
    
    try {
        // Send POST request to ChatServlet
        const response = await fetch(window.CONTEXT_PATH + '/chat', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                message: message,
                history: conversationHistory
            })
        });
        
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        
        const data = await response.json();
        
        // Hide loading
        hideLoading();
        
        // Add bot response to UI
        addMessageToUI('bot', data.bot_message);
        
        // Handle UI actions
        handleUIAction(data);
        
        // Save to conversation history
        conversationHistory.push({
            user: message,
            bot: data.bot_message,
            intent: data.intent
        });
        
    } catch (error) {
        console.error('Chat error:', error);
        hideLoading();
        addMessageToUI('bot', 'Xin lỗi, đã có lỗi xảy ra. Vui lòng thử lại.');
    }
}

/**
 * Add message bubble to chat UI
 * @param {string} sender - 'user' or 'bot'
 * @param {string} text - Message text
 */
function addMessageToUI(sender, text) {
    const messagesContainer = document.getElementById('chat-messages');
    
    const messageDiv = document.createElement('div');
    messageDiv.className = `message ${sender}`;
    
    const avatar = document.createElement('div');
    avatar.className = 'message-avatar';
    avatar.textContent = sender === 'user' ? 'U' : 'L';
    
    const content = document.createElement('div');
    content.className = 'message-content';
    content.textContent = text;
    
    messageDiv.appendChild(avatar);
    messageDiv.appendChild(content);
    
    messagesContainer.appendChild(messageDiv);
    
    // Scroll to bottom
    messagesContainer.scrollTop = messagesContainer.scrollHeight;
}

/**
 * Handle UI actions based on server response
 * @param {object} data - Response data from server
 */
function handleUIAction(data) {
    const action = data.ui_action;
    
    switch (action) {
        case 'CHANGE_BG':
            // Change background image
            if (data.background_url) {
                changeBackground(data.background_url);
            }
            break;
            
        case 'RENDER_RESULTS':
            // Render service cards
            if (data.services && data.services.length > 0) {
                renderServiceCards(data.services);
                if (data.background_url) {
                    changeBackground(data.background_url);
                }
            }
            break;
            
        case 'WAIT_INPUT':
            // Just show the message, wait for more input
            break;
            
        case 'NONE':
        default:
            // No special action
            break;
    }
}

/**
 * Change background wallpaper with fade effect
 * @param {string} imageUrl - URL to image
 */
function changeBackground(imageUrl) {
    const bgWallpaper = document.getElementById('bg-wallpaper');
    
    // Fade out
    bgWallpaper.style.opacity = '0';
    
    // Change image after fade
    setTimeout(() => {
        const fullUrl = imageUrl.startsWith('http') 
            ? imageUrl 
            : window.CONTEXT_PATH + '/' + imageUrl;
        
        bgWallpaper.src = fullUrl;
        
        // Fade in
        bgWallpaper.style.opacity = '0.3';
    }, 400);
}

/**
 * Render service cards in grid
 * @param {array} services - Array of service objects
 */
function renderServiceCards(services) {
    const servicesGrid = document.getElementById('services-grid');
    const emptyState = document.getElementById('empty-state');
    
    // Hide empty state
    if (emptyState) {
        emptyState.style.display = 'none';
    }
    
    // Clear previous results
    servicesGrid.innerHTML = '';
    
    // Show grid
    servicesGrid.style.display = 'grid';
    
    // Create cards
    services.forEach(service => {
        const card = createServiceCard(service);
        servicesGrid.appendChild(card);
    });
}

/**
 * Create a service card element
 * @param {object} service - Service data
 * @returns {HTMLElement} Card element
 */
function createServiceCard(service) {
    const card = document.createElement('div');
    card.className = 'service-card';
    
    // Image
    const img = document.createElement('img');
    img.className = 'service-card-image';
    img.src = service.imageUrl.startsWith('http') 
        ? service.imageUrl 
        : window.CONTEXT_PATH + '/' + service.imageUrl;
    img.alt = service.name;
    img.onerror = function() {
        this.src = window.CONTEXT_PATH + '/assets/images/defaults/placeholder.jpg';
    };
    
    // Body
    const body = document.createElement('div');
    body.className = 'service-card-body';
    
    // Type badge
    const badge = document.createElement('span');
    badge.className = 'service-type-badge';
    badge.textContent = getTypeLabel(service.type);
    
    // Title
    const title = document.createElement('h3');
    title.className = 'service-card-title';
    title.textContent = service.name;
    
    // Info (rating & supplier)
    const info = document.createElement('div');
    info.className = 'service-card-info';
    info.innerHTML = `
        <span class="service-rating">⭐ ${service.rating.toFixed(1)}</span>
        ${service.supplierName ? `<span>• ${service.supplierName}</span>` : ''}
    `;
    
    // Price section
    const priceSection = document.createElement('div');
    priceSection.className = 'service-card-price';
    
    const priceDiv = document.createElement('div');
    const priceAmount = document.createElement('span');
    priceAmount.className = 'price-amount';
    priceAmount.textContent = formatPrice(service.displayPrice);
    
    const currency = document.createElement('span');
    currency.className = 'price-currency';
    currency.textContent = service.currency || 'VND';
    
    priceDiv.appendChild(priceAmount);
    priceDiv.appendChild(currency);
    
    const bookBtn = document.createElement('button');
    bookBtn.className = 'book-btn';
    bookBtn.textContent = 'Đặt ngay';
    bookBtn.onclick = () => bookService(service);
    
    priceSection.appendChild(priceDiv);
    priceSection.appendChild(bookBtn);
    
    // Assemble card
    body.appendChild(badge);
    body.appendChild(title);
    body.appendChild(info);
    body.appendChild(priceSection);
    
    card.appendChild(img);
    card.appendChild(body);
    
    return card;
}

/**
 * Get Vietnamese label for service type
 */
function getTypeLabel(type) {
    const labels = {
        'FLIGHT': 'Vé máy bay',
        'HOTEL': 'Khách sạn',
        'ACTIVITY': 'Hoạt động'
    };
    return labels[type] || type;
}

/**
 * Format price with thousands separator
 */
function formatPrice(price) {
    return new Intl.NumberFormat('vi-VN').format(price);
}

/**
 * Book service (placeholder)
 */
function bookService(service) {
    alert(`Đặt ${service.name}\nGiá: ${formatPrice(service.displayPrice)} ${service.currency}\n\nTính năng đang phát triển!`);
}

/**
 * Show loading indicator
 */
function showLoading() {
    const messagesContainer = document.getElementById('chat-messages');
    
    const loadingDiv = document.createElement('div');
    loadingDiv.className = 'message bot';
    loadingDiv.id = 'loading-indicator';
    
    const avatar = document.createElement('div');
    avatar.className = 'message-avatar';
    avatar.textContent = 'L';
    
    const content = document.createElement('div');
    content.className = 'message-content';
    content.innerHTML = '<span class="loading"></span> Đang suy nghĩ...';
    
    loadingDiv.appendChild(avatar);
    loadingDiv.appendChild(content);
    
    messagesContainer.appendChild(loadingDiv);
    messagesContainer.scrollTop = messagesContainer.scrollHeight;
}

/**
 * Hide loading indicator
 */
function hideLoading() {
    const loading = document.getElementById('loading-indicator');
    if (loading) {
        loading.remove();
    }
}

// Make initChat available globally
window.initChat = initChat;

