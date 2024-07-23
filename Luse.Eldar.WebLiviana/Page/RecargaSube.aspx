<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="RecargaSube.aspx.vb" Inherits="Page_RecargaSube" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <%--<div class="subpres">
      <a href="http://www.cargaplus.com.ar/accesorios_plus.html#"  target="_blank">
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
        <a href="https://www.cargaplus.com.ar/sube.html" target="_blank">
            <div class="prestamo">
                <img class="imgcssprestamo" src="../Img/btnSubeNew.png" />
            </div>
        </a>
        <a href="http://www.cargaplus.com.ar/celulares_plus.html#" target="_blank">
            <div class="BtnAuxiliarcelular">

                <img class="imgcssgrande" src="../Img/boton_celular_01.png" />
            </div>
        </a>
       <a href="http://www.cargaplus.com.ar/motos_plus.html#" target="_blank">
            <div class="BtnAuxiliarMotos">
                <img class="imgcssgrande" src="../Img/boton_moto_01.png" />
            </div>
        </a>
    </div>--%>
    <div class="jumbotron" style="position: relative;">
        <h2>Carga Electronica SUBE</h2>
        <img src="../Img/SubeAzul.jpg" class="imgpag" style="position: absolute; right: 10px; bottom: 10px;" />
        <ul id="mnuSaldo" style="position: absolute; text-orientation: sideways; list-style-type: none; top: 10px; max-width: 200px;">
            <li>
                <button type="button" id="btnSaldo" class="btn btn-success">Saldo <span id="Saldo" class="badge"></span></button>
            </li>
            <li>
                <button type="button" id="btnTotalVentas" class="btn btn-primary">Total Ventas OK<span id="TotalVentas" class="badge"></span></button>
            </li>
            <li>
                <button type="button" id="btnCantVentas" class="btn btn-primary">Cant Ventas OK<span id="CantVentas" class="badge"></span></button>
            </li>
        </ul>
        <div class="form-group">

            <div class="input-group">

                <span class="input-group-addon">606126</span>
                <input style="background-color: white; background: white; background: rgba(0, 0, 0,0.1); text-align: left; font-weight: bolder; color: black;"
                    type="text" clientidmode="Static" class="form-control" runat="server"
                    id="txtNroTarjeta"
                    maxlength="10" onkeypress="return soloNumeros(event)">

                <asp:HiddenField ClientIDMode="Static" ID="User" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="Pass" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="NombreAgencia" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="DireccionAgencia" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="MontoVentas" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="AptoCredito" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="IPCliente" runat="server" />
            </div>
            <br />
            <div class="form-group">
                <div class="input-group">

                    <span class="input-group-addon">Monto</span>
                    <asp:DropDownList
                        ClientIDMode="Static" ID="cboMonto" runat="server" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                    </asp:DropDownList>

                    <%--                    <input type="text" runat="server" maxlength="5" class="form-control"
                        style="background-color: white; background: white; background: rgba(0, 0, 0,0.1); font-weight: bolder; color: black; text-align: right; max-width: 150px;"
                        onkeypress="return soloNumeros(event)"
                        clientidmode="Static" id="txtMonto" />--%>
                </div>

            </div>

             <div class="form-group">
                <div class="input-group">

                    <label id="msnSube" class="alert alert-warning" clientidmode="Static" runat="server">AVISO IMPORTANTE: A Partir del 01/02/2024, SUBE habilitara para este medio de carga los montos 6500,7000,7500,8000,8500,9000</label>
                </div>

            </div>

            <div class="form-group">
                <div class="input-group">
                    <button type="button" runat="server"
                        id="btnGrabar" onclick="document.getElementById('Mensajes2').scrollIntoView();" clientidmode="Static" class="btn btn-primary">
                        Aceptar</button>
                </div>
            </div>

        </div>

    </div>
    <div id="Mensajes">
        <label id="lblCargando" class="alert alert-info" style="display: none;" clientidmode="Static" runat="server"></label>
        <label id="lblresultokfail" class="alert alert-danger" style="display: none;" clientidmode="Static" runat="server"></label>
        <label id="lblresultok" class="alert alert-success" style="display: none;" clientidmode="Static" runat="server"></label>
    </div>
    <br />
    <br />
    <div id="Mensajes2"></div>
    <script lang="javascript">


        function ActualizarSaldos() {
            var SendObj = {
                "User": $("#User").val(),
                "Pass": $("#Pass").val()
            }

            var stringData = JSON.stringify(SendObj);

            $.ajax({


                type: "POST",

                url: "../Servicios/Servicios.asmx/GetSaldoAgencia",

                data: "{'pObj':" + stringData + "}",

                contentType: "application/json; charset=utf-8",

                dataType: "json",

                success: function (response) {

                    var models = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;

                    var val = models[0].Estado;
                    var text = models[0].Mensaje;
                    var mMonto = models[0].Monto;

                    var mTotalVtas = models[0].TotalVtas;
                    var mCantVtas = models[0].CantVtas;
                    if (parseInt(mMonto) <= 150) {
                        $("#btnSaldo").removeClass('btn btn-success');
                        $("#btnSaldo").addClass('btn btn-danger');

                    } else {
                        $("#btnSaldo").removeClass('btn btn-danger');
                        $("#btnSaldo").addClass('btn btn-success');
                    }
                    $("#Saldo").html("$ " + mMonto);
                    $("#TotalVentas").html("$ " + mTotalVtas);
                    $("#CantVentas").html(mCantVtas);

                },

            })

        }


        function printDiv(nombreDiv) {
            var contenido = document.getElementById(nombreDiv).innerHTML;
            var contenidoOriginal = document.body.innerHTML;

            document.body.innerHTML = contenido;

            window.print();

            document.body.innerHTML = contenidoOriginal;
        }

        // Solo permite ingresar numeros.
        function soloNumeros(e) {
            var key = window.Event ? e.which : e.keyCode
            return (key >= 48 && key <= 57)
        }

        $(window).load(function () {

            var SendObj = {
                "User": $("#User").val(),
                "Pass": $("#Pass").val()
            }
            var stringData = JSON.stringify(SendObj);

            $.ajax({


                type: "POST",

                url: "../Servicios/Servicios.asmx/GetMontos",

                data: "{'pObj':" + stringData + "}",

                contentType: "application/json; charset=utf-8",

                dataType: "json",

                success: function (response) {

                    var models = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;

                    $("#cboMonto").get(0).options.length = 0;


                    for (var i = 0; i < models.length; i++) {

                        var val = models[i].IDMonto;

                        var text = models[i].Descripcion;

                        $("#cboMonto").get(0).options[$("#cboMonto").get(0).options.length] = new Option(text, val);

                    }

                },

                error: function (jqXHR, textStatus, errorThrown) {

                },

            });

        });
        $(document).ready(function () {



            ActualizarSaldos();

            $("#btnGrabar").click(function () {
                var stringDataPayment;
                var mlotessel;

                if ($("#txtNroTarjeta").val() == 0) {
                    $("#lblCargando").css("display", "none");
                    $("#lblCargando").html("");
                    $("#lblresultok").css("display", "none");
                    $("#lblresultok").html("");
                    $("#lblresultokfail").css("display", "block");
                    $("#lblresultokfail").html("Ingrese Nro de Tarjeta");

                    return;
                }
                //if ($("#txtMonto").val() == 0) {
                //    $("#lblCargando").css("display", "none");
                //    $("#lblCargando").html("");
                //    $("#lblresultok").css("display", "none");
                //    $("#lblresultok").html("");
                //    $("#lblresultokfail").css("display", "block");
                //    $("#lblresultokfail").html("Ingrese Monto Recarga");

                //    return;
                //}

                $("#lblresultokfail").css("display", "none");
                $("#lblresultokfail").html("");
                $("#lblresultok").css("display", "none");
                $("#lblresultok").html("");


                var SendObj = {

                    "Monto": $("#cboMonto").val(),
                    "User": $("#User").val(),
                    "Pass": $("#Pass").val(),
                    "NombreAgencia": $("#NombreAgencia").val(),
                    "DireccionAgencia": $("#DireccionAgencia").val(),
                    "NroTarjeta": $("#txtNroTarjeta").val(),
                    "IPCliente": $("#IPCliente").val()
                }


                var stringData = JSON.stringify(SendObj);
                $.ajax({
                    type: "POST",
                    url: "../Servicios/Servicios.asmx/NewSaleSube",
                    data: "{'pObj':" + stringData + "}",
                    contentType: "application/json; charset=utf-8",
                    crossDomain: true,
                    dataType: "json",

                    beforeSend: function (response) {
                        $('#btnGrabar').attr('disabled', true);

                        $('#lblCargando').css({ display: 'block' });
                        $('#lblCargando').html('Realizando Recarga...');

                    },


                    success: function (response) {
                        console.log(response);

                        var models = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;
                        if (!models) {
                            $("#lblresultok").css("display", "none");
                            $('#lblCargando').css({ display: 'none' });
                            $("#lblresultokfail").css("display", "block");
                            $("#lblresultokfail").html("No se Obtuvo Respuesta. Consulte la Recarga");

                            $('#btnGrabar').attr('disabled', false);



                            return;
                        }
                        var mEstado = models[0].Estado;
                        var mIDTransaccion = models[0].IDTransaccion;
                        var mMensaje = models[0].Mensaje;
                        var mNroTarjeta = models[0].NroTarjeta;
                        var mTextoTicket = models[0].TemplateTicket;
                        var UrlSitio = models[0].UrlSitio;
                        var UrlSitioTicket = models[0].UrlSitioTicket;
                        //alert(mTextoTicket);
                        $('#lblCargando').css({ display: 'none' });
                        if (mEstado == 'Ok') {

                            //alert(mEstado);
                            //Limpio Valores
                            $("#txtNroTarjeta").val("");
                            //$("#txtMonto").val(0);
                            //Limpio Valores

                            $("#lblresultok").css("display", "block");
                            $("#lblresultokfail").css("display", "none");
                            $("#lblresultok").html("La Venta se realizo con exito");
                            $('#Imprimir').html(mTextoTicket);
                            //disparar ticket
                            $('#btnGrabar').attr('disabled', false);

                            var url = UrlSitio + "/mailtemplates/MostrarImpresionSube.aspx?Div=" + mTextoTicket;

                            ActualizarSaldos();

                            window.open(url, "_blank", "toolbar=no,menubar=no, width=350, height=500, scrollbars=no, resizable=no,location=no, directories=no, status=no");
                            window.close();

                        }
                        else {

                            $("#lblresultok").css("display", "none");
                            $("#lblresultokfail").css("display", "block");
                            $("#lblresultokfail").html(models[0].Mensaje);
                            $('#btnGrabar').attr('disabled', false);

                        }

                    },

                    error: function (jqXHR, textStatus, errorThrown) {
                        $("#lblCargando").css("display", "none");
                        $("#lblresultokfail").css("display", "block");
                        $("#lblresultokfail").html(textStatus);
                    },

                });
            });

        });






    </script>

</asp:Content>

