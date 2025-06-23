<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("registerTitle")}
    <#elseif section = "form">
        <form id="kc-register-form" class="form" action="${url.registrationAction}" method="post">

                <img class="logo" src="${url.resourcesPath}/img/my-logo.png" alt="My Auth">

            <div class="form-group ${messagesPerField.printIfExists('firstName', 'error')}">
                <div class="label-wrapper">
                    <label for="firstName" class="label">${msg("firstName")}</label>
                </div>
                <div class="input-wrapper">
                    <input type="text" id="firstName" class="input" name="firstName" value="${(register.formData.firstName!'')}" />
                </div>
            </div>

            <div class="form-group ${messagesPerField.printIfExists('lastName', 'error')}">
                <div class="label-wrapper">
                    <label for="lastName" class="label">${msg("lastName")}</label>
                </div>
                <div class="input-wrapper">
                    <input type="text" id="lastName" class="input" name="lastName" value="${(register.formData.lastName!'')}" />
                </div>
            </div>

            <div class="form-group ${messagesPerField.printIfExists('email', 'error')}">
                <div class="label-wrapper">
                    <label for="email" class="label">${msg("email")}</label>
                </div>
                <div class="input-wrapper">
                    <input type="text" id="email" class="input" name="email" value="${(register.formData.email!'')}" autocomplete="email" />
                </div>
            </div>

            <div class="${properties.kcInputWrapperClass!} form-group ${messagesPerField.printIfExists('cedula', 'error')}">
                  <label for="user.attributes.cedula" class="${properties.kcLabelClass!} label-wrapper label">
                    Cédula
                </label>
                <input type="text" class="${properties.kcInputClass!} input" 
                id="user.attributes.cedula" name="user.attributes.cedula" 
                value="${(register.formData['user.attributes.cedula']!'')}"/>
            </div>

          <#if !realm.registrationEmailAsUsername>
            <div class="form-group ${messagesPerField.printIfExists('username', 'error')}">
                <div class="label-wrapper">
                    <label for="username" class="label">${msg("username")}</label>
                </div>
                <div class="input-wrapper">
                    <input type="text" id="username" class="input" name="username" value="${(register.formData.username!'')}" autocomplete="username" />
                </div>
            </div>
          </#if>

            <#if passwordRequired>
            <div class="form-group ${messagesPerField.printIfExists('password', 'error')}">
                <div class="label-wrapper">
                    <label for="password" class="label">${msg("password")}</label>
                </div>
                <div class="input-wrapper">
                    <input type="password" id="password" class="input" name="password" autocomplete="new-password"/>
                </div>
            </div>

            <div class="form-group ${messagesPerField.printIfExists('password-confirm', 'error')}">
                <div class="label-wrapper">
                    <label for="password-confirm" class="label">${msg("passwordConfirm")}</label>
                </div>
                <div class="input-wrapper">
                    <input type="password" id="password-confirm" class="input" name="password-confirm" />
                </div>
            </div>
            </#if>

            <#if recaptchaRequired??>
            <div class="form-group">
                <div class="input-wrapper">
                    <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                </div>
            </div>
            </#if>

            <div class="form-group">
                <div id="kc-form-buttons" class="form-buttons">
                    <input id="RegisterButton" class="button button-primary button-block button-large" type="submit" value="${msg("doRegisterButton")}"/>
                </div>
                <div id="kc-form-options" class="form-options">
                    <div class="form-options-wrapper">
                        <span><a href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>
                    </div>
                </div>
            </div>
        </form>
          <!-- JavaScript for Cedula Validation -->
        <script>
            document.getElementById("kc-register-form").addEventListener("submit", function (event) {
                const cedulaInput = document.getElementById("user.attributes.cedula");
                const cedula = cedulaInput.value.trim();

                if (!validarCedula(cedula)) {
                    event.preventDefault();
                    alert("La cédula ingresada no es válida. Por favor, verifica.");
                    cedulaInput.focus();
                }
            });

            function validarCedula(cedula) {
                if (cedula.length !== 10 || isNaN(cedula)) return false;

                const digitoRegion = parseInt(cedula.substring(0, 2));
                if (digitoRegion < 1 || digitoRegion > 24) return false;

                const ultimoDigito = parseInt(cedula.charAt(9));
                const coeficientes = [2, 1, 2, 1, 2, 1, 2, 1, 2];
                let suma = 0;

                for (let i = 0; i < 9; i++) {
                    let valor = parseInt(cedula.charAt(i)) * coeficientes[i];
                    suma += valor > 9 ? valor - 9 : valor;
                }

                const digitoVerificador = 10 - (suma % 10 === 0 ? 10 : suma % 10);
                return digitoVerificador === ultimoDigito;
            }
        </script>
    </#if>
</@layout.registrationLayout>

<style>
/* General form styles */
form#kc-register-form {
    width: 21vw;
    max-width: 400px;
    margin: 8% auto;
    padding: 4rem;
    border: 1px solid #ccc;
    border-radius: 8px;
    background-color: #ffffff;
    height: auto;
    display: flex;
    flex-direction: column;
    justify-content: center;
    border-width: 2em;
    border-color: rgba(255, 255, 255, 0.03);
}

/* Form group styles */
.form-group {
    margin-right: 8%;
    margin-bottom: 2%;
}

/* Label styles */
.label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
    font-size: smaller;
}

/* Input styles */
.input {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

/* Error styles */
.error {
    border: 1px solid #e74c3c;
    border-radius: 4px;
    background-color: #f2dede;
}

.error input {
    border-color: #e74c3c;
}

.error .label {
    color: #e74c3c;
}

/* Button styles */
.button {
    width: 100%;
    padding: 10px;
    border: none;
    border-radius: 4px;
    background-color: #3498db;
    color: white;
    font-size: 16px;
    cursor: pointer;
}

.button:hover {
    background-color: #2980b9;
}

/* Options styles */
#kc-form-options {
    text-align: center;
    margin-top: 10px;
}

.logo{
    width:66%;
    margin-bottom: 3%;
    align-self:center;
}

/* Responsive adjustments */
@media (max-width: 600px) {
    form#kc-register-form {
        padding: 15px;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .input {
        padding: 14px;
        font-size: 18px;
    }

    .button {
        font-size: 18px;
        padding: 14px;
    }

    #kc-form-options {
        margin-top: 15px;
    }
}
</style>


