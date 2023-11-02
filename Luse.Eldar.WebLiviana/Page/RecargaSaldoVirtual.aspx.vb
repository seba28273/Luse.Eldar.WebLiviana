
Partial Class Page_RecargaSube
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Session("Usuario") Is Nothing Then
            'Server.Transfer("~/")
            Response.Redirect("~/")
        End If


        '    If (!User.Identity.IsAuthenticated) Then
        '            {
        '    // Redirige al usuario a la página de inicio (raíz) del sitio
        '    Response.Redirect("~/");
        '}



        User.Value = Session("Usuario")
        Pass.Value = Session("Password")
        IDAgencia.Value = Session("IDAgencia")
        NombreAgencia.Value = Session("NombreAgencia")
        DireccionAgencia.Value = Session("DireccionAgencia")
        MontoVentas.Value = Session("MontoVentas")
        AptoCredito.Value = Session("AptoCredito")
        IPCliente.Value = Session("IPCliente")

    End Sub
    Protected Sub btnSolicitudPrestamo_ServerClick(sender As Object, e As EventArgs)
        Response.Redirect("CreditApto.aspx")
    End Sub
End Class
