/**
 * 
 */
document.querySelectorAll('.remove-item').forEach(button => {
    button.addEventListener('click', function() {
        this.closest('.cart-item').remove();
        updateTotal();
    });
});

document.querySelectorAll('.item-quantity').forEach(input => {
    input.addEventListener('change', updateTotal);
});

function updateTotal() {
    let total = 0;
    document.querySelectorAll('.cart-item').forEach(item => {
        const price = parseFloat(item.cells[2].innerText.replace('$', ''));
        const quantity = parseInt(item.querySelector('.item-quantity').value);
        total += price * quantity;
    });
    document.querySelector('.cart-total h2').innerText = 'Total: $' + total.toFixed(2);
}