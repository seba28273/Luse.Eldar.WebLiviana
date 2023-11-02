

<System.Web.Script.Services.ScriptService>
Partial Class SolicitudSaldo
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("Usuario") Is Nothing Then
            Response.Redirect("~/")
        End If


        MontoVentas.Value = Session("MontoVentas")
        AptoCredito.Value = Session("AptoCredito")
        User.Value = Session("Usuario")
        Pass.Value = Session("Password")
    End Sub





End Class
