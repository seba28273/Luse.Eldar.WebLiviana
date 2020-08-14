
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

        Dim oEldar As New Luse.WsTransaccional.ExternalSales
        Dim oRes As Boolean
        Dim mAptoCredito As Int32
        Dim mIDPrestamoBase As Long
        Dim mMsnCredito As String = ""
        Dim mCodPuestoRP As Long
        Dim mAgenteRP As Long
        Dim mSucursalRP As Long
        Dim mIDAcceso As Long
        oRes = oEldar.LoginEscritorioWithRP(usr.Value, pwd.Value,
                               eTipoAccesoSistema.Escritorio, mMsn, mIDAgencia, mNombre, mSaldo,
                               mSaldoSube, mDireccionAgencia, mIDPrestamoBase, mAptoCredito, mMsnCredito, mCodPuestoRP, mAgenteRP, mSucursalRP, mIDAcceso)



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
        Session("IDAcceso") = mIDAcceso
        'Cargar estas variables segun el usuario para saber si el mismo tendra autorizaciones


        Session("CodPuestoRP") = mCodPuestoRP.ToString.PadLeft(6, "0")
        Session("AgenteRP") = mAgenteRP.ToString.PadLeft(5, "0")
        Session("SucursalRP") = mSucursalRP
        If mCodPuestoRP = 0 Then
            Session("mnuRPVisible") = False
        Else
            Session("mnuRPVisible") = True

        End If


        Response.Redirect("Page/Noticias.aspx")
        'Response.Redirect("Page/RecargaSube.aspx")
        'Response.Redirect("Page/Menu.aspx", False)
        'Server.Transfer("Page/Menu.aspx")

    End Sub



End Class
