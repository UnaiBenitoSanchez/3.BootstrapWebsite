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
        var productsContainer = $('#products-container');
        productsContainer.empty();

        var totalProducts = 0;

        data.forEach(function (product) {
            totalProducts += parseFloat(product.available_quantity);
        });

        data.forEach(function (product) {
            console.log("Image:", product.image);
            var productDiv = createProductCard(product, totalProducts);
            productsContainer.append(productDiv);
        });
    }

    function createProductCard(product, totalProducts) {
        var availableQuantity = parseFloat(product.available_quantity);
        var price = parseFloat(product.price);
        var percentage = totalProducts !== 0 ? (availableQuantity / totalProducts) * 100 : 0;
    
        var productDiv = $('<div>').addClass('col-md-4 mb-6');
        productDiv.html('<div class="card">\
                <div class="card-body">\
                    <h5 class="card-title">' + product.name + '</h5>\
                    <img src="' + product.image + '" style="max-width: 200px; max-height: 200px" class="card-img-top" alt="Product Image" onerror="handleImageError(this)">\
                    <p class="card-text">Product description: ' + product.description + '</p>\
                    <p class="card-text">Quantity: ' + availableQuantity + '</p>\
                    <p class="card-text">Price: $<span class="price-editable" data-product-id="' + product.id_product + '">' + price.toFixed(2) + '</span></p>\
                    <p>Percentage from the total:</p>\
                    <div class="progress">\
                        <div class="progress-bar" role="progressbar" style="width: ' + percentage + '%;" aria-valuenow="' + percentage + '" aria-valuemin="0" aria-valuemax="100">\
                            <span class="percentage-text">' + percentage.toFixed(2) + '%</span>\
                        </div>\
                    </div>\
                    <button style="margin-top: 10px" class="btn btn-primary btn-edit" data-product-id="' + product.id_product + '">Edit</button>\
                    <button style="margin-top: 10px" class="btn btn-danger btn-delete" data-product-id="' + product.id_product + '">Delete</button>\
                </div>\
            </div>');
    
        return productDiv;
    }    

    $(document).on('click', '.btn-edit', function () {
        handleEditButtonClick($(this));
    });

    $(document).on('click', '.btn-confirm', function () {
        handleConfirmButtonClick($(this));
    });

    $(document).on('click', '.btn-delete', function () {
        handleDeleteButtonClick($(this));
    });

    function handleEditButtonClick(button) {
        var productDiv = button.closest('.card-body');
        var name = productDiv.find('.card-title').text();
        var description = productDiv.find('.card-text:eq(0)').text();
        var quantity = productDiv.find('.card-text:eq(1)').text().trim().split(':')[1];
        var price = productDiv.find('.price-editable').text();
    
        var descriptionPart = description.replace(/^Product description:\s*/, '');
    
        var quantityPart = quantity.replace(/^Quantity:\s*/, '');
    
        productDiv.find('.card-title').html('<input type="text" class="form-control" value="' + name + '">');
        productDiv.find('.card-text:eq(0)').html('<p>Product description:</p><textarea class="form-control">' + descriptionPart + '</textarea>');
        productDiv.find('.card-text:eq(1)').html('<p>Quantity:</p><input type="text" class="form-control" value="' + quantityPart + '">');
        productDiv.find('.price-editable').html('<input type="text" class="form-control" value="' + price + '">');
    
        button.removeClass('btn-edit').addClass('btn-confirm').text('Confirm');
    }    
    
    function handleConfirmButtonClick(button) {
        var productDiv = button.closest('.card-body');
        var productId = button.data('product-id');
        var newName = productDiv.find('.card-title input').val();
        var newDescription = productDiv.find('.card-text textarea').val();
        var newQuantity = productDiv.find('.card-text:eq(1) input').val();
        var newPrice = productDiv.find('.price-editable input').val();

        $.ajax({
            url: 'updateData.php',
            method: 'POST',
            data: {
                id_product: productId,
                new_name: newName,
                new_description: newDescription,
                new_quantity: newQuantity,
                new_price: newPrice
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
        var productId = button.data('product-id');

        $.ajax({
            url: 'deleteData.php',
            method: 'POST',
            data: {
                id_product: productId
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
