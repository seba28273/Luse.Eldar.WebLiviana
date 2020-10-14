<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MostrarImpresionRapipago.aspx.vb" Inherits="mailtemplates_MostrarImpresion" %>

<!DOCTYPE html>

<html style="width: 170px" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body style="width: 170px; word-break:break-all">

    <form id="form1" runat="server">
        <div id="Imprimir" style="width: 170px; text-align: left; font-weight: 100;"
            clientidmode="Static" runat="server">
        </div>
        <center> <input type="image" height="80px" width="120px" src="../Img/printer.jpg" onclick="printDiv('Imprimir')" value="imprimir" /></center>

    </form>

    <script lang="javascript">
        function printDiv(nombreDiv) {


            var contenido = document.getElementById(nombreDiv).innerHTML;
            var contenidoOriginal = document.body.innerHTML;

            document.body.innerHTML = contenido;

            window.print();

            document.body.innerHTML = contenidoOriginal;
        }
    </script>

</body>
</html>
