<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Storage</title>
    <!-- Add any necessary CSS or JavaScript files -->
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
        }
        .navbar button:hover {
            background-color: #bbb;
        }
        .info-box {
            border: 1px solid #ddd; /* Light gray border */
            padding: 20px;
            margin: 20px;
            background-color: #fff; /* White background */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Soft shadow effect */
            border-radius: 8px; /* Rounded corners */
            width: 200px; /* Adjust the width */
            height: 350px; /* Adjust the height */
            position: fixed; /* Position the box relative to the viewport */
            top: 0; /* Align with the top of the viewport */
            left: 220px; /* Position next to the navbar */
            transition: transform 0.3s ease-in-out; /* Smooth transition on hover */
        }

        /* Styles for displaying information */
        .info-item {
            margin-bottom: 10px;
        }
        /* Styles for displaying category boxes */
        .category-box {
            margin-left: 20px; /* Adjust margin as needed */
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f2f2f2;
            margin-bottom: 10px;
            width: 150px; /* Adjust width as needed */
        }

        /* Additional styling for category boxes */
        .category-container {
            position: fixed;
            top: 0;
            left: 430px; /* Adjust as needed */
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
            width: 80%; /* Could be more or less, depending on screen size */
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
        <!-- You can add more information here if needed -->
    </div>

    <!-- Category boxes -->
    <div class="category-container">
        <h2>Categories</h2>
        <c:forEach var="category" items="${storage.categories}">
            <div class="category-box" onclick="fetchProductsByCategory('${category.name}')">
                ${category.name}
            </div>
        </c:forEach>
    </div>

    <!-- Products list -->
    <div id="productsList" class="products-container">
        <h2>Products</h2>
        <div id="products"></div>
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
    // JavaScript to open the modal when the button is clicked
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

    // Function to populate productCategory dropdown
    function populateProductCategoryDropdown() {
        // Get the categories from the category-container
        var categories = document.querySelectorAll(".category-container .category-box");

        // Select the productCategory dropdown
        var productCategoryDropdown = document.getElementById("productCategory");

        // Clear existing options
        productCategoryDropdown.innerHTML = '<option value="">Select a category</option>';

        // Populate options with categories
        categories.forEach(function(category) {
            var categoryName = category.textContent.trim();
            var option = document.createElement("option");
            option.value = categoryName;
            option.textContent = categoryName;
            productCategoryDropdown.appendChild(option);
        });
    }

    // Function to fetch and display products by category
    function fetchProductsByCategory(category) {
        console.log('Fetching products for category:', category); // Debugging statement
        fetch('/getProductsByCategory?category=' + encodeURIComponent(category))
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                var productsContainer = document.getElementById("products");
                productsContainer.innerHTML = ""; // Clear existing products

                if (data.length === 0) {
                    productsContainer.innerHTML = "<p>No products found for this category.</p>";
                } else {
                    data.forEach(product => {
                        var productDiv = document.createElement("div");
                        productDiv.className = "product-item";
                        productDiv.innerHTML = `<strong>Name:</strong> ${product.name} <br>
                                                <strong>Price:</strong> ${product.price} <br>
                                                <strong>Weight:</strong> ${product.weight}`;
                        productsContainer.appendChild(productDiv);
                    });
                }
            })
            .catch(error => {
                console.error('Error fetching products:', error);
                var productsContainer = document.getElementById("products");
                productsContainer.innerHTML = "<p>Error fetching products. Please try again later.</p>";
            });
    }

    document.getElementById("addProductForm").onsubmit = function(event) {
        event.preventDefault(); // Prevent default form submission

        // Get form data
        var formData = new FormData(this);

        // Send form data using fetch API or AJAX
        fetch('/addProduct', {
            method: 'POST',
            body: formData
        })
        .then(response => {
            if (response.ok) {
                // Close the modal dialog
                var modal = document.getElementById("myModal");
                modal.style.display = "none";
                // Optionally display a success message or refresh the product list
                console.log('Product added successfully');
                // Fetch and display the updated products list (optional)
                var selectedCategory = document.getElementById("productCategory").value;
                if (selectedCategory) {
                    fetchProductsByCategory(selectedCategory);
                }
            } else {
                console.error('Error adding product');
            }
        })
        .catch(error => {
            console.error('Error adding product:', error);
        });
    };
</script>

</body>
</html>