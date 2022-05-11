<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master"
    AutoEventWireup="false" CodeFile="ConsultaFactura.aspx.vb" EnableEventValidation="false" Inherits="Page_ConsultaFactura" %>

<script runat="server">

    Protected Sub cboModalidad_SelectedIndexChanged(sender As Object, e As EventArgs)

    End Sub
</script>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="jumbotronrapipago">
        <h2>Indicar Facturas a Cobrar</h2>
        <div id="Contenedorrapipago" clientidmode="Static" class="container">



            <%-- aca voy a cargar una variable de session codPuesto--%>
            <asp:HiddenField ClientIDMode="Static" ID="Usuario" runat="server" />
            <asp:HiddenField ClientIDMode="Static" ID="IDAgencia" runat="server" />
            <asp:HiddenField ClientIDMode="Static" ID="IDAcceso" runat="server" />
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
                    <span class="input-group-addon">Cod Barra:</span>
                    <input type="text" class="form-control" runat="server" style="text-align: right; text-transform: uppercase; font-size: x-large; max-width: 100%"
                        id="txtCodBarra" onclick="this.setSelectionRange(0, this.value.length)" placeholder="ingrese cod de barra" clientidmode="Static" onkeypress="return IngresoCodbarra(event)">
                </div>
                <input type="image" class="rapipagoimg"
                    src="../img/rapipago.png" />

            </div>
            <div id="dvdGetEmpresa">
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon">Empresas:</span>
                        <%-- <input type="text" class="form-control" runat="server" style="text-align: right; width: 10%"
                        id="txtCodEmpresa"  clientidmode="Static" onkeypress="return soloNumerosSinEnter(event)">--%>
                        <input type="text" placeholder="ingrese empresa y presione enter" class="form-control" runat="server" style="text-align: right; font-size: medium; width: 57%; max-width: 400px"
                            id="txtDescEmpresa" onkeypress="return GetEmpresas(event)" clientidmode="Static">
                    </div>


                    <br />
                    <button type="button" runat="server" id="btnBuscarEmpresa" clientidmode="Static" style="font-size: x-large;" class="btn btn-success"><span class="glyphicon glyphicon-search"></span>&nbsp;Buscar Empresa</button>
                    <div>
                        <label id="lblfailEmpresa" class="alert alert-danger" style="display: none" clientidmode="Static" runat="server"></label>
                        <label id="lblfailEmpresa2" class="alert alert-danger" style="display: none" clientidmode="Static" runat="server"></label>
                    </div>


                </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                    <span class="input-group-addon">Empresa:</span>
                    <asp:DropDownList data-placeholder="Seleccione Empresa..."
                        ClientIDMode="Static" ID="cboEmpresa" Style="max-width: 100%;" runat="server" class="form-control">
                    </asp:DropDownList>

                </div>
                <div>
                    <label id="lblMensajeEmpresa" class="alert alert-info" style="display: none; font-size: small" clientidmode="Static" runat="server"></label>

                </div>
            </div>

            <div style="display: none" class="form-group">
                <div class="input-group">
                    <span class="input-group-addon">Forma Pago:</span>
                    <asp:DropDownList data-placeholder="Forma Pago.."
                        ClientIDMode="Static" ID="cbofPago" Style="max-width: 500px;" runat="server" class="form-control">
                    </asp:DropDownList>
                </div>
            </div>
            <div id="ContenedorModalidad" clientidmode="Static" class="form-group">
                <div class="input-group">
                    <span class="input-group-addon">Modalidad:</span>
                    <asp:DropDownList data-placeholder="Modalidad.."
                        ClientIDMode="Static" ID="cboModalidad" Style="max-width: 90%;" runat="server" class="form-control">
                    </asp:DropDownList>

                </div>
                <img id="imgCom" style="display: none; width: 50px; height: 50px; float: right; margin-top: -50px; margin-right: 35px;"
                    clientidmode="Static" src="../Img/compag.png"></img>
                <img id="imgNoCom" style="display: none; width: 50px; height: 50px; float: right; margin-top: -50px; margin-right: 35px;" clientidmode="Static" src="../Img/comnopag.png"></img>
            </div>

            <div id="lblMonto" class="form-group">
                <div class="input-group">
                    <span class="input-group-addon">Importe $:</span>
                    <input type="number" class="form-control" runat="server" style="text-align: justify; width: 100%"
                        id="txtMonto" onclick="this.setSelectionRange(0, this.value.length)" onkeypress="return noenter()" clientidmode="Static">
                    <select clientidmode="Static" id="cboMonto" style="display: none" runat="server" class="form-control">
                    </select>

                </div>

            </div>
            <div class="container">
                <%--<h2>Lotes Pendientes</h2>--%>
                <table id="tablafacturasCSF" style="display: none;" clientidmode="Static" class="table">
                </table>
            </div>


            <div style="text-align: center; height: 45px">
                <button type="button" runat="server" id="btnAgregar" clientidmode="Static" style="font-size: x-large;" class="btn btn-info"><span class="glyphicon glyphicon-plus"></span>&nbsp;Buscar Facturas</button>
                <button type="button" runat="server" id="btnLimpiar" onclick="Limpiar();" clientidmode="Static" style="font-size: x-large;" class="btn btn-warning"><span class="glyphicon glyphicon-clean"></span>&nbsp;Limpiar</button>
            </div>
            <br />
            <br />
            <label id="lblfailAgregar" class="alert alert-danger" style="display: none" clientidmode="Static" runat="server"></label>
            <br />
            <br />
            <%--GRILLA--%>

            <div class="container" style="font-size: small; font-family: monospace;">
                <%--<h2>Lotes Pendientes</h2>--%>
                <table id="tablaFactura" clientidmode="Static" class="table">
                    <thead>
                        <tr id="fila0" class="info">
                            <th style='display: none'>#</th>
                            <th style="display: none">Cod. Empresa</th>
                            <th>Empresa</th>
                            <th>Codigo de Barras</th>
                            <th>Modalidad</th>
                            <th>Importe</th>
                            <th>T. Cob</th>
                            <th style="display: none">IDMod</th>
                            <th style="display: none">datosFormulario</th>
                            <th>#</th>
                        </tr>
                    </thead>

                </table>
            </div>
            <div class="form-group">
                <div class="input-group">
                    <span class="input-group-addon">Total a Recaudar.:</span>
                    <input type="text" runat="server" disabled="disabled" clientidmode="Static" class="form-control" id="txtTotal" />
                    <span class="input-group-addon">Dinero Recibido:</span>
                    <input type="text" runat="server" clientidmode="Static" class="form-control" id="txtDineroRecibido" />
                    <span class="input-group-addon">Vuelto:</span>
                    <input type="text" runat="server" disabled="disabled" clientidmode="Static" class="form-control" id="txtVuelto" />
                </div>
            </div>
        </div>

    </div>
    <div style="text-align: center; height: 65px;">
        <button type="button" runat="server" id="btnCalcularVuelto" style="font-size: x-large;" clientidmode="Static" class="btn btn-warning"><i clientidmode="Static" id="spnCalcular" class="fas fa-calculator"></i>&nbsp;Calcular Vuelto</button>
    </div>
    <div style="text-align: center; height: 45px;">
        <button type="button" runat="server" id="btnAceptar" style="font-size: x-large;" clientidmode="Static" class="btn btn-primary"><i clientidmode="Static" id="spnConfirmar" class="glyphicon glyphicon-ok"></i>&nbsp;Confirmar Operaciones</button>
        <button type="button" runat="server" id="btnEliminar" style="font-size: x-large;" visible="false" clientidmode="Static" class="btn btn-danger"><i class="glyphicon glyphicon-remove"></i>&nbsp;Eliminar Seleccionada</button>

        <%--       <button type="button" runat="server" id="btnConfirmar" style="font-size: x-large;" clientidmode="Static" visible="true" class="btn btn-success">&nbsp;Confirmar</button>
        <button type="button" runat="server" id="btnConsultarUltTransaccion" style="font-size: x-large;" visible="true" clientidmode="Static" class="btn btn-Info">&nbsp;Buscar</button>--%>
    </div>
    <br />
    <br />
    <label id="lblCargando" class="alert alert-info" style="display: none" clientidmode="Static" runat="server"></label>
    <label id="lblresultokfail" class="alert alert-danger" style="display: none" clientidmode="Static" runat="server"></label>
    <label id="lblresultok" class="alert alert-success" style="display: none" clientidmode="Static" runat="server"></label>

    <script lang="javascript">

        $(function () {
            $(document).on('click', '.borrar', function (event) {
                event.preventDefault();
                $(this).closest('tr').remove();
                CalcularTotal();
            });
        });

        function validar(e) {
            var tecla = (document.all) ? e.keyCode : e.which;
            //var key = window.Event ? e.which : e.keyCode
            if (tecla >= 48 && tecla <= 57)
                return true;
            if (tecla == 13) {
                AgregarFact();
                eliminarCamposAdicionales();
                return false;
            }
        }

        function IngresoCodbarra(e) {
            var key = window.Event ? e.which : e.keyCode
            if (key != 13)
                return true;
            else {


                if (key == 13) {
                    e.preventDefault();
                    $('#btnAgregar').removeAttr('disabled');
                    $('#txtMonto').css({ display: 'block' });
                    $('#lblMonto').css({ display: 'block' });

                    $("#btnAgregar").html('Agregar');

                    BuscarFactura();
                    $('#dvdGetEmpresa').css({ display: 'block' });
                    return false;
                }
                else
                    return false;
            }
        }
        function soloNumerosSinEnter(e) {
            var key = window.Event ? e.which : e.keyCode
            return (key >= 48 && key <= 57);

        }

        function soloNumeros(e) {
            var key = window.Event ? e.which : e.keyCode
            if (key >= 48 && key <= 57)
                return true;
            else {
                if (key == 13) {
                    e.preventDefault();
                    $('#btnAgregar').removeAttr('disabled');
                    $('#txtMonto').css({ display: 'block' });
                    $('#lblMonto').css({ display: 'block' });

                    $("#btnAgregar").html('Agregar');
                    BuscarFactura();
                    return false;
                }
                else
                    return false;
            }
        }

        function CloseModal() {
            document.getElementById('MyModal').style.display = 'none';
        }

        function TranslateErrorPago(pCodError, pEmpresa, pdescItem) {
            var mError;
            mError = "La factura de " + pEmpresa + " No pudo Cobrarse. Error :" + pdescItem

            return mError

        }
        function TranslateError(pCodError, pEmpresa, pImpItem) {
            var mError;
            switch (pCodError) {
                case 58: mError = " Fecha del Cliente desconfigurada.</br>"
                    break;
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
                case 42: mError = "El importe de uno o varios ítem no es válido, se deberá ingresar el importe de la factura que corresponda.</br>"
                    break;
                case 44: mError = "La factura de " + pEmpresa + " ya se encuentra paga.</br>"
                    break;
                case 204: mError = "Items con error.</br>"
                    break;
                case 130: mError = "Errores encontrados en la carga de los datos del cliente.</br>"
                    break;
                case 157: mError = "La factura de " + pEmpresa + " Por un monto de $" + pImpItem + " no pudo cobrarse.</br>"
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
                case 197: mError = "Faltan Completar campos para generar el cobro</br>"
                    break;
                default: mError = "Error al Cobrar La Factura, reintente mas tarde</br>"

            }

            return mError
        }
        function GetEmpresas(e) {

            var tecla = (document.all) ? e.keyCode : e.which;

            if (tecla == 13) {
                if ($("#txtDescEmpresa").val().length < 3) {
                    $('#lblfailEmpresa').css({ display: 'block' });
                    $('#lblfailEmpresa').html("Error: para buscar debe ingresar al menos 3 digitos");

                    return false;
                }
                $('#lblfailEmpresa').css({ display: 'none' });
                $('#lblfailAgregar').css({ display: 'none' });
                $('#lblresultokfail').css({ display: 'none' });
                BuscarEmpresas($("#txtDescEmpresa").val());
                return false;
            }


        }

        function Limpiar() {

            $('#imgNoCom').css({ display: 'none' });
            $('#imgCom').css({ display: 'none' });
            $('#lblMensajeEmpresa').css({ display: 'none' });
            $('#txtMonto').attr('disabled', false);
            $('#dvdGetEmpresa').css({ display: 'block' });
            LimpiarCampos();
            LimpiarCamposPosSave();
            LimpiarGrillaExtras();
            LimpiarGrillaFacturas();
        }


        function BuscarFactura() {
            $('#imgNoCom').css({ display: 'none' });
            $('#imgCom').css({ display: 'none' });
            $('#lblMensajeEmpresa').css({ display: 'none' });
            $('#lblresultok').css({ display: 'none' });
            $('#lblCargando').css({ display: 'none' });
            $('#tablafacturasCSF').css({ display: 'none' });
            $('#dvdGetEmpresa').css({ display: 'none' });
            $('#lblfailAgregar').css({ display: 'none' });
            $('#lblresultokfail').css({ display: 'none' });
            $("#idMod").val(0);
            $("#txtMonto").val(0);
            $("#cboModalidad").val(0);


            var SendObjLote = {
                "codPuesto": $("#codPuesto").val(),
                "CodBarra": $("#txtCodBarra").val()
            }

            //stringDataPayment = '{"items":[' + stringDataPayment + '],' + SendObj + '}';

            stringData = JSON.stringify(SendObjLote);
            console.log(stringData);
            $.ajax({
                type: "POST",
                url: "../Servicios/Servicios.asmx/GetFacturas",
                data: "{'pObj':" + stringData + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function (response) {
                    $('#lblCargando').css({ display: 'block' });
                    $('#lblCargando').html('Procesando...');
                },
                success: function (response) {

                    //console.log("Empresa");
                    //console.log(response);
                    //console.log("Empresa");
                    $('#lblCargando').css({ display: 'none' });
                    if (response.d.codResul == "0") {
                        var models = (typeof response.d.facturas) == "string" ? eval("(" + response.d.facturas + ")") : response.d.facturas;

                        $("#cboEmpresa").get(0).options.length = 2;
                        $('#lblMensajeEmpresa').css({ display: 'block' });
                        $('#lblMensajeEmpresa').html(response.d.descResul);
                        try {
                            if (response.d.comision == "NO") {
                                $('#imgCom').css({ display: 'none' });
                                $('#imgNoCom').css({ display: 'block' });

                            }
                            else {
                                $('#imgCom').css({ display: 'block' });
                                $('#imgNoCom').css({ display: 'none' });
                            }
                        } catch (e) {
                            $('#imgCom').css({ display: 'none' });
                            $('#imgNoCom').css({ display: 'block' });
                        }

                        for (var i = 0; i < models.length; i++) {

                            var val = models[i].codEmp;


                            var text = models[i].descEmp;

                            $("#cboEmpresa").get(0).options[$("#cboEmpresa").get(0).options.length] = new Option(text, val);

                            var textCod = models[i].codEmp;
                            $("#txtCodEmpresa").val(val);


                        }

                        CargarDatosFactura();
                        eliminarCamposAdicionales();
                        //AgregarCamposAdicionales();
                    }
                    else {
                        var msn;
                        msn = TranslateError(response.d.codResul, "", "")

                        $('#lblfailAgregar').css({ display: 'block' });
                        $('#lblfailAgregar').html(msn);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {

                    alert("Error " + textStatus);
                },
            });
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

            CalcularTotal();


            var a = 1;
            $("#tablaFactura tbody tr").each(function () {
                $("#fila" + a).removeAttr("id");

                a++;
            });

            var b = 1;
            $("#tablaFactura tbody tr").each(function () {
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
            $("#txtCodBarra").val("");
            $("#cboEmpresa").val("");
            $("#cboModalidad").val("");
            $("#txtVuelto").val(0);
            $("#txtDineroRecibido").val(0);
            $("#txtMonto").val(0);
            $("#cboMonto").css({ display: 'none' });
            $("#txtMonto").css({ display: 'block' });
            $('#lblfailAgregar').css({ display: 'none' });
            $('#lblresultokfail').css({ display: 'none' });
            $('#lblresultok').css({ display: 'none' });
            $('#lblCargando').css({ display: 'none' });
            $('#lblMensajeEmpresa').css({ display: 'none' });
        }

        function LimpiarGrillaFacturas() {

            $('#tablaFactura tbody tr').each(function () {
                $(this).remove();
                return false;
            });
        }
        function LimpiarGrillaExtras() {



            $('#tablafacturasCSF tr').each(function () {
                $(this).remove();
                return false;
            });
            $('#tablafacturasCSF th').each(function () {
                $(this).remove();
                return false;
            });;

        }

        function LimpiarCamposPosSave() {
            // $("#txtCodBarra").val("");
            $("#cboEmpresa").val("");
            $("#cboModalidad").val("");
            $("#txtMonto").val(0);

            $('#tablaFactura tbody tr').each(function () {
                $(this).remove();
                return false;
            });
            $('#tablafacturasCSF tr').each(function () {
                $(this).remove();
                return false;
            });
            $('#tablafacturasCSF th').each(function () {
                $(this).remove();
                return false;
            });


            CalcularTotal();

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
        function CalcularTotal() {

            var mTotal = 0;
            $("#txtTotal").val(mTotal);
            //repetir por columna, o usa un array
            $('#tablaFactura .success').map(function (k, v) {
                mTotal = mTotal + parseFloat($(this).children('td:eq(5)').text());

                //repetir por columna o llena un array
            })
            mTotal = round(mTotal);
            $("#txtTotal").val(mTotal);
        }

        function noenter() {
            return !(window.event && window.event.keyCode == 13);
        }

        function AgregarCamposAdicionales() {
            eliminarCamposAdicionales();
            LimpiarGrillaExtras();
            var mUrl;
            $('#lblMensajeEmpresa').css({ display: 'none' });
            $('#imgCom').css({ display: 'none' });
            $('#btnAgregar').removeAttr('disabled');
            var SendObjLote = {
                "codPuesto": $("#codPuesto").val(),
                "idMod": $("#cboModalidad").val().split("|")[0],
                "codEmpresa": $("#cboEmpresa").val(),
                "Modalidad": $('#cboModalidad :selected').text()
            }


            stringData = JSON.stringify(SendObjLote);
            console.log(stringData);
            $.ajax({
                type: "POST",
                url: "../Servicios/Servicios.asmx/GetForm",
                data: "{'pObj':" + stringData + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //console.log("AgregarCamposAdicionales");
                    //console.log(response);
                    //console.log("AgregarCamposAdicionales");
                    if (response.d.codResul == 0) {
                        var models = response.d.campos;
                        var nextinput = 0;
                        $('#lblMensajeEmpresa').css({ display: 'block' });
                        $('#lblMensajeEmpresa').html(response.d.descResul);
                        try {
                            if (response.d.comision == "NO") {
                                $('#imgCom').css({ display: 'none' });
                                $('#imgNoCom').css({ display: 'block' });

                            }
                            else {
                                $('#imgCom').css({ display: 'block' });
                                $('#imgNoCom').css({ display: 'none' });
                            }
                        } catch (e) {
                            $('#imgCom').css({ display: 'none' });
                            $('#imgNoCom').css({ display: 'block' });
                        }
                        for (var i = 0; i < models.length; i++) {

                            nextinput++;
                            //TEXT_FIELD
                            //COMBO_BOX_ESTATICO
                            //COMBO_BOX_DINAMICO
                            //LABEL
                            //CHECK_BOX 
                            $("#ItemAdicional" + i).val(models[i].nombre);
                            //console.log(models[i].tipoComponenteVisual);
                            //console.log(models[i].nombre);
                            //console.log(models[i].tipo);
                            if (models[i].tipoComponenteVisual == "TEXT_FIELD" || models[i].tipoComponenteVisual == "HIDDEN_TEXT_FIELD") {
                                var maxleng = models[i].longitud;
                                var tipo = models[i].tipo;
                                // alert(tipo);
                                if (tipo == "ALF" || tipo == "CBA") {
                                    tipo = "text";
                                }
                                else {
                                    if (tipo == "FEC") {

                                        tipo = "text";
                                    }
                                    else {
                                        tipo = "number";
                                    }
                                }

                                var sEtiqueta;
                                sEtiqueta = models[i].etiqueta;

                                if (sEtiqueta.includes("BARRA") || sEtiqueta.includes("Barra") || sEtiqueta.includes("barra")) {
                                    nuevocampo = '<br clientidmode="Static" class="inputbr"/><div class="form-groupAdd"><div class="input-group"><span class="input-group-addon">' + models[i].etiqueta + ':</span><input  maxlength="' + maxleng + '"  type="' + tipo + '" class="form-control" onKeyPress="return noenter()" style="text-align: justify; max-width: 100%; width: 100%" id="' + models[i].nombre + '" clientidmode="Static"></div></div>';
                                } else {
                                    nuevocampo = '<br clientidmode="Static" class="inputbr"/><div class="form-groupAdd"><div class="input-group"><span class="input-group-addon">' + models[i].etiqueta + ':</span><input maxlength="' + maxleng + '"  type="' + tipo + '" class="form-control" onKeyPress="return noenter()" style="text-align: justify; width: 100%" id="' + models[i].nombre + '" clientidmode="Static"></div></div>';
                                }

                                $("#ContenedorModalidad").append(nuevocampo);

                            }

                            if (models[i].tipoComponenteVisual == "COMBO_BOX_ESTATICO") {
                                nuevocampo = '<br clientidmode="Static" class="inputbr"/>' +
                                    '<div class="form-groupAdd"><div class="input-group">' +
                                    '<span class="input-group-addon">' + models[i].etiqueta + ':</span>' +
                                    '<select ClientIDMode="Static" ID="' + models[i].nombre + '" class="form-control"></select>' +
                                    '</div></div>';


                                //' <asp:DropDownList  ClientIDMode="Static" ID="C12" class="form-control"> </asp:DropDownList>' +

                                $("#ContenedorModalidad").append(nuevocampo);


                                var modelsListaValores = (typeof response.d.campos[i].listaValores) == "string" ? eval("(" + response.d.campos[i].listaValores + ")") : response.d.campos[i].listaValores;
                                var q = 1;
                                var json_data;
                                //modelsListaValores = "listaValores {" + modelsListaValores.toString() + "}"
                                //json_data = JSON.parse(modelsListaValores);

                                for (var q = 0; q <= 3; q++) {
                                    val = q;
                                    text = response.d.campos[i].listaValores["_" + q];
                                    // $('#' + models[i].nombre).append($('<option>').text(q).attr('value', q));
                                    $('#' + models[i].nombre).get(0).options[$('#' + models[i].nombre).get(0).options.length] = new Option(text, val);
                                }

                            }

                        }

                    } else {
                        try {
                            if (response.d.comision == "NO") {
                                $('#imgCom').css({ display: 'none' });
                                $('#imgNoCom').css({ display: 'block' });

                            }
                            else {
                                $('#imgCom').css({ display: 'block' });
                                $('#imgNoCom').css({ display: 'none' });
                            }
                        } catch (e) {
                            $('#imgCom').css({ display: 'none' });
                            $('#imgNoCom').css({ display: 'block' });
                        }


                        $('#lblMensajeEmpresa').css({ display: 'block' });
                        $('#lblMensajeEmpresa').html(response.d.descResul);
                    }



                },

                error: function (jqXHR, textStatus, errorThrown) {

                },

            });
        }
        var SendObjLotedatosFormulario = {};

        function SelFact(ctl) {
            var _row = null;

            $('#lblfailAgregar').css({ display: 'none' });
            _row = $(ctl).parents("tr");
            var cols = _row.children("td");
            console.log(cols);
            var mEsPrimeraFila = 1;
            $('#tablaFactura tbody tr').each(function () {
                var mCodBarra;
                mEsPrimeraFila = 0;
                //console.log($.trim($(this).find('td').eq(3).text());
                //if (item.codEmp = 1157) {

                //}
                // console.log('text');
                mCodBarra = $.trim($(this).find('td').eq(3).text());

                //Quiere decir que existe
                if (mCodBarra == cols[1].innerText) {
                    $('#lblfailAgregar').css({ display: 'block' });
                    $('#lblfailAgregar').html("La factura indicada ya esta agregada para cobrarse");
                    mEsPrimeraFila = 2;
                    return;
                }
            });

            if (mEsPrimeraFila != 2) {
                var mMonto;
                mMonto = cols[cols.length - 1].innerText;

                if ($("#txtMonto").val() > 0) {
                    mMonto = $("#txtMonto").val();
                } else {
                    if ($('#cboEmpresa :selected').val() == 652 && $('#cboModalidad :selected').val().split("|")[0] == "56967652726500006882") {
                        $('#lblfailAgregar').css({ display: 'block' });
                        $('#lblfailAgregar').html("Indique Monto a Cargar en la cuenta de Mercado Pago");
                        mEsPrimeraFila = 2;
                        return;
                    }
                }

                console.log('text');
                console.log(cols[1].innerText);
                console.log('text');
                console.log('html');
                console.log(cols[1].innerhtml);
                console.log('html');
                console.log('html');
                console.log(cols[1]);
                console.log('html');

                $("#idMod").val($('#cboModalidad :selected').val().split("|")[0]);
                $("#tablaFactura").append("<tr class='success'><td style='display:none'> <input type='checkbox' /></td>" +
                    "<td style='display:none'> " + $("#cboEmpresa").val() + "</td > " +
                    "<td> " + $('#cboEmpresa :selected').text() + "</td > " +
                    "<td> " + cols[1].innerText + "</td >" +
                    "<td> " + $('#cboModalidad :selected').text() + "</td > " +
                    "<td> " + mMonto +
                    "<td > " + $('#cboModalidad :selected').val().split("|")[1] + "</td >" +
                    "<td style='display:none'> " + $("#idMod").val() + "</td >" +
                    "<td  style='display:none'> " + JSON.stringify('{}') + "</td >" +
                    "<td><input type='button' class='borrar' style='color: #ffffff;background-color: #d9534f;border-color: #d43f3a;display: inline-block;padding: 6px 12px;margin-bottom: 0;line-height: 1.428571429;text-align: center;white-space: nowrap;vertical-align: middle;cursor: pointer;border: 1px solid transparent;border-radius: 10px;' value='Eliminar' /></td>" +
                    "</tr > ");


                //LimpiarCamposPosSave();

                CalcularTotal();
                eliminarCamposAdicionales();
                $('#btnAgregar').removeAttr('disabled');
            }

            //    return;



            //if (mEsPrimeraFila == 1) {

            //    $("#idMod").val($('#cboModalidad :selected').val().split("|")[0]);
            //    $("#tablaFactura").append("<tr class='success'><td> <input type='checkbox' /></td>" +
            //        "<td style='display:none'> " + $("#cboEmpresa").val() + "</td > " +
            //        "<td> " + $('#cboEmpresa :selected').text() + "</td > " +
            //        "<td> " + cols[1].innerText + "</td >" +
            //        "<td> " + $('#cboModalidad :selected').text() + "</td > " +
            //        "<td> " + cols[cols.length - 1].innerText +
            //        "<td > " + $('#cboModalidad :selected').val().split("|")[1] + "</td >" +
            //        "<td style='display:none'> " + $("#idMod").val() + "</td >" +
            //        "<td  style='display:none'> " + JSON.stringify('{}') + "</td >" +
            //        "</tr > ");


            //    //LimpiarCamposPosSave();

            //    CalcularTotal();
            //    eliminarCamposAdicionales();
            //    $('#btnAgregar').removeAttr('disabled');
            //}



        }

        function ArmarGrillaCSF() {

            var mDeboConsultarGrilla;
            var mTipoCobranza = $('#cboModalidad :selected').val().split("|")[1];

            if (mTipoCobranza == "CSF" || mTipoCobranza == "SFM") {
                mDeboConsultarGrilla = 1;
                $('#btnAgregar').attr("disabled", 'disabled');
            }
            else {
                mDeboConsultarGrilla = 0;
                $('#btnAgregar').attr("disabled", 'disabled');
            }

            if (mDeboConsultarGrilla == 1) {


                //llamo al consultar grilla
                $.ajax({
                    type: "POST",
                    url: "../Servicios/Servicios.asmx/GetGrilla",
                    data: "{codPuesto:'" + $("#codPuesto").val() + "', idMod:'" + $('#cboModalidad :selected').val().split("|")[0] + "',idTrxAnterior:'', datosFormulario:'" + JSON.stringify(SendObjLotedatosFormulario) + "'}",
                    contentType: "application/json; charset=utf-8",
                    beforeSend: function () {
                        $('#lblCargando').css({ display: 'block' });
                        $('#lblCargando').html('Consultando Facturas...');
                    },
                    success: function (response) {
                        console.log("grilla");
                        console.log(response);
                        console.log("grilla");

                        $('#lblCargando').css({ display: 'none' });

                        if (response.d.codResul == "0") {
                            var models = (typeof response.d.camposGrilla) == "string" ? eval("(" + response.d.camposGrilla + ")") : response.d.camposGrilla;
                            var modelsvalores = (typeof response.d.valoresGri) == "string" ? eval("(" + response.d.valoresGri + ")") : response.d.valoresGri;


                            $('#tablafacturasCSF').css({ display: 'block' });
                            var mTitulosGrilla;
                            var encabezado;
                            var pie;
                            encabezado = "<thead><tr id='Tr1' class='info'><th>Sel</th>";
                            pie = "</tr></thead>";

                            for (var i = 0; i < models.length; i++) {

                                if (models[i].codCampo != 'DAF' && models[i].codCampo != 'codTI' && models[i].codCampo != 'descTI') {
                                    mTitulosGrilla = mTitulosGrilla + "<th id=" + models[i].codCampo + ">" + models[i].descCampo + "</th>";
                                }


                            }
                            $("#tablafacturasCSF").append(encabezado + mTitulosGrilla + pie);






                            var i = 0;

                            var leng = modelsvalores.length / models.length;

                            for (var j = 0; j < leng; j++) {
                                var mNameFila;
                                var mClaseGrilla = "";
                                mNameFila = "FilaGrilla" + j;
                                if (mClaseGrilla == "") {
                                    mClaseGrilla = "success";
                                }
                                else {
                                    mClaseGrilla = "";
                                }
                                var detallegrilla = "<tr id=" + mNameFila + " class=" + mClaseGrilla + "><td>" +
                                    "<button style='width:20px;height:30px;font-size: 12px;' type='button' " +
                                    "onclick='SelFact(this);' " +
                                    "class='btn btn-info'><i style='margin-left:-6px;' class='glyphicon glyphicon-plus'></i>" +
                                    "</button>"

                                //for (i < models.length; i++;) {
                                var r = 0;
                                while (r < models.length) {

                                    //console.log("modelsvalores[i].valor")
                                    //console.log(modelsvalores[i].valor);
                                    //alert(response.d.codEmp);
                                    var barradesc = modelsvalores[i].valor;

                                    if (response.d.codEmp = 1157) {
                                        barradesc = barradesc.replace(' ', '        ');
                                    }

                                    if (modelsvalores[i]["codCampo"] != 'DAF' && modelsvalores[i]["codCampo"] != 'codTI' && modelsvalores[i]["codCampo"] != 'descTI') {

                                        detallegrilla = detallegrilla + "<td id=" + modelsvalores[i].codCampo + ">" + barradesc + "</td>";

                                    }
                                    r = r + 1;
                                    i = i + 1;
                                }
                                //r = r + models.length;
                                console.log(detallegrilla);
                                detallegrilla = detallegrilla + "</tr>";
                                console.log(detallegrilla);
                                $("#tablafacturasCSF").append(detallegrilla);
                            }

                            //}


                            SendObjLotedatosFormulario = {};

                        } else {

                            $('#lblCargando').css({ display: 'none' });
                            var msnerror;
                            msnerror = TranslateError(response.d.codResul, '', 0)
                            $('#lblfailAgregar').css({ display: 'block' });
                            $('#lblfailAgregar').html(response.d.descResul);
                            $('#dvdGetEmpresa').css({ display: 'block' });

                        }

                    },

                    error: function (Msn) {
                        // LimpiarCamposPosSave()
                        $('#lblCargando').css({ display: 'none' });
                        var msnerror;
                        try {
                            msnerror = TranslateError(Msn.codResul, '', 0)
                            $('#lblfailAgregar').css({ display: 'block' });
                            $('#lblfailAgregar').html(msnerror);
                        } catch (e) {
                            console.log(e);
                            $('#lblfailAgregar').css({ display: 'block' });
                            $('#lblfailAgregar').html(e.description);
                        }

                        return;

                    },
                });

            }


        }

        function AgregarFact() {

            $('#lblfailAgregar').css({ display: 'none' });
            $('#lblresultokfail').css({ display: 'none' });
            $('#lblfailEmpresa').css({ display: 'none' });
            $('#lblCargando').css({ display: 'none' });
            $('#lblresultok').css({ display: 'none' });
            if ($("#cboEmpresa").val() == null) {
                $('#lblfailAgregar').css({ display: 'block' });
                $('#lblfailAgregar').html("Debe ingresar la empresa");
                return;
            }
            var mNombre;
            var mClase = "";

            var n = 1;
            $("#tablaFactura tbody tr").each(function () {

                n++;
            });


            mNombre = "fila" + (n + 1);
            if (mClase == "") {
                mClase = "success";
            }
            else {
                mClase = "";
            }

            var SendObjLote2 = { "datosFormulario": [] };
            //  var SendObjLotedatosFormulario = {};

            if (typeof ($("#" + $("#ItemAdicional0").val()).val()) != "undefined") {
                //alert(1)
                //SendObjLote = "" + $("#ItemAdicional0").val() + ":" + $("#" + $('#ItemAdicional0').val()).val();
                SendObjLotedatosFormulario[$("#ItemAdicional0").val()] = $("#" + $('#ItemAdicional0').val()).val();
            }

            if (typeof ($("#" + $("#ItemAdicional1").val()).val()) != "undefined") {
                // alert(2)
                //SendObjLote = SendObjLote + "," + $('#ItemAdicional1').val() + ":"  + $("#" + $('#ItemAdicional1').val()).val();
                SendObjLotedatosFormulario[$("#ItemAdicional1").val()] = $("#" + $('#ItemAdicional1').val()).val();
            }
            //alert(SendObjLote);

            if (typeof ($("#" + $("#ItemAdicional2").val()).val()) != "undefined") {
                // alert(3)
                //SendObjLote = SendObjLote + "," + $("#ItemAdicional2").val() + ":" + $("#" + $("#ItemAdicional2").val()).val();
                SendObjLotedatosFormulario[$("#ItemAdicional2").val()] = $("#" + $('#ItemAdicional2').val()).val();
            }

            //alert($("#ItemAdicional2").val());
            //alert($("#ItemAdicional3").val());
            var cadena;
            if (typeof ($("#" + $("#ItemAdicional0").val()).val()) != "undefined") {
                //alert(4)
                SendObjLotedatosFormulario["IV1"] = $("#txtMonto").val();

            } else {
                cadena = "";
            }


            if ($('#cboModalidad :selected').val().split("|")[1] == "CSF" || $('#cboModalidad :selected').val().split("|")[1] == "SFM") {
                ArmarGrillaCSF();
            }
            else {
                if ($('#cboModalidad :selected').val().split("|")[1] == "CEI") {

                    $("#idMod").val($('#cboModalidad :selected').val().split("|")[0]);
                    $("#tablaFactura").append("<tr class='" + mClase + "'><td style='display:none'> <input type='checkbox' /></td>" +
                        "<td style='display:none'> " + $("#cboEmpresa").val() + "</td > " +
                        "<td> " + $('#cboEmpresa :selected').text() + "</td > " +
                        "<td> " + $("#txtCodBarra").val() + "</td >" +
                        "<td> " + $('#cboModalidad :selected').text() + "</td > " +
                        "<td> " + $("#cboMonto").val() + "</td >" +
                        "<td> " + $('#cboModalidad :selected').val().split("|")[1] + "</td >" +
                        "<td style='display:none'> " + $("#idMod").val() + "</td >" +
                        "<td  style='display:none'> " + JSON.stringify(SendObjLotedatosFormulario) + "</td >" +
                        "<td><input type='button' class='borrar' style='color: #ffffff;background-color: #d9534f;border-color: #d43f3a;display: inline-block;padding: 6px 12px;margin-bottom: 0;line-height: 1.428571429;text-align: center;white-space: nowrap;vertical-align: middle;cursor: pointer;border: 1px solid transparent;border-radius: 10px;' value='Eliminar' /></td>" +
                        "</tr > ");

                }
                else {



                    //if ($('#cboModalidad :selected').val().split("|")[1] == "CAB") {

                    //    $('#lblresultokfail').css({ display: 'block' });
                    //    $('#lblresultokfail').html("La Cobranza Abierta no esta permitida. Busque el comprobante");
                    //    return;

                    //}
                    //else {

                    $("#idMod").val($('#cboModalidad :selected').val().split("|")[0]);
                    $("#tablaFactura").append("<tr class='" + mClase + "'><td style='display:none'> <input type='checkbox' /></td>" +
                        "<td style='display:none'> " + $("#cboEmpresa").val() + "</td > " +
                        "<td> " + $('#cboEmpresa :selected').text() + "</td > " +
                        "<td> " + $("#txtCodBarra").val() + "</td >" +
                        "<td> " + $('#cboModalidad :selected').text() + "</td > " +
                        "<td> " + $("#txtMonto").val() + "</td >" +
                        "<td> " + $('#cboModalidad :selected').val().split("|")[1] + "</td >" +
                        "<td style='display:none'> " + $("#idMod").val() + "</td >" +
                        "<td  style='display:none'> " + JSON.stringify(SendObjLotedatosFormulario) + "</td >" +
                        "<td><input type='button' class='borrar' style='color: #ffffff;background-color: #d9534f;border-color: #d43f3a;display: inline-block;padding: 6px 12px;margin-bottom: 0;line-height: 1.428571429;text-align: center;white-space: nowrap;vertical-align: middle;cursor: pointer;border: 1px solid transparent;border-radius: 10px;' value='Eliminar' /></td>" +
                        "</tr > ");
                    //}
                }


                SendObjLotedatosFormulario = {};

                CalcularTotal();
                LimpiarCampos();
            }

        }
        function CargarDatosFactura() {

            var mUrl;
            $('#lblresultokfail').css({ display: 'none' });
            $('#lblfailAgregar').css({ display: 'none' });
            $('#lblfailEmpresa').css({ display: 'none' });
            if ($("#txtCodBarra").val() == " ") {
                var SendObjLote = {
                    "codPuesto": $("#codPuesto").val(),
                    "CodBarra": "",
                    "codEmp": $("#txtCodEmpresa").val()
                }
            }
            else {

                var SendObjLote = {
                    "codPuesto": $("#codPuesto").val(),
                    "CodBarra": $("#txtCodBarra").val(),
                    "codEmp": ""
                }
            }

            stringData = JSON.stringify(SendObjLote);
            try {

                $.ajax({
                    type: "POST",
                    url: "../Servicios/Servicios.asmx/GetFacturas",
                    data: "{'pObj':" + stringData + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function (response) {
                        $('#lblCargando').css({ display: 'block' });
                        $('#lblCargando').html('Procesando...');
                    },
                    success: function (response) {

                        $('#lblCargando').css({ display: 'none' });
                        //var models = (typeof response.facturas["0"].formasPago) == "string" ? eval("(" + response.facturas["0"].formasPago + ")") : response.facturas["0"].formasPago;


                        $("#cbofPago").get(0).options.length = 0;
                        $("#cbofPago").get(0).options[$("#cbofPago").get(0).options.length] = new Option("PESOS", "PES");
                        $("#cboModalidad").get(0).options.length = 0;
                        $("#cboEmpresa").get(0).options.length = 0;

                        $("#cboModalidad").get(0).options[$("#cboModalidad").get(0).options.length] = new Option(response.d.facturas["0"].descMod, response.d.facturas["0"].idMod + "|" + response.d.facturas["0"].tipoCobranza);
                        $("#cboEmpresa").get(0).options[$("#cboEmpresa").get(0).options.length] = new Option(response.d.facturas["0"].descEmp, response.d.facturas["0"].codEmp);
                        $('#idMod').val(response.d.facturas["0"].idMod);
                        $('#TipoCobranza').val(response.d.facturas["0"].tipoCobranza);

                        if (response.d.cantColisiones > 1 && response.d.facturas["0"].tipoCobranza == "CEI") {

                            var a = 0;
                            $('#cboMonto').css({ display: 'block' });
                            $('#txtMonto').css({ display: 'none' });
                            $("#cboMonto").get(0).options.length = 0;
                            for (var i = 0; a < response.d.cantColisiones; i++) {

                                $("#cboMonto").get(0).options[$("#cboMonto").get(0).options.length] = new Option(response.d.facturas[i].importe, response.d.facturas[i].importe);
                            }

                        }
                        else {

                            //CAC Cobranza Abierta con Importe Cero Si viene importe es cerrado, si es 0 se puede modificar. 
                            //ESC Cobranza Cerrado Solo se cobra lo que interpreta la barra. 
                            //SAB Cobranza Abierto Permite cualquier importe respetando los topes de la empresa. 
                            //SLI  Cobranza Mayor o Igual al Importe Establecido Permite cobrar importes mayores iguales a lo interpretado en la barra respetando los topes de la empresa. 
                            //SLS Cobranza Hasta el Importe Establecido Permite cobrar importes menores iguales a lo interpretado en la barra respetando los topes de la empresa. 
                            $("#txtMonto").removeAttr("min");
                            $("#txtMonto").removeAttr("max");
                            $("#txtMonto").val(response.d.facturas["0"].importe);
                            //alert("tipoCob");
                            //alert(response.d.facturas["0"].tipoCobranza);
                            //alert("CodTI");
                            //alert(response.d.facturas["0"].codTI);
                            switch (response.d.facturas["0"].codTI) {
                                case "CAC":
                                    if (response.d.facturas["0"].importe == "0") {
                                        $('#txtMonto').attr('disabled', false);
                                    }
                                    else {
                                        // $('#txtMonto').attr('disabled', true);
                                    }
                                    break;
                                case "ESC":
                                    if (response.d.facturas["0"].tipoCobranza == "CEI") {
                                        $('#cboMonto').css({ display: 'block' });
                                        $('#txtMonto').css({ display: 'none' });
                                    }
                                    else {
                                        if (response.d.facturas["0"].tipoCobranza == "CAB") {
                                            $('#dvdGetEmpresa').css({ display: 'block' });
                                            $('#lblfailEmpresa').css({ display: 'block' });
                                            $('#lblfailEmpresa').html("La Modalidad de Pago de la Empresa No permite el ingreso directo de la barra. Debe hacerlo mediante la busqueda de empresas y completando la informacion solicitada");
                                            //alert("La Modalidad de Pago de la Empresa No permite el ingreso directo de la barra. Debe hacerlo mediante la busqueda de empresas y completando la informacion solicitada");
                                            LimpiarCampos();
                                            //return false;
                                        }
                                        else {
                                            $('#cboMonto').css({ display: 'none' });
                                            $('#txtMonto').css({ display: 'block' });
                                            // $('#txtMonto').attr('disabled', true);
                                        }
                                    }

                                    break;
                                case "SAB":
                                    $('#txtMonto').attr('disabled', false);
                                    $('#txtMonto').attr('min', response.d.facturas["0"].topes.minimoPositivo);
                                    $('#txtMonto').attr('max', response.d.facturas["0"].topes.maximoPositivo);
                                    break;
                                case "SLI":
                                    $('#txtMonto').attr('disabled', false);
                                    $('#txtMonto').attr('min', response.d.facturas["0"].importe);
                                    $('#txtMonto').attr('max', response.d.facturas["0"].topes.maximoPositivo);
                                    break;
                                case "SLS":
                                    $('#txtMonto').attr('disabled', false);
                                    $('#txtMonto').attr('min', response.d.facturas["0"].topes.minimoPositivo);
                                    $('#txtMonto').attr('max', response.d.facturas["0"].importe);
                                    break;
                                default:
                                    break;
                            }
                        }

                        //for (var i = 0; i < models.length; i++) {

                        //    var val = models[i].codFP;
                        //    var text = models[i].descFP;

                        //    $("#cbofPago").get(0).options[$("#cbofPago").get(0).options.length] = new Option(text, val);


                        //}


                    },
                    error: function (textStatus) {

                        $('#lblfailAgregar').css({ display: 'block' });
                        $('#lblfailAgregar').html("Error al intentar Obtener Datos:" + textStatus);
                    },

                });

            }
            catch (e) {

                $('#lblfailAgregar').css({ display: 'block' });
                $('#lblfailAgregar').html("Error al intentar Obtener Datos:" + e);
            }

        }
        function padLeft(nr, n, str) {
            return Array(n - String(nr).length + 1).join(str || '0') + nr;
        }

        function obtenerInicio(fechaInicio) {

            fecha = new Date(fechaInicio);

            var options = { month: 'long', year: 'numeric' };
            return fecha.toLocaleDateString("es-ES", options);

        }
        function obtenervencimiento(fechaprogramada) {

            fecha = new Date(fechaprogramada);

            var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            return fecha.toLocaleDateString("es-ES", options);

        }

        function GetFechaAhora() {
            now = new Date();
            year = "" + now.getFullYear();
            month = "" + (now.getMonth() + 1); if (month.length == 1) { month = "0" + month; }
            day = "" + now.getDate(); if (day.length == 1) { day = "0" + day; }
            hour = "" + now.getHours(); if (hour.length == 1) { hour = "0" + hour; }
            minute = "" + now.getMinutes(); if (minute.length == 1) { minute = "0" + minute; }
            second = "" + now.getSeconds(); if (second.length == 1) { second = "0" + second; }
            $("#FechaOperacion").val(year + month + day + hour + minute + second);
            //alert($("#FechaOperacion").val());
            sleep(2000);
            return year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;
        }

        function sleep(milliseconds) {
            var start = new Date().getTime();
            for (var i = 0; i < 1e7; i++) {
                if ((new Date().getTime() - start) > milliseconds) {
                    break;
                }
            }
        }

        function PagarFactura() {
            var mCodBarra;
            var midMod;
            var mEmpresa;
            var mimporteItem;
            var mIdItem;
            var mNombreEmpresa;
            var mTipoCob;
            var mformulario;
            var stringDataPayment;

            CalcularTotal();
            var SendObj = '"codPuesto"' + ":" + '"' + $("#codPuesto").val() + '"' + "," + '"idMobile"' + ":" + '"3516339290"' + "," + '"importeTotal"' + ":" + '"' + $("#txtTotal").val() + '"' + "," + '"idTrxAnterior"' + ":" + '""';

            $("btnAceptar").addClass("btn btn-primary disabled");
            $("btnEliminar").addClass("disabled");

            var mEntro = 0;
            $('#lblresultokfail').css({ display: 'none' });
            $('#lblfailAgregar').css({ display: 'none' });
            $('#tablafacturasCSF').css({ display: 'none' });
            var nroFila = 0;
            $('#tablaFactura tbody tr').each(function () {
                nroFila = nroFila + 1;

                mCodBarra = $.trim($(this).find('td').eq(3).text());

                if (mCodBarra != 'Codigo de Barras') {
                    mEntro = 1;
                    $("#FechaOperacionFormateada").val(GetFechaAhora());

                    mEmpresa = $.trim($(this).find('td').eq(1).text());
                    midMod = $.trim($(this).find('td').eq(7).text());
                    mimporteItem = $.trim($(this).find('td').eq(5).text());
                    mNombreEmpresa = $.trim($(this).find('td').eq(2).text());
                    mIdItem = "03" + $("#codAgente").val() + $("#codPuesto").val() + $("#FechaOperacion").val();
                    mformulario = $.trim($(this).find('td').eq(8).text());
                    mTipoCob = $.trim($(this).find('td').eq(6).text());


                    if (mTipoCob == "CAB" && mCodBarra == "")
                        mCodBarra = "";

                    var SendObjFormaPago = {
                        "PES": mimporteItem
                    }

                    //"datosFormulario": SendObjLotedatosFormulario, aca ver con varias facturas, antes se grababa esa variable pero solo funciona para una factura ya que la segunda
                    //cobranza quedan pegados los datos de la fact anterior, aca ahora se recupero del valor de la fila de la grilla que tienne un attr llamado"datosform"

                    if (mTipoCob == "CSF" || mTipoCob == "SFM") {
                        var SendObjLote = {
                            "barra": mCodBarra,
                            "idMod": midMod,
                            "codEmp": mEmpresa,
                            "Empresa": mNombreEmpresa,
                            "fechaHoraLectura": $("#FechaOperacionFormateada").val(),
                            "importeItem": mimporteItem,
                            "idItem": mIdItem,
                            "formasPago": SendObjFormaPago,
                            "datosFormulario": {}
                        }
                    }
                    else {

                        if (mformulario == "{}") {

                            var SendObjLote = {
                                "barra": mCodBarra,
                                "idMod": midMod,
                                "codEmp": mEmpresa,
                                "Empresa": mNombreEmpresa,
                                "fechaHoraLectura": $("#FechaOperacionFormateada").val(),
                                "importeItem": mimporteItem,
                                "idItem": mIdItem,
                                "formasPago": SendObjFormaPago,
                                "datosFormulario": {}
                            }

                        } else {
                            var SendObjLote = {
                                "barra": mCodBarra,
                                "idMod": midMod,
                                "codEmp": mEmpresa,
                                "Empresa": mNombreEmpresa,
                                "fechaHoraLectura": $("#FechaOperacionFormateada").val(),
                                "importeItem": mimporteItem,
                                "idItem": mIdItem,
                                "formasPago": SendObjFormaPago,
                                "datosFormulario": jQuery.parseJSON(mformulario)
                            }
                        }

                    }


                    if (typeof (stringDataPayment) == "undefined") {
                        stringDataPayment = JSON.stringify(SendObjLote);
                    } else {
                        stringDataPayment = stringDataPayment + "," + JSON.stringify(SendObjLote);
                    }



                }


            })
            stringDataPayment = '{"items":[' + stringDataPayment + '],' + SendObj + '}';


            if (mEntro == 0) {
                $('#lblresultokfail').css({ display: 'block' });
                $('#lblresultokfail').html('Debe Ingresar Facturas a Pagar');
                $('#spnConfirmar').removeClass('fa fa-circle-o-notch fa-spin');
                $('#spnConfirmar').addClass('glyphicon glyphicon-ok');
                $('#btnAceptar').removeAttr('disabled');
                return;
            }
            $.ajax({
                type: "POST",
                url: "../Servicios/Servicios.asmx/Pagar",
                data: "{datosFormulario:" + JSON.stringify(stringDataPayment) + ", pIDAgencia: " + $("#IDAgencia").val() + ", pIDAcceso: " + $("#IDAcceso").val() + "}",
                contentType: "application/json; charset=utf-8",
                beforeSend: function (response) {
                    $('#lblCargando').css({ display: 'block' });
                    $('#lblCargando').html('Procesando pago...');

                },
                success: function (responsepago) {

                    var msn = "";
                    $('#lblCargando').css({ display: 'none' });
                    $('#lblresultok').css({ display: 'none' });

                    $('#spnConfirmar').removeClass('fa fa-circle-o-notch fa-spin');
                    $('#spnConfirmar').addClass('glyphicon glyphicon-ok');
                    $('#btnAceptar').removeAttr('disabled');
                    LimpiarCamposPosSave();
                    LimpiarGrillaExtras();
                    eliminarCamposAdicionales();

                    //console.log(responsepago);
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

                        LimpiarGrillaExtras();
                        LimpiarCamposPosSave();

                    }

                    if (responsepago.d.codResul == "666") {
                        $('#lblresultokfail').css({ display: 'block' });
                        $('#lblresultokfail').html("Rapipago Momentaneamente sin servicio, reintente mas tarde.");
                        $('#spnConfirmar').removeClass('fa fa-circle-o-notch fa-spin');
                        $('#spnConfirmar').addClass('glyphicon glyphicon-ok');
                        $('#btnAceptar').removeAttr('disabled');
                        return;

                    }

                    //if (responsepago.d.codResul == "999") {
                    //    $('#lblresultokfail').css({ display: 'block' });
                    //    $('#lblresultokfail').html("Solo Puede enviar una factura para cobro");
                    //    $('#spnConfirmar').removeClass('fa fa-circle-o-notch fa-spin');
                    //    $('#spnConfirmar').addClass('glyphicon glyphicon-ok');
                    //    $('#btnAceptar').removeAttr('disabled');
                    //    return;

                    //}
                    if (responsepago.d.codResul == "777") {
                        $('#lblresultokfail').css({ display: 'block' });
                        $('#lblresultokfail').html("Fuera de Horario de Atencion. Horario Habilitado desde las 07:00 hasta las 20:00");
                        $('#spnConfirmar').removeClass('fa fa-circle-o-notch fa-spin');
                        $('#spnConfirmar').addClass('glyphicon glyphicon-ok');
                        $('#btnAceptar').removeAttr('disabled');
                        return;

                    }
                    if (responsepago.d.codResul == "888") {
                        $('#lblresultokfail').css({ display: 'block' });
                        $('#lblresultokfail').html("Rapipago Momentaneamente fuera de servicio");
                        $('#spnConfirmar').removeClass('fa fa-circle-o-notch fa-spin');
                        $('#spnConfirmar').addClass('glyphicon glyphicon-ok');
                        $('#btnAceptar').removeAttr('disabled');
                        return;

                    }
                    if (responsepago.d.codResul == "222") {
                        $('#lblresultokfail').css({ display: 'block' });
                        $('#lblresultokfail').html("Rapipago Momentaneamente fuera de servicio..");
                        $('#spnConfirmar').removeClass('fa fa-circle-o-notch fa-spin');
                        $('#spnConfirmar').addClass('glyphicon glyphicon-ok');
                        $('#btnAceptar').removeAttr('disabled');
                        return;

                    }
                    if (responsepago.d.codResul == "333") {
                        $('#lblresultokfail').css({ display: 'block' });
                        $('#lblresultokfail').html("Limite de Credito alcanzado.");
                        $('#spnConfirmar').removeClass('fa fa-circle-o-notch fa-spin');
                        $('#spnConfirmar').addClass('glyphicon glyphicon-ok');
                        $('#btnAceptar').removeAttr('disabled');
                        return;

                    }
                    if (responsepago.d.codResul == "444") {
                        $('#lblresultokfail').css({ display: 'block' });
                        $('#lblresultokfail').html("Cobro Fuera del Horario Permitido.");
                        $('#spnConfirmar').removeClass('fa fa-circle-o-notch fa-spin');
                        $('#spnConfirmar').addClass('glyphicon glyphicon-ok');
                        $('#btnAceptar').removeAttr('disabled');
                        return;

                    }
                    if (responsepago.d.codResul == "555") {
                        $('#lblresultokfail').css({ display: 'block' });
                        $('#lblresultokfail').html("Servicio de Ingreso de Dinero No habilitado.");
                        $('#spnConfirmar').removeClass('fa fa-circle-o-notch fa-spin');
                        $('#spnConfirmar').addClass('glyphicon glyphicon-ok');
                        $('#btnAceptar').removeAttr('disabled');
                        return;

                    }

                    if (responsepago.d.codResul != "0" && msn == "") {
                        $('#lblresultokfail').css({ display: 'block' });
                        $('#lblresultokfail').html("Los Items Ingresados no se puedieron cobrar");
                        $('#spnConfirmar').removeClass('fa fa-circle-o-notch fa-spin');
                        $('#spnConfirmar').addClass('glyphicon glyphicon-ok');
                        $('#btnAceptar').removeAttr('disabled');
                        return;

                    }
                    if (msn != "") {
                        //alert(2222);
                        $('#lblresultokfail').css({ display: 'block' });
                        $('#lblresultokfail').html(msn);

                    }

                },
                error: function (responseerr) {
                    $('#spnConfirmar').removeClass('fa fa-circle-o-notch fa-spin');
                    $('#spnConfirmar').addClass('glyphicon glyphicon-ok');
                    $('#btnAceptar').removeAttr('disabled');
                    LimpiarCamposPosSave();
                    LimpiarGrillaExtras();
                    //alert(1111);
                    $('#lblCargando').css({ display: 'none' });
                    var msnerror;
                    msnerror = TranslateError(responseerr.responseJSON.codResul, mNombreEmpresa, mimporteItem)
                    $('#lblresultokfail').css({ display: 'block' });
                    $('#lblresultokfail').html(msnerror);
                },
                complete: function () {

                },
            });
        }

        function BuscarEmpresas(pEmpresa) {

            $("#txtCodBarra").val("");
            $("#idMod").val(0);
            $("#txtMonto").val(0);
            $("#cboModalidad").val("");
            $('#lblMensajeEmpresa').css({ display: 'none' });
            $('#lblresultokfail').css({ display: 'none' });
            $('#lblfailAgregar').css({ display: 'none' });
            $('#lblfailEmpresa').css({ display: 'none' });
            $('#lblresultokfail').css({ display: 'none' });
            $('#tablafacturasCSF').css({ display: 'none' });


            var SendObjLote = {
                "codPuesto": $("#codPuesto").val(),
                "codEmpresa": pEmpresa
            }

            stringData = JSON.stringify(SendObjLote);
            //console.log(mUrl);
            $.ajax({
                type: "POST",
                url: "../Servicios/Servicios.asmx/GetEmpresas",
                data: "{'pObj':" + stringData + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //console.log("empresa");
                    //console.log(response);
                    //console.log("empresa");

                    if (response.d.codResul == "0") {
                        var models = (typeof response.d.empresas) == "string" ? eval("(" + response.d.empresas + ")") : response.d.empresas;

                        $('#lblMensajeEmpresa').css({ display: 'block' });
                        $('#lblMensajeEmpresa').html(response.d.descResul);

                        $("#cboEmpresa").get(0).options.length = 0;


                        for (var i = 0; i < models.length; i++) {

                            var val = models[i].codEmp;


                            var text = models[i].descEmp;

                            $("#cboEmpresa").get(0).options[$("#cboEmpresa").get(0).options.length] = new Option(text, val);

                            var textCod = models[i].codEmp;
                            $("#txtCodEmpresa").val(val);
                            $("#txtDescEmpresa").val("");

                        }
                        $("#cboModalidad").get(0).options.length = 0;
                        $("#cbofPago").get(0).options.length = 0;
                        var models = (typeof response.d.empresas["0"].modalidades) == "string" ? eval("(" + response.d.empresas["0"].modalidades + ")") : response.d.empresas["0"].modalidades;


                        for (var i = 0; i < models.length; i++) {

                            var val = models[i].idMod;

                            var tipoCob = models[i].tipoCobranza;
                            var text = models[i].descMod;

                            $("#cboModalidad").get(0).options[$("#cboModalidad").get(0).options.length] = new Option(text, val + "|" + tipoCob);
                            //$("#cboModalidad").attr("tipoCobranza", models[i].tipoCobranza)

                        }

                        AgregarCamposAdicionales();
                        $("#cbofPago").get(0).options[$("#cbofPago").get(0).options.length] = new Option("PESOS", "PES");
                        //var models = (typeof response.empresas["0"].formasPago) == "string" ? eval("(" + response.empresas["0"].formasPago + ")") : response.empresas["0"].formasPago;

                        //for (var i = 0; i < models.length; i++) {

                        //    var val = models[i].codFP;


                        //    var text = models[i].descFP;

                        //    $("#cbofPago").get(0).options[$("#cbofPago").get(0).options.length] = new Option(text, val);


                        //}

                    }
                    else {

                        if (response.d.codResul == "28") {
                            $('#lblfailEmpresa').css({ display: 'block' });
                            $('#lblfailEmpresa').html("Empresa no valida o inexistente");
                            return;
                        }
                        //{"codPuesto":997120,"empresas":[],"codResul":120,"descResul":"No se ha ingresado el Id de transacción anterior, el puesto tiene una transacción pendiente a confirmar."}
                        $('#lblfailEmpresa').css({ display: 'block' });
                        $('#lblfailEmpresa').html(response.d.descResul);
                        return;

                    }




                },

                error: function (jqXHR, textStatus, errorThrown) {
                    //{"codPuesto":997120,"empresas":[],"codResul":120,"descResul":"No se ha ingresado el Id de transacción anterior, el puesto tiene una transacción pendiente a confirmar."}
                },

            });

        }

        function CargarDatosEmpresas(pEmpresa) {

            $("#txtCodBarra").val("");
            $("#idMod").val(0);
            $("#txtMonto").val(0);
            $("#cboModalidad").val("");
            $('#txtMonto').css({ display: 'block' });
            $('#lblMonto').css({ display: 'block' });
            $("#btnAgregar").html('Agregar');

            var SendObjLote = {
                "codPuesto": $("#codPuesto").val(),
                "codEmpresa": pEmpresa
            }

            stringData = JSON.stringify(SendObjLote);
            //console.log(mUrl);
            $.ajax({
                type: "POST",
                url: "../Servicios/Servicios.asmx/GetEmpresas",
                data: "{'pObj':" + stringData + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#cboModalidad").get(0).options.length = 0;
                    $("#cbofPago").get(0).options.length = 0;
                    var models = (typeof response.d.empresas["0"].modalidades) == "string" ? eval("(" + response.d.empresas["0"].modalidades + ")") : response.d.empresas["0"].modalidades;

                    for (var i = 0; i < models.length; i++) {

                        var val = models[i].idMod;

                        var tipoCob = models[i].tipoCobranza;
                        var text = models[i].descMod;

                        $("#cboModalidad").get(0).options[$("#cboModalidad").get(0).options.length] = new Option(text, val + "|" + tipoCob);


                    }

                    $("#cbofPago").get(0).options[$("#cbofPago").get(0).options.length] = new Option("PESOS", "PES");
                    //var models = (typeof response.empresas["0"].formasPago) == "string" ? eval("(" + response.empresas["0"].formasPago + ")") : response.empresas["0"].formasPago;

                    //for (var i = 0; i < models.length; i++) {

                    //    var val = models[i].codFP;


                    //    var text = models[i].descFP;

                    //    $("#cbofPago").get(0).options[$("#cbofPago").get(0).options.length] = new Option(text, val);


                    //}
                },

                error: function (jqXHR, textStatus, errorThrown) {

                },

            });
        }


        $(document).ready(function () {


            $('input[type="number"]').on('keyup', function () {
                if ($(this).val() > $(this).attr('max') * 1) {
                    $('#lblresultokfail').css({ display: 'block' });
                    $('#lblresultokfail').html("El monto ingresado no puede superar el max. para la empresa seleccionada $" + $(this).attr('max'));
                    $(this).val(0);
                    return;
                }
                else {
                    $('#lblresultokfail').css({ display: 'none' });
                    $('#lblresultokfail').html("");

                    return;
                }
                if ($(this).val() < $(this).attr('min')) {
                    $('#lblresultokfail').css({ display: 'block' });
                    $('#lblresultokfail').html("El monto ingresado no puede ser inferior al establecido por la empresa $" + $(this).attr('min'));
                    $(this).val(0);
                    return;
                }
                else {
                    $('#lblresultokfail').css({ display: 'none' });
                    $('#lblresultokfail').html("");
                    return;
                }
            });

            $("#btnCalcular").click(function () {
                CalcularTotal();
            });


            $("#btnEliminar").click(function () {
                eliminaFilas();

            });
            $("#btnAgregar").click(function () {
                $('#lblresultokfail').css({ display: 'none' });
                $('#lblfailAgregar').css({ display: 'none' });
                //if ($("#ItemAdicional0").val() != "") {
                //    if ($("#" + $("#ItemAdicional0").val()).val() == "") {
                //        $('#lblresultokfail').css({ display: 'block' });
                //        $('#lblresultokfail').html("Debe ingresar el valor 1 solicitado");
                //        return;
                //    }
                //}
                //if ($("#ItemAdicional1").val() != "") {
                //    if ($("#" + $("#ItemAdicional1").val()).val() == "") {
                //        $('#lblresultokfail').css({ display: 'block' });
                //        $('#lblresultokfail').html("Debe ingresar el valor 2 solicitado");
                //        return;
                //    }
                //}
                //if ($("#ItemAdicional2").val() != "") {
                //    if ($("#" + $("#ItemAdicional2").val()).val() == "") {
                //        $('#lblresultokfail').css({ display: 'block' });
                //        $('#lblresultokfail').html("Debe ingresar el valor 3 solicitado");
                //        return;
                //    }
                //}
                AgregarFact();
                eliminarCamposAdicionales();

                $('#dvdGetEmpresa').css({ display: 'block' });

            });
            $("#btnAceptar").click(function () {
                $('#spnConfirmar').removeClass('glyphicon glyphicon-ok');
                $('#spnConfirmar').addClass('fa fa-circle-o-notch fa-spin');
                $('#btnAceptar').attr('disabled', 'disabled');
                // buscarFechaFactura
                eliminarCamposAdicionales();
                PagarFactura();

            });
            $("#btnCalcularVuelto").click(function () {

                var mTotal = 0;

                mTotal = $("#txtDineroRecibido").val() - $("#txtTotal").val();

                mTotal = round(mTotal);
                $("#txtVuelto").val(mTotal);

            });

            $("#btnConsultarUltTransaccion").click(function () {

                $.ajax({
                    type: "GET",
                    url: "http://200.123.144.198/fase2/transaccion/ultima?codPuesto=" + $("#codPuesto").val(),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function (response) {
                        $('#lblCargando').css({ display: 'block' });
                        $('#lblCargando').html('Buscando Ultimo pago...');
                    },
                    success: function (response) {
                        $('#lblCargando').css({ display: 'none' });
                        $('#lblresultok').css({ display: 'block' });
                        $('#lblresultok').html('Pago Encontrado con  exito.');
                        console.log("response");
                        console.log(response);
                        console.log("response");
                    },
                    error: function (Msn) {

                        $('#lblCargando').css({ display: 'none' });
                        $('#lblresultokfail').css({ display: 'block' });
                        $('#lblresultokfail').html(Msn.responseJSON.descResul);
                        console.log(Msn)
                    },

                });

            });
            $("#btnConfirmar").click(function () {


                var SendObjLoteConf = {
                    "codPuesto": $("#codPuesto").val(),
                    "idTrxAnterior": $("#txtCodBarra").val()
                }
                var strConfirmacion;

                strConfirmacion = JSON.stringify(SendObjLoteConf);
                $.ajax({
                    type: "POST",
                    url: "http://200.123.144.198/fase2/transaccion/confirmar/ ",
                    data: strConfirmacion,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function (response) {
                        $('#lblCargando').css({ display: 'block' });
                        $('#lblCargando').html('Confirmando pago...');
                    },
                    success: function (response) {
                        $('#lblCargando').css({ display: 'none' });
                        $('#lblresultok').css({ display: 'block' });
                        $('#lblresultok').html('Pago Confirmado con  exito.');
                        console.log("responseConfirmacion");
                        console.log(response);
                        console.log("responseConfirmacion");


                    },
                    error: function (Msn) {

                        $('#lblCargando').css({ display: 'none' });
                        $('#lblresultokfail').css({ display: 'block' });
                        $('#lblresultokfail').html(Msn.responseJSON.descResul);
                    },

                });

            });


            $("#cboModalidad").focusout(function () {
                eliminarCamposAdicionales();
                AgregarCamposAdicionales();

            });

            $("#cboModalidad").change(function () {
                eliminarCamposAdicionales();
                AgregarCamposAdicionales();
                var mTipoCobranza = $('#cboModalidad :selected').val().split("|")[1];

                if (mTipoCobranza == "CSF" || mTipoCobranza == "SFM") {
                    $("#btnAgregar").html('Buscar Facturas');
                    //$('#txtMonto').css({ display: 'none' });
                    //$('#lblMonto').css({ display: 'none' });
                }
                else {
                    $("#btnAgregar").html('Agregar');
                    $('#txtMonto').css({ display: 'block' });
                    $('#lblMonto').css({ display: 'block' });
                }

                if (mTipoCobranza == "CEI") {

                }

            });


            $('#cboEmpresa').change(function () {
                eliminarCamposAdicionales();
                //AgregarCamposAdicionales();
                $('#txtCodEmpresa').val($('#cboEmpresa option:selected').val());

                if ($("#txtCodBarra").val() == "") {

                    //alert($('#cboEmpresa option:selected').text());
                    CargarDatosEmpresas($('#cboEmpresa option:selected').text());

                }
                else {
                    CargarDatosFactura();
                }


            });



            $("#btnBuscarEmpresa").click(function () {
                //if ($("#txtDescEmpresa").val().length < 3) {
                //    $('#lblresultokfail').css({ display: 'block' });
                //    $('#lblresultokfail').html("Error: para buscar debe ingresar al menos 3 digitos");

                //    return;
                //}

                $('#lblfailAgregar').css({ display: 'none' });
                $('#lblresultokfail').css({ display: 'none' });
                BuscarEmpresas($("#txtDescEmpresa").val());

            });


        });



    </script>

</asp:Content>


