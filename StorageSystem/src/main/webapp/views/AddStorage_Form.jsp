<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <title>Adauga depozit</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #538392;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
				#addCategoryBtn {
		    background-color: #80B9AD; /* Change button background color to white */
		    color: #fff; /* Change text color to black */
		    padding: 12px 24px; /* Adjust padding to change button size */
		    border-radius: 5px;
		    cursor: pointer;
		    font-size: 16px; /* Adjust font size */
		    border: none;
		}
		
		#addCategoryBtn:hover {
		    background-color: #538392; /* Change hover background color to gray */
		}
        .wrapper {
            background: #fff;
            max-width: 500px;
            width: 100%;
            padding: 30px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        .wrapper h2 {
            margin-bottom: 20px;
            color: #333;
            text-align: center;
        }

        .input-box,
        .category-box {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .input-box input,
        .category-box select {
            flex-grow: 1;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box; /* Ensures padding is included in width calculation */
        }

        .input-box input:focus,
        .category-box select:focus {
            border-color: #538392;
            outline: none;
        }

        .button input,
        .button button {
            background-color: #80B9AD;
            color: #fff;
            border: none;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .button input:hover,
        .button button:hover {
            background-color: #538392;
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <h2>Adauga depozit</h2>
        <form id="form1" action="CreateStorage" method="post">
            <div class="input-box">
                <input type="text" id="name" name="name" placeholder="Nume" required>
            </div>
            <div class="input-box">
                <input type="number" id="maxCapacity" name="maxCapacity" placeholder="capacitate maximala" required>
            </div>
            <div class="category-box">
            <select id="categories" name="categories" required multiple>
                <option value="">Selecteaza o categorie</option>
            </select>
            <button id="addCategoryBtn" type="button">Adauga Categorie</button>
        </div>
            <div class="input-box">
                <input type="text" id="location" name="location" placeholder="Locatie" required>
            </div>
            <div class="input-box button">
                <input type="submit" value="Creaza depozit">
            </div>
        </form>
    </div>

    <script>
    document.addEventListener("DOMContentLoaded", function() {
        // Fetch categories from the backend
        fetch("/categories")
            .then(response => response.json())
            .then(data => {
                const categoriesSelect = document.getElementById("categories");
                // Clear existing options
                categoriesSelect.innerHTML = '<option value="">Selecteaza o categorie</option>';
                // Populate options with fetched categories
                data.forEach(category => {
                    const option = document.createElement("option");
                    option.value = category.id;
                    option.text = category.name;
                    categoriesSelect.appendChild(option);
                });
            })
            .catch(error => {
                console.error("Error fetching categories:", error);
            });
    });

    document.getElementById("addCategoryBtn").addEventListener("click", function() {
        var categoryName = prompt("Introduceti numele categoriei:");

        if (categoryName !== null && categoryName.trim() !== "") {
            // Send AJAX request to create a category
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "/categories", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    // Category created successfully
                    alert("Categoria a fost creata cu succes!");
                    // Refresh categories dropdown after creating a new category
                    fetchCategories();
                } else if (xhr.readyState === 4) {
                    // Error occurred
                    alert("A aparut o eroare la crearea categoriei. Va rugam incercati din nou mai tarziu.");
                }
            };
            xhr.send("name=" + encodeURIComponent(categoryName));
        } else {
            // Prompt was canceled or empty input
            alert("Numele categoriei este necesar.");
        }
    });

    function fetchCategories() {
        fetch("/categories")
            .then(response => response.json())
            .then(data => {
                const categoriesSelect = document.getElementById("categories");
                // Clear existing options
                categoriesSelect.innerHTML = '<option value="">Selecteaza o categorie</option>';
                // Populate options with fetched categories
                data.forEach(category => {
                    const option = document.createElement("option");
                    option.value = category.id;
                    option.text = category.name;
                    categoriesSelect.appendChild(option);
                });
            })
            .catch(error => {
                console.error("Error fetching categories:", error);
            });
    }
    
    document.getElementById("form1").addEventListener("submit", function(event) {
        // Prevent the default form submission
        event.preventDefault();
        
        // Get the selected categories
        var categoriesSelect = document.getElementById("categories");
        var selectedCategories = Array.from(categoriesSelect.selectedOptions).map(option => option.value);
        
        // Append hidden inputs for each selected category
        selectedCategories.forEach(categoryId => {
            var input = document.createElement("input");
            input.type = "hidden";
            input.name = "categoryIds";
            input.value = categoryId;
            document.getElementById("form1").appendChild(input);
        });
        
        // Submit the form
        this.submit();
    });

</script>
</body>
</html>
