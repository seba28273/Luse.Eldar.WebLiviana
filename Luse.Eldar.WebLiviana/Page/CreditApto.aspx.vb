
Partial Class CreditApto
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If (Not Page.IsPostBack) Then
            If Session("Usuario") Is Nothing Then
                Response.Redirect("~/")
            End If


            User.Value = Session("Usuario")
            Pass.Value = Session("Password")
            MensajeCredito.Value = Session("MensajeCredito")
            IDPrestamoBase.Value = Session("IDPrestamoBase")
            AptoCredito.Value = Session("AptoCredito")
            lblMsn.InnerHtml = Session("MensajeCredito")
            NombreAgencia.Value = Session("NombreAgencia")
        End If



    End Sub
End Class
