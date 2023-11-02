<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="RecargaSaldoDTV.aspx.vb" Inherits="Page_RecargaSube" %>

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
       <%-- <a href="http://www.cargaplus.com.ar/motos_plus.html#" target="_blank">
            <div class="BtnAuxiliarMotos">
                <img class="imgcssgrande" src="../Img/boton_moto_01.png" />
            </div>
        </a>--%>
    </div>
    <div id="dvFondo" style="position: relative;" class="jumbotron">
         
        <h2>Recarga DTV Virtual</h2>
        <img src="../Img/Dtv.png" class="imgpag" style="position: absolute; right: 10px; bottom: 10px;" />
        <ul id="mnuSaldo" style="position: absolute; text-orientation:sideways;     list-style-type: none; top: 10px; max-width: 200px;">
            <li><button type="button" id="btnSaldo" class="btn btn-success">Saldo <span id="Saldo" class="badge"></span></button>
            </li>
            <li><button type="button" id="btnTotalVentas" class="btn btn-primary">Total Ventas OK<span id="TotalVentas" class="badge"></span></button>
            </li>
            <li> <button type="button"  id="btnCantVentas" class="btn btn-primary">Cant Ventas OK<span id="CantVentas" class="badge"></span></button>
            </li>
        </ul>

        <div>
            <div class="form-group">


                <div class="input-group">

                    <span class="input-group-addon">05700</span>
                    <input style="background-color: white; background: white; background: rgba(0, 0, 0,0.1); text-align: left; font-weight: bolder; color: black;"
                        type="text" clientidmode="Static" class="form-control inputSpecial" runat="server"
                        id="txtDestinoDTV"
                        maxlength="18" onkeypress="return soloNumeros(event)">

                    <asp:hiddenfield clientidmode="Static" id="User" runat="server" />
                    <asp:hiddenfield clientidmode="Static" id="Pass" runat="server" />
                    <asp:hiddenfield clientidmode="Static" id="IDAgencia" runat="server" />
                    <asp:hiddenfield clientidmode="Static" id="NombreAgencia" runat="server" />
                    <asp:hiddenfield clientidmode="Static" id="DireccionAgencia" runat="server" />
                     <asp:hiddenfield clientidmode="Static" id="MontoVentas" runat="server" />
                    <asp:hiddenfield clientidmode="Static" id="AptoCredito" runat="server" />
                    <asp:hiddenfield clientidmode="Static" id="IPCliente" runat="server" />
                </div>
                <br />
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon">Monto </span>
                        <input type="text" maxlength="5" runat="server" class="form-control"
                            style="background-color: white; background: white; background: rgba(0, 0, 0,0.1); font-weight: bolder; color: black; text-align: right;"
                            onkeypress="return soloNumeros(event)"
                            clientidmode="Static" id="txtMonto" />
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
    </div>
    <div id="Mensajes">
        <label id="lblCargando" class="alert alert-info" style="display: none;" clientidmode="Static" runat="server"></label>
        <label id="lblresultokfail" class="alert alert-danger" style="display: none;" clientidmode="Static" runat="server"></label>
        <label id="lblresultok" class="alert alert-success" style="display: none;" clientidmode="Static" runat="server"></label>
    </div>
    <br />
    <br />
    <div id="Mensajes2"></div>

    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script lang="javascript">

        // Solo permite ingresar numeros.
        function soloNumeros(e) {
            var key = window.Event ? e.which : e.keyCode
            return (key >= 48 && key <= 57)
        }


        function ActaulizarSaldos() {
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


        $(document).ready(function () {


            //$(".IdComp").chosen({
            //    width: "100%",
            //    html_template: '{text} <img style="border:3px solid #ff703d;padding:0px;margin-right:4px"  class="{class_name}" src="{url}" />'
            //});

            ActaulizarSaldos();

            $("#btnGrabar").click(function () {

                if ($("#txtDestinoDTV").val() == "") {
                    $("#lblCargando").css("display", "none");
                    $("#lblCargando").html("");
                    $("#lblresultok").css("display", "none");
                    $("#lblresultok").html("");
                    $("#lblresultokfail").css("display", "block");
                    $("#lblresultokfail").html("Ingrese Nro de Tarjeta sin 05700");

                    return;
                }
                if ($("#txtMonto").val() == 0) {
                    $("#lblCargando").css("display", "none");
                    $("#lblCargando").html("");
                    $("#lblresultok").css("display", "none");
                    $("#lblresultok").html("");
                    $("#lblresultokfail").css("display", "block");
                    $("#lblresultokfail").html("Ingrese Monto Recarga");

                    return;
                }

                $('#lblresultok').css({ display: 'none' });
                $('#lblresultokfail').css({ display: 'none' });
                $("#lblresultok").html("");
                $("#lblresultokfail").html("");

                var SendObj = {
                    "Destino": $("#txtDestinoDTV").val(),
                    "Monto": $("#txtMonto").val(),
                    "IDAgencia": $("#IDAgencia").val(),
                    "User": $("#User").val(),
                    "NombreAgencia": $("#NombreAgencia").val(),
                    "DireccionAgencia": $("#DireccionAgencia").val(),
                    "Pass": $("#Pass").val(),
                    "IPCliente": $("#IPCliente").val()
                }
                var stringData = JSON.stringify(SendObj);
                $.ajax({
                    type: "POST",
                    url: "../Servicios/Servicios.asmx/GrabarVentaDTV",
                    data: "{'pObj':" + stringData + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    beforeSend: function (response) {
                        $('#btnGrabar').attr('disabled', true);
                        $('#lblCargando').css({ display: 'block' });
                        $('#lblCargando').html('Realizando Recarga...');
                    },
                    success: function (response) {

                        var models = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;

                        var val = models[0].Estado;

                        var text = models[0].Mensaje;
                        var UrlSitio = models[0].UrlSitio;

                        var UrlSitioTicket = models[0].UrlSitioTicket;
                        var mTextoTicket = models[0].TemplateTicket;
                        $('#btnGrabar').attr('disabled', false);

                        $('#lblCargando').css({ display: 'none' });

                        if (val == 'Ok') {
                            $("#lblresultok").css("display", "block");
                            $("#lblresultokfail").css("display", "none");

                            $("#lblresultok").html(text);
                            $("#txtMonto").val(0);
                            $("#txtDestinoDTV").val("");

                            //var url = UrlSitio + "/mailtemplates/MostrarImpresionTicket.aspx?Page=http://" + UrlSitioTicket + "/Reportes/Trabajo/" + CodigoTicket + "TicketVenta.html";

                            //window.open(url, '_blank');

                            ActaulizarSaldos();
                            var url = UrlSitio + "/mailtemplates/MostrarImpresionTicket.aspx?Div=" + mTextoTicket + "|DirecTv";

                            window.open(url, "_blank", "toolbar=no,menubar=no, width=350, height=500, scrollbars=no, resizable=no,location=no, directories=no, status=no");
                            window.close();




                        }
                        else {
                            $('#btnGrabar').attr('disabled', false);
                            $("#lblresultok").css("display", "none");
                            $("#lblresultokfail").css("display", "block");
                            $("#lblresultokfail").html(text);

                        }

                    },

                    error: function (jqXHR, textStatus, errorThrown) {

                    },

                });
            });
            $("#cboCompania").change(function () {
                $("#lblresultok").css("display", "none");
                $("#lblresultokfail").css("display", "none");
                $("#lblCargando").css("display", "none");
                $("#txtMonto").val(0);
                $("#txtDestinoDTV").val("");
                // $("#dvfondo").im("");

            });
            //$("#cboClientes").change(function () {
            //    $("#lblresultok").css("display", "none");
            //    $("#lblresultokfail").css("display", "none");
            //    $("#lblCargando").css("display", "none");
            //    var SendObj = {
            //        "IDCliente": $("#cboClientes").val(),
            //        "User": $("#User").val(),
            //        "Pass": $("#Pass").val()
            //    }
            //    var stringData = JSON.stringify(SendObj);

            //    $.ajax({


            //        type: "POST",

            //        url: "../Servicios/Servicios.asmx/GetAgenciasNew",

            //        data: "{'pObj':" + stringData + "}",

            //        contentType: "application/json; charset=utf-8",

            //        dataType: "json",

            //        success: function (response) {

            //            var models = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;

            //            $("#cboIDAgencia").get(0).options.length = 0;


            //            for (var i = 0; i < models.length; i++) {

            //                var val = models[i].IDAgencia;

            //                var text = models[i].NombreAgencia;

            //                $("#cboIDAgencia").get(0).options[$("#cboIDAgencia").get(0).options.length] = new Option(text, val);

            //            }

            //        },

            //        error: function (jqXHR, textStatus, errorThrown) {

            //        },

            //    });

            //});

        });

    </script>
</asp:Content>

