<%-- 
    Document   : login
    Created on : May 29, 2024, 2:30:26 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background: linear-gradient(to right, #cb117a9e, #25dcfcd4);
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .container {
                background: white;
                padding: 40px;
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
                text-align: center;
            }
            h1 {
                margin-bottom: 30px;
                color: #333;
                font-size: 24px;
                text-align: center;
            }
            form {
                display: flex;
                flex-direction: column;
            }
            input[type="text"],
            input[type="password"] {
                padding: 15px;
                margin-bottom: 20px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 16px;
            }
            input[type="submit"],
            input[type="reset"] {
                padding: 15px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            input[type="submit"] {
                background-color: #28a745;
                color: white;
            }
            input[type="submit"]:hover {
                background-color: #2231b5;
            }
            input[type="reset"] {
                background-color: #dc3545;
                color: white;
                margin-top: 10px;
            }
            input[type="reset"]:hover {
                background-color: #c82333;
            }
            a {
                display: block;
                margin-top: 20px;
                color: #00fffd;
                text-align: center;
                font-size: larger;
            }
            a:hover {
                text-decoration: underline;
            }
            .error-message {
                color: #fa0000;
                margin-top: 30px;
                margin-left: 25px;
                font-size: 35px;

            }
        </style>
        <script>
            window.addEventListener('load', function () {
                const canvas = document.getElementById('captchaCanvas');
                const ctx = canvas.getContext('2d');

                // Function to generate random characters
                function generateCaptcha() {
                    const chars = 'ABCDEFGHJKLMNOPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz0123456789';
                    let captchaText = '';
                    for (let i = 0; i < 6; i++) {
                        captchaText += chars.charAt(Math.floor(Math.random() * chars.length));
                    }
                    return captchaText;
                }

                // Generate initial CAPTCHA text
                let captcha = generateCaptcha();

                // Draw the CAPTCHA text on canvas
                function drawCaptcha() {
                    ctx.clearRect(0, 0, canvas.width, canvas.height); // Clear the canvas before drawing new CAPTCHA
                    ctx.font = '20px Arial';
                    ctx.fillText(captcha, 10, 25);

                    // Add noise and distortion (optional for better security)
                    ctx.fillStyle = '#ddd'; // Set background noise color
                    for (let i = 0; i < 50; i++) {
                        ctx.fillRect(Math.random() * canvas.width, Math.random() * canvas.height, 2, 2);
                    }
                }

                drawCaptcha();

                // Handle form submission and validate CAPTCHA
                const form = document.getElementById('yourFormId'); // Replace with your form ID
                form.addEventListener('submit', function (event) {
                    const userCaptcha = document.getElementById('captchaInput').value;
                    if (userCaptcha.toLowerCase() !== captcha.toLowerCase()) {
                        alert('Invalid CAPTCHA!');
                        event.preventDefault();
                        captcha = generateCaptcha();
                        drawCaptcha();
                    }
                });


            });
        </script>
    </head>
    <body>

        <form action="MainController" method="post">

            <h1>Login Information</h1>
            User ID:<input type="text" name="userID" /></br>
            Password:<input type="password" name="password" /></br>
            <canvas id="captchaCanvas" width="100" height="30" style="background-color: lightseagreen;"></canvas><br>
            <input id="captchaInput" type="text" name="captcha" placeholder="Enter CAPTCHA" required=""/><br>
            <input type="submit" name="action" value="Login" />
            <input type="reset" value="Reset" />
            <div id="error-message" style="
                 margin-top: 10px;
                 color: crimson;">INCORRECT USERID OR PASSWORD</div>
            <a href="MainController?action=Create_Page">Create User</a>
            
            <a href="Top1">TOP1</a>
        </form>

    </body>


</html>


