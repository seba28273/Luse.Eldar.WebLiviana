<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="ConsultaOC.aspx.vb" Inherits="Page_ConsultaOC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <h3>Consulta de Informes de Ordenes Comerciales</h3>
        <div class="container">
            <div>
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon">Nro Comercio:</span>
                        <input type="text" runat="server" clientidmode="Static" class="form-control" id="txtNroComercio" />
                        <asp:HiddenField ClientIDMode="Static" ID="User" runat="server" />
                    <asp:HiddenField ClientIDMode="Static" ID="Pass" runat="server" />
                         
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon">Fecha</span>
                        <input type="date" runat="server" class="form-control" clientidmode="Static" id="txtFecha" />
                        <div class="input-group-btn">
                            <button class="btn btn-default" type="button" clientidmode="Static" onclick="CargarOC();" runat="server" id="btnBuscar">
                                <i class="glyphicon glyphicon-search"></i>
                            </button>
                        </div>

                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <h2>Lotes Pendientes</h2>
                        <table clientidmode="Static" id="tablaMuestraOC" class="table">
                            <thead>
                                <tr id="fila0" class="info">
                                    <th>Nro. Comercio</th>
                                    <th>Fecha</th>
                                    <th>Nro. Orden Comercial</th>
                                    <th>Monto</th>
                                    <th>Lotes</th>
                                    <th>Usuario</th>
                                    <th>NroRecibo</th>
                                </tr>
                            </thead>

                        </table>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon">Total OC:</span>
                        <input type="text" runat="server" disabled="disabled" 
                            clientidmode="Static" class="form-control" id="txtTotalOC" />
                      

                    </div>
                </div>
            </div>
        </div>
        <label id="lblCargando" class="alert alert-info" style="display: none" clientidmode="Static" runat="server"></label>

    </div>
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>


    <script lang="javascript">
        function eliminaFilas() {
          
            var n = 1;
            $("#tablaMuestraOC tbody tr").each(function () {
                $("#fila" + n).remove();
                n++;
            });
           
        };

        function CargarOC() {
            
            var SendObj = {

                "NroComercio": $("#txtNroComercio").val(),
                "User": $("#User").val(),
                "Pass": $("#Pass").val(),
                "Fecha": $("#txtFecha").val()

            }

            var stringData = JSON.stringify(SendObj);
            
            $.ajax({

                type: "POST",
                url: "services/Empresas",
                data: "{'pObj':" + stringData + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                beforeSend: function (response) {
                    $('#lblCargando').css({ display: 'block' });
                    $('#lblCargando').html('Procesando...');

                },


                success: function (response) {
                    console.log(response);

                    eliminaFilas();

                    $('#lblCargando').css({ display: 'none' });

                   
                    var models = JSON.parse(response.d[0].Mensaje);
                 
                    var mNombre;
                    var mMonto=0;
                    var mClase = "";
                    for (var i = 0; i < models.length; i++) {

                        mNombre = "fila" + (i + 1);
                        if (mClase == "") {
                            mClase = "success";
                        }
                        else {
                            mClase = "";
                        }
                        //Para sumar debo pasar la , a . porque sino java no me lo toma como decimal
                        var res = (models[i].Monto).replace(",", ".");
                      
                        mMonto = mMonto + parseFloat(res);
                        
                        $("#tablaMuestraOC").append("<tr id=" + mNombre + " class='" + mClase + "'>" +
                            "<td> " + models[i].NroComercio + "</td > " +
                            "<td> " + models[i].Fecha + "</td > " +
                            "<td> " + models[i].NroOrdenComercial + "</td >" +
                            "<td> " + models[i].Monto + "</td >" +
                            "<td> " + models[i].Lotes + "</td >" +
                            "<td> " + models[i].Usuario + "</td >" +
                            "<td> " + models[i].NroRecibo + "</td >" +
                            "</tr > ");

                        
                    }

                    $("#txtTotalOC").val(mMonto);

                },

                error: function (jqXHR, textStatus, errorThrown) {
                    alert("se detecto un error al intentar consultar las Ordenes Comerciales");
                },

            });
        }

        $(document).ready(function () {
            CargarOC();
        });

    </script>
</asp:Content>


