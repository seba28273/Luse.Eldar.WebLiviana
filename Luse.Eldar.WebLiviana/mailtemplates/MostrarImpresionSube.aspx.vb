﻿
Partial Class mailtemplates_MostrarImpresionSube
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

        Imprimir.InnerHtml = "<h3><center><b>Carga Electrónica SUBE</b></center></h3>" _
           & " <center><b>" & mNombreAgencia & "</b> <br /> " _
            & " Direccion:" & mDireccionAgencia & "<br />" _
           & "  Fecha-Hora:  " & Format(Now, "dd/MM/yyyy HH:mm:ss") & " <br /><br />" _
           & "  ID Trans.SUBE:" & mIDtransaccion & " <br />" _
           & " " & mNroTarOfuscado & "<br />" _
           & "  Monto: $ " & mMonto & "  <br /></center>" _
           & "  <h3 style = 'font-size:13px'><center><i><b>para acreditar su carga debe acercar la tarjeta a una <br /> Terminal Automática o <br /> Dispositivo de conexión  <br />móvil " _
           & "   <br />Más Información en: <b></i></center></h3>" _
           & "  <center><a target = '_blank' href='https//www.argentina.gob.ar/sube' >https://www.argentina.gob.ar/sube</a> </center>"






    End Sub


End Class
