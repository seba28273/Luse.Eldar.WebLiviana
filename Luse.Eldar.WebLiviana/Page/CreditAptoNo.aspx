<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="CreditAptoNo.aspx.vb"
    Inherits="CreditAptoNo" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron" style="position: relative;">        
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
                <label id="Label1" class="alert alert-warning" style="font-size:smaller" 
                    clientidmode="Static" runat="server"><p>Dejanos un nro de contacto y te contactaremos para brindarte una solucion a tu medida. Muchas Gracias</p></label>
                 
                 <br />
                 <div class="input-group">
                  <span class="input-group-addon">Nro Contacto</span>
                    <input type="text" maxlength="20" runat="server" class="form-control" clientidmode="Static" id="txtNroContacto" />
                 
                </div>
                <asp:HiddenField ClientIDMode="Static" ID="User" runat="server" />
                <asp:HiddenField ClientIDMode="Static" ID="Pass" runat="server" />
                 <asp:hiddenfield clientidmode="Static" id="MontoVentas" runat="server" />
                    <asp:hiddenfield clientidmode="Static" id="AptoCredito" runat="server" />
                <br />
                <div class="form-group">
                    <div class="input-group" style="text-align:center">
                        <button type="button" runat="server" id="btnIngresar" clientidmode="Static" class="btn btn-primary">Aceptar</button>
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

       

        $("#btnIngresar").click(function () {

            $("#lblresultokfail").css("display", "none");
            $("#lblresultokfail").html("");
            $('#btnIngresar').attr('disabled', true);

            var SendObj = {

                "IDPrestamoBase": $("#txtFecha").val(),
                "Mensaje": $("#txtFechaHasta").val(),
                "NroContacto": $("#txtNroContacto").val(),
                "Pass": $("#Pass").val(),
                "Destino": $("#txtDestino").val()

            }

            var stringData = JSON.stringify(SendObj);

            $.ajax({
                type: "POST",
                url: "../Servicios/Servicios.asmx/SaveSolicitudPrestamo",
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

    </script>

</asp:Content>


