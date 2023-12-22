// scripts/main.js

$(document).ready(function () {
    // Hacer una solicitud AJAX para obtener datos de inventario
    $.ajax({
        url: 'obtener_inventario.php', // Ajusta la URL según la configuración de tu servidor
        method: 'GET',
        dataType: 'json',
        success: function (data) {
            // Manejar los datos obtenidos
            manejarDatosInventario(data);
        },
        error: function (error) {
            console.error('Error al obtener datos de inventario:', error);
        }
    });
});

function manejarDatosInventario(data) {
    // Iterar sobre los datos del inventario y mostrar alertas según sea necesario
    data.forEach(function (producto) {
        if (producto.cantidad_disponible < 50) {
            mostrarAlertaBajoStock(producto.nombre, producto.cantidad_disponible);
        }
    });
}

function mostrarAlertaBajoStock(producto, cantidad) {
    // Muestra una alerta para productos con bajos niveles de stock
    alert(`¡Atención! El nivel de stock para ${producto} es bajo (${cantidad} unidades). Considere reabastecer.`);
}
