﻿<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Novedades.aspx.vb" Inherits="SolicitudSaldo" %>

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
    <div class="jumbotron"  style="position: relative;">
        <h2>Novedades</h2>
         <ul id="mnuSaldo" style="position: absolute; text-orientation:sideways;     list-style-type: none; top: 10px; max-width: 200px;">
            <li><button type="button" id="btnSaldo" class="btn btn-success">Saldo <span id="Saldo" class="badge"></span></button>
            </li>
            <li><button type="button" id="btnTotalVentas" class="btn btn-primary">Total Ventas OK<span id="TotalVentas" class="badge"></span></button>
            </li>
            <li> <button type="button"  id="btnCantVentas" class="btn btn-primary">Cant Ventas OK<span id="CantVentas" class="badge"></span></button>
            </li>
        </ul>
        <div class="container">
            <div class="form-group">

                <div class="input-group">
                     <label id="lblresultok" class="alert alert-success" style="display: none" clientidmode="Static" runat="server"></label>
                    <label id="lblCargando" class="alert alert-info" style="display: none" clientidmode="Static" runat="server"></label>
                    <asp:hiddenfield clientidmode="Static" id="User" runat="server" />
                    <asp:hiddenfield clientidmode="Static" id="Pass" runat="server" />
                     <asp:hiddenfield clientidmode="Static" id="MontoVentas" runat="server" />
                    <asp:hiddenfield clientidmode="Static" id="AptoCredito" runat="server" />
                </div>
            </div>

        </div>

       
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

            ActaulizarSaldos();

            var SendObj = {

                "User": $("#User").val(),
                "Pass": $("#Pass").val()
            }
            var stringData = JSON.stringify(SendObj);
            $.ajax({
                type: "POST",
                url: "../Servicios/Servicios.asmx/GetNews",
                data: "{'pObj':" + stringData + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                beforeSend: function (response) {
                    $('#lblCargando').css({ display: 'block' });
                    $('#lblCargando').html('Buscando novedades...');
                },
                success: function (response) {

                    var models = (typeof response.d) == "string" ? eval("(" + response.d + ")") : response.d;

                    var mEstado = models[0].Estado;

                    var text = models[0].Mensaje;

                    $("#lblCargando").css("display", "none");
                    $("#lblresultok").css("display", "block");
                    $("#lblresultok").html(text);

                    ActualizarSaldos();

                },

                error: function (jqXHR, textStatus, errorThrown) {
                    ActualizarSaldos();
                },

            });
        });

    </script>

</asp:Content>

