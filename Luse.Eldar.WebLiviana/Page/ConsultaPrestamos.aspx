<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="ConsultaPrestamos.aspx.vb"
    Inherits="Page_ConsultaVentas" %>

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
        <h2>Consulta de Prestamos</h2>
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
                <asp:HiddenField ClientIDMode="Static" ID="NombreAgencia" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="DireccionAgencia" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="IDAgencia" runat="server" />

                   
                <br />
                <div class="form-group">
                    <div class="input-group">
                        <button type="button" runat="server" id="btnIngresar" clientidmode="Static" class="btn btn-primary">Buscar</button>

                    </div>
                </div>
                <div class="table-responsive">
                    <table clientidmode="Static" id="tablaPrestamos" class="table">
                     
                        <thead>
                            <tr id="filaRes0" class="info">
                                <th>#</th>
                                <th>NroPrestamo</th>
                                <th>Fecha Vencimiento</th>
                                <th>Cuotas</th>
                                <th>Monto</th>
                            </tr>
                        </thead>
                    </table>
                </div>
                <div class="table-responsive">

                    <table clientidmode="Static" id="tabladetalleprestamos" class="table">
                        <thead>
                            <tr id="fila0" class="info">
                                <th>Nro Cuota</th>
                                <th>Fecha Programada</th>
                                <th>Fecha Ejecucion</th>
                                <th>Reintentos</th>
                                <th>Monto Cuota</th>
                                <th>Ejecutada</th>
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

        function CargarCuotas(nroPrestamo) {
            var SendObj = {
                "User": $("#User").val(),
                "Pass": $("#Pass").val(),
                "IDPrestamo": nroPrestamo
            }

            var stringData = JSON.stringify(SendObj);

            $.ajax({
                type: "POST",
                url: "../Servicios/Servicios.asmx/GetCuotasPrestamo",
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

                    //ActualizarSaldos();

                    $('#lblCargando').css({ display: 'none' });
                    //if (response.codError == 200) {

                    if (response.d[0].Mensaje == "]") {

                        $("#lblCargando").css("display", "none");
                        $("#lblresultokfail").css("display", "block");
                        $("#lblresultokfail").html("No dispone de prestamos activos");
                        return;
                    } else {
                        var models = JSON.parse(response.d[0].Mensaje);
                    }

                    var mNombre;
                    var mEstado;
                    var mMonto;
                    var mClase = "";
                    var aaa = 0;
                    var TotalVentasUsuario = 0;
                    var CantidadVentas = 0;
                    for (var i = 0; i < models.length; i++) {


                        mNombre = "fila" + (aaa + 1);
                        if (mClase == "") {
                            mClase = "success";
                        }
                        else {
                            mClase = "";
                        }
                        try {

                            mMonto = models[i].Monto.split(',')[0];
                        } catch (e) {
                            mMonto = models[i].Monto;
                        }
                       // alert(models[i].Ejecutada);
                        if(models[i].Ejecutada == "True") {
                            mEstado = "SI";
                        } else {
                            mEstado = "NO";
                        }
                        //mRes.Append("{""NroCuota"":""" & Item("NroCuota") & """,""FechaProgramada"":""" & Item("FechaProgramada") & """,""FechaEjecucion"":""" & Item("FechaEjecucion") & """,
                        //    ""Reintentos"": """ & Item("Reintentos") & """, ""Monto"": """ & Item("Monto") & """, ""Ejecutada"": """ & Item("Ejecutada") & """}, ")

                        $("#tabladetalleprestamos").append("<tr id=" + mNombre + " class='" + mClase + "'>" +
                            "<td> " + models[i].NroCuota + "</td > " +
                            "<td> " + models[i].FechaProgramada + "</td >" +
                            "<td> " + models[i].FechaEjecucion + "</td >" +
                            "<td> " + models[i].Reintentos + "</td >" +
                            "<td> " + mMonto + "</td >" +
                            "<td> " + mEstado + "</td >" +
                           
                            "</tr > ");

                        aaa = aaa + 1;



                    }
                    $("#lblresultok").css("display", "none");
                    $("#lblresultokfail").css("display", "none");


                },

                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                    console.log(errorThrown);
                    $("#lblCargando").css("display", "none");
                    $("#lblresultokfail").css("display", "block");
                    $("#lblresultokfail").html("Error al consultar los registros");
                },

            });
        }
        function eliminaFilas() {

            var n = 1;
            $("#tablaPrestamos tbody tr").each(function () {
                $("#filaRes" + n).remove();
                n++;
            });

            var nn = 1;
            $("#tabladetalleprestamos tbody tr").each(function () {
                $("#fila" + nn).remove();
                nn++;
            });

            //BORRA LAS n-1 FILAS VISIBLES DE LA TABLA
            //LAS BORRA DE LA ULTIMA FILA HASTA LA SEGUNDA
            //DEJANDO LA PRIMERA FILA VISIBLE, MÁS LA FILA PLANTILLA OCULTA
            //for (i = 0; i > n; i++) {
            //    $("#tablaVentas tbody tr:eq('" + i + "')").remove();
            //};
        };


        function VerDetalle(ctl) {
            var _row = null;

            _row = $(ctl).parents("tr");
            var cols = _row.children("td");
            console.log(cols);

            var nn = 1;
            $("#tabladetalleprestamos tbody tr").each(function () {
                $("#fila" + nn).remove();
                nn++;
            });

            CargarCuotas(cols[1].innerText);
           
        }

        $(document).ready(function () {

          
            ActualizarSaldos();

            $("#btnIngresar").click(function () {

                eliminaFilas();
               
                $("#lblresultokfail").css("display", "none");
                $("#lblresultokfail").html("");
                $('#btnIngresar').attr('disabled', true);

                var SendObj = {
                    "User": $("#User").val(),
                    "Pass": $("#Pass").val(),
                    "IDAgencia": $("#IDAgencia").val()
                }
            
                var stringData = JSON.stringify(SendObj);
                $.ajax({
                    type: "POST",
                    url: "../Servicios/Servicios.asmx/GetPrestamos",
                    data: "{'pObj':" + stringData + "}",
                    contentType: "application/json; charset=utf-8",
                    crossDomain: true,
                    dataType: "json",
                    beforeSend: function (response) {
                        $('#lblCargando').css({ display: 'block' });
                        $('#lblCargando').html('Procesando...');

                    },
                    success: function (response) {

                        $('#btnIngresar').attr('disabled', false);
                      
                        var mNombre;
                        var mMonto;
                        var mClase = "";
                        var aaa = 0;
                        var models = JSON.parse(response.d[0].Mensaje);
                        if (models.length <1) {

                            $('#lblCargando').css({ display: 'block' });
                            $('#lblCargando').html('No existen Registros...');

                        }
                        else {
                            $('#lblCargando').css({ display: 'none' });
                        }
                        for (var i = 0; i < models.length; i++) {

                            mNombre = "filaRes" + (aaa + 1);
                            if (mClase == "") {
                                mClase = "success";
                            }
                            else {
                                mClase = "";
                            }
                            try {

                                mMonto = models[i].Monto.split(',')[0];
                            } catch (e) {
                                mMonto = models[i].Monto;
                            }
                            $("#tablaPrestamos").append("<tr id=" + mNombre + " class='" + mClase + "'>" +
                                "<td> " + (aaa + 1) + "</td > " +
                                "<td> " + models[i].NroPrestamo + "</td > " +
                                "<td> " + models[i].FechaVencimiento + "</td >" +
                                "<td> " + models[i].CuotasCobrada + "</td >" +
                                "<td> " + mMonto + "</td >" +
                                "<td style='width: 34px; height: 33px;'>" +
                                "<button type='button' " +
                                "onclick='VerDetalle(this);' " +
                                "class='btn btn-outline-light'>" +
                                "</button>" +
                                "</td>" +
                                "</tr > ");

                            aaa = aaa + 1;
                        }

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $("#lblCargando").css("display", "none");
                        $("#lblresultokfail").css("display", "block");
                        $("#lblresultokfail").html("Error al consultar los registros");
                    },

                });

            });


        });

    </script>

</asp:Content>


