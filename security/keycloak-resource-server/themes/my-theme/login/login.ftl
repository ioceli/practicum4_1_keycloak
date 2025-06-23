<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=social.displayInfo; section>
    <#if section = "title">
        ${msg("loginTitle",(realm.displayName!''))}
    <#elseif section = "header">
        <link href="https://fonts.googleapis.com/css?family=Muli" rel="stylesheet"/>
        <link href="${url.resourcesPath}/img/favicon.png" rel="icon"/>
        <script>
            function togglePassword() {
                var x = document.getElementById("password");
                var v = document.getElementById("vi");
                if (x.type === "password") {
                    x.type = "text";
                    v.src = "${url.resourcesPath}/img/eye.png";
                } else {
                    x.type = "password";
                    v.src = "${url.resourcesPath}/img/eye-off.png";
                }
            }
        </script>
       
    <#elseif section = "form">
    <style>
        /* Resetting defaults and setting up body and HTML styles */
        body,
        html {
            height: 100vh;
            margin: 0;
            font-family: 'Muli', sans-serif;
            background-color: #f1f1f1; /* Adjust as per your design */
        }

        /* Centering login content */
        .login-content {
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url("/resources/rl63n/login/my-theme/img/my-login-bg.jpg");
            background-size: cover;
            background-position: center;
            height:100vh;
            flex-direction:column;
            justify-content:center;
            width:100vw;
        }

        /* Styling for the login box */
        .box {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            padding: 20px;
            /*max-width: 400px;*/ /* Adjust as per your design */
            width: 40%;
            text-align: center;
            overflow: hidden; /* Prevents content overflow */
            margin:2%;
            height:90vh;
            justify-content:center;
        }

        /* Form styling */
        form#kc-form-login {
            text-align: center;
            position: relative; /* Added position relative to parent */
            padding: 0% 20% 0% 20%;
        }

        .login-field {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px; /* Adjust spacing */
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 12px;
            box-sizing: border-box; /* Ensures padding and border are included in width */
        }

        .submit {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 4px;
            background-color: #3498db;
            color: white;
            font-size: 12px;
            cursor: pointer;
            margin:2%;
        }

        .submit:hover {
            background-color: #2980b9;
        }

        /* Forgot password link */
        .forgot-password-wrapper {
            margin-top: 10px; /* Adjust spacing */
            text-align: center;
        }

        .forgot-password-button {
            color: #3498db;
            font-size: 14px;
            text-decoration: underline;
            cursor: pointer;
        }

        .forgot-password-button:hover {
            color: #2980b9;
        }

        /* Copyright text */
        .copyright {
            font-size: 12px;
            color: #888;
            margin-top: 20px; /* Adjust spacing */
            text-align: center;
        }
        .logo{
            width:50%
        }
        .visibility{
            position: relative;
            left: 116px!important;
            top: 38px;
            width: 24px;
            height: 24px;
            opacity: 0.54;
            border: none;
            z-index: 100;
        }
        /* Responsive adjustments */
        @media (max-width: 600px) {
            .box {
                max-width: 90%; /* Adjust maximum width for smaller screens */
            }
            .login-content {
                height:100vh;
            }
            .login-field,
            .submit {
                font-size: 14px; /* Adjust font size for smaller screens */
            }
        }
    </style>
        <div class="box-container">
            <img class="logo" src="${url.resourcesPath}/img/my-logo.png" alt="My Auth">
            <!--<div>
                <p class="application-name">Custom Identity Service</p>
            </div>-->
        <#if realm.password>
               <form id="kc-form-login" class="form" onsubmit="return true;" action="${url.loginAction}" method="post">
                    <input id="username" class="login-field" placeholder="${msg("username")}" type="text" name="username" tabindex="1">
                    <div>
                        <label class="visibility" id="v" onclick="togglePassword()"><img id="vi" src="${url.resourcesPath}/img/eye-off.png"></label>
                    </div>
                    <input id="password" class="login-field" placeholder="${msg("password")}" type="password" name="password" tabindex="2">
                 
                    <input class="submit" type="button" onclick="location.href='${url.registrationUrl}';" value="${msg("doRegister")}"/>
                    <input class="submit" type="submit" value="${msg("doLogIn")}" tabindex="3"> 
                   
                    <div>
                        <p class="copyright">&copy; ${msg("copyright", "${.now?string('yyyy')}")}</p>
                    </div>
                </form>

                   <div class="forgot-password-wrapper">
                        <a href="${url.loginResetCredentialsUrl}" class="forgot-password-button">${msg("doForgotPassword")}</a>
                    </div>
        </#if>
        <#if social.providers??>
            <div class="alternate-wrapper">
                <span spacing="16" class="separator"></span>
                <div class="login-alternate-spacer"></div>
                <span data-cy="text" font-size="16px" font-weight="400" class="login-alternate">or</span>
                <div class="login-alternate-spacer"></div>
                <span spacing="16" class="separator"></span>
            </div>
            <!--<p class="para">${msg("socialLoginAlternate")}</p>-->
            <div id="social-providers">
                <#list social.providers as p>
                <input class="social-link-style" type="button" onclick="location.href='${p.loginUrl}';" value="${p.displayName}"/>
                </#list>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>
