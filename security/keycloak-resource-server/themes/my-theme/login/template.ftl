<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">

    <title><#nested "title"></title>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
      <style>
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0, 0, 0);
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }

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
        .message-text{
            color:green;
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
            background-color: rgba(0,0,0,0.03);
        }
    </style>
</head>

	<body>
        <div class="login-content">
            
           
            <div class="box" style="display:flex; flex-direction:column; overflow:auto;">
            
                <#nested "form">

                <#if displayMessage && message?has_content>
                    <div id="messageModal" class="modal">
                        <div class="modal-content">
                            <span class="close">&times;</span>
                            <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                            <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                            <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
                            <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
                            <span >${message.summary?no_esc}</span>
                        </div>
                    </div>
                </#if>
            </div>  
        </div>
        <script>
        // Get the modal
        var modal = document.getElementById("messageModal");

        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];

        // When the user clicks on <span> (x), close the modal
        span.onclick = function () {
            modal.style.display = "none";
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }

        // Show the modal if there is a message
        <#if displayMessage && message?has_content>
        modal.style.display = "block";
        </#if>
    </script>
	</body>
</html>
</#macro>
