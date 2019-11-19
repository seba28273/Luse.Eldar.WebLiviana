﻿<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="RecargaPin.aspx.vb" Inherits="Page_RecargaSube" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
  <div class="subpres">
      <%--  <a href="http://www.cargaplus.com.ar/accesorios_plus.html#"  target="_blank">
            <div class="BtnAuxiliarcelulartecnologia">

                <img class="imgcssgrande" src="../Img/boton_moto_01.png" />
            </div>
        </a>--%>
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
    <div class="jumbotron" style="position: relative;">
        <h2>Recarga Pines</h2>
        <%--<img src="../Img/CPImg.png" class="imgpag" style="position: absolute; right: 25px; bottom: 20px;" />--%>
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

                   <%-- <span class="input-group-addon">Compañia</span>--%>
                    <asp:DropDownList data-placeholder="Seleccione Compañia..."
                        ClientIDMode="Static" ID="cboCompania" runat="server"
                        class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                    </asp:DropDownList>

                    <asp:HiddenField ClientIDMode="Static" ID="User" runat="server" />
                    <asp:HiddenField ClientIDMode="Static" ID="Pass" runat="server" />
                    <asp:HiddenField ClientIDMode="Static" ID="IDAgencia" runat="server" />
                    <asp:HiddenField ClientIDMode="Static" ID="NombreAgencia" runat="server" />
                    <asp:HiddenField ClientIDMode="Static" ID="DireccionAgencia" runat="server" />
                     <asp:hiddenfield clientidmode="Static" id="MontoVentas" runat="server" />
                    <asp:hiddenfield clientidmode="Static" id="AptoCredito" runat="server" />

                </div>
                <br />

                <div class="input-group">

                    <%--<span class="input-group-addon">Producto</span>--%>
                    <asp:DropDownList data-placeholder="Seleccione Producto..."
                        ClientIDMode="Static" ID="cboProducto" runat="server"
                        class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                    </asp:DropDownList>

                    <asp:HiddenField ClientIDMode="Static" ID="HiddenField1" runat="server" />
                    <asp:HiddenField ClientIDMode="Static" ID="HiddenField2" runat="server" />
                    <asp:HiddenField ClientIDMode="Static" ID="HiddenField3" runat="server" />

                </div>
                <br />
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


        function GetPines() {

            var SendObj = {
                "User": $("#User").val(),
                "Pass": $("#Pass").val(),
                "IDProveedor": $("#cboCompania").val()
            }

            var stringData = JSON.stringify(SendObj);

            $.ajax({


                type: "POST",

                url: "../Servicios/Servicios.asmx/GetProductoPin",

                data: "{'pObj':" + stringData + "}",

                contentType: "application/json; charset=utf-8",

                dataType: "json",

                success: function (response) {

                    var models = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;

                    $("#cboProducto").get(0).options.length = 0;


                    for (var i = 0; i < models.length; i++) {

                        var val = models[i].IDProducto;

                        var text = models[i].NombreProducto;

                        $("#cboProducto").get(0).options[$("#cboProducto").get(0).options.length] = new Option(text, val);

                    }

                },

                error: function (jqXHR, textStatus, errorThrown) {

                },

            });

        }


        $(document).ready(function () {


            //$(".IdComp").chosen({
            //    width: "100%",
            //    html_template: '{text} <img style="border:3px solid #ff703d;padding:0px;margin-right:4px"  class="{class_name}" src="{url}" />'
            //});


            $(window).load(function () {

                ActaulizarSaldos();

                var SendObj = {
                    "User": $("#User").val(),
                    "Pass": $("#Pass").val()

                }
                var stringData = JSON.stringify(SendObj);

                $.ajax({


                    type: "POST",

                    url: "../Servicios/Servicios.asmx/GetProveedoresPines",

                    data: "{'pObj':" + stringData + "}",

                    contentType: "application/json; charset=utf-8",

                    dataType: "json",

                    success: function (response) {

                        var models = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;

                        $("#cboCompania").get(0).options.length = 0;


                        for (var i = 0; i < models.length; i++) {

                            var val = models[i].IDProveedor;

                            var text = models[i].NombreProveedor;

                            $("#cboCompania").get(0).options[$("#cboCompania").get(0).options.length] = new Option(text, val);

                        }

                        GetPines();

                    },

                    error: function (jqXHR, textStatus, errorThrown) {

                    },

                });

            });

            $("#btnGrabar").click(function () {

                if ($("#cboProducto").val() == null) {
                    $("#lblCargando").css("display", "none");
                    $("#lblCargando").html("");
                    $("#lblresultok").css("display", "none");
                    $("#lblresultok").html("");
                    $("#lblresultokfail").css("display", "block");
                    $("#lblresultokfail").html("Ingrese Pin a Vender");

                    return;
                }

                $('#lblresultok').css({ display: 'none' });
                $('#lblresultokfail').css({ display: 'none' });
                $("#lblresultok").html("");
                $("#lblresultokfail").html("");

                var SendObj = {
                    "IDProveedor": $("#cboCompania").val(),
                    "IDProducto": $("#cboProducto").val(),
                    "IDAgencia": $("#IDAgencia").val(),
                    "User": $("#User").val(),
                    "NombreAgencia": $("#NombreAgencia").val(),
                    "DireccionAgencia": $("#DireccionAgencia").val(),
                    "Pass": $("#Pass").val()
                }

                var stringData = JSON.stringify(SendObj);
                $.ajax({
                    type: "POST",
                    url: "../Servicios/Servicios.asmx/GrabarVentaPin",
                    data: "{'pObj':" + stringData + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    beforeSend: function (response) {
                        $('#lblCargando').css({ display: 'block' });
                        $('#lblCargando').html('Realizando Recarga...');
                    },
                    success: function (response) {

                        var models = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;

                        var val = models[0].Estado;

                        var text = models[0].Mensaje;
                        var CodigoTicket = models[0].CodigoTicket;

                        var UrlSitio = models[0].UrlSitio;
                        var UrlSitioTicket = models[0].UrlSitioTicket;
                        var mTextoTicket = models[0].TemplateTicket;

                        $('#lblCargando').css({ display: 'none' });
                        var ProveedorSel = $("#cboCompania option:selected").text();
                        var ProductoSel = $("#cboProducto option:selected").text();

                        if (val == 'True') {
                            $("#lblresultok").css("display", "block");
                            $("#lblresultokfail").css("display", "none");

                            $("#lblresultok").html(text);
                            $("#txtDestino").val("");
                            $("#txtMonto").val(0);

                            //var url = UrlSitio + "/mailtemplates/MostrarImpresionPin.aspx?Page=" + UrlSitioTicket + "/Reportes/Trabajo/" + CodigoTicket + "TicketPin.html";

                            //window.open(url, '_blank');

                            ActaulizarSaldos();

                            var url = UrlSitio + "/mailtemplates/MostrarImpresionPin.aspx?Div=" + mTextoTicket + "|" + ProveedorSel + "|" + ProductoSel;

                            window.open(url, "_blank", "toolbar=no,menubar=no, width=350, height=500, scrollbars=no, resizable=no,location=no, directories=no, status=no");
                            window.close();



                        }
                        else {

                            $("#lblresultok").css("display", "none");
                            $("#lblresultokfail").css("display", "block");
                            $("#lblresultokfail").html(text);

                        }

                    },

                    error: function (jqXHR, textStatus, errorThrown) {
                        $('#lblCargando').css({ display: 'none' });
                        $("#lblresultok").css("display", "none");
                        $("#lblresultokfail").css("display", "block");
                        $("#lblresultokfail").html("Error al Realizar la Recarga");
                    },

                });
            });

            $("#cboCompania").change(function () {



                $("#lblresultok").css("display", "none");
                $("#lblresultokfail").css("display", "none");
                $("#lblCargando").css("display", "none");

                var SendObj = {
                    "User": $("#User").val(),
                    "Pass": $("#Pass").val(),
                    "IDProveedor": $("#cboCompania").val()

                }
                var stringData = JSON.stringify(SendObj);

                $.ajax({


                    type: "POST",

                    url: "../Servicios/Servicios.asmx/GetProductoPin",

                    data: "{'pObj':" + stringData + "}",

                    contentType: "application/json; charset=utf-8",

                    dataType: "json",

                    success: function (response) {

                        var models = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;

                        $("#cboProducto").get(0).options.length = 0;


                        for (var i = 0; i < models.length; i++) {

                            var val = models[i].IDProducto;

                            var text = models[i].NombreProducto;

                            $("#cboProducto").get(0).options[$("#cboProducto").get(0).options.length] = new Option(text, val);

                        }

                    },

                    error: function (jqXHR, textStatus, errorThrown) {

                    },

                });

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

