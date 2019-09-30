
Partial Class mailtemplates_MostrarImpresionPin
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' Imprimir.InnerHtml = Request.Params(0)
        Dim mVariableas As String = Request.QueryString("Div")

        Dim mNombreAgencia As String
        Dim mDireccionAgencia As String
        Dim mFechaExp As String
        Dim mPin As String
        Dim mNroSerie As String
        Dim mEstado As String
        Dim mMsn As String
        Dim mNombreProducto As String
        Dim mNombreProveedor As String

        mNombreAgencia = mVariableas.Split("|")(0)
        mDireccionAgencia = mVariableas.Split("|")(1)
        mEstado = mVariableas.Split("|")(2)
        mNroSerie = mVariableas.Split("|")(3)
        mPin = mVariableas.Split("|")(4)
        mFechaExp = mVariableas.Split("|")(5)
        mMsn = mVariableas.Split("|")(6)
        mNombreProducto = mVariableas.Split("|")(8)
        mNombreProveedor = mVariableas.Split("|")(7)


        Imprimir.InnerHtml = "<h3><center><img src='../Img/cp200px.png';></center></h3>" _
           & " <center><b>" & mNombreAgencia & "</b> <br /> " _
            & " Direccion:" & mDireccionAgencia & "</center><br /><br />" _
           & "  Fecha-Hora:  " & Format(Now, "dd/MM/yyyy HH:mm:ss") & "<br />" _
            & "  Compañia:" & mNombreProveedor & "<br />" _
            & "  Producto:" & mNombreProducto & "<br />" _
              & "  Nro. Serie.:" & mNroSerie & " <br />" _
             & "  <b>Pin Seguridad.:" & mPin & " </b><br />" _
            & "  Fecha Exp.:" & mFechaExp & "<br /><br />" _
           & "  <center>Estado:<b> " & IIf(mEstado = "True", "OK", "Error") & "</b> <br />" _
           & "  Mensaje: " & mMsn & " </center> <br />" _
           & "  <h3 style = 'font-size:13px'><center><i><b>Gracias por Operar con CargaPlus</center>"

    End Sub

End Class
