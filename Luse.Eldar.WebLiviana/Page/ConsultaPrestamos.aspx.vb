
Partial Class Page_ConsultaVentas
    Inherits System.Web.UI.Page

    Public Class Lotes
        Private mid As Long
        Public Property id() As Long
            Get
                Return mid
            End Get
            Set(ByVal value As Long)
                mid = value
            End Set
        End Property

        Private mnrolote As Long
        Public Property nrolote() As Long
            Get
                Return mnrolote
            End Get
            Set(ByVal value As Long)
                mnrolote = value
            End Set
        End Property
    End Class
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("Usuario") Is Nothing Then
            Response.Redirect("~/")
        End If

        MontoVentas.Value = Session("MontoVentas")
        AptoCredito.Value = Session("AptoCredito")

        User.Value = Session("Usuario")
        Pass.Value = Session("Password")
        NombreAgencia.Value = Session("NombreAgencia")
        IDAgencia.Value = Session("IDAgencia")
        DireccionAgencia.Value = Session("DireccionAgencia")


    End Sub
End Class
