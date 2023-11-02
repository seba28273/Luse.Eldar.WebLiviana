
Partial Class Page_changepassword
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'If Session("Usuario") Is Nothing Then
        '    Server.Transfer("../Default.aspx")
        'End If
        'MontoVentas.Value = Session("MontoVentas")
        'AptoCredito.Value = Session("AptoCredito")

        User.Value = Session("Usuario")
        Pass.Value = Session("Password")
        Try
            If IsNothing(Session("Usuario")) Then
                IDAcceso.Value = Request.Params(0)
            Else
                IDAcceso.Value = Session("IDAcceso")
            End If

        Catch ex As Exception

        End Try



    End Sub


End Class
