<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MostrarImpresionPin.aspx.vb" Inherits="mailtemplates_MostrarImpresionPin" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
   <div id="Imprimir" clientidmode="Static" runat="server">
      

    </div>
          <center> <input type="image" height="110px" width="150px" src="../Img/printer.jpg" onclick="printDiv('Imprimir')" value="imprimir" /></center>
    
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