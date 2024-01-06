$(document).ready(function () {
    loadData();

    function loadData() {
        $.ajax({
            url: 'getData.php',
            method: 'GET',
            dataType: 'json',
            success: function (data) {
                console.log(data);
                renderProducts(data);
            },
            error: function (error) {
                console.error('Error:', error);
            }
        });
    }

    function renderProducts(data) {
        var productosContainer = $('#productos-container');
        productosContainer.empty();

        var totalProductos = 0;

        data.forEach(function (producto) {
            totalProductos += parseFloat(producto.available_quantity);
        });

        data.forEach(function (producto) {
            console.log("Imagen:", producto.image);
            var productoDiv = createProductCard(producto, totalProductos);
            productosContainer.append(productoDiv);
        });
    }

    function createProductCard(producto, totalProductos) {
        var cantidadDisponible = parseFloat(producto.available_quantity);
        var precio = parseFloat(producto.price);
        var porcentaje = totalProductos !== 0 ? (cantidadDisponible / totalProductos) * 100 : 0;
    
        var productoDiv = $('<div>').addClass('col-md-4 mb-6');
        productoDiv.html('<div class="card">\
                <div class="card-body">\
                    <h5 class="card-title">' + producto.name + '</h5>\
                    <img src="' + producto.image + '" style="max-width: 200px; max-height: 200px" class="card-img-top" alt="Product Image" onerror="handleImageError(this)">\
                    <p class="card-text">Product description: ' + producto.description + '</p>\
                    <p class="card-text">Quantity: ' + cantidadDisponible + '</p>\
                    <p class="card-text">Price: $<span class="precio-editable" data-producto-id="' + producto.id_product + '">' + precio.toFixed(2) + '</span></p>\
                    <p>Percentage from the total:</p>\
                    <div class="progress">\
                        <div class="progress-bar" role="progressbar" style="width: ' + porcentaje + '%;" aria-valuenow="' + porcentaje + '" aria-valuemin="0" aria-valuemax="100">\
                            <span class="porcentaje-text">' + porcentaje.toFixed(2) + '%</span>\
                        </div>\
                    </div>\
                    <button style="margin-top: 10px" class="btn btn-primary btn-editar" data-producto-id="' + producto.id_product + '">Editar</button>\
                    <button style="margin-top: 10px" class="btn btn-danger btn-eliminar" data-producto-id="' + producto.id_product + '">Eliminar</button>\
                </div>\
            </div>');
    
        return productoDiv;
    }    

    $(document).on('click', '.btn-editar', function () {
        handleEditButtonClick($(this));
    });

    $(document).on('click', '.btn-confirmar', function () {
        handleConfirmButtonClick($(this));
    });

    $(document).on('click', '.btn-eliminar', function () {
        handleDeleteButtonClick($(this));
    });

    function handleEditButtonClick(button) {
        var productoDiv = button.closest('.card-body');
        var nombre = productoDiv.find('.card-title').text();
        var descripcion = productoDiv.find('.card-text:eq(0)').text();
        var cantidad = productoDiv.find('.card-text:eq(1)').text().trim().split(':')[1];
        var precio = productoDiv.find('.precio-editable').text();
    
        var descripcionParte = descripcion.replace(/^Product description:\s*/, '');
    
        var cantidadParte = cantidad.replace(/^Quantity:\s*/, '');
    
        productoDiv.find('.card-title').html('<input type="text" class="form-control" value="' + nombre + '">');
        productoDiv.find('.card-text:eq(0)').html('<p>Product description:</p><textarea class="form-control">' + descripcionParte + '</textarea>');
        productoDiv.find('.card-text:eq(1)').html('<p>Quantity:</p><input type="text" class="form-control" value="' + cantidadParte + '">');
        productoDiv.find('.precio-editable').html('<input type="text" class="form-control" value="' + precio + '">');
    
        button.removeClass('btn-editar').addClass('btn-confirmar').text('Confirmar');
    }    
    
    function handleConfirmButtonClick(button) {
        var productoDiv = button.closest('.card-body');
        var idProducto = button.data('producto-id');
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
    }

    function handleDeleteButtonClick(button) {
        var idProducto = button.data('producto-id');

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
    }
});
