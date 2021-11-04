<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="RetiroDinero.aspx.vb" Inherits="RetiroDinero" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
   
    <div class="jumbotron" style="position: relative;">
        <ul id="mnuSaldo" style="position: absolute; text-orientation: sideways; list-style-type: none; top: 10px; max-width: 200px;">
            <li>
                <button type="button" id="btnSaldo" class="btn btn-success">Saldo<span id="Saldo" class="badge"></span></button>
            </li>
            <li>
                <button type="button" id="btnTotalVentas" class="btn btn-primary">Total Ventas OK<span id="TotalVentas" class="badge"></span></button>
            </li>
            <li>
                <button type="button" id="btnCantVentas" class="btn btn-primary">Cant Ventas OK<span id="CantVentas" class="badge"></span></button>
            </li>
        </ul>
        <div class="container">
            <div class="form-group">
                <div>
                    <div class="form-group">


                        <div class="input-group">
                            <span class="input-group-addon">Nro Dni</span>
                            <asp:HiddenField ClientIDMode="Static" ID="User" runat="server" />
                            <asp:HiddenField ClientIDMode="Static" ID="Pass" runat="server" />
                            <asp:HiddenField ClientIDMode="Static" ID="IDAgencia" runat="server" />
                            <asp:HiddenField ClientIDMode="Static" ID="IDAcceso" runat="server" />
                            <asp:HiddenField ClientIDMode="Static" ID="codPuesto" runat="server" />

                            <input style="background-color: white; background: white; text-align: left; font-weight: bolder; color: black;"
                                type="text" clientidmode="Static" class="form-control" runat="server"
                                id="txtDNI"
                                maxlength="10" onkeypress="return soloNumeros(event)">
                        </div>
                        <br />
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">Nro Referencia Pago</span>
                                <input type="text" runat="server" maxlength="15" class="form-control"
                                    style="background-color: white; background: white; font-weight: bolder; color: black; text-align: right;"
                                    onkeypress="return soloNumeros(event)"
                                    clientidmode="Static" id="txtNroReferencia" />
                            </div>
                        </div>
                        <br />
                        <div class="form-group">
                            <div class="input-group">
                                <button type="button" runat="server"
                                    id="btnBuscar" clientidmode="Static" class="btn btn-primary">
                                    Buscar</button>
                            </div>
                        </div>
                        <br />
                        <label id="lblresultokfail2" class="alert alert-danger" style="display: none;font-size: small;" clientidmode="Static" runat="server"></label>
                        <label id="lblresultok2" class="alert alert-success" style="display: none;font-size: small;" clientidmode="Static" runat="server"></label>
                         <label id="lblCargando2" class="alert alert-info" style="display: none;font-size: small;" clientidmode="Static" runat="server"></label>
                        <hr />

                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">Datos Cliente</span>
                                <input type="text" runat="server" class="form-control" disabled
                                    style="background-color: white; background: white; max-width: 946px; background: rgba(0, 0, 0,0.1); font-weight: bolder; color: black; text-align: left;"
                                    clientidmode="Static" id="txtDatosCliente" />
                            </div>
                        </div>

                        <div  style="display: none" class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">Cod Barra</span>
                                <input type="text" runat="server" class="form-control" disabled
                                    style="background-color: white; background: white; max-width: 1188px; background: rgba(0, 0, 0,0.1); font-weight: bolder; color: black; text-align: left;"
                                    clientidmode="Static" id="txtCodBarra" />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">Monto</span>
                                <input type="text" runat="server" class="form-control" disabled
                                    style="background-color: white; background: white; max-width: 300px; background: rgba(0, 0, 0,0.1); font-weight: bolder; color: black; text-align: right;"
                                    clientidmode="Static" id="txtMonto" />
                            </div>
                        </div>
                        <hr />

                        <div class="form-group">
                            <div class="input-group">
                                <button type="button" runat="server"
                                    id="btnContinuar" onclick="document.getElementById('Mensajes2').scrollIntoView();" clientidmode="Static" class="btn btn-primary">
                                    Continuar</button>
                            </div>
                        </div>

                        <div id="dvdConfirmacion" style="display: none">

                            <br />
                            <div class="form-group">
                                <div class="input-group">
                                    <label id="lblMensaje" class="alert alert-warning" style="font-size: small;" clientidmode="Static" runat="server">Indique la forma en que quiere recibir el saldo por la entrega de dinero</label>
                                </div>
                            </div>

                            <br />
                            <div    style=" display: inline-flex;">
                                <div class="input-group" >
                                    <span class="input-group-addon">Saldo Virtual</span>
                                    <input type="number" runat="server" class="form-control"
                                        style="background-color: white; background: white; max-width: 200px;  font-weight: bolder; color: black; text-align: right;"
                                        onkeypress="return noenter()"
                                        clientidmode="Static" id="txtSaldoVirtual" />
                                </div>
                                <div class="input-group" style="margin-left:15px" >
                                    <span class="input-group-addon">Saldo SUBE</span>
                                    <input type="number" runat="server" class="form-control"
                                        style="background-color: white; background: white; max-width: 200px;  font-weight: bolder; color: black; text-align: right;"
                                        onkeypress="return noenter()"
                                        clientidmode="Static" id="txtSaldoSube" />
                                </div>
                            </div>

                            <br />
                            <hr />

                            <div class="form-group">
                                <div style="text-align: left; height: 45px">
                                    <button type="button" runat="server"
                                        id="btnGrabar" clientidmode="Static" class="btn btn-primary">
                                        Confirmar</button>
                                    <button type="button" runat="server"
                                        id="btnCancelar" clientidmode="Static" class="btn btn-danger">
                                        Cancelar</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
                <div class="input-group">
                    <label id="lblresultok" class="alert alert-success" style="display: none; font-size: small;" clientidmode="Static" runat="server"></label>
                    <label id="lblCargando" class="alert alert-info" style="display: none; font-size: small;" clientidmode="Static" runat="server"></label>
                    <label id="lblresultokfail" class="alert alert-danger" style="display: none; font-size: small;" clientidmode="Static" runat="server"></label>


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


        $("#btnContinuar").click(function () {
            $("#dvdConfirmacion").css("display", "");
            $("#txtSaldoVirtual").val($("#txtMonto").val());
            $("#txtSaldoSube").val(0);
            $('#lblCargando2').css({ display: 'none' });

        });

        $("#btnCancelar").click(function () {
            $("#dvdConfirmacion").css("display", "none");
            $('#lblCargando2').css({ display: 'none' });
            $('#lblresultokfail').css({ display: 'none' });
            $('#lblresultokfail2').css({ display: 'none' });
            $('#lblresultok').css({ display: 'none' });
            $('#lblresultok2').css({ display: 'none' });
            $("#txtSaldoVirtual").val(0);
            $("#txtSaldoSube").val(0);
            LimpiarCamposRetiroDinero();

        });

        function noenter() {
            return !(window.event && window.event.keyCode == 13);
        }

        $("#btnBuscar").click(function () {

            $("#lblresultokfail").css("display", "none");
            $("#dvdConfirmacion").css("display", "none");
            if ($("#txtDNI").val() == "") {
                $("#lblCargando2").css("display", "none");
                $("#lblCargando2").html("");
                $("#lblresultok2").css("display", "none");
                $("#lblresultok2").html("");
                $("#lblresultokfail2").css("display", "block");
                $("#lblresultokfail2").html("Ingrese Nro DNI");

                return;
            }
            if ($("#txtNroReferencia").val() == "") {
                $("#lblCargando2").css("display", "none");
                $("#lblCargando2").html("");
                $("#lblresultok2").css("display", "none");
                $("#lblresultok2").html("");
                $("#lblresultokfail2").css("display", "block");
                $("#lblresultokfail2").html("Ingrese Nro Referencia de Pago Provisto por Mercado Pago");

                return;
            }

            $('#lblresultok2').css({ display: 'none' });
            $('#lblresultokfail2').css({ display: 'none' });
            $("#lblresultok2").html("");
            $("#lblresultokfail2").html("");
            var SendObj = {

                "Dni": $("#txtDNI").val(),
                "NroReferencia": $("#txtNroReferencia").val(),
                "User": $("#User").val(),
                "Pass": $("#Pass").val(),
                "IDAgencia": $("#IDAgencia").val(),
                "IDAcceso": $("#IDAcceso").val(),
                "CodPuesto": $("#codPuesto").val()


            }
            var stringData = JSON.stringify(SendObj);
            console.log(stringData);
            $.ajax({
                type: "POST",
                url: "../Servicios/Servicios.asmx/GetRetirarDinero",
                data: "{'pObj':" + stringData + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                beforeSend: function (response) {
                    // $('#btnGrabar').attr('disabled', true);
                    $('#lblCargando2').css({ display: 'block' });
                    $('#lblCargando2').html('Obteniendo datos para realizar Retiro de Dinero...');
                },
                success: function (responsepago) {


                    $('#lblCargando2').css({ display: 'none' });
                    $('#lblresultok2').css({ display: 'none' });

                    //console.log("responsepago");
                    //console.log(responsepago);
                    //console.log("responsepago");



                    if (responsepago.d.codResul == "0") {
                        $("#txtDatosCliente").val(responsepago.d.Nombre + " DNI: " + responsepago.d.Dni);
                        $("#txtCodBarra").val(responsepago.d.Barra)
                        $("#txtMonto").val(responsepago.d.Importe * -1)

                        $('#lblresultokfail2').css({ display: 'none' });
                        $('#lblresultok2').css({ display: 'block' });
                        $('#lblresultok2').html("Verifique los datos ingresados, si son correctos confirme la operacion.");
                        $('#btnBuscar').removeAttr('disabled');
                        return;

                    }

                    if (responsepago.d.codResul != "0") {
                        $('#lblresultokfail2').css({ display: 'block' });
                        $('#lblresultokfail2').html(responsepago.d.descResul);
                        $('#btnBuscar').removeAttr('disabled');
                        return;

                    }
                    if (responsepago.d.codResul != "0" && msn == "") {
                        $('#lblresultokfail2').css({ display: 'block' });
                        $('#btnBuscar').removeAttr('disabled');
                        $('#lblresultokfail2').html("Los Items Ingresados no se puedieron cobrar");

                        return;

                    }
                    if (msn != "") {
                        //alert(2222);
                        $('#lblresultokfail2').css({ display: 'block' });
                        $('#lblresultokfail2').html(msn);
                        $('#btnBuscar').removeAttr('disabled');

                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $("#lblresultok2").css("display", "none");
                    $("#lblresultokfail2").css("display", "block");
                    $("#lblresultokfail2").html(textStatus);
                    $('#btnBuscar').removeAttr('disabled');
                },

            });

        });

        $("#btnGrabar").click(function () {

            if (($("#txtSaldoVirtual").val() == "0" && $("#txtSaldoSube").val() == "0") || ($("#txtSaldoVirtual").val() == "" && $("#txtSaldoSube").val() == "")) {
                $("#lblresultokfail").css("display", "block");
                $("#lblresultokfail").html("Ingrese como le debitaremos el dinero que esta entregando, debe elegir Saldo Virtual o SUBE");
                return;
            }

            if ((parseInt($("#txtSaldoVirtual").val()) + parseInt($("#txtSaldoSube").val())) != parseInt($("#txtMonto").val()) ) {
                $("#lblresultokfail").css("display", "block");
                $("#lblresultokfail").html("La Suma de Saldo Virtual y SUBE debe coincidir con el retiro de dinero");
                return;
            }


            if ($("#txtDNI").val() == "") {
                $("#lblCargando").css("display", "none");
                $("#lblCargando").html("");
                $("#lblresultok").css("display", "none");
                $("#lblresultok").html("");
                $("#lblresultokfail").css("display", "block");
                $("#lblresultokfail").html("Ingrese Nro DNI");

                return;
            }
            if ($("#txtNroReferencia").val() == "") {
                $("#lblCargando").css("display", "none");
                $("#lblCargando").html("");
                $("#lblresultok").css("display", "none");
                $("#lblresultok").html("");
                $("#lblresultokfail").css("display", "block");
                $("#lblresultokfail").html("Ingrese Nro Referencia de Pago Provisto por Mercado Pago");

                return;
            }

            $('#lblresultok').css({ display: 'none' });
            $('#lblresultokfail').css({ display: 'none' });
            $("#lblresultok").html("");
            $("#lblresultokfail").html("");
            $('#lblresultok2').css({ display: 'none' });
            $('#lblresultokfail2').css({ display: 'none' });
            $("#lblresultok2").html("");
            $("#lblresultokfail2").html("");
            var SendObj = {

                "Dni": $("#txtDNI").val(),
                "Monto": $("#txtMonto").val(),
                "NroReferencia": $("#txtNroReferencia").val(),
                "User": $("#User").val(),
                "Pass": $("#Pass").val(),
                "IDAgencia": $("#IDAgencia").val(),
                "IDAcceso": $("#IDAcceso").val(),
                "CodPuesto": "026936", //Reservado para puestos de retiro unicamente
                "CodBarra": $("#txtCodBarra").val(),
                "SaldoVirtual": $("#txtSaldoVirtual").val(),
                "SaldoSube": $("#txtSaldoSube").val()


            }
            var stringData = JSON.stringify(SendObj);
            console.log(stringData);
            $.ajax({
                type: "POST",
                url: "../Servicios/Servicios.asmx/RetirarDinero",
                data: "{'pObj':" + stringData + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                beforeSend: function (response) {
                    $('#btnGrabar').attr('disabled', true);
                    $('#lblCargando').css({ display: 'block' });
                    $('#lblCargando').html('Realizando Retiro de Dinero...');
                },
                success: function (responsepago) {

                    var msn = "";
                    $('#lblCargando').css({ display: 'none' });
                    $('#lblresultok').css({ display: 'none' });



                    var mres = 0;

                    var mTextoTicket;//items[""0""].ticket[""0""][""0""]
                    for (var i = 0; i < responsepago.d.items.length; i++) {
                        if (responsepago.d.items[i].codResulItem == "0") {
                            var itemTic = 0;
                            for (var f = 0; f < responsepago.d.items[i].tic.length; f++) {

                                mTextoTicket = mTextoTicket + responsepago.d.items[i].tic[f] + "|";
                                mres = 1;

                            }
                            itemTic = itemTic + 1;
                            var url = "http://ventas.cargaplus.com.ar/mailtemplates/MostrarImpresionRapipago.aspx?Div=" + mTextoTicket;
                            window.open(url, "_blank", "toolbar=no,menubar=no, width=350, height=500, scrollbars=no, resizable=no,location=no, directories=no, status=no");
                            mTextoTicket = "";
                        }
                        else {

                            msn = msn + TranslateErrorPago(responsepago.d.items[i].codResulItem, responsepago.d.items[i].Empresa,
                                responsepago.d.items[i].descResulItem);

                        }
                    }

                    if (mres == 1) {

                        LimpiarCamposRetiroDinero();

                    }
                    //console.log("responsepago");
                    //console.log(responsepago);
                    //console.log("responsepago");
                    if (responsepago.d.codResul != "0") {
                        $('#lblresultokfail').css({ display: 'block' });
                        $('#lblresultokfail').html(responsepago.d.descResul);
                        $('#btnGrabar').removeAttr('disabled');
                        return;

                    }
                    if (responsepago.d.codResul != "0" && msn == "") {
                        $('#lblresultokfail').css({ display: 'block' });
                        $('#btnGrabar').removeAttr('disabled');
                        $('#lblresultokfail').html("Los Items Ingresados no se puedieron cobrar");

                        return;

                    }
                    if (msn != "") {
                        //alert(2222);
                        $('#lblresultokfail').css({ display: 'block' });
                        $('#lblresultokfail').html(msn);
                        $('#btnGrabar').removeAttr('disabled');

                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $("#lblresultok").css("display", "none");
                    $("#lblresultokfail").css("display", "block");
                    $("#lblresultokfail").html(textStatus);
                    $('#btnGrabar').removeAttr('disabled');
                },

            });

        });

        $(document).ready(function () {

            ActaulizarSaldos();


        });

        function TranslateErrorPago(pCodError, pEmpresa, pdescItem) {
            var mError;
            mError = "La factura de " + pEmpresa + " No pudo Cobrarse. Error :" + pdescItem

            return mError

        }

        function LimpiarCamposRetiroDinero() {
            // $("#txtCodBarra").val("");
            $("#txtDNI").val("");
            $("#txtNroReferencia").val("");
            $("#txtMonto").val(0);
            $("#txtDatosCliente").val("");
            $("#txtCodBarra").val("")




        }

    </script>

</asp:Content>

