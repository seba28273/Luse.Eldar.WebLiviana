
Partial Class Page_ConsultaOC
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Session("Usuario") Is Nothing Then
            Response.Redirect("~/")
        End If


        User.Value = Session("Usuario")
        Pass.Value = Session("Password")


    End Sub


End Class
