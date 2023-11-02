
Partial Class CreditAptoNo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("Usuario") Is Nothing Then
            Response.Redirect("~/")
        End If


        User.Value = Session("Usuario")
        Pass.Value = Session("Password")
        MontoVentas.Value = Session("MontoVentas")
        AptoCredito.Value = Session("AptoCredito")


    End Sub


    Protected Sub btnIngresar_ServerClick(sender As Object, e As EventArgs)

        Dim correo As New System.Net.Mail.MailMessage()
        correo.From = New System.Net.Mail.MailAddress("Sebastian.Bustos@eldar.com.ar")
        correo.To.Add("luis.gauchat@eldar.com.ar")
        correo.To.Add("Sebastian.Bustos@eldar.com.ar")
        correo.Subject = "Solicitud Credito Agencia no Apta"
        correo.Body = "La Agencia " & Session("NombreAgencia") & " Esta identificada como NO APTA por la sucursal. pero la misma solicita informacion sobre creditos. Su Nro Contacto es: " & txtNroContacto.Value
        correo.IsBodyHtml = True
        correo.Priority = Net.Mail.MailPriority.Normal
        Dim ls_SmtpClient As New System.Net.Mail.SmtpClient
        ls_SmtpClient.Host = "200.115.185.11"
        ls_SmtpClient.Port = 25
        'ls_SmtpClient.EnableSsl = True
        'ls_SmtpClient.UseDefaultCredentials = True
        'ls_SmtpClient.Credentials = New System.Net.NetworkCredential("sebastian.bustos@eldar.com.ar", "Seba1980")
        'ls_SmtpClient.DeliveryMethod = Net.Mail.SmtpDeliveryMethod.Network
        Try
            ls_SmtpClient.Send(correo)
        Catch ee As Exception
            lblresultokfail.InnerText = ee.Message
            lblresultokfail.Visible = True
        End Try

    End Sub
End Class
