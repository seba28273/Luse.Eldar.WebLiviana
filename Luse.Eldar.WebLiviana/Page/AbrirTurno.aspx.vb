﻿

<System.Web.Script.Services.ScriptService>
Partial Class AbrirTurno
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("Usuario") Is Nothing Then
            Server.Transfer("../Default.aspx")
        End If
        User.Value = Session("Usuario")
        Pass.Value = Session("Password")
        MontoVentas.Value = Session("MontoVentas")
        AptoCredito.Value = Session("AptoCredito")

    End Sub





End Class
