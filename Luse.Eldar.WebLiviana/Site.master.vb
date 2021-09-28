
Partial Class SIte2
    Inherits System.Web.UI.MasterPage


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

        If Session("Usuario") <> "" Then
            menuSistema.Visible = True
            'btnSolicitudPrestamo.Visible = True
        Else
            menuSistema.Visible = False
            'btnSolicitudPrestamo.Visible = False

        End If
        usrLogin2.InnerText = " " & Session("Usuario")
        usrAgencia.InnerText = " " & Session("NombreAgencia")
        mnuRP.Disabled = Not Convert.ToBoolean(Session("mnuRP"))
        If Convert.ToBoolean(Session("mnuRetiroDinero")) Then
            mnuRetiroDinero.Visible = True
        Else
            mnuRetiroDinero.Visible = False
        End If

        'SaldoAgencia.InnerText = " " & Session("Saldo")
        ' SaldoSube.InnerText = " " & Session("SaldoSube")
        Session("datos") = True

        'Dim oEldar As New Luse.WsTransaccional.ExternalSales
        'oEldar.GetSaldoWeb(Session("Usuario"), Session("Password"), Session("Saldo"), Session("SaldoSube"))
        'SaldoAgencia.InnerText = " " & Session("Saldo")
        'SaldoSube.InnerText = " " & Session("SaldoSube")


    End Sub





End Class

