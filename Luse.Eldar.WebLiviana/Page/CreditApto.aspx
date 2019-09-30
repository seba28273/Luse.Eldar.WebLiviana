<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="CreditApto.aspx.vb"
    Inherits="CreditApto" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron" style="position: relative;">

        <div class="container" style="text-align: center;">
            <div class="form-group">
                <label id="lblMsn" class="alert alert-warning" style="font-size: medium"
                    clientidmode="Static" runat="server">
                    <p>Tenes <strong>preaprobado</strong> tu credito dejanos un nro de contacto y te contactaremos a la brevedad. Muchas Gracias</p>
                </label>
                </br>
                <div style="text-align: center; display: -webkit-inline-box;">

                    <input type="text" style="font-size: medium; text-align:center" runat="server" class="form-control"
                        clientidmode="Static" placeholder="Ingrese un Nro de Contacto" id="txtNroContacto" />

                </div>
                <asp:HiddenField ClientIDMode="Static" ID="User" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="Pass" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="MensajeCredito" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="AptoCredito" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="IDPrestamoBase" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="NombreAgencia" runat="server" />
                
                <br />
                <div class="form-group" style="text-align: center;">
                    <div style="text-align: center">
                        <img src="../Img/CREDITOSONLINE.png" id="imgCreditosOnline" clientidmode="Static" 
                            runat="server" style="display: none; margin:auto; width:25%" />
                    </div>
                </div>
                <br />

                <div class="form-group" style="text-align: center;">
                    <div style="text-align: center">
                        <button type="button" runat="server" id="btnIngresar" 
                            clientidmode="Static" class="btn btn-success">Aceptar</button>
                    </div>
                </div>
            </div>
        </div>
        <label id="lblCargando" class="alert alert-info" style="display: none; text-align:center; font-size:medium" clientidmode="Static" runat="server"></label>
        <label id="lblresultokfail" class="alert alert-danger" style="display: none; text-align:center; font-size:medium" clientidmode="Static" runat="server"></label>
        <label id="lblresultok" class="alert alert-success" style="display: none; text-align:center; font-size:medium" clientidmode="Static" runat="server"></label>
    </div>
    <script type="text/javascript">
        // Solo permite ingresar numeros.
        function soloNumeros(e) {
            var key = window.Event ? e.which : e.keyCode
            return (key >= 48 && key <= 57)
        }

    </script>
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>


    <script lang="javascript">

        // var Base64 = { _keyStr: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=", encode: function (e) { var t = ""; var n, r, i, s, o, u, a; var f = 0; e = Base64._utf8_encode(e); while (f < e.length) { n = e.charCodeAt(f++); r = e.charCodeAt(f++); i = e.charCodeAt(f++); s = n >> 2; o = (n & 3) << 4 | r >> 4; u = (r & 15) << 2 | i >> 6; a = i & 63; if (isNaN(r)) { u = a = 64 } else if (isNaN(i)) { a = 64 } t = t + this._keyStr.charAt(s) + this._keyStr.charAt(o) + this._keyStr.charAt(u) + this._keyStr.charAt(a) } return t }, decode: function (e) { var t = ""; var n, r, i; var s, o, u, a; var f = 0; e = e.replace(/[^A-Za-z0-9\+\/\=]/g, ""); while (f < e.length) { s = this._keyStr.indexOf(e.charAt(f++)); o = this._keyStr.indexOf(e.charAt(f++)); u = this._keyStr.indexOf(e.charAt(f++)); a = this._keyStr.indexOf(e.charAt(f++)); n = s << 2 | o >> 4; r = (o & 15) << 4 | u >> 2; i = (u & 3) << 6 | a; t = t + String.fromCharCode(n); if (u != 64) { t = t + String.fromCharCode(r) } if (a != 64) { t = t + String.fromCharCode(i) } } t = Base64._utf8_decode(t); return t }, _utf8_encode: function (e) { e = e.replace(/\r\n/g, "\n"); var t = ""; for (var n = 0; n < e.length; n++) { var r = e.charCodeAt(n); if (r < 128) { t += String.fromCharCode(r) } else if (r > 127 && r < 2048) { t += String.fromCharCode(r >> 6 | 192); t += String.fromCharCode(r & 63 | 128) } else { t += String.fromCharCode(r >> 12 | 224); t += String.fromCharCode(r >> 6 & 63 | 128); t += String.fromCharCode(r & 63 | 128) } } return t }, _utf8_decode: function (e) { var t = ""; var n = 0; var r = c1 = c2 = 0; while (n < e.length) { r = e.charCodeAt(n); if (r < 128) { t += String.fromCharCode(r); n++ } else if (r > 191 && r < 224) { c2 = e.charCodeAt(n + 1); t += String.fromCharCode((r & 31) << 6 | c2 & 63); n += 2 } else { c2 = e.charCodeAt(n + 1); c3 = e.charCodeAt(n + 2); t += String.fromCharCode((r & 15) << 12 | (c2 & 63) << 6 | c3 & 63); n += 3 } } return t } };
        //function eliminaFilas() {
        //    //OBTIENE EL NÚMERO DE FILAS DE LA TABLA
        //    var n = 0;
        //    $("#tabla tbody tr").each(function () {
        //        n++;
        //    });
        //    //BORRA LAS n-1 FILAS VISIBLES DE LA TABLA
        //    //LAS BORRA DE LA ULTIMA FILA HASTA LA SEGUNDA
        //    //DEJANDO LA PRIMERA FILA VISIBLE, MÁS LA FILA PLANTILLA OCULTA
        //    for (i = n - 1; i > 1; i--) {
        //        $("#tabla tbody tr:eq('" + i + "')").remove();
        //    };
        //};



        $("#btnIngresar").click(function () {

            if ($("#txtNroContacto").val()== "") {
                $("#lblresultokfail").css("display", "block");
                $("#lblresultokfail").html("Debe ingresar su nro de contacto");
                return;
            }
            $("#lblresultokfail").css("display", "none");
            $("#lblresultok").css("display", "none");
            $("#lblresultokfail").html("");
            $("#lblresultok").html("");
            $('#btnIngresar').attr('disabled', true);

            var SendObj = {

                "IDPrestamoBase": $("#IDPrestamoBase").val(),
                "Mensaje": $("#MensajeCredito").val(),
                "Destino": $("#txtNroContacto").val(),
                "NombreAgencia": $("#NombreAgencia").val(),
                "User": $("#User").val(),
                "Pass": $("#Pass").val()

            }

            var stringData = JSON.stringify(SendObj);

            $.ajax({
                type: "POST",
                url: "../Servicios/Servicios.asmx/SaveSolicitudPrestamo",
                data: "{'pObj':" + stringData + "}",
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                dataType: "json",

                beforeSend: function (response) {
                    $('#lblCargando').css({ display: 'block' });
                    $('#lblCargando').html('Procesando...');

                },
                success: function (response) {
                    
                    $('#btnIngresar').css({ display: 'none' });
                    $('#txtNroContacto').css({ display: 'none' });
                    $('#lblMsn').css({ display: 'none' });
                    $('#imgCreditosOnline').css({ display: 'block' });
                    
                    $('#lblCargando').css({ display: 'none' });

                    $("#lblresultok").css("display", "block");
                    $("#lblresultok").html("Muchas Gracias, nos estaremos comunicando a la brevedad");
                    $("#lblresultokfail").css("display", "none");
                    $('#lblCargando').css({ display: 'none' });

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $("#lblCargando").css("display", "none");
                    $("#lblresultokfail").css("display", "block");
                    $("#lblresultokfail").html(textStatus);
                },

            });
        });


    </script>

</asp:Content>


