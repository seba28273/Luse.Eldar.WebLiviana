<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" EnableEventValidation="false" AutoEventWireup="false" CodeFile="changepassword.aspx.vb" 
    Inherits="Page_changepassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <div class="subpres">
      <%--  <a href="http://www.cargaplus.com.ar/accesorios_plus.html#"  target="_blank">
            <div class="BtnAuxiliarcelulartecnologia">

                <img class="imgcssgrande" src="../Img/boton_moto_01.png" />
            </div>
        </a>
        <a href="http://www.cargaplus.com.ar/factura_plus.html#"  target="_blank">
            <div class="BtnAuxiliarAccesorios">

                <img class="imgcssgrande" src="../Img/boton_factura_02.png" />
            </div>
        </a>
        <a href="CreditApto.aspx">
            <div class="prestamo">
                <img class="imgcssprestamo" src="../Img/btnPrestNew.png" />
            </div>
        </a>
        <a href="https://www.cargaplus.com.ar/sube.html">
            <div class="prestamo">
                <img class="imgcssprestamo" src="../Img/btnSubeNew.png" />
            </div>
        </a>
        <a href="http://www.cargaplus.com.ar/celulares_plus.html#" target="_blank">
            <div class="BtnAuxiliarcelular">

                <img class="imgcssgrande" src="../Img/boton_celular_01.png" />
            </div>
        </a>
       <%-- <a href="http://www.cargaplus.com.ar/motos_plus.html#" target="_blank">
            <div class="BtnAuxiliarMotos">
                <img class="imgcssgrande" src="../Img/boton_moto_01.png" />
            </div>
        </a>--%>
    </div>
    <div class="jumbotron">
        <h2>Cambio Contraseña</h2>


        <div class="container">


            <div class="input-group">
                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                <input data-toggle="password" id="txtpassword" type="password" runat="server"
                    ClientIDMode="Static" class="form-control" style="max-width:350px;" autocomplete="off" placeholder="Contraseña Actual">
     
            </div>
             
            <br />
            <div class="input-group">
                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                <input data-toggle="password" id="txtNewPassword" type="password" runat="server"
                    ClientIDMode="Static" class="form-control"  style="max-width:350px;" autocomplete="off"  placeholder="Nueva Contraseña">
            </div>
            <br />
            <div class="input-group">
                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                <input data-toggle="password" id="txtRepnewPassword" type="password" runat="server"
                    ClientIDMode="Static" class="form-control"  style="max-width:350px;"   autocomplete="off" placeholder="Repetir Nueva Contraseña">
            </div>
            <br />
            <asp:HiddenField ClientIDMode="Static" ID="User" runat="server" />
            <asp:HiddenField ClientIDMode="Static" ID="IDAcceso" runat="server" />
            <asp:HiddenField ClientIDMode="Static" ID="Pass" runat="server" />
            <asp:hiddenfield clientidmode="Static" id="MontoVentas" runat="server" />
            <asp:hiddenfield clientidmode="Static" id="AptoCredito" runat="server" />
            <button type="button" id="btnIngresar" runat="server"  clientidmode="Static" class="btn btn-primary">Cambiar</button>
            <label id="lblCargando" class="alert alert-info" style="display: none" clientidmode="Static" runat="server"></label>
            <label id="lblresultokfail" class="alert alert-danger" style="display: none" clientidmode="Static" runat="server"></label>
            <label id="lblresultok" class="alert alert-success" style="display: none" clientidmode="Static" runat="server"></label>
        </div>

    </div>
   
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
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
        $("#btnIngresar").click(function () {

            $("#lblCargando").css("display", "none");
            $("#lblresultokfail").css("display", "none");
            var SendObj = {
                "PassActual": $("#txtpassword").val(),
                "NewPass": $("#txtNewPassword").val(),
                "RepNewPass": $("#txtRepnewPassword").val(),
                "User": $("#User").val(),
                "Pass": $("#Pass").val(),
                "IDAcceso": $("#IDAcceso").val()
            }
            var stringData = JSON.stringify(SendObj);
           // alert(stringData)
            $.ajax({
                type: "POST",
                url: "../Servicios/Servicios.asmx/ChangePassword",
                data: "{'pObj':" + stringData + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                beforeSend: function (response) {
                    $('#lblCargando').css({ display: 'block' });
                    $('#lblCargando').html('Procesando...');
                },
                success: function (response) {
                   
                    var models = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;

                    var val = models[0].Estado;

                    var text = models[0].Mensaje;

                    $('#lblCargando').css({ display: 'none' });

                   
                    if (val) {
                        
                        $("#lblresultok").css("display", "block");
                        $("#lblresultokfail").css("display", "none");
                       
                        $("#lblresultok").html("El cambio de contraseña fue exitoso, en instantes sera redirigido al Login");
                        setTimeout(redirigir(), 4000);
                       // window.location.href("../Default.aspx");
                       
                    }
                    else {

                        $("#lblresultok").css("display", "none");
                        $("#lblresultokfail").css("display", "block");
                        $("#lblresultokfail").html(text);
                    }
                },

                error: function (jqXHR, textStatus, errorThrown) {

                },

            });
        });
        function redirigir() {
            
            window.location.href = '../Default.aspx';
        }
    </script>
</asp:Content>

