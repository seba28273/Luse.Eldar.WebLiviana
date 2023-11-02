
Partial Class Page_Noticias
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Usuario") Is Nothing Then
            Response.Redirect("~/")
        End If
    End Sub
    Private Sub Login(ByVal sender As Object, ByVal e As EventArgs) Handles btnSi.ServerClick
        Response.Redirect("RecargaSaldoVirtual.aspx")
    End Sub
End Class
