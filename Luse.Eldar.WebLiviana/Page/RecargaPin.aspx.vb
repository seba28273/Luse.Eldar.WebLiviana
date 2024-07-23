
Imports System.Security.Policy
Imports System.Web.Services

Partial Class Page_RecargaSube
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Session("Usuario") Is Nothing Then
            Response.Redirect("~/")
        End If


        User.Value = Session("Usuario")
        Pass.Value = Session("Password")
        IDAgencia.Value = Session("IDAgencia")
        NombreAgencia.Value = Session("NombreAgencia")
        DireccionAgencia.Value = Session("DireccionAgencia")
        MontoVentas.Value = Session("MontoVentas")
        AptoCredito.Value = Session("AptoCredito")
        IPCliente.Value = Session("IPCliente")
    End Sub


End Class
