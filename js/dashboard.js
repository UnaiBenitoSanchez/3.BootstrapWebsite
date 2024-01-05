$(document).ready(function () {
    $.ajax({
        url: 'getData.php',
        method: 'GET',
        dataType: 'json',
        success: function (data) {
            console.log(data);
            mostrarProductosEnBody(data);
        },
        
        error: function (error) {
            console.error('Error:', error);
        }
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
            var precio = parseFloat(producto.price);
            var porcentaje = totalProductos !== 0 ? (cantidadDisponible / totalProductos) * 100 : 0;
        
            var productoDiv = $('<div>').addClass('col-md-4 mb-4');
            productoDiv.append('<div class="card">\
                                <div class="card-body">\
                                    <h5 class="card-title">' + producto.name + '</h5>\
                                    <p class="card-text">' + producto.description + '</p>\
                                    <p class="card-text">Quantity: ' + cantidadDisponible + '</p>\
                                    <p class="card-text">Price: $<span class="precio-editable" data-producto-id="' + producto.id_product + '">' + precio.toFixed(2) + '</span></p>\
                                    <div class="progress">\
                                        <div class="progress-bar" role="progressbar" style="width: ' + porcentaje + '%;" aria-valuenow="' + porcentaje + '" aria-valuemin="0" aria-valuemax="100">\
                                            <span class="porcentaje-text">' + porcentaje.toFixed(2) + '%</span>\
                                        </div>\
                                    </div>\
                                    <button style="margin-top: 10px" class="btn btn-primary btn-editar" data-producto-id="' + producto.id_product + '">Editar</button>\
                                    <button style="margin-top: 10px" class="btn btn-danger btn-eliminar" data-producto-id="' + producto.id_product + '">Eliminar</button>\
                                </div>\
                            </div>');
        
            productosContainer.append(productoDiv);
        }),
               

        $(document).on('click', '.btn-editar', function () {
            var productoDiv = $(this).closest('.card-body');
            var nombre = productoDiv.find('.card-title').text();
            var descripcion = productoDiv.find('.card-text:eq(0)').text();
            var cantidad = productoDiv.find('.card-text:eq(1)').text().trim().split(':')[1];
            var precio = productoDiv.find('.precio-editable').text();  // Obtén el precio
        
            productoDiv.find('.card-title').html('<input type="text" class="form-control" value="' + nombre + '">');
            productoDiv.find('.card-text:eq(0)').html('<textarea class="form-control">' + descripcion + '</textarea>');
            productoDiv.find('.card-text:eq(1)').html('<input type="text" class="form-control" value="' + cantidad + '">');
            productoDiv.find('.precio-editable').html('<input type="text" class="form-control" value="' + precio + '">');  // Campo editable para el precio
        
            $(this).removeClass('btn-editar').addClass('btn-confirmar').text('Confirmar');
        }),

        $(document).on('click', '.btn-confirmar', function () {
            var productoDiv = $(this).closest('.card-body');
            var idProducto = $(this).data('producto-id');
            var nuevoNombre = productoDiv.find('.card-title input').val();
            var nuevaDescripcion = productoDiv.find('.card-text textarea').val();
            var nuevaCantidad = productoDiv.find('.card-text:eq(1) input').val();
            var nuevoPrecio = productoDiv.find('.precio-editable input').val();  
        
            $.ajax({
                url: 'updateData.php',
                method: 'POST',
                data: {
                    id_producto: idProducto,
                    nuevo_nombre: nuevoNombre,
                    nueva_descripcion: nuevaDescripcion,
                    nueva_cantidad: nuevaCantidad,
                    nuevo_precio: nuevoPrecio  
                },
                success: function (response) {
                    console.log(response);
                    location.reload();
                },
                error: function (error) {
                    console.error('Error:', error);
                }
            });
        });
        

        $(document).on('click', '.btn-eliminar', function () {
            var idProducto = $(this).data('producto-id');

            $.ajax({
                url: 'deleteData.php', 
                method: 'POST',
                data: {
                    id_producto: idProducto
                },
                success: function (response) {
                    console.log(response);
                    location.reload();
                },
                error: function (error) {
                    console.error('Error:', error);
                }
            });
        });
    }
});
