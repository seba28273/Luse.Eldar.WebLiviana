﻿
Imports Luse.WsTransaccional

Partial Class Default2
    Inherits System.Web.UI.Page


    public Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load



    End Sub
    Private Sub Login(ByVal sender As Object, ByVal e As EventArgs) Handles btnLog.ServerClick

        If usr.Value = "" Or pwd.Value = "" Then
            lblresultokfail.Visible = True
            lblresultokfail.InnerText = "Ingrese Usuario y Contraseña"
            Exit Sub
        End If

        Dim mPassRB As String = ""
        Dim mImeiRB As String = ""
        Dim mMsn As String = ""
        Dim mNombre As String = ""
        Dim mDireccionAgencia As String = ""
        Dim mSaldo As String = ""
        Dim mSaldoSube As String = ""
        Dim mIDAgencia As Long
        Dim mMontoVentas As Long
        Dim oEldar As New Luse.WsTransaccional.ExternalSales
        Dim oRes As Boolean
        Dim mAptoCredito As Int32
        Dim mIDPrestamoBase As Long
        Dim mMsnCredito As String
        oRes = oEldar.LoginWeb(usr.Value, pwd.Value,
                               eTipoAccesoSistema.Escritorio, mMsn, mIDAgencia, mNombre, mSaldo,
                               mSaldoSube, mDireccionAgencia, mIDPrestamoBase, mAptoCredito, mMsnCredito)



        If Not oRes Then
            lblresultokfail.Visible = True
            lblresultokfail.InnerText = "Usuario y Contraseña mal ingresada o el usuario esta bloqueado."
            Exit Sub
        End If

        Session("Usuario") = usr.Value
        Session("Password") = pwd.Value
        Session("Saldo") = mSaldo
        Session("SaldoSube") = mSaldoSube
        Session("IDAgencia") = mIDAgencia
        Session("NombreAgencia") = mNombre
        Session("DireccionAgencia") = mDireccionAgencia
        Session("ImeI") = mImeiRB
        Session("IDPrestamoBase") = mIDPrestamoBase
        Session("AptoCredito") = mAptoCredito
        Session("MensajeCredito") = mMsnCredito
        'Cargar estas variables segun el usuario para saber si el mismo tendra autorizaciones


        Response.Redirect("Page/RecargaSaldoVirtual.aspx")
        'Response.Redirect("Page/Menu.aspx", False)
        'Server.Transfer("Page/Menu.aspx")

    End Sub



End Class