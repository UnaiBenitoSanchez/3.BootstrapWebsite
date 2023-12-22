document.addEventListener('DOMContentLoaded', function () {
    const inventario = {
        'Producto A': 150,
        'Producto B': 80,
    };

    Object.entries(inventario).forEach(([producto, cantidad]) => {
        if (cantidad < 50) {
            mostrarAlertaBajoStock(producto, cantidad);
        }
    });
});

function mostrarAlertaBajoStock(producto, cantidad) {
    alert(`¡Atención! El nivel de stock para ${producto} es bajo (${cantidad} unidades). Considere reabastecer.`);
}
