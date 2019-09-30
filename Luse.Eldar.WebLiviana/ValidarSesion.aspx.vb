Imports System.Web.Services

Partial Class ValidarSesion
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        Session("datos") = True

    End Sub


    <WebMethod()>
    Public Shared Function KeepActiveSession() As Boolean

        If HttpContext.Current.Session("datos") IsNot Nothing Then
            Return True
        Else
            Return False
        End If

    End Function

    <WebMethod()>
    Public Shared Sub SessionAbandon()

        HttpContext.Current.Session.Remove("datos")

    End Sub


End Class
