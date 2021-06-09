
Partial Class mailtemplates_MostrarImpresion
    Inherits System.Web.UI.Page



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' TextoTicket.Value = Session("TextoTicket")
        ' Imprimir.InnerHtml = Request.Params(0)
        Dim mVariableas As String = Request.Params(0)
        'Imprimir.InnerHtml = Request.Params(0)
        'Dim mPuesto As String
        'Dim mCodigoEmpresa As String
        'Dim mIDtransaccion As String
        'Dim mNombreEmpresa As String
        'Dim mMonto As String
        'Dim mNroSerie As String
        'Dim mCodSeguridad As String
        Dim mMsn() As String
        'mPuesto = mVariableas.Split("|")(0)
        'mCodigoEmpresa = mVariableas.Split("|")(1)
        'mNombreEmpresa = mVariableas.Split("|")(2)
        'mNroSerie = mVariableas.Split("|")(3)
        'mIDtransaccion = mVariableas.Split("|")(4)
        'mMonto = mVariableas.Split("|")(5)
        'mCodSeguridad = mVariableas.Split("|")(6)
        'mMsn = mVariableas.Split("|")(7)
        mMsn = mVariableas.Split("|")

        Dim mInicio As String = ""
        Dim mINtermedio As String = "<h3><img width='120px' src='../Img/rapipagoprint.png';></h3>"

        Dim mCuerpo As String = ""
        For Each item As String In mMsn
            mCuerpo = mCuerpo & "<tr style='width: 40px; max-width:  40px; word-break: break-all;'><td style='display: table-cell;vertical-align: inherit;'>" & item.Replace(" ", "&nbsp") & "</td></tr>"
        Next

        mCuerpo = mCuerpo.Replace("undefinedPuesto", "<b>Puesto</b>")
        mCuerpo = mCuerpo.Replace("Puesto", "<b>Puesto</b>")
        'mCuerpo = mCuerpo.Replace("Fecha:", "")
        'mCuerpo = mCuerpo.Replace("Hora:", "")
        mCuerpo = mCuerpo.Replace("PESOS", "<b>PESOS**</b>")
        mCuerpo = mCuerpo.Replace("Empresa", "<b>Empresa</b>")
        mCuerpo = mCuerpo.Replace("Cliente", "<b>Cliente</b>")
        mCuerpo = mCuerpo.Replace("undefined", "<b>ANULADO</b>")
        mCuerpo = mCuerpo.Replace("ORIGINAL", "<b>ORIGINAL</b></br></br>")
        mCuerpo = mCuerpo.Replace("DUPLICADO", "<b>DUPLICADO</b></br></br>")

        'Imprimir.InnerHtml = "<Table  style='font-family: arial;'> " & mInicio & mCuerpo & "</Table>"
        'Imprimir.InnerHtml = "<Table style='font-family: monospace;'> " & mInicio & mINtermedio & mCuerpo & "</Table>"
        Imprimir.InnerHtml = "<Table style='font-family:sans-serif;font-size: 9px;'> " & mInicio & mINtermedio & mCuerpo & "</Table>"
        ' & " Puesto:" & mPuesto & "<br />" _
        '& "  Fecha: " & Format(Now, "dd/MM/yyyy") & "  Hora: " & Format(Now, "HH:mm:ss") & " <br /><br />" _
        '& "  Empresa:" & mCodigoEmpresa & "  " & mNombreEmpresa & " <br />" _
        '& "  Importe: " & mMonto & "<br />" _
        '& "  Cliente: " & mIDtransaccion & "<br />" _
        '& "  Nro op.: " & mNroSerie & "<br />" _
        '& "  Cod. Seg.: $ " & mMonto & "  <br /></center>" _
        '& "  <h3 style = 'font-size:13px'><center> " _
        '& "   <br /> " & mMsn & " <b></i></center></h3>" _
        '& "  <center> <br />----------******------------"






    End Sub


End Class
