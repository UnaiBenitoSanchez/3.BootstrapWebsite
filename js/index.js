$(document).ready(function () {
    $.ajax({
        url: 'getData.php',
        method: 'GET',
        dataType: 'json',
        success: function (data) {
            mostrarProductosEnBody(data);
        },
        error: function (error) {
            console.error('Error al obtener datos de productos:', error);
        }
    });
});

function mostrarProductosEnBody(data) {
    var productosContainer = $('#productos-container');

    productosContainer.empty();

    var totalProductos = 0;

    data.forEach(function (producto) {
        totalProductos += parseFloat(producto.available_quantity);
    });

    data.forEach(function (producto) {
        var cantidadDisponible = parseFloat(producto.available_quantity);
        var porcentaje = totalProductos !== 0 ? (cantidadDisponible / totalProductos) * 100 : 0;

        var productoDiv = $('<div>').addClass('col-md-4 mb-4');
        productoDiv.append('<div class="card">\
                            <div class="card-body">\
                                <h5 class="card-title">' + producto.name + '</h5>\
                                <p class="card-text">' + producto.description + '</p>\
                                <p class="card-text">Cantidad: ' + cantidadDisponible + '</p>\
                                <div class="progress">\
                                    <div class="progress-bar" role="progressbar" style="width: ' + porcentaje + '%;" aria-valuenow="' + porcentaje + '" aria-valuemin="0" aria-valuemax="100">\
                                        <span class="porcentaje-text">' + porcentaje.toFixed(2) + '%</span>\
                                    </div>\
                                </div>\
                            </div>\
                        </div>');
        productosContainer.append(productoDiv);
    });
}
