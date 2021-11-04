<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="ConsultaVentasRedBusElectronico.aspx.vb"
    Inherits="ConsultaVentasRedBusElectronico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="subpres">
        <%--  <a href="http://www.cargaplus.com.ar/accesorios_plus.html#"  target="_blank">
            <div class="BtnAuxiliarcelulartecnologia">

                <img class="imgcssgrande" src="../Img/boton_moto_01.png" />
            </div>
        </a>
        <a href="http://www.cargaplus.com.ar/factura_plus.html#" target="_blank">
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
    <div class="jumbotron" style="position: relative;">
        <h2>Consulta de Ventas</h2>
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


        <div class="container">
            <div class="form-group">

                <div class="input-group">
                    <span class="input-group-addon">Fecha</span>
                    <input type="date" value="" runat="server" class="form-control" clientidmode="Static" id="txtFecha" />


                </div>
                <br />
                <div class="input-group">
                    <span class="input-group-addon">Fecha Hasta</span>
                    <input type="date" value="" min="2018-01-01" runat="server" class="form-control" clientidmode="Static" id="txtFechaHasta" />

                </div>
                <br />
                <div class="input-group">
                    <span class="input-group-addon">Destino</span>
                    <input type="text" maxlength="18" runat="server" class="form-control" clientidmode="Static" id="txtDestino" />

                </div>
                <br />
                <div class="input-group">
                    <span>Usuario Activo</span>
                    <input type="checkbox" runat="server" style="height: 30px;" class="form-control" clientidmode="Static" id="chkUsrActivo" />
                </div>

                <asp:HiddenField ClientIDMode="Static" ID="User" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="Pass" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="MontoVentas" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="AptoCredito" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="NombreAgencia" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="DireccionAgencia" runat="server" />
                <br />
                <div class="form-group">
                    <div class="input-group">
                        <button type="button" runat="server" id="btnIngresar" clientidmode="Static" class="btn btn-primary">Buscar</button>

                    </div>
                </div>
                
                <div class="table-responsive">
                    
                    <table clientidmode="Static" id="tablaVentas" class="table">
                        <thead>
                            <tr id="fila0" class="info">
                                <th>#</th>
                                <th>Fecha</th>
                                <th>Producto</th>
                                <th>Destino</th>
                                <th>Monto</th>
                                <th>IdTransaccion</th>
                                <th>Usuario</th>
                                <th>Respuesta</th>
                                <th>Estado</th>
                                <th>Ref. Operador</th>
                                <th>Imprimir</th>
                            </tr>
                        </thead>

                    </table>
                </div>

                
                <div class="form-group">
                    <div class="input-group">

                        <button type="button" id="btnTotalUsuario" style="font-size: unset" class="btn btn-success">Ventas OK</button>
                        <button type="button" id="btnCantidadVentas" style="font-size: unset" class="btn btn-info">Cant Vta OK</button>
                    </div>
                </div>

            </div>
        </div>
        <label id="lblCargando" class="alert alert-info" style="display: none" clientidmode="Static" runat="server"></label>
        <label id="lblresultokfail" class="alert alert-danger" style="display: none" clientidmode="Static" runat="server"></label>
        <label id="lblresultok" class="alert alert-success" style="display: none" clientidmode="Static" runat="server"></label>
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


        function GetDate() {

            var fecha = new Date(); //Fecha actual
            var mes = fecha.getMonth() + 1; //obteniendo mes
            var dia = fecha.getDate(); //obteniendo dia
            var ano = fecha.getFullYear(); //obteniendo año
            if (dia < 10)
                dia = '0' + dia; //agrega cero si el menor de 10
            if (mes < 10)
                mes = '0' + mes //agrega cero si el menor de 10



            document.getElementById('txtFecha').value = ano + "-" + mes + "-" + dia;
            document.getElementById('txtFechaHasta').value = ano + "-" + mes + "-" + dia;
        }


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

        function eliminaFilas() {

            var n = 1;
            $("#tablaVentas tbody tr").each(function () {
                $("#fila" + n).remove();
                n++;
            });

            var nn = 1;
            $("#tablaVentasResumidas tbody tr").each(function () {
                $("#filaRes" + nn).remove();
                nn++;
            });

            //BORRA LAS n-1 FILAS VISIBLES DE LA TABLA
            //LAS BORRA DE LA ULTIMA FILA HASTA LA SEGUNDA
            //DEJANDO LA PRIMERA FILA VISIBLE, MÁS LA FILA PLANTILLA OCULTA
            //for (i = 0; i > n; i++) {
            //    $("#tablaVentas tbody tr:eq('" + i + "')").remove();
            //};
        };

        function isValidDate(dateString) {
            // revisar el patrón
            //if (!/^\d{2}\-\d{1,2}\-\d{1,4}$/.test(dateString))
            //    return false;


            //    alert(111);
            // convertir los numeros a enteros
            var parts = dateString.split("/");
            var day = parseInt(parts[0], 10);
            var month = parseInt(parts[1], 10);
            var year = parseInt(parts[2], 10);

            // Revisar los rangos de año y mes
            if ((year < 1000) || (year > 3000) || (month == 0) || (month > 12))
                return false;

            var monthLength = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

            // Ajustar para los años bisiestos
            if (year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
                monthLength[1] = 29;

            // Revisar el rango del dia
            return day > 0 && day <= monthLength[month - 1];
        };

        function PrintSale(ctl) {
            var _row = null;

            _row = $(ctl).parents("tr");
            var cols = _row.children("td");
            console.log(cols);
            var mMsn;
            if (cols[7].innerText == "OK") {
                mMsn = "La Venta se realizo con exito";
            }
            else {
                mMsn = "Error";
            }
            var SendObj = {
                "User": $("#User").val(),
                "Pass": $("#Pass").val(),
                "IdVenta": cols[9].innerText
            }

            var stringData = JSON.stringify(SendObj);
            $.ajax({
                type: "POST",
                url: "../Servicios/Servicios.asmx/GetEstadoVentasRedbus",
                data: "{'pObj':" + stringData + "}",
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                dataType: "json",

                beforeSend: function (response) {
                    $('#lblCargando').css({ display: 'block' });
                    $('#lblCargando').html('Procesando...');

                },
                success: function (response) {
                    console.log(response);
                    $('#btnIngresar').attr('disabled', false);

                    //{ "d": { "__type": "Servicios+RespuestaRedBus", "Estado": "True", "id": "443932", "proveedor": "700", "fechaImpacta": "00:00:00", "fechaRecarga": "18/11/2020 14:00:00", "estadoRecarga": "Pendiente", "Mensaje": "Venta Encontrada" } }

                    var mTextoTicket;
                    mTextoTicket = $("#NombreAgencia").val() + "|" + $("#DireccionAgencia").val() + "|" + response.d.estadoRecarga + "|" + response.d.fechaImpacta + "|" + response.d.fechaRecarga + "|" + response.d.proveedor + "|" + mMsn + "|" + response.d.id + "|" + response.d.importe
                    //mTextoTicket = "Eldar|San Martin 1074 22|162239039-2059615634|057000864019732099|100|Ok|La Venta se realizo con exito|Directv"
                    var url = "http://ventas.cargaplus.com.ar/mailtemplates/MostrarImpresionTicketRedbus.aspx?Div=" + mTextoTicket; //+ "|" + cols[2].innerText + "|" + cols[1].innerText;
                    window.open(url, "_blank", "toolbar=no,menubar=no, width=350, height=500, scrollbars=no, resizable=no,location=no, directories=no, status=no");
                    window.close();

                }
            });

          
            
        }

        $(document).ready(function () {

            //$("#txtFecha").focusout(function () {
            //    s = $(this).val();
            //    var bits = s.split('/');
            //    var d = new Date(bits[0] + '/' + bits[1] + '/' + bits[2]);
            //    // alert(d);
            //});
            ActualizarSaldos();

            GetDate();



            $("#btnIngresar").click(function () {

                eliminaFilas();
                //if (!isValidDate($("#txtFecha").val())) {
                //    $("#lblCargando").css("display", "none");
                //    $("#lblresultokfail").css("display", "block");
                //    $("#lblresultokfail").html("Ingrese Fecha Valida");

                //    return;
                //}
                $("#lblresultokfail").css("display", "none");
                $("#lblresultokfail").html("");
                $('#btnIngresar').attr('disabled', true);

                var SendObj = {

                    "Fecha": $("#txtFecha").val(),
                    "FechaHasta": $("#txtFechaHasta").val(),
                    "User": $("#User").val(),
                    "Pass": $("#Pass").val(),
                    "Destino": $("#txtDestino").val()//,
                    //"UsuarioActivo": $("#chkUsrActivo").val()

                }

                var stringData = JSON.stringify(SendObj);
              
            $.ajax({
                type: "POST",
                url: "../Servicios/Servicios.asmx/GetVentasRedbus",
                data: "{'pObj':" + stringData + "}",
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                dataType: "json",

                beforeSend: function (response) {
                    $('#lblCargando').css({ display: 'block' });
                    $('#lblCargando').html('Procesando...');

                },
                success: function (response) {
                    console.log(response);
                    $('#btnIngresar').attr('disabled', false);

                    ActualizarSaldos();

                    $('#lblCargando').css({ display: 'none' });
                    //if (response.codError == 200) {

                    if (response.d[0].Mensaje == "]") {

                        $("#lblCargando").css("display", "none");
                        $("#lblresultokfail").css("display", "block");
                        $("#lblresultokfail").html("No existen Registros para la Fecha indicada");
                        return;
                    } else {
                        var models = JSON.parse(response.d[0].Mensaje);
                    }

                    // $("#btnTotalUsuario").css("display", "none");
                    var mNombre;
                    var mEstado;
                    var mMonto;
                    var mClase = "";
                    var aaa = 0;
                    var TotalVentasUsuario = 0;
                    var CantidadVentas = 0;
                   
                    for (var i = 0; i < models.length; i++) {
                        if ($('#chkUsrActivo').is(":checked")) {
                            // $("#btnTotalUsuario").css("display", "block");
                            if (models[i].Usuario == $("#User").val()) {


                                mNombre = "fila" + (aaa + 1);
                                if (mClase == "") {
                                    mClase = "success";
                                }
                                else {
                                    mClase = "";
                                }
                                try {
                                    //alert(models[i].Monto);
                                    mMonto = models[i].Monto.toFixed(2);
                                } catch (e) {
                                    mMonto = models[i].Monto;
                                }
                                if (models[i].Estado == "2") {
                                    mEstado = "OK";
                                    TotalVentasUsuario = TotalVentasUsuario + parseInt(mMonto);
                                    CantidadVentas = CantidadVentas + 1;
                                }
                                else if (models[i].Estado == "4") {
                                    mEstado = "ANULADA";
                                } else {
                                    mEstado = "ERROR";
                                }

                                mMonto = mMonto.replace(",", ".");
                                mMonto = dosDecimales(mMonto);
                                $("#tablaVentas").append("<tr id=" + mNombre + " class='" + mClase + "'>" +
                                    "<td> " + (aaa + 1) + "</td > " +
                                    "<td> " + models[i].Fecha + "</td > " +
                                    "<td> " + models[i].Producto + "</td >" +
                                    "<td> " + models[i].Destino + "</td >" +
                                    "<td> " + mMonto + "</td >" +
                                    "<td> " + models[i].IdTransaccion + "</td >" +
                                    "<td> " + models[i].Usuario + "</td >" +
                                    "<td> " + models[i].Respuesta + "</td >" +
                                    "<td> " + mEstado + "</td >" +
                                    "<td> " + models[i].IDVenta + "</td >" +
                                    "<td style='width: 34px; height: 33px;'>" +
                                    "<button type='button' " +
                                    "onclick='PrintSale(this);' " +
                                    "class='btn btn-outline-light'>" +
                                    "</button>" +
                                    "</td>" +
                                    "</tr > ");

                                aaa = aaa + 1;
                            }

                        }
                        else {

                            mNombre = "fila" + (i + 1);
                            if (mClase == "") {
                                mClase = "success";
                            }
                            else {
                                mClase = "";
                            }
                            try {
                                //alert(models[i].Monto);
                                mMonto = models[i].Monto.toFixed(2);
                            } catch (e) {
                                mMonto = models[i].Monto;
                            }

                            if (models[i].Estado == "2") {
                                mEstado = "OK";
                                TotalVentasUsuario = TotalVentasUsuario + parseInt(mMonto);
                                CantidadVentas = CantidadVentas + 1;
                            }
                            else if (models[i].Estado == "4") {
                                mEstado = "ANULADA";
                            } else {
                                mEstado = "ERROR";

                            }


                            try {
                                //alert(models[i].Monto);
                                mMonto = models[i].Monto;
                            } catch (e) {
                                mMonto = models[i].Monto;
                            }
                            mMonto = mMonto.replace(",", ".");
                            mMonto = dosDecimales(mMonto);

                            $("#tablaVentas").append("<tr id=" + mNombre + " class='" + mClase + "'>" +
                                "<td> " + (i + 1) + "</td > " +
                                "<td> " + models[i].Fecha + "</td > " +
                                "<td> " + models[i].Producto + "</td >" +
                                "<td> " + models[i].Destino + "</td >" +
                                "<td> " + mMonto + "</td >" +
                                "<td> " + models[i].IdTransaccion + "</td >" +
                                "<td> " + models[i].Usuario + "</td >" +
                                "<td> " + models[i].Respuesta + "</td >" +
                                "<td> " + mEstado + "</td >" +
                                "<td> " + models[i].IDVenta + "</td >" +
                                "<td style='width: 34px; height: 33px;'>" +
                                "<button style='width: 34px; height: 33px;' class='glyphicon glyphicon-print' type='button' " +
                                "onclick='PrintSale(this);' " +
                                "class='btn btn-outline-light'>" +
                                "</button>" +
                                "</td>" +
                                "</tr > ");
                        }
                    }
                    $("#lblresultok").css("display", "none");
                    $("#lblresultokfail").css("display", "none");
                    $("#btnTotalUsuario").html("Ventas OK $" + TotalVentasUsuario);
                    $("#btnCantidadVentas").html("Cant. Ventas OK " + CantidadVentas);

                },

                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                    console.log(errorThrown);
                    $("#lblCargando").css("display", "none");
                    $("#lblresultokfail").css("display", "block");
                    $("#lblresultokfail").html("Error al consultar los registros");
                },

            });
        });


        });

        function dosDecimales(n) {
            let t = n.toString();
            let regex = /(\d*.\d{0,2})/;
            return t.match(regex)[0];
        }

    </script>

</asp:Content>


