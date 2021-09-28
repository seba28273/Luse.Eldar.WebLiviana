<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Noticias.aspx.vb" Inherits="Page_Noticias" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="../Content/bootstrap.css">
    <script src="../Scripts/jquery.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <link href="../Content/btnPrestamo.css" rel="stylesheet" />
    <title></title>
</head>
<body style="background-color: darkorange;">
     <form runat="server">
    <div style="background-color: darkorange; height: 100%; display: block; margin: auto;">

        <a href="#">
            <div style="vertical-align: middle; width: 100%; height: 100%;">

                <img class="imgNews"
                    src="../Img/portadaretirodinero.jpg" />
            </div>

        </a>


    </div>
    <div style="display: block; margin: auto; margin-top:10px; text-align:center; vertical-align: central">
    <button type="button" runat="server" id="btnSi"
        clientidmode="Static" class="btn btn-info">
        Continuar</button>
    
    </div>
         </form>
</body>
</html>
