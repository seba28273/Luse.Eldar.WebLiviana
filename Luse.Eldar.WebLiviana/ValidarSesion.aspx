<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ValidarSesion.aspx.vb" Inherits="ValidarSesion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="js/jquery.timers.js" type="text/javascript"></script>
    
    <script language="javascript" type="text/javascript">

        $().ready(function() {

        $(document).everyTime(3000, function() {
        
                $.ajax({
                    type: "POST",
                    url: "ValidarSesion.aspx/KeepActiveSession",
                    data: {},
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: VerifySessionState,
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        alert(textStatus + ": " + XMLHttpRequest.responseText);
                    }
                });
                
            });

     
        });

        var cantValidaciones = 0;

        function VerifySessionState(result) {

            if (result.d) {
                $("#EstadoSession").text("activo");
            }
            else
                $("#EstadoSession").text("expiro");

            $("#cantValidaciones").text(cantValidaciones);
            cantValidaciones++;

        }

    </script>
    


</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>
