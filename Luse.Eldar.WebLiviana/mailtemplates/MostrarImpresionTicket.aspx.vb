
Partial Class mailtemplates_MostrarImpresionTicket
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' Imprimir.InnerHtml = Request.Params(0)
        Dim mVariableas As String = Request.QueryString("Div")

        'mVariableas = "Eldar|San Martin 1074 22|162239039-2059615634|057000864019732099|100|Ok|La Venta se realizo con exito|Directv"

        Dim mNombreAgencia As String
        Dim mDireccionAgencia As String
        Dim mIDtransaccion As String
        Dim mDestino As String
        Dim mMonto As String
        Dim mEstado As String
        Dim mMsn As String
        Dim mNombreProducto As String

        mNombreAgencia = mVariableas.Split("|")(0)
        mDireccionAgencia = mVariableas.Split("|")(1)
        mIDtransaccion = mVariableas.Split("|")(2)
        mDestino = mVariableas.Split("|")(3)
        mMonto = mVariableas.Split("|")(4)
        mEstado = mVariableas.Split("|")(5)
        mMsn = mVariableas.Split("|")(6)
        mNombreProducto = mVariableas.Split("|")(7)
        Dim mFecha As String
        Try
            mFecha = mVariableas.Split("|")(8)
        Catch ex As Exception
            mFecha = Format(Now, "dd/MM/yyyy HH:mm:ss")
        End Try
        '& "  Mensaje: " & mMsn & "  <br /></center>" _
        If mNombreProducto.ToUpper().Contains("CLARO") Then
            Imprimir.InnerHtml = "<center>Fecha-Hora:  " & mFecha & " <br /><br />" _
                 & "  Destino:" & mDestino & "<br />" _
                 & "  Codigo de Transaccion Nº:" & mIDtransaccion & " <br />" _
                 & "  Monto: $ " & mMonto & "  <br />" _
                 & "  Estado:<b> " & mEstado & "</b> <br />" _
                 & "  PDV: " & mNombreAgencia & "<br /> " _
                 & "  Direccion:" & mDireccionAgencia & "<br />" _
                & "  <h3 style = 'font-size:10px'><center><i><b>Distribucion prestada por carga al toque</center>"
        Else
            Imprimir.InnerHtml = "<h3><center><img src='../Img/cp200px.png';></center></h3>" _
          & " <center><b>" & mNombreAgencia & "</b> <br /> " _
           & " Direccion:" & mDireccionAgencia & "<br />" _
          & "  Fecha-Hora:  " & mFecha & " <br /><br />" _
          & "  ID Trans.:" & mIDtransaccion & " <br />" _
           & "  <b>Producto:" & mNombreProducto & "</b><br />" _
           & "  Destino:" & mDestino & "<br />" _
          & "  Monto: $ " & mMonto & "  <br />" _
          & "  Estado:<b> " & mEstado & "</b> <br />" _
          & "  <h3 style = 'font-size:13px'><center><i><b>Gracias por Operar con CargaPlus</center>"
        End If


    End Sub

End Class
