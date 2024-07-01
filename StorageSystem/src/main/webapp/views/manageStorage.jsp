<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Storage</title>
    <style>
        /* Styles for the navbar and info box */
        .navbar {
            position: fixed;
            left: 0;
            top: 0;
            width: 200px; /* Adjust the width as needed */
            height: 100%;
            background-color: #538392;
            padding-top: 20px;
        }
        .navbar button {
            display: block;
            width: 100%;
            padding: 10px 20px;
            margin-bottom: 10px;
            text-align: left;
            border: none;
            cursor: pointer;
            background-color: #538392;
            color: white;
        }
        .navbar button:hover {
            background-color: #bbb;
            color: black;
        }
        .info-box {
            border: 1px solid #ddd; /* Light gray border */
            padding: 20px;
            margin: 20px;
            background-color: #fff; /* White background */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Soft shadow effect */
            border-radius: 8px; /* Rounded corners */
            width: 200px; /* Adjust the width */
            position: fixed; /* Position the box relative to the viewport */
            top: 0; /* Align with the top of the viewport */
            left: 220px; /* Position next to the navbar */
        }

        /* Styles for displaying information */
        .info-item {
            margin-bottom: 10px;
        }

        /* Styles for table */
        .table-container {
            margin: 20px;
            padding: 20px;
            border: 1px solid #ddd;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            width: 70%;
            margin-left: 250px; /* Adjusted left position */
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }

        /* Modal styles */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
            padding-top: 60px;
        }

        /* Modal content */
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto; /* 5% from the top, centered */
            padding: 20px;
            border: 1px solid #888;
            width: 60%; /* Adjusted width */
            max-width: 400px; /* Maximum width */
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Soft shadow effect */
        }

        /* Close button */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        /* Styles for product container */
        .products-container {
            margin: 20px;
            padding: 100px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            margin-left: 550px; /* Adjusted left position */
            display: flex;
            flex-wrap: wrap; /* Allow products to wrap */
            justify-content: flex-start; /* Align products to start */
        }

        .product-item {
            width: calc(33.33% - 20px); /* Adjusted width to fit three items per row */
            margin: 10px;
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out; /* Smooth hover effect */
        }

        .product-item:hover {
            transform: translateY(-5px); /* Move up on hover */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Enhanced shadow on hover */
        }

        .product-item h3 {
            margin-top: 0;
            color: #333;
        }

        .product-item p {
            margin: 8px 0;
            color: #666;
        }

        .product-item hr {
            border-color: #ddd;
            margin-top: 10px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <button id="openModalBtn">Adauga produs</button>
        <button onclick="location.href='#'">Adauga categorie</button>
        <button onclick="location.href='#'">Inapoi</button>
    </div>

    <div class="info-box">
        <h1>Storage Details</h1>
        <div class="info-item"><strong>Name:</strong> ${storage.name}</div>
        <div class="info-item"><strong>Max Capacity:</strong> ${storage.maxCapacity}</div>
        <div class="info-item"><strong>Current Capacity:</strong> ${storage.currentCapacity}</div>
        <div class="info-item"><strong>Location:</strong> ${storage.location}</div>
        <div class="info-item"><strong>Availability:</strong> ${storage.availability}</div>
    </div>

     <div id="productsContainer" class="products-container">
        <!-- Products will be dynamically added here -->
    </div>

    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>Add Product</h2>
            <form id="addProductForm" action="/addProduct" method="post">
                <label for="productName">Name:</label>
                <input type="text" id="productName" name="productName" required><br><br>
                <label for="productPrice">Price:</label>
                <input type="number" id="productPrice" name="productPrice" min="0" required><br><br>
                <label for="productWeight">Weight:</label>
                <input type="number" id="productWeight" name="productWeight" min="0" required><br><br>
                <label for="productCategory">Category:</label>
                <select id="productCategory" name="productCategory" required>
                    <option value="">Select a category</option>
                </select><br><br>
                <input type="hidden" name="storageId" value="${storage.id}">
                <input type="submit" value="Add Product">
            </form>
        </div>
    </div>
    
    <div id="editModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeEditModal()">&times;</span>
        <h2>Edit Product</h2>
        <form id="editProductForm" onsubmit="saveEditedProduct(); return false;">
            <input type="hidden" id="productId" name="productId">
            <label for="editProductName">Name:</label>
            <input type="text" id="editProductName" name="editProductName" required><br><br>
            <label for="editProductPrice">Price:</label>
            <input type="number" id="editProductPrice" name="editProductPrice" min="0" required><br><br>
            <label for="editProductWeight">Weight:</label>
            <input type="number" id="editProductWeight" name="editProductWeight" min="0" required><br><br>
            <label for="editProductCategory">Category:</label>
            <select id="editProductCategory" name="editProductCategory" required>
                <option value="">Select a category</option>
                <!-- Populate categories dynamically if needed -->
            </select><br><br>
            <input type="submit" value="Save">
        </form>
   	 </div>
	</div>

	<div class="message">
        <c:if test="${not empty message}">
            <p>${message}</p>
        </c:if>
    </div>


    <script>
    document.getElementById("openModalBtn").onclick = function() {
        var modal = document.getElementById("myModal");
        modal.style.display = "block";
        populateProductCategoryDropdown();
    };

    var modal = document.getElementById("myModal");
    var span = document.getElementsByClassName("close")[0];

    span.onclick = function() {
        modal.style.display = "none";
    };

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    };

    function populateProductCategoryDropdown() {
        fetch('/categories')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(categories => {
                var productCategoryDropdown = document.getElementById("productCategory");
                productCategoryDropdown.innerHTML = '<option value="">Select a category</option>';

                categories.forEach(category => {
                    var option = document.createElement("option");
                    option.value = category.name;
                    option.textContent = category.name;
                    productCategoryDropdown.appendChild(option);
                });
            })
            .catch(error => {
                console.error('Error fetching categories:', error);
            });
    }
    
    function fetchAndDisplayProducts() {
        var storageId = ${storage.id}; // Retrieve storage ID from JSP variable
        fetch('/getAllProdusByStorageId?storageId=' + storageId)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(products => {
                var productsContainer = document.getElementById("productsContainer");
                productsContainer.innerHTML = ''; // Clear previous content

                products.forEach(product => {
                    var productItem = document.createElement("div");
                    productItem.classList.add("product-item");

                    var productName = document.createElement("h3");
                    productName.textContent = product.name;
                    productItem.appendChild(productName);

                    var productCategory = document.createElement("p");
                    productCategory.textContent = "Category: " + product.category;
                    productItem.appendChild(productCategory);

                    var productWeight = document.createElement("p");
                    productWeight.textContent = "Weight: " + product.weight;
                    productItem.appendChild(productWeight);

                    var productPrice = document.createElement("p");
                    productPrice.textContent = "Price: " + product.price;
                    productItem.appendChild(productPrice);

                    // Amount controls (increment and decrement buttons + input field)
                    var amountControls = document.createElement("div");
                    amountControls.classList.add("amount-controls");

                    var decreaseButton = document.createElement("button");
                    decreaseButton.textContent = "-";
                    decreaseButton.addEventListener('click', function() {
                        updateProductAmount(product.id, product.amount - 1);
                    });
                    amountControls.appendChild(decreaseButton);

                    var amountInput = document.createElement("input");
                    amountInput.type = "number";
                    amountInput.value = product.amount;
                    amountInput.addEventListener('change', function() {
                        updateProductAmount(product.id, parseInt(amountInput.value));
                    });
                    amountControls.appendChild(amountInput);

                    var increaseButton = document.createElement("button");
                    increaseButton.textContent = "+";
                    increaseButton.addEventListener('click', function() {
                        updateProductAmount(product.id, product.amount + 1);
                    });
                    amountControls.appendChild(increaseButton);

                    productItem.appendChild(amountControls);

                    // Edit button
                    var editButton = document.createElement("button");
                    editButton.textContent = "Edit";
                    editButton.onclick = function() {
                        openEditModal(product.id, product.name, product.price, product.weight, product.category);
                    };
                    productItem.appendChild(editButton);

                    // Delete button
                    var deleteButton = document.createElement("button");
                    deleteButton.textContent = "Delete";
                    deleteButton.onclick = function() {
                        deleteProduct(product.id);
                    };
                    productItem.appendChild(deleteButton);

                    productsContainer.appendChild(productItem);
                });
            })
            .catch(error => {
                console.error('Error fetching products:', error);
            });
    }

    function updateProductAmount(productId, newAmount) {
        fetch('/updateProductAmount/' + productId + '?amount=' + newAmount, {
            method: 'PUT'
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to update product amount');
            }
            // Refresh products after update
            fetchAndDisplayProducts();
        })
        .catch(error => {
            console.error('Error updating product amount:', error);
        });
    }



    function deleteProduct(productId) {
        fetch('/deleteProduct/' + productId, {
            method: 'DELETE'
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to delete product');
            }
            // Refresh products after deletion
            fetchAndDisplayProducts();
        })
        .catch(error => {
            console.error('Error deleting product:', error);
        });
    }

    function openEditModal(productId, currentName, currentPrice, currentWeight, currentCategory) {
        // Populate modal fields with current product details
        document.getElementById("productId").value = productId;
        document.getElementById("editProductName").value = currentName;
        document.getElementById("editProductPrice").value = currentPrice;
        document.getElementById("editProductWeight").value = currentWeight;

        // Populate select element (editProductCategory) with categories
        fetch('/categories')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(categories => {
                var productCategoryDropdown = document.getElementById("editProductCategory");
                productCategoryDropdown.innerHTML = ''; // Clear previous options

                categories.forEach(category => {
                    var option = document.createElement("option");
                    option.value = category.name;
                    option.textContent = category.name;
                    
                    if (category.name === currentCategory) {
                        option.selected = true; // Select the current category
                    }
                    
                    productCategoryDropdown.appendChild(option);
                });
            })
            .catch(error => {
                console.error('Error fetching categories:', error);
            });

        // Show the edit modal
        var modal = document.getElementById("editModal");
        modal.style.display = "block";
    }

    function closeEditModal() {
        // Close the edit modal
        var modal = document.getElementById("editModal");
        modal.style.display = "none";
    }

    function saveEditedProduct() {
        var productId = document.getElementById("productId").value;
        var newName = document.getElementById("editProductName").value;
        var newPrice = parseFloat(document.getElementById("editProductPrice").value);
        var newWeight = parseInt(document.getElementById("editProductWeight").value);
        var newCategory = document.getElementById("editProductCategory").value;

        if (newName && !isNaN(newPrice) && !isNaN(newWeight) && newCategory) {
            fetch('/editProduct/' + productId + '?productName=' + encodeURIComponent(newName) + '&productPrice=' + newPrice + '&productWeight=' + newWeight + '&productCategory=' + encodeURIComponent(newCategory), {
                method: 'PUT'
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to edit product');
                }
                // Close the edit modal and refresh products
                closeEditModal();
                fetchAndDisplayProducts();
            })
            .catch(error => {
                console.error('Error editing product:', error);
            });
        }
    }

    // Call the function when the page loads
    window.onload = function() {
        fetchAndDisplayProducts();
    };

    </script>
</body>
</html>