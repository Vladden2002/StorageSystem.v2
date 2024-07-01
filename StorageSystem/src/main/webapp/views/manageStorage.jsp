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

    <!-- Info box -->
    <div class="info-box">
        <h1>Storage Details</h1>
        <div class="info-item">
            <strong>Name:</strong> ${storage.name}
        </div>
        <div class="info-item">
            <strong>Max Capacity:</strong> ${storage.maxCapacity}
        </div>
        <div class="info-item">
            <strong>Current Capacity:</strong> ${storage.currentCapacity}
        </div>
        <div class="info-item">
            <strong>Location:</strong> ${storage.location}
        </div>
        <div class="info-item">
            <strong>Availability:</strong> ${storage.availability}
        </div>
    </div>

    <div id="productsContainer" class="products-container">
        <!-- Products will be dynamically added here -->
    </div>

    <!-- Modal -->
    <div id="myModal" class="modal">
        <!-- Modal content -->
        <div class="modal-content">
            <span class="close">&times;</span>
            <!-- Add your form for adding a product here -->
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
                    <!-- Categories will be populated dynamically using JavaScript -->
                </select><br><br>
                <input type="hidden" name="storageId" value="${storage.id}">
                <input type="submit" value="Add Product">
            </form>
        </div>
    </div>

    <script>
        document.getElementById("openModalBtn").onclick = function() {
            var modal = document.getElementById("myModal");
            modal.style.display = "block";
            populateProductCategoryDropdown(); // Populate productCategory dropdown when modal is opened
        };

        // JavaScript to close the modal when the close button or outside the modal is clicked
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

        function fetchProducts() {
            fetch('/getAllProdus')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(products => {
                    console.log(products); // Check what data is received

                    var productsContainer = document.getElementById("productsContainer");
                    productsContainer.innerHTML = ''; // Clear existing content

                    if (products.length === 0) {
                        // Handle case when there are no products
                        productsContainer.innerHTML = '<p>No products found</p>';
                    } else {
                        // Populate container with products
                        products.forEach(product => {
                            var productDiv = document.createElement("div");
                            productDiv.classList.add("product-item");

                            productDiv.innerHTML = `
                                <h3>${product.name}</h3>
                                <p><strong>Category:</strong> ${product.category}</p>
                                <p><strong>Weight:</strong> ${product.weight}</p>
                                <p><strong>Price:</strong> ${product.price}</p>
                                <p><strong>Amount:</strong> ${product.amount}</p>
                                <hr>
                            `;
                            productsContainer.appendChild(productDiv);
                        });
                    }
                })
                .catch(error => {
                    console.error('Error fetching products:', error);
                    var productsContainer = document.getElementById("productsContainer");
                    productsContainer.innerHTML = '<p>Error fetching products</p>';
                });
        }

        document.addEventListener('DOMContentLoaded', function() {
            fetchProducts();
        });
    </script>
</body>
</html>
