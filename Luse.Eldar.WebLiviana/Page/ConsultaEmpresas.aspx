<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="ConsultaEmpresas.aspx.vb"
    Inherits="Page_ConsultaEmpresas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron" style="position: relative;">
        <h2>Consulta de Empresas</h2>

        <div class="container">
            <div class="form-group">

                <div class="input-group">
                    <span class="input-group-addon">Cod Empresa</span>
                    <input type="number" value="" runat="server" class="form-control" clientidmode="Static" id="txtCodEmpresa" />


                </div>
                <br />
                <div class="input-group">
                    <span class="input-group-addon">Nombre Empresa</span>
                    <input type="text" maxlength="18" runat="server" class="form-control" clientidmode="Static" id="txtNombreEmpresa" />

                </div>
                <br />


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
                                <th>Cod Empresa</th>
                                <th>Nombre Empresa</th>
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


        function eliminaFilas() {

            var n = 1;
            $("#tablaVentas tbody tr").each(function () {
                $("#fila" + n).remove();
                //document.getElementById("tablaVentas").deleteRow(n);
                n++;
                //alert(1);
            });


        };

        $(document).ready(function () {

            $("#btnIngresar").click(function () {

                eliminaFilas();

                $("#lblresultokfail").css("display", "none");
                $("#lblresultokfail").html("");
                $('#btnIngresar').attr('disabled', true);

                var SendObj = {

                    "CodEmpresa": $("#txtCodEmpresa").val(),
                    "NombreEmpresa": $("#txtNombreEmpresa").val(),
                    "User": $("#User").val(),
                    "Pass": $("#Pass").val()

                }

                var stringData = JSON.stringify(SendObj);
                $.ajax({
                    type: "POST",
                    url: "../Servicios/Servicios.asmx/GetEmpresasListado",
                    data: "{'pObj':" + stringData + "}",
                    contentType: "application/json; charset=utf-8",
                    crossDomain: true,
                    dataType: "json",
                    beforeSend: function (response) {
                        $('#lblCargando').css({ display: 'block' });
                        $('#lblCargando').html('Procesando...');

                    },
                    success: function (response) {

                        var mNombre;
                        var mClase = "";
                        var aaa = 0;
                        var models = "";

                        if (response.d[0].Mensaje == "]") {

                            $("#lblCargando").css("display", "none");
                            $("#lblresultokfail").css("display", "block");
                            $("#lblresultokfail").html("No existen para la BUSQUEDA indicada");
                            $('#btnIngresar').attr('disabled', false);
                            return;
                        } else {
                            models = JSON.parse(response.d[0].Mensaje);
                        }
                        console.log(models);
                        for (var i = 0; i < models.length; i++) {


                            mNombre = "fila" + (aaa + 1);
                            if (mClase == "") {
                                mClase = "success";
                            }
                            else {
                                mClase = "";
                            }

                            $("#tablaVentas").append("<tr id=" + mNombre + " class='" + mClase + "'>" +
                                "<td> " + (i + 1) + "</td > " +
                                "<td> " + models[i].CodEmpresa + "</td > " +
                                "<td> " + models[i].NombreEmpresa + "</td >" +
                                "</tr > ");

                            aaa = aaa + 1;
                        }

                        $('#btnIngresar').attr('disabled', false);
                        $("#lblCargando").css("display", "none");
                        $("#lblresultokfail").css("display", "none");
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $("#lblCargando").css("display", "none");
                        $("#lblresultokfail").css("display", "block");
                        $("#lblresultokfail").html("Error al consultar los registros");
                        $('#btnIngresar').attr('disabled', false);
                    },

                });
            });
        });

    </script>

</asp:Content>


