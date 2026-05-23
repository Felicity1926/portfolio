// Simple form submission handler
document.getElementById('contactForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    // Get form data
    const name = document.getElementById('name').value;
    const email = document.getElementById('email').value;
    const subject = document.getElementById('subject').value;
    const message = document.getElementById('message').value;
    
    // For now, show a success message (in a real application, this would send to a server)
    const formMessage = document.getElementById('formMessage');
    formMessage.textContent = 'Thank you for your message! I will get back to you soon.';
    formMessage.classList.add('success');
    formMessage.classList.remove('hidden');
    
    // Reset form
    this.reset();
    
    // Hide message after 5 seconds
    setTimeout(() => {
        formMessage.classList.add('hidden');
        formMessage.classList.remove('success');
    }, 5000);
});
