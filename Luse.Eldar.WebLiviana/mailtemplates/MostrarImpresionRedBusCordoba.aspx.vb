
Partial Class mailtemplates_MostrarImpresionRedBusCordoba
    Inherits System.Web.UI.Page



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        ' Imprimir.InnerHtml = Request.Params(0)
        Dim mVariableas As String = Request.QueryString("Div")

        Dim mNombreAgencia As String
        Dim mDireccionAgencia As String
        Dim mIDtransaccion As String
        Dim mNroTarOfuscado As String
        Dim mMonto As String
        mNombreAgencia = mVariableas.Split("|")(0)
        mDireccionAgencia = mVariableas.Split("|")(1)
        mIDtransaccion = mVariableas.Split("|")(2)
        mNroTarOfuscado = mVariableas.Split("|")(3)
        mMonto = mVariableas.Split("|")(4)

        Imprimir.InnerHtml = "<h3><center><b>Carga Electrónica Red BUS</b></center></h3>" _
             & " <center><b>CORDOBA</b> <br /> " _
           & " <center><b>" & mNombreAgencia & "</b> <br /> " _
            & " Direccion:" & mDireccionAgencia & "<br />" _
           & "  Fecha-Hora:  " & Format(Now, "dd/MM/yyyy HH:mm:ss") & " <br /><br />" _
           & "  ID Trans.Red BUS:" & mIDtransaccion & " <br />" _
           & " Nro de Tarjeta: " & mNroTarOfuscado & "<br />" _
           & "  Monto: $ " & mMonto & "  <br /></center>" _
           & "  <h3 style = 'font-size:13px'><center><i><b>Su recarga se encuentra pendiente de impactar <br /> el proceso puede demorar o <br /> unos minutos  <br />Muchas gracias " _
           & "   <br />Más Información en: <b></i></center></h3>" _
           & "  <center><a target = '_blank' href='https://mrb.red-bus.com.ar/' >Mi_Red_bus</a> </center>"






    End Sub


End Class
