
Partial Class MostrarImpresionTicketRedbus
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' Imprimir.InnerHtml = Request.Params(0)
        Dim mVariableas As String = Request.QueryString("Div")

        'mVariableas = "Eldar|San Martin 1074 22|162239039-2059615634|057000864019732099|100|Ok|La Venta se realizo con exito|Directv"

        Dim mNombreAgencia As String
        Dim mDireccionAgencia As String
        Dim mIDtransaccion As String

        Dim mMonto As String
        Dim mEstado As String
        Dim mMsn As String
        Dim mFecha As String
        Dim mFechaHoraimpacto As String


        mNombreAgencia = mVariableas.Split("|")(0)
        mDireccionAgencia = mVariableas.Split("|")(1)
        mIDtransaccion = mVariableas.Split("|")(7)
        mFecha = mVariableas.Split("|")(4)
        mFechaHoraimpacto = mVariableas.Split("|")(3)
        mMonto = mVariableas.Split("|")(8)
        mEstado = mVariableas.Split("|")(2)
        mMsn = mVariableas.Split("|")(6)


        '& "  Mensaje: " & mMsn & "  <br /></center>" _
        Imprimir.InnerHtml = "<h3><center><img src='../Img/cp200px.png';></center></h3>" _
           & " <center><b style=font-size:20px;>Estado Recarga Red bus</b><br /><br /><b>" & mNombreAgencia & "</b> <br /> " _
            & " Direccion:" & mDireccionAgencia & "<br /><br />" _
           & "  Fecha Recarga:  " & mFecha & " <br /><br />" _
            & "  Fecha Impacto:  " & mFechaHoraimpacto & " <br /><br />" _
           & "  ID Trans.:" & mIDtransaccion & " <br /> <br />" _
           & "  <b>Producto:Recarga Red bus" & "</b><br />" _
           & "  Monto: $ " & mMonto & "  <br /> <br />" _
           & "  Estado:<b style=font-size:20px;> " & mEstado & "</b> <br />" _
           & "  <h3 style = 'font-size:13px'><center><i><b>Gracias por Operar con CargaPlus</center>"

    End Sub

End Class
