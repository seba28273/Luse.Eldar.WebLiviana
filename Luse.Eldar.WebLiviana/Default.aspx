<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

       <div class="jumbotron" style="position:relative;">
            <h2>Inicio Sesion</h2>
            <img src="../Img/cp200px.png" class ="imgpag" style="position:absolute; right:30px; bottom:5px; max-width:300px;"  />

            <div class="container">

                <div class="input-group">
                    <span style="font-size:initial;" class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                    <input id="usr" type="text" runat="server" class="form-control" name="email" placeholder="Usuario" />
                </div>
                <br />
                <div class="input-group">
                    <span style="font-size:initial;" class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                    <input id="pwd" data-toggle="password" type="password" runat="server" class="form-control" name="email" placeholder="Contraseña" />
                </div>
                <br />

                <button type="button" id="btnLog" runat="server" class="btn btn-primary">Ingresar</button>
                <label id="lblresultokfail" class="alert alert-danger" visible="false" runat="server"></label>
            </div>
        </div>
        <script src="../Scripts/jquery.min.js"></script>
        <script src="../Scripts/bootstrap.js"></script>
        <script src="../Scripts/bootstrap-show-password.js"></script>
        <script>
            $(function () {
                $('#password').password().on('show.bs.password', function (e) {
                    $('#eventLog').text('On show event');
                    $('#methods').prop('checked', true);
                }).on('hide.bs.password', function (e) {
                    $('#eventLog').text('On hide event');
                    $('#methods').prop('checked', false);
                });
                $('#methods').click(function () {
                    $('#password').password('toggle');
                });
            });
        </script>


</asp:Content>

