

<System.Web.Script.Services.ScriptService>
Partial Class RetiroDinero
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("Usuario") Is Nothing Then
            Server.Transfer("../Default.aspx")
        End If
        User.Value = Session("Usuario")
        Pass.Value = Session("Password")
        IDAgencia.Value = Session("IDAgencia")
        IDAcceso.Value = Session("IDAcceso")
        codPuesto.Value = Session("CodPuestoRP")
    End Sub





End Class
