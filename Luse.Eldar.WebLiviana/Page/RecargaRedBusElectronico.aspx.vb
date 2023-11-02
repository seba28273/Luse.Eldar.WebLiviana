
Partial Class Page_RecargaRedBusElectronico
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Session("Usuario") Is Nothing Then
            Response.Redirect("~/")
        End If


        User.Value = Session("Usuario")
        Pass.Value = Session("Password")
        NombreAgencia.Value = Session("NombreAgencia")
        DireccionAgencia.Value = Session("DireccionAgencia")
        MontoVentas.Value = Session("MontoVentas")
        AptoCredito.Value = Session("AptoCredito")
        IDAgencia.Value = Session("IDAgencia")
        IPCliente.Value = Session("IPCliente")



    End Sub
End Class
