<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <div class="jumbotronlogin" style="position: relative; display: grid;">

        <img src="../Img/cp200px.png" class="imgpag" style="position: absolute; right: 30px; bottom: 5px; max-width: 300px;" />

        <div class="container">

            <div class="input-group">
                <span style="font-size: initial;" class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                <input id="usr" clientidmode="Static" type="text" runat="server" class="form-control" name="usr" placeholder="Usuario" />
            </div>
            <br />
            <div class="input-group">
                <span style="font-size: initial;" class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                <input id="pwd" clientidmode="Static" data-toggle="password" type="password" runat="server" class="form-control" name="pwd" placeholder="Contraseña" />
            </div>
            <br />
            <div class="input-group">
                <div class="g-recaptcha" data-sitekey="6LfLouEoAAAAALoCVF-iHUTtaS8T0S4R3ysAuok9" action="LOGIN"></div>

            </div>
            <br />
            <asp:HiddenField ClientIDMode="Static" ID="ipadressext" runat="server" />
            <asp:HiddenField ClientIDMode="Static" ID="errorcaptcha" runat="server" />
            <%--<button type="button" id="btnLog" runat="server" class="btn btn-primary">Ingresar</button>--%>
            <div class="input-group">
                <button type="button" id="btnIngresar" runat="server" clientidmode="Static" class="btn btn-primary">Ingresar</button>
            </div>
            <br />

            <div class="input-group">
                <%--<a href="RecuperacionContrasena.aspx">¿Olvidó su contraseña?</a>--%>

            </div>
            <br />
            <div class="input-group">
                <label id="lblresultokfail" clientidmode="Static" name="lblresultokfail" class="alert alert-danger" style="display: none" runat="server"></label>
                <label id="lblCargando" clientidmode="Static" name="lblCargando" class="alert alert-info" style="display: none" runat="server"></label>
            </div>
        </div>
    </div>
    <script src="../Scripts/jquery.min.js"></script>
    <script src="../Scripts/bootstrap.js"></script>
    <script src="../Scripts/bootstrap-show-password.js"></script>
    <script>
        $(function () {
            $('#password').password().on('show.bs.password', function (e) {
                $('#eventLog').text('On show event');
                $('#methods').prop('checked', true);
            }).on('hide.bs.password', function (e) {
                $('#eventLog').text('On hide event');
                $('#methods').prop('checked', false);
            });
            $('#methods').click(function () {
                $('#password').password('toggle');
            });
        });

        function verificarRecaptcha() {
            var response = grecaptcha.getResponse();
            //console.log(response)

            if (response.length === 0) {
                // El reCAPTCHA no se ha completado, realiza una acción o muestra un mensaje de error.
                //alert("Por favor, completa el reCAPTCHA.");
                return "error";
            } else {
                // El reCAPTCHA se ha completado y response contiene el valor g-recaptcha-response.
                // Puedes utilizar este valor para enviarlo al servidor para su validación.
                // Continúa con la lógica de tu aplicación.
                return response;
            }
        }
        let ipAddress = null;

        // Función para obtener la IP del cliente con timeout
        function getClientIP() {
            const fetchIP = fetch('https://api64.ipify.org?format=json')
                .then(response => response.json())
                .then(data => data.ip);

            const timeout = new Promise((resolve, reject) => {
                setTimeout(() => {
                    resolve("127.0.0.9");  // IP predeterminada en caso de timeout
                }, 3000);  // Timeout de 5 segundos
            });

            return Promise.race([fetchIP, timeout])
                .then(ip => {
                    ipAddress = ip;
                    return ipAddress;
                })
                .catch(error => {
                    console.error("Error al obtener la IP:", error);
                    return "127.0.0.9";
                });
        }

        // Función para realizar el login
        function login() {
            const user = $("#usr").val();
            const pass = $("#pwd").val();
            var mCaptcha = verificarRecaptcha();
            if (mCaptcha == "error") {

                $('#btnIngresar').attr('disabled', false);
                $("#lblresultokfail").css("display", "block");
                $('#lblresultokfail').html('Marque la casilla de verificacion');
                return;

            }
            const responseCaptcha = mCaptcha;

            // Verifica si ya tenemos la IP
            if (!ipAddress) {
                // Si no tenemos la IP, la obtenemos primero
                getClientIP().then(() => {
                    sendLoginRequest(user, pass, responseCaptcha, ipAddress);
                }).catch(error => {
                    // Manejo de error si no se pudo obtener la IP
                    console.error("No se pudo obtener la IP. Por favor, inténtelo de nuevo.");
                });
            } else {
                // Si ya tenemos la IP, continuamos con el login
                sendLoginRequest(user, pass, responseCaptcha, ipAddress);
            }
        }

        // Función para enviar la solicitud de login
        function sendLoginRequest(user, pass, responseCaptcha, ipAddress) {
            const sendObj = {
                "User": user,
                "Pass": pass,
                "IPCliente": ipAddress,
                "responsecaptcha": responseCaptcha
            };

            const stringData = JSON.stringify(sendObj);

            $.ajax({
                type: "POST",
                url: "../Servicios/Servicios.asmx/Login",
                data: "{'pObj':" + stringData + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function (response) {
                    $('#lblCargando').css({ display: 'block' });
                    $('#lblCargando').html('Procesando...');
                    $("#lblresultokfail").css("display", "none");
                },
                success: function (response) {
                    const models = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
                    const val = models[0].Estado;
                    const text = models[0].Mensaje;

                    $('#lblCargando').css({ display: 'none' });

                    if (val) {
                        handleSuccessfulLogin(models[0]);
                    } else {
                        handleFailedLogin(text, models[0].IDAcceso);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.error("Error en la solicitud de login:", textStatus, errorThrown);
                }
            });
        }

        // Función para manejar un login exitoso
        function handleSuccessfulLogin(model) {
            const sendObj = {
                "User": model.User,
                "Pass": model.Pass,
                "Saldo": model.Saldo,
                "SaldoSube": model.SaldoSube,
                "IDAgencia": model.IDAgencia,
                "NombreAgencia": model.NombreAgencia,
                "DireccionAgencia": model.DireccionAgencia,
                "IDPrestamoBase": model.IDPrestamoBase,
                "AptoCredito": model.AptoCredito,
                "MensajeCredito": model.MensajeCredito,
                "IDAcceso": model.IDAcceso,
                "HabilitadoEntregaDinero": model.HabilitadoEntregaDinero,
                "CodPuestoRP": model.CodPuestoRP,
                "Agente": model.Agente,
                "Sucursal": model.Sucursal,
                "IDAuditoria": model.IDAuditoria,
                "IPCliente": model.IPCliente
            };

            const stringData = JSON.stringify(sendObj);

            $.ajax({
                type: "POST",
                url: "default.aspx",
                data: stringData,
                success: function (respuesta) {
                    $('#btnIngresar').attr('disabled', false);
                    window.location.href = 'Page/RecargaSaldoVirtual.aspx';
                },
                error: function (error) {
                    $('#btnIngresar').attr('disabled', false);
                    console.error("Error al asignar valor a la sesión:", error);
                    window.location.href = '../default.aspx';
                }
            });
        }

        // Función para manejar un login fallido
        function handleFailedLogin(text, idAcceso) {
            $('#btnIngresar').attr('disabled', false);
            $("#lblCargando").css("display", "none");
            $("#lblresultokfail").css("display", "block");

            if (text == "Su clave ha expirado. Debe cambiarla!") {
                $("#lblresultokfail").html("Su clave ha expirado. Debe cambiarla!. En unos segundos sera redireccionado...");
                setTimeout(updateClock(text, 0, idAcceso), 4000);
            } else {
                $("#lblresultokfail").html(text);
                grecaptcha.reset();
            }
        }

        // Llamar a la función de login cuando se haga clic en el botón
        $("#btnIngresar").on("click", function () {
            login();
        });
        //$("#btnIngresar").click(function () {


        //    var ipAddress;
        //    $('#btnIngresar').attr('disabled', true);
        //    var mCaptcha = verificarRecaptcha();
        //    if (mCaptcha == "error") {

        //        $('#btnIngresar').attr('disabled', false);
        //        $("#lblresultokfail").css("display", "block");
        //        $('#lblresultokfail').html('Marque la casilla de verificacion');
        //        return;

        //    }
        //    fetch('https://api64.ipify.org?format=json')
        //        .then(response => response.json())
        //        .then(data => {
        //            ipAddress = data.ip;
        //            //console.log("Remote IP Address: " + ipAddress);

        //            //alert(ipadressext);
        //            var SendObj = {
        //                "User": $("#usr").val(),
        //                "Pass": $("#pwd").val(),
        //                "IPCliente": ipAddress,
        //                "responsecaptcha": mCaptcha
        //            }

        //            var stringData = JSON.stringify(SendObj);
        //            //alert(stringData);
        //            $.ajax({
        //                type: "POST",
        //                url: "../Servicios/Servicios.asmx/Login",
        //                data: "{'pObj':" + stringData + "}",
        //                contentType: "application/json; charset=utf-8",
        //                dataType: "json",

        //                beforeSend: function (response) {
        //                    $('#lblCargando').css({ display: 'block' });
        //                    $('#lblCargando').html('Procesando...');
        //                    $("#lblresultokfail").css("display", "none");
        //                },
        //                success: function (response) {

        //                    var models = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;

        //                    var val = models[0].Estado;

        //                    var text = models[0].Mensaje;

        //                    $('#lblCargando').css({ display: 'none' });



        //                    if (val) {

        //                        var SendObj = {
        //                            "User": models[0].User,
        //                            "Pass": models[0].Pass,
        //                            "Saldo": models[0].Saldo,
        //                            "SaldoSube": models[0].SaldoSube,
        //                            "IDAgencia": models[0].IDAgencia,
        //                            "NombreAgencia": models[0].NombreAgencia,
        //                            "DireccionAgencia": models[0].DireccionAgencia,
        //                            "IDPrestamoBase": models[0].IDPrestamoBase,
        //                            "AptoCredito": models[0].AptoCredito,
        //                            "MensajeCredito": models[0].MensajeCredito,
        //                            "IDAcceso": models[0].IDAcceso,
        //                            "HabilitadoEntregaDinero": models[0].HabilitadoEntregaDinero,
        //                            "CodPuestoRP": models[0].CodPuestoRP,
        //                            "Agente": models[0].Agente,
        //                            "User": models[0].User,
        //                            "Sucursal": models[0].Sucursal,
        //                            "IDAuditoria": models[0].IDAuditoria,
        //                            "IPCliente": models[0].IPCliente

        //                        }
        //                        var stringData = JSON.stringify(SendObj);
        //                        // Realizar una solicitud AJAX al servidor
        //                        $.ajax({
        //                            type: "POST",
        //                            url: "default.aspx", // Reemplaza con la URL de tu página o controlador
        //                            data: stringData,
        //                            success: function (respuesta) {
        //                                $('#btnIngresar').attr('disabled', false);
        //                                window.location.href = 'Page/RecargaSaldoVirtual.aspx'
        //                            },
        //                            error: function (error) {
        //                                $('#btnIngresar').attr('disabled', false);
        //                                console.error("Error al asignar valor a la sesión: " + error);
        //                                window.location.href = '../default.aspx'
        //                            }
        //                        });

        //                    }
        //                    else {
        //                        $('#btnIngresar').attr('disabled', false);
        //                        $("#lblCargando").css("display", "none");
        //                        $("#lblresultokfail").css("display", "block");
        //                        if (text == "Su clave ha expirado. Debe cambiarla!") {

        //                            $("#lblresultokfail").html("Su clave ha expirado. Debe cambiarla!. En unos segundos sera redireccionado...");

        //                            setTimeout(updateClock(text, 0, models[0].IDAcceso), 4000);
        //                        }
        //                        else {
        //                            $("#lblresultokfail").css("display", "block");
        //                            $("#lblresultokfail").html(text);
        //                            grecaptcha.reset();
        //                        }

        //                    }
        //                },

        //                error: function (jqXHR, textStatus, errorThrown) {

        //                },

        //            });
        //        });

        //});

        var totalTime = 3;
        function updateClock(texto, aprobado, id) {



            //window.location.href = 'Page/changepassword.aspx?id=' + id
            //location.reload();
            window.location.replace('Page/changepassword.aspx?id=' + id);

            //if (aprobado == 1) {
            //    $("#lblresultok").html(texto + ' . Recargando en ' + totalTime.toString());
            //} else {
            //    $("#lblresultokfail").html(texto + ' . Recargando en ' + totalTime.toString());
            //    window.location.href = 'Page/changepassword.aspx?id='+ id
            //}

            //if (totalTime == 0) {
            //    location.reload();
            //} else {
            //    totalTime -= 1;
            //    setTimeout(function () {
            //        updateClock(texto, aprobado, id);
            //    }, 1000);
            //}
        }
    </script>


</asp:Content>

