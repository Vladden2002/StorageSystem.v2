<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Sistem de Gestiune a Depozitelor</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0; /* Light gray background */
            color: #333; /* Dark gray text color */
        }
        
        #navbar {
            background-color: #538392; /* Dark blue navbar */
            color: #fff;
            width: 200px;
            height: 100%;
            position: fixed;
            left: 0;
            top: 0;
            padding-top: 20px;
            padding-bottom: 20px;
        }
        
        #navbar ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }
        
        #navbar ul li {
            padding: 10px;
        }
        
        #navbar ul li#contul-meu {
	    border-bottom: 1px solid #fff; /* Add a white horizontal line under Contul Meu */
	}
        
        #navbar ul li a {
            color: #fff;
            text-decoration: none;
            display: block;
            transition: background-color 0.3s ease-in-out; /* Smooth transition on hover */
            font-size: 16px; /* Adjust the font size */
        }
        
        #navbar ul li a:hover {
            background-color: #34495e; /* Darker shade of blue on hover */
        }
        
        #logout {
            position: absolute;
            bottom: 20px;
            left: 10px;
        }
        
        #content {
            margin-left: 220px;
            padding: 20px;
            color: #333; /* Dark gray text color */
        }
        
        .storage-box {
            border: 1px solid #ddd; /* Light gray border */
            padding: 20px;
            margin: 20px;
            background-color: #fff; /* White background */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Soft shadow effect */
            border-radius: 8px; /* Rounded corners */
            width: 200px; /* Adjust the width */
            height: 200px; /* Adjust the height */
            display: inline-block; /* Make boxes appear in a row */
            transition: transform 0.3s ease-in-out; /* Smooth transition on hover */
        }

        .storage-box:hover {
            transform: scale(1.05); /* Increase size on hover */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Add shadow on hover */
        }

        .storage-box h2 {
            margin-top: 0; /* Remove default margin */
            color: #538392; /* Dark blue heading color */
            font-size: 1.2em; /* Larger font size */
            border-bottom: 1px solid #ddd; /* Light gray bottom border */
            padding-bottom: 10px; /* Space below the heading */
        }
        
        .storage-box p {
            margin: 10px 0; /* Add some space between paragraphs */
            color: #666; /* Medium gray text color */
        }
    </style>
</head>
<body>
    <div id="navbar">
        <ul>
            <li><a href="#">Contul Meu</a></li>
            <li><a href="/AddStorage">Adăugare Depozit</a></li>
            <li id="logout"><a href="#">Logout</a></li> <!-- Link-ul de logout -->
        </ul>
    </div>

    <div id="content">
        <h1>Depozite</h1>
        <c:forEach var="storage" items="${storages}">
            <a href="/manageStorage/${storage.id}"> <!-- Redirect to manageStorage.jsp with storage ID -->
                <div class="storage-box">
                    <h2>${storage.name}</h2>
                    <p>Locație: ${storage.location}</p>
                    <p>Capacitate maximă: ${storage.maxCapacity}</p>
                    <p>Capacitate curentă: ${storage.currentCapacity}</p>
                    <p>Disponibilitate: ${storage.availability}</p>
                </div>
            </a>
        </c:forEach>
    </div>
</body>
</html>

