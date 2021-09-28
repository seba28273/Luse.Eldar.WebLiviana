<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Ultimos10Turnos.aspx.vb" Inherits="Ultimos10Turnos" %>

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
        <a href="https://www.cargaplus.com.ar/sube.html"  target="_blank">
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
        <h2>Ultimos 10 Turnos</h2>
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

                <asp:HiddenField ClientIDMode="Static" ID="User" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="Pass" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="MontoVentas" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="AptoCredito" runat="server" />
                <br />
                <div class="form-group">
                    <div class="input-group">
                        <button type="button" runat="server" id="btnLastTenTurns" clientidmode="Static" class="btn btn-primary">Buscar</button>
                    </div>
                </div>

                <div class="table-responsive">

                    <table clientidmode="Static" id="tablaTurnos" class="table">
                        <thead>
                            <tr id="fila0" class="info">
                                <th>#</th>
                                <th>Cerrado</th>
                                <th>Fecha Apertura</th>
                                <th>Fecha Cierre</th>
                                <th>Acceso Apert.</th>
                                <th>Acceso Cierre</th>
                                <th>Stk. Inicial</th>
                                <th>Stk. Fin</th>
                                <th>Cant Vta. Ok</th>
                                <th>Tot Vta. Ok</th>
                                <th>Tot Asig. Stk.</th>
                                <th>Otros +</th>
                                <th>Otros -</th>

                            </tr>
                        </thead>

                    </table>
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


        $("#btnLastTenTurns").click(function () {
            $('#btnLastTenTurns').attr('disabled', true);

            var SendObj = {

                "User": $("#User").val(),
                "Pass": $("#Pass").val()
            }
            var stringData = JSON.stringify(SendObj);
            $.ajax({
                type: "POST",
                url: "../Servicios/Servicios.asmx/LastTenTurns",
                data: "{'pObj':" + stringData + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                beforeSend: function (response) {
                    $('#lblCargando').css({ display: 'block' });
                    $('#lblCargando').html('Abriendo Turno...');
                },
                success: function (response) {

                    console.log(response);
                    $('#btnLastTenTurns').attr('disabled', false);

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
                    var mEstado;
                    var mMonto;
                    var mClase = "";

                    for (var i = 0; i < models.length; i++) {

                        // alert(models[i].Cerrado);

                        mNombre = "fila" + (i + 1);
                        if (mClase == "") {
                            mClase = "success";
                        }
                        else {
                            mClase = "";
                        }
                        if (models[i].Cerrado == "1") {
                            mEstado = "SI";
                        } else {
                            mEstado = "NO";
                        }


                        try {

                            mMonto = models[i].Monto.split(',')[0];
                        } catch (e) {
                            mMonto = models[i].Monto;
                        }


                        $("#tablaTurnos").append("<tr id=" + mNombre + " class='" + mClase + "'>" +
                            "<td> " + (i + 1) + "</td > " +
                            "<td> " + models[i].Cerrado + "</td > " +
                            "<td> " + models[i].FechaApertura + "</td > " +
                            "<td> " + models[i].FechaCierre + "</td >" +
                            "<td> " + models[i].AccesoApertura + "</td >" +
                            "<td> " + models[i].AccesoCierre + "</td >" +
                            "<td> " + models[i].StockInicial + "</td >" +
                            "<td> " + models[i].StockFinal + "</td >" +
                            "<td> " + models[i].TotalCantVtasOk + "</td >" +
                            "<td> " + models[i].TotalVentasOK + "</td >" +
                            "<td> " + models[i].TotalAsigStock + "</td >" +
                            "<td> " + models[i].OtrosPositivos + "</td >" +
                            "<td> " + models[i].OtrosNegativos + "</td >" +
                            "</tr > ");
                    }
                    //ActualizarSaldos();

                },

                error: function (jqXHR, textStatus, errorThrown) {
                    ActualizarSaldos();
                },

            });

        });

        $(document).ready(function () {

            ActaulizarSaldos();


        });
    </script>

</asp:Content>

