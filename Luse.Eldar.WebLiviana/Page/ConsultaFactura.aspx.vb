
Imports System.Web.Services
<System.Web.Script.Services.ScriptService()>
Partial Class Page_ConsultaFactura
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("Usuario") Is Nothing Then
            Response.Redirect("~/")
        End If

        Usuario.Value = Session("Usuario")
        Pass.Value = Session("Password")
        codPuesto.Value = Session("CodPuestoRP")
        codAgente.Value = Session("AgenteRP")
        IDAgencia.Value = Session("IDAgencia")
        IDAcceso.Value = Session("IDAcceso")
    End Sub


End Class
