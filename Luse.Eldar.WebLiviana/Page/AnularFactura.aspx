<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master"
    AutoEventWireup="false" CodeFile="AnularFactura.aspx.vb" Inherits="Page_AnularFactura" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="jumbotron">
        <h2>Indicar Facturas a Anular</h2>
        <div id="Contenedor" clientidmode="Static" class="container">


            <%-- aca voy a cargar una variable de session codPuesto--%>
            <asp:HiddenField ClientIDMode="Static" ID="Usuario" runat="server" />
            <asp:HiddenField ClientIDMode="Static" ID="Pass" runat="server" />
            <asp:HiddenField ClientIDMode="Static" ID="codPuesto" runat="server" />
            <asp:HiddenField ClientIDMode="Static" ID="codAgente" runat="server" />
            <asp:HiddenField ClientIDMode="Static" ID="idMod" runat="server" />
            <asp:HiddenField ClientIDMode="Static" ID="txtCodEmpresa" runat="server" />
            <asp:HiddenField ClientIDMode="Static" ID="FechaOperacion" runat="server" />
            <asp:HiddenField ClientIDMode="Static" ID="FechaOperacionFormateada" runat="server" />
            <asp:HiddenField ClientIDMode="Static" ID="TipoCobranza" runat="server" />
            <asp:HiddenField ClientIDMode="Static" ID="ItemAdicional0" runat="server" />
            <asp:HiddenField ClientIDMode="Static" ID="ItemAdicional2" runat="server" />
            <asp:HiddenField ClientIDMode="Static" ID="ItemAdicional1" runat="server" />
            <div class="form-group">

                <div class="input-group">
                    <span class="input-group-addon">Nro Operacion: </span>
                    <input type="text" class="form-control" runat="server" style="text-align: right; width: 203px"
                        id="txtNroOperacion" clientidmode="Static" onkeypress="return soloNumeros(event)">
                </div>
                 <input type="image" class="rapipagoimg"
                    src="../img/rapipago.png" />
            </div>

            <div class="form-group">

                <div class="input-group">
                    <span class="input-group-addon">Cod. Seguridad:</span>
                    <input type="text" class="form-control" runat="server" style="text-align: right; width: 194px"
                        id="txtCodSeguridad" clientidmode="Static">
                </div>

            </div>
            <div class="form-group">

                <div class="input-group">
                    <span class="input-group-addon">Cod. Seguridad Duplicado:</span>
                    <input type="text" class="form-control" runat="server" style="text-align: right; width: 194px"
                        id="txtCodSeguridadDuplicado" placeholder="solo aplicar para anular en ticket emitido en duplicado" clientidmode="Static">
                </div>

            </div>

            <div id="mySpinner" clientidmode="Static" style="text-align: center; height: 45px">

                <button type="button" runat="server" id="btnAgregar" clientidmode="Static" class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>&nbsp;Agregar</button>
            </div>
            <div class="container" style="font-size: small; font-family: monospace;">
                <table id="tablaAnularFactura" clientidmode="Static" class="table">
                    <thead>
                        <tr id="fila0" class="info">
                            <th>#</th>
                            <th>Nro Operacion</th>
                            <th>Codigo de Seguridad</th>
                            <th>Codigo de Seguridad(Duplicado)</th>
                        </tr>
                    </thead>

                </table>
            </div>

        </div>

    </div>
    <div style="text-align: center; height: 45px;">

        <button type="button" runat="server" id="btnAceptar" clientidmode="Static" class="btn btn-primary"><span clientidmode="Static"  id="spnConfirmar" class="glyphicon glyphicon-ok"></span>&nbsp;Confirmar Operaciones</button>
        <button type="button" runat="server" id="btnEliminar" clientidmode="Static" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span>&nbsp;Eliminar Seleccionada</button>
    </div>
    <label id="lblCargando" class="alert alert-info" style="display: none" clientidmode="Static" runat="server"></label>
    <label id="lblresultokfail" class="alert alert-danger" style="display: none" clientidmode="Static" runat="server"></label>
    <label id="lblresultok" class="alert alert-success" style="display: none" clientidmode="Static" runat="server"></label>
    <script type="text/javascript">
        // Solo permite ingresar numeros.
        function soloNumeros(e) {
            var key = window.Event ? e.which : e.keyCode
            if (key >= 48 && key <= 57)
                return true;
        }


        function soloNumerosSinEnter(e) {
            var key = window.Event ? e.which : e.keyCode
            return (key >= 48 && key <= 57);

        }

        function CloseModal() {
            document.getElementById('MyModal').style.display = 'none';
        }
    </script>
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script lang="javascript">

        function TranslateError(pCodError, pEmpresa, pImpItem) {
            var mError;
            switch (pCodError) {
                case 50: mError = " El importe total de la factura no coincide a la suma de sus ítems.</br>"
                    break;
                case 22: mError = "Las siguientes formas de pago: [PESOS] estan fuera del rango permitido para cobrar.</br>"
                    break;
                case 35: mError = "La Sucursal excede el monto permitido para cobrar.</br>"
                    break;
                case 139: mError = "Comprobante fuera de término.</br>"
                    break;
                case 40: mError = "Cod. de Barra incorrecto.</br>"
                    break;
                case 42: mError = "El importe del ítem no es válido, se deberá ingresar el importe de la factura.</br>"
                    break;
                case 157: mError = "Errores encontrados al intentar cobrar la factura" + pEmpresa + " Por un monto de $" + pImpItem + " .</br>"
                    break;    
                case 44: mError = "La factura de " + pEmpresa + " Por un monto de $" + pImpItem + " ya se encuentra paga.</br>"
                    break;
                case 204: mError = "Items con error.</br>"
                    break;
                case 130: mError = "Errores encontrados en la carga de los datos del cliente.</br>"
                    break;
                case 208: mError = "Los datos del formulario no deberian estar presentes para el tipo de cobranza..</br>"
                    break;
                case 199: mError = "No existen facturas pendientes para imputar</br>"
                    break;
                case 198: mError = "Nro de CLiente erroneo o inexistente</br>"
                    break;
                case 136: mError = "Complete todos los campos solicitados</br>"
                    break;
                case 137: mError = "Uno de los campos solicitados tiene un valor erroneo</br>"
                    break;
                case 120: mError = "Tiene Operaciones sin confirmar. Consulte con su vendedor</br>"
                    break;
                case 63: mError = "Cod de barra erroneo</br>"
                    break;
                case 215: mError = "El monto de la factura supera los limites habilitados para el puesto</br>"
                    break;
                case 203: mError = "Por favor volver a consultar los datos</br>"
                    break;

                default: mError = "Error " + pCodError + "</br>"

            }

            return mError
        }

        function eliminaTotalFilas() {

            var n = 1;
            $("#tablaMuestraLotes tbody tr").each(function () {
                $("#fila" + n).remove();
                n++;
            });

            CalcularTotal();

        };

        function eliminaFilas() {

            var n = 1;
            $("input[type=checkbox]:checked").each(function () {
                //cada elemento seleccionado
                //alert(1);
                $("#fila" + n).remove();
                n++;
            });



            var a = 1;
            $("#tablaAnularFactura tbody tr").each(function () {
                $("#fila" + a).removeAttr("id");

                a++;
            });

            var b = 1;
            $("#tablaAnularFactura tbody tr").each(function () {
                $(this).attr("id", "fila" + b);

                b++;
            });

        };

        function eliminarCamposAdicionales() {

            $(".form-groupAdd").remove();
            $(".inputbr").remove();

        }

        function validarEntradaMonto() {
            if ($("#txtMonto").val() == 0) {
                $('#lblresultokfail').css({ display: 'block' });
                $('#lblresultokfail').html("Ingrese monto");
            }
            else {
                $('#lblresultokfail').css({ display: 'none' });
                $('#lblresultokfail').html("");
            }

        }

        function LimpiarCampos() {

            $("#txtNroOperacion").val("");
            $("#txtCodSeguridad").val("");
        }
        function LimpiarCamposPosSave() {

            $("#txtNroOperacion").val("");
            $("#txtCodSeguridad").val("");

            $("#fila1").remove();
            $("#fila2").remove();
            $("#fila3").remove();
            $("#fila4").remove();
            $("#fila5").remove();
            $("#fila6").remove();
            $("#fila7").remove();
            $("#fila8").remove();
            $("#fila9").remove();


        }
        function round(num, decimales = 2) {
            var signo = (num >= 0 ? 1 : -1);
            num = num * signo;
            if (decimales === 0) //con 0 decimales
                return signo * Math.round(num);
            // round(x * 10 ^ decimales)
            num = num.toString().split('e');
            num = Math.round(+(num[0] + 'e' + (num[1] ? (+num[1] + decimales) : decimales)));
            // x * 10 ^ (-decimales)
            num = num.toString().split('e');
            return signo * (num[0] + 'e' + (num[1] ? (+num[1] - decimales) : -decimales));
        }


        var SendObjLotedatosFormulario = {};



        function AgregarFact() {
            $('#lblresultokfail').css({ display: 'none' });
            $('#lblCargando').css({ display: 'none' });
            $('#lblresultok').css({ display: 'none' });

            if ($("#txtNroOperacion").val() == "") {
                $('#lblresultokfail').css({ display: 'block' });
                $('#lblresultokfail').html("Debe ingresar Nro Operacion");
                return;
            }

            if ($("#txtCodSeguridad").val() == "") {
                $('#lblresultokfail').css({ display: 'block' });
                $('#lblresultokfail').html("Debe ingresar Cod Seguridad");
                return;
            }

            var mNombre;
            var mClase = "";

            var n = 1;
            $("#tablaAnularFactura tbody tr").each(function () {

                n++;
            });

            if (n >1) {
                $('#lblresultokfail').css({ display: 'block' });
                $('#lblresultokfail').html("Solo puede anular de a una operacion.");
                return;
            }
            mNombre = "fila" + (n + 1);
            if (mClase == "") {
                mClase = "success";
            }
            else {
                mClase = "";
            }



            $("#tablaAnularFactura").append("<tr id=" + mNombre + " class='" + mClase + "'><td> <input type='checkbox' /></td>" +
                "<td> " + $("#txtNroOperacion").val() + "</td >" +
                "<td> " + $("#txtCodSeguridad").val() + "</td >" +
                "<td> " + $("#txtCodSeguridadDuplicado").val() + "</td >" +
                "</tr > ");


            SendObjLotedatosFormulario = {};


            LimpiarCampos();


        }


        function AnularFactura() {
            var mCodSeguridad;
            var mNroOperacion;
            var mCodSeguridadDuplicado;
            var stringDataPayment;
            var SendObj = '"codPuesto"' + ":" + '"' + $("#codPuesto").val() + '"';


            var nroFila = 0;
            var mEntro = 0;
            $('#tablaAnularFactura tbody tr').each(function () {
                nroFila = nroFila + 1;
                mNroOperacion = $.trim($(this).find('td').eq(1).text());
                if (mNroOperacion != 'Nro operacion') {

                    mEntro = 1;
                    mCodSeguridad = $.trim($(this).find('td').eq(2).text());
                    mCodSeguridadDuplicado = $.trim($(this).find('td').eq(3).text());
                    var SendObjLote = {
                        "nroOperacion": mNroOperacion,
                        "codSeguridad": mCodSeguridad,

                    }

                    if (typeof (stringDataPayment) == "undefined") {
                        stringDataPayment = JSON.stringify(SendObjLote);
                    } else {
                        stringDataPayment = stringDataPayment + "," + JSON.stringify(SendObjLote);
                    }
                    if (mCodSeguridadDuplicado != "") {

                        var SendObjLote = {
                            "nroOperacion": mNroOperacion,
                            "codSeguridad": mCodSeguridadDuplicado,

                        }

                        if (typeof (stringDataPayment) == "undefined") {
                            stringDataPayment = JSON.stringify(SendObjLote);
                        } else {
                            stringDataPayment = stringDataPayment + "," + JSON.stringify(SendObjLote);
                        }

                    }
                }
            })
            stringDataPayment = '{"facturas":[' + stringDataPayment + '],' + SendObj + '}';
            console.log("stringDataPayment");
            console.log(stringDataPayment);
            console.log("stringDataPayment");
            if (mEntro == 0) {
                $('#lblresultokfail').css({ display: 'block' });
                $('#lblresultokfail').html('Debe Ingresar Facturas para anular');
                $('#spnConfirmar').removeClass('fa fa-circle-o-notch fa-spin');
                $('#spnConfirmar').addClass('glyphicon glyphicon-ok');
                $('#btnAceptar').removeAttr('disabled');
                return;
            }
            $.ajax({
                type: "POST",
                url: "../Servicios/Servicios.asmx/AnularFacturas",
                data: "{datosFormulario:" + JSON.stringify(stringDataPayment) + "}",
                contentType: "application/json; charset=utf-8",
                beforeSend: function (response) {
                    $('#lblCargando').css({ display: 'block' });
                    $('#lblCargando').html('Procesando Anulacion...');
                },
                success: function (responseAnulacionpago) {
                   
                    var msn = "";
                    $('#lblCargando').css({ display: 'none' });
                    $('#lblresultok').css({ display: 'none' });
                    $('#spnConfirmar').removeClass('fa fa-circle-o-notch fa-spin');
                    $('#spnConfirmar').addClass('glyphicon glyphicon-ok');

                    LimpiarCamposPosSave();

                    var mres = 0;

                    var mTextoTicket;//items[""0""].ticket[""0""][""0""]
                    for (var i = 0; i < responseAnulacionpago.d.itemsPago.length; i++) {
                        if (responseAnulacionpago.d.itemsPago[i].codResulItem == "0") {
                            var itemTic = 0;
                            for (var f = 0; f < responseAnulacionpago.d.itemsPago[i].tic.length; f++) {

                                mTextoTicket = mTextoTicket + responseAnulacionpago.d.itemsPago[i].tic[f] + "|";
                                mres = 1;

                            }
                            itemTic = itemTic + 1;
                        }
                        else {

                            msn = msn + TranslateError(responseAnulacionpago.d.itemsPago[i].codResulItem, responseAnulacionpago.d.itemsPago[i].NombreEmpresa,
                                responseAnulacionpago.d.itemsPago[i].Importe);

                        }
                    }

                    if (mres == 1) {

                        var url = "../mailtemplates/MostrarImpresion.aspx?Div=" + mTextoTicket;

                        window.open(url, "_blank", "toolbar=no,menubar=no, width=350, height=500, scrollbars=no, resizable=no,location=no, directories=no, status=no");
                        LimpiarCamposPosSave();

                    }
                    if (responseAnulacionpago.d.codResul != "0" && msn == "") {
                        $('#lblresultokfail').css({ display: 'block' });
                        $('#lblresultokfail').html(responseAnulacionpago.d.descResul);
                        $('#spnConfirmar').removeClass('fa fa-circle-o-notch fa-spin');
                        $('#spnConfirmar').addClass('glyphicon glyphicon-ok');
                        $('#btnAceptar').removeAttr('disabled');
                        return;

                    }
                    if (msn != "") {
                        $('#lblresultokfail').css({ display: 'block' });
                        $('#lblresultokfail').html(msn);

                    }

                },
                error: function (responseerr) {
                    $('#spnConfirmar').removeClass('fa fa-circle-o-notch fa-spin');
                    $('#spnConfirmar').addClass('glyphicon glyphicon-ok');
                    $('#btnAceptar').removeAttr('disabled');
                    $('#lblCargando').css({ display: 'none' });

                    $('#lblresultokfail').css({ display: 'block' });
                    $('#lblresultokfail').html('Las operaciones no se pudieron anular..(' + responseerr.responseJSON.Message + ')');
                },
            });
        }

        function sleep(milliseconds) {
            var start = new Date().getTime();
            for (var i = 0; i < 1e7; i++) {
                if ((new Date().getTime() - start) > milliseconds) {
                    break;
                }
            }
        }


        $(document).ready(function () {

            $("#btnAgregar").click(function () {
                //$('#lblresultokfail').css({ display: 'none' });

                AgregarFact();
                eliminarCamposAdicionales();

            });
            $("#btnEliminar").click(function () {
                eliminaFilas();

            });
            $("#btnAceptar").click(function () {
                $('#spnConfirmar').removeClass('glyphicon glyphicon-ok');
                $('#spnConfirmar').addClass('fa fa-circle-o-notch fa-spin');
                $('#btnAceptar').attr('disabled', 'disabled');
                //sleep(10000);
                AnularFactura();
                LimpiarCamposPosSave();
               
            });
        });



    </script>

</asp:Content>


