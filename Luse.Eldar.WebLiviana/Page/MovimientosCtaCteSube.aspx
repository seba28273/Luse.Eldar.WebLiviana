<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="MovimientosCtaCteSube.aspx.vb"
    Inherits="Page_ConsultaCtacteSube" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <%--<div class="subpres">
      <%--  <a href="http://www.cargaplus.com.ar/accesorios_plus.html#"  target="_blank">
            <div class="BtnAuxiliarcelulartecnologia">

                <img class="imgcssgrande" src="../Img/boton_moto_01.png" />
            </div>
        </a>--
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
        </a>
    </div>--%>
    <div class="jumbotron" style="position: relative;">
        <h2>Movimientos de Cta Cte Agencia Sube</h2>
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
                    <span class="input-group-addon">Fecha      </span>
                    <input type="date" value="" min="2018-01-01" runat="server" class="form-control" clientidmode="Static" id="txtFecha" />
                 
                </div>

                <asp:HiddenField ClientIDMode="Static" ID="User" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="Pass" runat="server" />
                 <asp:hiddenfield clientidmode="Static" id="MontoVentas" runat="server" />
                    <asp:hiddenfield clientidmode="Static" id="AptoCredito" runat="server" />
                <br />
                <div class="input-group">
                    <span class="input-group-addon">Fecha Hasta</span>
                    <input type="date" value="" min="2018-01-01" runat="server" class="form-control" clientidmode="Static" id="txtFechaHasta" />
                 
                </div>
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
                                <th>Descripcion</th>
                                <th>Monto</th>
                                <th>Saldo</th>
                            </tr>
                        </thead>

                    </table>
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
        function eliminaFilas() {

            var n = 1;
            $("#tablaVentas tbody tr").each(function () {
                $("#fila" + n).remove();
                n++;
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


        $(document).ready(function () {

            ActualizarSaldos();

            GetDate();

            $("#btnIngresar").click(function () {

            
                eliminaFilas();
                
                $("#lblresultokfail").css("display", "none");
                $("#lblresultokfail").html("");
                $('#btnIngresar').attr('disabled', true);

                var SendObj = {

                    "Fecha": $("#txtFecha").val(),
                    "FechaHasta": $("#txtFechaHasta").val(),
                    "User": $("#User").val(),
                    "Pass": $("#Pass").val()

                }

                var stringData = JSON.stringify(SendObj);

                $.ajax({
                    type: "POST",
                    url: "../Servicios/Servicios.asmx/GetMovCtaCteSube",
                    data: "{'pObj':" + stringData + "}",
                    contentType: "application/json; charset=utf-8",
                    crossDomain: true,
                    dataType: "json",

                    beforeSend: function (response) {
                        $('#lblCargando').css({ display: 'block' });
                        $('#lblCargando').html('Procesando...');

                    },

                    success: function (response) {
                        //console.log(response);
                        $('#btnIngresar').attr('disabled', false);

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


                        var mNombre;
                        var mSaldo;
                        var mMonto;
                        var mClase = "";

                        for (var i = 0; i < models.length; i++) {

                            mNombre = "fila" + (i + 1);
                            if (mClase == "") {
                                mClase = "success";
                            }
                            else {
                                mClase = "";
                            }
                            if (models[i].Estado == "2") {
                                mEstado = "OK";
                            }
                            else if (models[i].Estado == "4") {
                                mEstado = "ANULADA";
                            } else {
                                mEstado = "ERROR";
                            }

                            $("#tablaVentas").append("<tr id=" + mNombre + " class='" + mClase + "'>" +
                                "<td> " + (i + 1) + "</td > " +
                                "<td> " + models[i].Fecha + "</td > " +
                                "<td> " + models[i].Descripcion + "</td >" +
                                "<td style='text-align: right;'> $" + models[i].Monto + "</td >" +
                                "<td style='text-align: right;'> $" + models[i].Saldo + "</td >" +
                                "</tr > ");
                        }

                        $("#lblresultok").css("display", "none");
                        $("#lblresultokfail").css("display", "none");

                        
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


