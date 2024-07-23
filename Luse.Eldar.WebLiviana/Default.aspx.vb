
Imports System.Data
Imports System.IO
Imports System.Net.Http
Imports System.Threading.Tasks
Imports System.Web.Services
Imports LuSe.WsTransaccional
Imports Newtonsoft.Json
Imports Servicios


Partial Class Default2
    Inherits System.Web.UI.Page


    Protected Sub Page_LoadAsync(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Request.HttpMethod = "POST" Then


            'Dim secretKey As String = "6LfLouEoAAAAANeEe9Sg12dTM_LRne8XPLQUr36N"
            'Dim response As String = Request.Form("g-recaptcha-response")



            'Dim client As New System.Net.WebClient()
            'Dim Result = client.DownloadString(String.Format("https://www.google.com/recaptcha/api/siteverify?secret={0}&response={1}", secretKey, response))
            'Dim obj As resCaptcha = Newtonsoft.Json.JsonConvert.DeserializeObject(Of resCaptcha)(Result)
            'Dim recaptchaValid As Boolean = obj.success
            'If recaptchaValid = False Then
            '    errorcaptcha.Value = "Indique que no es un robot"

            '    Exit Sub
            'End If


            Dim json As String = New StreamReader(Request.InputStream).ReadToEnd()

            Dim valor As Parametros = JsonConvert.DeserializeObject(Of Parametros)(json) ' Obtener el valor enviado desde JavaScript
            If valor IsNot Nothing Then
                Dim cSQL As String
                Dim referer As String = "No detectado"
                Dim navegador As String = "No detectado"
                Try
                    referer = Request.UrlReferrer.ToString()
                Catch ex As Exception
                    referer = "Error al obtener el origen " + ex.Message
                End Try

                Try
                    navegador = Request.Browser.Browser.ToString() + " V." + Request.Browser.Version.ToString()
                Catch ex As Exception
                    navegador = "Error al obtener el navegador " + ex.Message
                End Try
                referer = referer
                Dim oServicio As New Servicios
                cSQL = "Update AuditoriaIngreso set Navegador = '" + navegador + "'   , Observaciones = '" + referer + "' where IDAuditoriaIngreso = " + valor.IDAuditoria.ToString()
                oServicio.ExecuteSqlAudit(cSQL)


                Session("Usuario") = valor.User
                Session("Password") = valor.Pass

                Session("Saldo") = valor.Saldo
                Session("SaldoSube") = valor.SaldoSube
                Session("IDAgencia") = valor.IDAgencia
                Session("NombreAgencia") = valor.NombreAgencia
                Session("DireccionAgencia") = valor.DireccionAgencia
                Session("ImeI") = valor.Imei
                Session("IDPrestamoBase") = valor.IDPrestamoBase
                Session("AptoCredito") = valor.AptoCredito
                Session("MensajeCredito") = valor.MensajeCredito
                Session("IDAcceso") = valor.IDAcceso
                Session("IPCliente") = valor.IPCliente
                Session("HabilitadoEntregaDinero") = valor.HabilitadoEntregaDinero
                'Cargar estas variables segun el usuario para saber si el mismo tendra autorizaciones


                Session("CodPuestoRP") = valor.CodPuestoRP.ToString.PadLeft(6, "0") ' mCodPuestoRP.ToString.PadLeft(6, "0")
                Session("AgenteRP") = valor.Agente.ToString.PadLeft(5, "0") 'mAgenteRP.ToString.PadLeft(5, "0")
                Session("SucursalRP") = valor.Sucursal

                If Session("CodPuestoRP") = 0 Then
                    Session("mnuRPVisible") = False
                Else
                    Session("mnuRPVisible") = True

                End If

                If Session("HabilitadoEntregaDinero") = 0 Then
                    Session("mnuRetiroDinero") = False
                Else
                    Session("mnuRetiroDinero") = True

                End If
            End If


        End If

    End Sub

    Public Class resCaptcha

        Private msuccess As Boolean
        Public Property success() As Boolean
            Get
                Return msuccess
            End Get
            Set(ByVal value As Boolean)
                msuccess = value
            End Set
        End Property
        Private mchallenge_ts As DateTime
        Public Property challenge_ts() As DateTime
            Get
                Return mchallenge_ts
            End Get
            Set(ByVal value As DateTime)
                mchallenge_ts = value
            End Set
        End Property
        Private mhostname As String
        Public Property hostname() As String
            Get
                Return mhostname
            End Get
            Set(ByVal value As String)
                mhostname = value
            End Set
        End Property
        Private maction As String
        Public Property action() As String
            Get
                Return maction
            End Get
            Set(ByVal value As String)
                maction = value
            End Set
        End Property

    End Class


    Private Sub Login(ByVal sender As Object, ByVal e As EventArgs) 'Handles btnIngresar.ServerClick




        '    If usr.Value = "" Or pwd.Value = "" Then
        '        lblresultokfail.Visible = True
        '        lblresultokfail.InnerText = "Ingrese Usuario y Contraseña"
        '        Exit Sub
        '    End If

        '    Dim mPassRB As String = ""
        '    Dim mImeiRB As String = ""
        '    Dim mMsn As String = ""
        '    Dim mNombre As String = ""
        '    Dim mDireccionAgencia As String = ""
        '    Dim mSaldo As String = ""
        '    Dim mSaldoSube As String = ""
        '    Dim mIDAgencia As Long

        '    Dim oEldar As New Luse.WsTransaccional.ExternalSales
        '    Dim oRes As Boolean
        '    Dim mAptoCredito As Int32
        '    Dim mIDPrestamoBase As Long
        '    Dim mMsnCredito As String = ""
        '    Dim mCodPuestoRP As Long
        '    Dim mAgenteRP As Long
        '    Dim mSucursalRP As Long
        '    Dim mIDAcceso As Long
        '    Dim mHabilitadoEntregaDinero As Integer

        '    'oRes = oEldar.LoginEscritorioWithRPNew(usr.Value, pwd.Value,
        '    '                       eTipoAccesoSistema.Escritorio, mMsn, mIDAgencia, mNombre, mSaldo,
        '    '                       mSaldoSube, mDireccionAgencia, mIDPrestamoBase, mAptoCredito, mMsnCredito, mCodPuestoRP, mAgenteRP, mSucursalRP, mIDAcceso,
        '    '                       mHabilitadoEntregaDinero)




        '    Dim cSQL As String = ""
        '    Dim password As String = Luse.Framework.Common.Helper.CryptoFunctions.CriptText(pwd.Value, GetCryptoKey, GetCryptoInitKey())

        '    cSQL = "SELECT   Agencia.IDAgencia, Agencia.IDAgenciaSup, Agencia.Nombre, Agencia.UpgPos, " _
        '    & "    PoseeSube,(Agencia.Direccion + ' ' + convert(varchar(10),Agencia.DireccionNumero)) as DireccionAgencia  " _
        '     & "   ,ISNULL(CodPuesto,0) as CodPuesto, ISNULL(Sucursal,0) as Sucursal , ISNULL(Agente,0) as Agente, ISNULL(HabilitadoEntregaDinero,0) " _
        '   & " as HabilitadoEntregaDinero ,ChangePassword, NotChangePassword, ExpirationPassword, DateExpirationAccount, DateExpiration, S.Cantidad as StockAgencia, SS.Cantidad as StockAgenciaSube, IDPrestamoBase, Mensaje,PrestamoBase.AptoCredito " _
        '    & "   CountDaysForExpirationPassword, DateForExpirationPassword, Acceso.IDAgencia, BloqueadoVenta, Acceso.IntentosFallidos  FROM Agencia INNER JOIN AgenciaXUsers ON Agencia.IDAgencia = AgenciaXUsers.IDAgencia " _
        '    & " left join  PrestamoBase ON PrestamoBase.IDAgencia = Agencia.IDAgencia  INNER JOIN Acceso ON Acceso.IDAcceso = AgenciaXUsers.IDUserAcceso Inner join StockSube as SS On SS.IDAgencia = Agencia.IDAgencia Inner join Stock as S On S.IDAgencia = Agencia.IDAgencia  LEFT JOIN AgenciaRapipago ON " _
        '   & " AgenciaRapipago.IDAgencia = Agencia.IDAgencia   WHERE 1=1 and  Acceso.IDTipoAcceso = 2 and  Usercode like '" + usr.Value + "' And password  like '" + password + "'"


        '    Dim oservicios As New Servicios
        '    Dim oTablaTemp As DataTable
        '    oTablaTemp = oservicios.GetDatos(cSQL)

        '    If oTablaTemp.Rows.Count = 0 Or oTablaTemp.Rows.Count > 1 Then
        '        lblresultokfail.Visible = True
        '        lblresultokfail.InnerText = "Usuario y Contraseña mal ingresada o el usuario esta bloqueado."
        '        'incrementar intetos fallidos guardar log de login
        '        If oTablaTemp.Rows(0)("IntentosFallidos") > 3 Then

        '            lblresultokfail.Visible = True
        '            lblresultokfail.InnerText = "cantidad de intentos de ingreso alcanzado. Usuario Bloqueado."

        '            'Desactivar usuario
        '        End If

        '        Exit Sub
        '    End If

        '    If DateDiff(DateInterval.Day, oTablaTemp.Rows(0)("DateForExpirationPassword"), Now.Date) Then
        '        lblresultokfail.Visible = True
        '        lblresultokfail.InnerText = "Su contraseña expiro bloqueado."
        '        Response.Redirect("Page/changepassword.aspx")
        '        Exit Sub
        '    End If

        '    'si va todo bien reintentos poner en 0

        '    Session("Usuario") = usr.Value
        '    Session("Password") = pwd.Value
        '    Session("Saldo") = oTablaTemp.Rows(0)("StockAgencia") 'mSaldo
        '    Session("SaldoSube") = oTablaTemp.Rows(0)("StockAgenciaSube") 'mSaldoSube
        '    Session("IDAgencia") = oTablaTemp.Rows(0)("IDAgencia") 'mIDAgencia
        '    Session("NombreAgencia") = oTablaTemp.Rows(0)("Nombre") ' mNombre
        '    Session("DireccionAgencia") = oTablaTemp.Rows(0)("DireccionAgencia") ' mDireccionAgencia
        '    Session("ImeI") = oTablaTemp.Rows(0)("IntentosFallidos") ' mImeiRB
        '    Session("IDPrestamoBase") = oTablaTemp.Rows(0)("IDPrestamoBase") ' mIDPrestamoBase
        '    Session("AptoCredito") = oTablaTemp.Rows(0)("AptoCredito") ' mAptoCredito
        '    Session("MensajeCredito") = oTablaTemp.Rows(0)("Mensaje") ' mMsnCredito
        '    Session("IDAcceso") = oTablaTemp.Rows(0)("IDAcceso") ' mIDAcceso
        '    Session("HabilitadoEntregaDinero") = oTablaTemp.Rows(0)("HabilitadoEntregaDinero") ' mHabilitadoEntregaDinero
        '    'Cargar estas variables segun el usuario para saber si el mismo tendra autorizaciones


        '    Session("CodPuestoRP") = oTablaTemp.Rows(0)("CodPuesto").ToString.PadLeft(6, "0") ' mCodPuestoRP.ToString.PadLeft(6, "0")
        '    Session("AgenteRP") = oTablaTemp.Rows(0)("Agente").ToString.PadLeft(5, "0") 'mAgenteRP.ToString.PadLeft(5, "0")
        '    Session("SucursalRP") = oTablaTemp.Rows(0)("Sucursal")
        '    If mCodPuestoRP = 0 Then
        '        Session("mnuRPVisible") = False
        '    Else
        '        Session("mnuRPVisible") = True

        '    End If

        '    If mHabilitadoEntregaDinero = 0 Then
        '        Session("mnuRetiroDinero") = False
        '    Else
        '        Session("mnuRetiroDinero") = True

        '    End If

        '    'Response.Redirect("Page/Noticias.aspx")
        '    Response.Redirect("Page/RecargaSaldoVirtual.aspx")
        '    'Response.Redirect("Page/Menu.aspx", False)
        '    'Server.Transfer("Page/Menu.aspx")

    End Sub



End Class
