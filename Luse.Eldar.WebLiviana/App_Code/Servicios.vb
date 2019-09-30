Imports System.Web.Services
Imports System.ComponentModel
Imports System.Data
Imports System.Web.Configuration

' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Servicios
    Inherits System.Web.Services.WebService


    Public Class Parametros

        Private mIDProducto As Integer
        Public Property IDProducto() As Integer
            Get
                Return mIDProducto
            End Get
            Set(ByVal value As Integer)
                mIDProducto = value
            End Set
        End Property
        Private mPassActual As String
        Public Property PassActual() As String
            Get
                Return mPassActual
            End Get
            Set(ByVal value As String)
                mPassActual = value
            End Set
        End Property

        Private mDireccionAgencia As String
        Public Property DireccionAgencia() As String
            Get
                Return mDireccionAgencia
            End Get
            Set(ByVal value As String)
                mDireccionAgencia = value
            End Set
        End Property

        Private mNombreAgencia As String
        Public Property NombreAgencia() As String
            Get
                Return mNombreAgencia
            End Get
            Set(ByVal value As String)
                mNombreAgencia = value
            End Set
        End Property

        Private mNewPass As String
        Public Property NewPass() As String
            Get
                Return mNewPass
            End Get
            Set(ByVal value As String)
                mNewPass = value
            End Set
        End Property

        Private mRepNewPass As String
        Public Property RepNewPass() As String
            Get
                Return mRepNewPass
            End Get
            Set(ByVal value As String)
                mRepNewPass = value
            End Set
        End Property

        Private mMensaje As String
        Public Property Mensaje() As String
            Get
                Return mMensaje
            End Get
            Set(ByVal value As String)
                mMensaje = value
            End Set
        End Property



        Private mIDAgencia As Long
        Public Property IDAgencia() As Long
            Get
                Return mIDAgencia
            End Get
            Set(ByVal value As Long)
                mIDAgencia = value
            End Set
        End Property

        Private mNroTarjeta As String
        Public Property NroTarjeta() As String
            Get
                Return mNroTarjeta
            End Get
            Set(ByVal value As String)
                mNroTarjeta = value
            End Set
        End Property

        Private mUser As String
        Public Property User() As String
            Get
                Return mUser
            End Get
            Set(ByVal value As String)
                mUser = value
            End Set
        End Property

        Private mPass As String
        Public Property Pass() As String
            Get
                Return mPass
            End Get
            Set(ByVal value As String)
                mPass = value
            End Set
        End Property


        Private mNroRecibo As Long
        Public Property NroRecibo() As Long
            Get
                Return mNroRecibo
            End Get
            Set(ByVal value As Long)
                mNroRecibo = value
            End Set
        End Property


        Private mMonto As Integer
        Public Property Monto() As Integer
            Get
                Return mMonto
            End Get
            Set(ByVal value As Integer)
                mMonto = value
            End Set
        End Property

        Private mMontoDecimal As Decimal
        Public Property MontoDecimal() As Decimal
            Get
                Return mMontoDecimal
            End Get
            Set(ByVal value As Decimal)
                mMontoDecimal = value
            End Set
        End Property

        Private mFecha As String
        Public Property Fecha() As String
            Get
                Return mFecha
            End Get
            Set(ByVal value As String)
                mFecha = value
            End Set
        End Property
        Private mFechaHasta As String
        Public Property FechaHasta() As String
            Get
                Return mFechaHasta
            End Get
            Set(ByVal value As String)
                mFechaHasta = value
            End Set
        End Property


        Private mDestino As String
        Public Property Destino() As String
            Get
                Return mDestino
            End Get
            Set(ByVal value As String)
                mDestino = value
            End Set
        End Property



        Private mIDPrestamoBase As Integer
        Public Property IDPrestamoBase() As Integer
            Get
                Return mIDPrestamoBase
            End Get
            Set(ByVal value As Integer)
                mIDPrestamoBase = value
            End Set
        End Property
        Private mIDProveedor As Integer
        Public Property IDProveedor() As Integer
            Get
                Return mIDProveedor
            End Get
            Set(ByVal value As Integer)
                mIDProveedor = value
            End Set
        End Property
        Public Sub New()

        End Sub

        Private mPrefijo As String
        Public Property Prefijo() As String
            Get
                Return mPrefijo
            End Get
            Set(ByVal value As String)
                mPrefijo = value
            End Set
        End Property
    End Class

    Public Class Respuesta

        Public Estado As Boolean
        Public Mensaje As String

    End Class

    Public Class Proveedores

        Public IDProveedor As Long
        Public NombreProveedor As String

    End Class

    Public Class MontosDisponibles

        Public IDMonto As Long
        Public Descripcion As String

    End Class

    Public Class ProductoPin

        Public IDProducto As Long
        Public NombreProducto As String

    End Class


    Public Class RespuestaRecarga

        Public Estado As String
        Public Mensaje As String
        Public IDTransaccion As String
        Public NroTarjeta As String
        Public Monto As String
        Public CantVtas As String
        Public TotalVtas As String
        Public Destino As String
        Public UrlSitio As String
        Public UrlSitioTicket As String
        Public CodigoTicket As String
        Public TemplateTicket As String

    End Class




    <WebMethod()>
    Public Function OpenTurn(pObj As Parametros) As List(Of Respuesta)

        Dim oEldar As New LuSe.WsTransaccional.ExternalSales
        Dim oRetorno As New LuSe.WsTransaccional.ObjetoRetorno
        Dim mRes As Boolean = False
        Dim mMsn As String = ""
        Dim oRta As New Respuesta
        Dim olstRta As New List(Of Respuesta)
        Try
            Dim musuario As String
            musuario = pObj.User + "|" + pObj.Pass + "|0|Escritorio"
            oRetorno = oEldar.AbrirTurno(musuario)
            'oRetorno.oArraylista[1]
            If oRetorno.oArraylista(0) = "ISOQRYOK" Then
                oRta.Estado = True
                oRta.Mensaje = oRetorno.oArraylista(1)
            Else
                oRta.Estado = False
                oRta.Mensaje = oRetorno.oArraylista(2)
            End If

            olstRta.Add(oRta)
            Return olstRta

        Catch ex As Exception
            oRta.Estado = False
            oRta.Mensaje = ex.Message
            olstRta.Add(oRta)
            Return olstRta
        End Try



    End Function

    <WebMethod()>
    Public Function CloseTurn(pObj As Parametros) As List(Of Respuesta)

        Dim oEldar As New LuSe.WsTransaccional.ExternalSales
        Dim oRetorno As New LuSe.WsTransaccional.ObjetoRetorno
        Dim mRes As Boolean = False
        Dim mMsn As String = ""
        Dim oRta As New Respuesta
        Dim olstRta As New List(Of Respuesta)
        Try
            Dim musuario As String
            musuario = pObj.User + "|" + pObj.Pass + "|0|Escritorio"
            oRetorno = oEldar.CerrarTurno(musuario)

            If oRetorno.oArraylista(0) = "ISOQRYOK" Then
                oRta.Estado = True
                oRta.Mensaje = "Turno Cerrado con exito"
            Else
                oRta.Estado = False
                oRta.Mensaje = oRetorno.oArraylista(2)
            End If

            olstRta.Add(oRta)
            Return olstRta

        Catch ex As Exception
            oRta.Estado = False
            oRta.Mensaje = ex.Message
            olstRta.Add(oRta)
            Return olstRta
        End Try



    End Function

    <WebMethod()>
    Public Function LastTenTurns(pObj As Parametros) As List(Of Respuesta)

        Dim oEldar As New LuSe.WsTransaccional.ExternalSales
        Dim oRetorno As New DataSet
        Dim oRta As New Respuesta
        Dim olstRta As New List(Of Respuesta)
        Try
            Dim musuario As String
            musuario = pObj.User + "|" + pObj.Pass + "|0|Escritorio"
            oRetorno = oEldar.LastTenTurn(musuario)
            Dim mRes As New StringBuilder
            mRes.Append("[")

            '   Turnos.FechaApertura, Turnos.AccesoApertura, Turnos.FechaCierre,
            '   Turnos.AccesoCierre, Turnos.StockInicial, Turnos.StockFinal,
            '   Turnos.TotalVentasOK, Turnos.TotalAsigStock,
            '   Turnos.OtrosPositivos, Turnos.OtrosNegativos " _
            '& " , Agencia.Nombre, Turnos.TotalCantVtasOk
            For Each Item As DataRow In oRetorno.Tables(0).Rows
                mRes.Append("{""TotalVentasOK"":""" & Item("TotalVentasOK") & """,""TotalAsigStock"":""" &
                            Item("TotalAsigStock") & """,""OtrosPositivos"":""" &
                            Item("OtrosPositivos") & """,""OtrosNegativos"":""" &
                            Item("OtrosNegativos") & """,""FechaCierre"":""" &
                            Item("FechaCierre") & """,""FechaApertura"":""" &
                            Convert.ToDateTime(Item("FechaApertura")) & """,""TotalCantVtasOk"":""" & Item("TotalCantVtasOk") & """,""StockFinal"":""" & Item("StockFinal") &
                            """,""Cerrado"":""" & IIf(Item("Cerrado") = True, "SI", "NO") & """,""AccesoApertura"":""" &
                            Item("AccesoApertura") & """,""AccesoCierre"": """ &
                            Item("AccesoCierre") & """, ""StockInicial"": """ & Item("StockInicial") & """},")

            Next
            Dim oREST As String
            oREST = mRes.ToString.Substring(0, mRes.Length - 1)


            oRta.Estado = True
            oRta.Mensaje = oREST & "]"
            olstRta.Add(oRta)
            Return olstRta

        Catch ex As Exception
            oRta.Estado = False
            oRta.Mensaje = ex.Message
            olstRta.Add(oRta)
            Return olstRta
        End Try



    End Function


    <WebMethod()>
    Public Function GetTurnsXDAte(pObj As Parametros) As List(Of Respuesta)

        Dim oEldar As New LuSe.WsTransaccional.ExternalSales
        Dim oRetorno As New DataSet
        Dim oRta As New Respuesta
        Dim olstRta As New List(Of Respuesta)

        Try
            Dim oFusion As New LuSe.WsTransaccional.ExternalSales
            If pObj.Fecha = "" Then
                pObj.Fecha = Format(Now.Date, "yyyy-MM-dd")
            End If
            Dim musuario As String
            musuario = pObj.User + "|" + pObj.Pass + "|0|Escritorio"
            oRetorno = oEldar.LastTurnByDate(musuario, pObj.Fecha)

            Dim mRes As New StringBuilder
            mRes.Append("[")

            For Each Item As DataRow In oRetorno.Tables(0).Rows
                mRes.Append("{""TotalVentasOK"":""" & Item("TotalVentasOK") & """,""TotalAsigStock"":""" &
                            Item("TotalAsigStock") & """,""OtrosPositivos"":""" &
                            Item("OtrosPositivos") & """,""OtrosNegativos"":""" &
                            Item("OtrosNegativos") & """,""FechaCierre"":""" &
                            Item("FechaCierre") & """,""FechaApertura"":""" &
                            Convert.ToDateTime(Item("FechaApertura")) & """,""TotalCantVtasOk"":""" & Item("TotalCantVtasOk") & """,""StockFinal"":""" & Item("StockFinal") &
                            """,""Cerrado"":""" & IIf(Item("Cerrado") = True, "SI", "NO") & """,""AccesoApertura"":""" &
                            Item("AccesoApertura") & """,""AccesoCierre"": """ &
                            Item("AccesoCierre") & """, ""StockInicial"": """ & Item("StockInicial") & """},")

            Next
            Dim oREST As String
            oREST = mRes.ToString.Substring(0, mRes.Length - 1)


            oRta.Estado = True
            oRta.Mensaje = oREST & "]"
            olstRta.Add(oRta)
            Return olstRta

        Catch ex As Exception
            oRta.Estado = False
            oRta.Mensaje = ex.Message
            olstRta.Add(oRta)
            Return olstRta
        End Try



    End Function

    <WebMethod()>
    Public Function GetNews(pObj As Parametros) As List(Of Respuesta)

        Dim oEldar As New LuSe.WsTransaccional.ExternalSales
        Dim mRes As Boolean = False
        Dim mMsn As String = ""
        Dim oRta As New Respuesta
        Dim olstRta As New List(Of Respuesta)
        Try
            mRes = oEldar.GetNews(pObj.User, pObj.Pass, mMsn)

            oRta.Estado = mRes
            oRta.Mensaje = mMsn
            olstRta.Add(oRta)
            Return olstRta

        Catch ex As Exception
            oRta.Estado = False
            oRta.Mensaje = ex.Message
            olstRta.Add(oRta)
            Return olstRta
        End Try



    End Function

    <WebMethod()>
    Public Function AddSolicitudStock(pObj As Parametros) As List(Of Respuesta)

        Dim oEldar As New LuSe.WsTransaccional.ExternalSales
        Dim mRes As String = ""
        Dim mMsn As String = ""
        Dim oRta As New Respuesta
        Dim olstRta As New List(Of Respuesta)
        Try
            mRes = oEldar.SolicitudStockWebLiviana(pObj.User, pObj.Pass,
                                           pObj.Monto, 0)

            oRta.Estado = True
            oRta.Mensaje = mRes
            olstRta.Add(oRta)
            Return olstRta

        Catch ex As Exception
            oRta.Estado = False
            oRta.Mensaje = ex.Message
            olstRta.Add(oRta)
            Return olstRta
        End Try



    End Function

    <WebMethod()>
    Public Function ChangePassword(pObj As Parametros) As List(Of Respuesta)

        Dim oEldar As New LuSe.WsTransaccional.ExternalSales
        Dim mRes As Boolean = False
        Dim mMsn As String = ""
        Dim oRta As New Respuesta
        Dim olstRta As New List(Of Respuesta)


        If pObj.NewPass <> pObj.RepNewPass Then
            oRta.Estado = False
            oRta.Mensaje = "La contraseña nueva y la anterior no coinciden"
            olstRta.Add(oRta)
            Return olstRta
        End If


        If pObj.PassActual <> "" AndAlso pObj.PassActual <> pObj.Pass Then
            oRta.Estado = False
            oRta.Mensaje = "el valor ingresado en contraseña actual es incorrecto"
            olstRta.Add(oRta)
            Return olstRta
        End If

        If pObj.NewPass = pObj.Pass Then
            oRta.Estado = False
            oRta.Mensaje = "La contraseña nueva debe ser diferente a la actual."
            olstRta.Add(oRta)
            Return olstRta
        End If

        Dim mCode As String = pObj.PassActual & "|" & pObj.NewPass & "|" & pObj.RepNewPass

        mRes = oEldar.CambiarPassword(pObj.User, pObj.Pass,
                                mCode, mMsn)


        oRta.Estado = mRes
        oRta.Mensaje = mMsn
        olstRta.Add(oRta)
        Return olstRta


    End Function

    <WebMethod()>
    Public Function GetSaldoAgencia(pObj As Parametros) As List(Of RespuestaRecarga)
        Dim oEldar As New LuSe.WsTransaccional.ExternalSales
        Dim oRta As New RespuestaRecarga
        Dim oList As New List(Of RespuestaRecarga)
        Try

            'Obtengo el Saldo de la agencia
            oEldar.GetSaldoWeb(pObj.User, pObj.Pass, oRta.Monto, oRta.TotalVtas, oRta.CantVtas)

            oRta.Estado = "Ok"

        Catch ex As Exception
            oRta.Mensaje = "Error al Obtener el saldo." & ex.Message
            oRta.Estado = "Fail"
            oRta.Monto = "0"
        End Try
        oList.Add(oRta)

        Return oList

    End Function

    Public Function NewSaleSube(pObj As Parametros) As List(Of RespuestaRecarga)
        Dim oEldar As New LuSe.WsTransaccional.ExternalSales
        Dim oList As New List(Of RespuestaRecarga)
        Dim oRespuestaRecarga As New RespuestaRecarga
        Try
            Dim mRes As Boolean = False
            Dim mMsn As String = ""
            Dim pIDtransaccion As String = ""
            Dim pSaleData As String = ""
            Dim pRefOperador As String = "" 'Este Valor lo asigna eldar al enviar la recarga a SUBE.
            Dim mDireccion As String = ""
            Dim mRazonSocial As String = ""

            pObj.NroTarjeta = "606126" & pObj.NroTarjeta

            mRes = oEldar.NewSaleWithRefOperadorSube(pObj.User,
                                                pObj.Pass, pObj.NroTarjeta, pObj.Monto, pRefOperador, pIDtransaccion, pSaleData,
                                                 mMsn)




            oRespuestaRecarga.IDTransaccion = pIDtransaccion
            oRespuestaRecarga.Mensaje = mMsn
            Dim mNroTarOfuscado As String = "XXXX XXXX XXXX " & pObj.NroTarjeta.Substring(12, 3) & "X"
            oRespuestaRecarga.NroTarjeta = mNroTarOfuscado
            oRespuestaRecarga.Monto = pObj.Monto
            oRespuestaRecarga.Estado = pSaleData
            oRespuestaRecarga.UrlSitio = GetSiteRoot()

            If pSaleData = "Ok" Then

                oRespuestaRecarga.TemplateTicket = pObj.NombreAgencia & "|" & pObj.DireccionAgencia & "|" & pIDtransaccion & "|" & mNroTarOfuscado & "|" & pObj.Monto


            End If

            oList.Add(oRespuestaRecarga)


        Catch ex As Exception
            oRespuestaRecarga.Estado = False
            oRespuestaRecarga.Mensaje = ex.Message
            oList.Add(oRespuestaRecarga)
        End Try
        Return oList

    End Function

    <WebMethod()>
    Public Function GrabarVentaDTV(pObj As Parametros) As List(Of RespuestaRecarga)
        Dim oRta As New RespuestaRecarga
        Dim oList As New List(Of RespuestaRecarga)
        Dim oEldar As New LuSe.WsTransaccional.ExternalSales
        Try

            Dim mRes As Boolean = False
            Dim mMsn As String = ""
            Dim pIDtransaccion As String = ""
            Dim pSaleData As String = ""
            Dim pRefOperador As String = "" 'Este Valor lo asigna eldar al enviar la recarga a SUBE.
            Dim CodigoTicket As String = ""
            '15=Proveedor DTV
            pObj.Destino = "05700" & pObj.Destino

            mRes = oEldar.NewSaleDirecTVWebLiviana(pObj.User, pObj.Pass, pObj.Destino, pObj.Monto,
                                                          15, pIDtransaccion, pSaleData, mMsn, CodigoTicket)




            oRta.IDTransaccion = pIDtransaccion
            oRta.Mensaje = mMsn
            oRta.Destino = pObj.Prefijo & pObj.Destino
            oRta.Monto = pObj.Monto
            oRta.Estado = pSaleData
            oRta.CodigoTicket = CodigoTicket
            oRta.UrlSitio = GetSiteRoot()
            Dim uri As New Uri(oEldar.Url)

            oRta.UrlSitioTicket = uri.Host

            oRta.TemplateTicket = pObj.NombreAgencia & "|" & pObj.DireccionAgencia & "|" & pIDtransaccion & "|" & oRta.Destino & "|" & pObj.Monto & "|" & oRta.Estado & "|" & mMsn


            oList.Add(oRta)

        Catch ex As Exception
            oRta.Estado = False
            oRta.Mensaje = ex.Message
            oList.Add(oRta)
        End Try
        Return oList

    End Function


    <WebMethod()>
    Public Function GrabarVentaPin(pObj As Parametros) As List(Of RespuestaRecarga)
        Dim oRta As New RespuestaRecarga
        Dim oList As New List(Of RespuestaRecarga)
        Dim oEldar As New LuSe.WsTransaccional.ExternalSales
        Try

            Dim mRes As Boolean = False
            Dim mMsn As String = ""
            Dim pIDtransaccion As String = ""
            Dim pSaleData As String = ""
            Dim pPinSeguridad As String = ""
            Dim pNroSerie As String = ""
            Dim pFechaExp As String = ""
            Dim pRefOperador As String = "" 'Este Valor lo asigna eldar al enviar la recarga a SUBE.

            pObj.Prefijo = "00"
            mRes = oEldar.NewSalePinWebLiviana(pObj.User, pObj.Pass, pObj.IDProducto, pNroSerie, pPinSeguridad, pFechaExp, mMsn)




            oRta.Mensaje = mMsn
            oRta.Estado = mRes
            oRta.CodigoTicket = pPinSeguridad
            oRta.UrlSitio = GetSiteRoot()
            Dim uri As New Uri(oEldar.Url)

            oRta.UrlSitioTicket = uri.Host

            oRta.TemplateTicket = pObj.NombreAgencia & "|" & pObj.DireccionAgencia & "|" & oRta.Estado & "|" & pNroSerie & "|" & pPinSeguridad & "|" & pFechaExp & "|" & mMsn

            oList.Add(oRta)

        Catch ex As Exception
            oRta.Estado = False
            oRta.Mensaje = ex.Message
            oRta.CodigoTicket = "0"
            oRta.UrlSitio = ""
            oList.Add(oRta)
        End Try
        Return oList

    End Function

    <WebMethod()>
    Public Function GrabarVentaSaldo(pObj As Parametros) As List(Of RespuestaRecarga)
        Dim oRta As New RespuestaRecarga
        Dim oList As New List(Of RespuestaRecarga)
        Dim oEldar As New LuSe.WsTransaccional.ExternalSales
        Try

            Dim mRes As Boolean = False
            Dim mMsn As String = ""
            Dim pIDtransaccion As String = ""
            Dim pSaleData As String = ""
            Dim CodigoTicket As String = ""
            Dim pRefOperador As String = "" 'Este Valor lo asigna eldar al enviar la recarga a SUBE.

            pObj.Prefijo = "00"
            mRes = oEldar.NewSaleWithRefOperadorWebLiviana(pObj.User, pObj.Pass, pObj.Destino, pObj.Prefijo, pObj.Monto,
                                                           pObj.IDProveedor, pIDtransaccion, pSaleData, mMsn, CodigoTicket)




            oRta.IDTransaccion = pIDtransaccion
            oRta.Mensaje = mMsn
            oRta.Destino = pObj.Prefijo & pObj.Destino
            oRta.Monto = pObj.Monto
            oRta.Estado = pSaleData
            oRta.CodigoTicket = CodigoTicket

            oRta.UrlSitio = GetSiteRoot()
            Dim uri As New Uri(oEldar.Url)

            oRta.UrlSitioTicket = uri.Host

            oRta.TemplateTicket = pObj.NombreAgencia & "|" & pObj.DireccionAgencia & "|" & pIDtransaccion & "|" & oRta.Destino & "|" & pObj.Monto & "|" & oRta.Estado & "|" & mMsn

            oList.Add(oRta)



        Catch ex As Exception
            oRta.Estado = False
            oRta.Mensaje = ex.Message
            oRta.CodigoTicket = "0"
            oRta.UrlSitio = ""
            oList.Add(oRta)
        End Try
        Return oList

    End Function

    Public Shared Function GetSiteRoot() As String
        If System.Web.HttpContext.Current IsNot Nothing Then

            Dim Protocol As String = System.Web.HttpContext.Current.Request.ServerVariables("SERVER_PORT_SECURE")

            If Protocol Is Nothing OrElse Protocol = "0" Then
                Protocol = "http://"
            Else
                Protocol = "https://"
            End If
            Dim sOut As String = Protocol & System.Web.HttpContext.Current.Request.ServerVariables("HTTP_HOST") & System.Web.HttpContext.Current.Request.ApplicationPath

            If sOut.Chars(sOut.Length - 1) = "/" Then
                sOut = Left(sOut, sOut.Length - 1)
            End If

            Return sOut
        Else
            Return ""
        End If
    End Function

    <WebMethod()>
    Public Function GetProveedores(pObj As Parametros) As List(Of Proveedores)

        Dim oList As New List(Of Proveedores)
        Dim oProveedores As New Proveedores
        'For Each item As DataRow In oDs.Tables(0).Rows
        '    oProveedores = New Proveedores
        '    oProveedores.IDProveedor = item("IDCliente")
        '    oProveedores.NombreProveedor = item("NombreCliente")
        '    oList.Add(oProveedores)
        'Next


        oProveedores = New Proveedores

        oProveedores.IDProveedor = 2
        oProveedores.NombreProveedor = "Claro"
        oList.Add(oProveedores)
        oProveedores = New Proveedores
        oProveedores.IDProveedor = 4
        oProveedores.NombreProveedor = "Movistar"
        oList.Add(oProveedores)
        oProveedores = New Proveedores
        oProveedores.IDProveedor = 3
        oProveedores.NombreProveedor = "Personal"
        oList.Add(oProveedores)
        oProveedores = New Proveedores
        oProveedores.IDProveedor = 5
        oProveedores.NombreProveedor = "Nextel"
        oList.Add(oProveedores)
        oProveedores = New Proveedores
        oProveedores.IDProveedor = 24
        oProveedores.NombreProveedor = "Tuenti"
        oList.Add(oProveedores)


        Return oList


    End Function

    <WebMethod()>
    Public Function GetMontos(pObj As Parametros) As List(Of MontosDisponibles)

        Dim oList As New List(Of MontosDisponibles)
        Dim oMontosDisponibles As New MontosDisponibles

        oMontosDisponibles = New MontosDisponibles
        'Ej 50 / 100 / 150 / 200 / 250 / 300 / 400 / 500 / 600 / 700 / 800)
        oMontosDisponibles.IDMonto = 50
        oMontosDisponibles.Descripcion = "50"
        oList.Add(oMontosDisponibles)
        oMontosDisponibles = New MontosDisponibles
        oMontosDisponibles.IDMonto = 100
        oMontosDisponibles.Descripcion = "100"
        oList.Add(oMontosDisponibles)
        oMontosDisponibles = New MontosDisponibles
        oMontosDisponibles.IDMonto = 150
        oMontosDisponibles.Descripcion = "150"
        oList.Add(oMontosDisponibles)
        oMontosDisponibles = New MontosDisponibles
        oMontosDisponibles.IDMonto = 200
        oMontosDisponibles.Descripcion = "200"
        oList.Add(oMontosDisponibles)
        oMontosDisponibles = New MontosDisponibles
        oMontosDisponibles.IDMonto = 250
        oMontosDisponibles.Descripcion = "250"
        oList.Add(oMontosDisponibles)
        oMontosDisponibles = New MontosDisponibles
        oMontosDisponibles.IDMonto = 300
        oMontosDisponibles.Descripcion = "300"
        oList.Add(oMontosDisponibles)
        oMontosDisponibles = New MontosDisponibles
        oMontosDisponibles.IDMonto = 400
        oMontosDisponibles.Descripcion = "400"
        oList.Add(oMontosDisponibles)
        oMontosDisponibles = New MontosDisponibles
        oMontosDisponibles.IDMonto = 500
        oMontosDisponibles.Descripcion = "500"
        oList.Add(oMontosDisponibles)
        oMontosDisponibles = New MontosDisponibles
        oMontosDisponibles.IDMonto = 600
        oMontosDisponibles.Descripcion = "600"
        oList.Add(oMontosDisponibles)
        oMontosDisponibles = New MontosDisponibles
        oMontosDisponibles.IDMonto = 700
        oMontosDisponibles.Descripcion = "700"
        oList.Add(oMontosDisponibles)
        oMontosDisponibles = New MontosDisponibles
        oMontosDisponibles.IDMonto = 800
        oMontosDisponibles.Descripcion = "800"
        oList.Add(oMontosDisponibles)


        Return oList


    End Function

    <WebMethod()>
    Public Function GetProductoPin(pObj As Parametros) As List(Of ProductoPin)

        Dim oRta As New Respuesta
        Dim oDs As DataSet
        Dim olstRta As New List(Of ProductoPin)
        Try
            Dim oFusion As New LuSe.WsTransaccional.ExternalSales

            oDs = oFusion.GetProductsWebLiviana(pObj.User, pObj.Pass, pObj.IDProveedor)

            For Each Item As DataRow In oDs.Tables(0).Rows
                Dim oProd As New ProductoPin
                oProd.IDProducto = Item("IDProducto")
                oProd.NombreProducto = Item("NombreProducto")
                olstRta.Add(oProd)
            Next
            oRta.Estado = True

            Return olstRta
        Catch ex As Exception
            oRta.Estado = False
            oRta.Mensaje = "Error: " & ex.Message

            Return olstRta
        End Try
    End Function


    <WebMethod()>
    Public Function SaveSolicitudPrestamo(pObj As Parametros) As List(Of ProductoPin)

        Dim oRta As New Respuesta
        Dim oDs As DataSet
        Dim olstRta As New List(Of ProductoPin)
        Try
            Dim oFusion As New LuSe.WsTransaccional.ExternalSales

            oRta.Estado = oFusion.SaveSolicitudPrestamo(pObj.User, pObj.Pass, pObj.IDPrestamoBase, pObj.Destino)

            oRta.Mensaje = "Su Consulta se genero con exito"


            Dim correo As New System.Net.Mail.MailMessage()
            correo.From = New System.Net.Mail.MailAddress(WebConfigurationManager.AppSettings("MailFrom").ToString())
            correo.To.Add(WebConfigurationManager.AppSettings("MailTO").ToString())

            correo.Subject = "Solicitud Credito Agencia"
            correo.Body = "La Agencia " & pObj.NombreAgencia & " Esta identificada como NO APTA por la sucursal. pero la misma solicita informacion sobre creditos. Su Nro Contacto es: " & pObj.Destino &
                        " Recibio el siguiente mensaje en pantalla " & vbCrLf & pObj.Mensaje
            correo.IsBodyHtml = True
            correo.Priority = Net.Mail.MailPriority.Normal
            Dim ls_SmtpClient As New System.Net.Mail.SmtpClient
            ls_SmtpClient.Host = WebConfigurationManager.AppSettings("Host").ToString() '"200.115.185.11"
            ls_SmtpClient.Port = WebConfigurationManager.AppSettings("Puerto").ToString()

            Try
                ls_SmtpClient.Send(correo)
            Catch ee As Exception
                oRta.Estado = False
                oRta.Mensaje = ee.Message
            End Try

            Return olstRta
        Catch ex As Exception
            oRta.Estado = False
            oRta.Mensaje = "Error: " & ex.Message

            Return olstRta
        End Try
    End Function

    <WebMethod()>
    Public Function GetProveedoresPines(pObj As Parametros) As List(Of Proveedores)

        Dim oList As New List(Of Proveedores)
        Dim oProveedores As New Proveedores
        'For Each item As DataRow In oDs.Tables(0).Rows
        '    oProveedores = New Proveedores
        '    oProveedores.IDProveedor = item("IDCliente")
        '    oProveedores.NombreProveedor = item("NombreCliente")
        '    oList.Add(oProveedores)
        'Next

        oProveedores = New Proveedores
        oProveedores.IDProveedor = 7
        oProveedores.NombreProveedor = "Telefonica"
        oList.Add(oProveedores)
        oProveedores = New Proveedores
        oProveedores.IDProveedor = 18
        oProveedores.NombreProveedor = "Teletel"
        oList.Add(oProveedores)
        oProveedores = New Proveedores
        oProveedores.IDProveedor = 13
        oProveedores.NombreProveedor = "Hablemas"
        oList.Add(oProveedores)

        Return oList


    End Function

    <WebMethod()>
    Public Function GetVentas(pObj As Parametros) As List(Of Respuesta)

        Dim oRta As New Respuesta
        Dim oDs As DataSet
        Dim olstRta As New List(Of Respuesta)
        Try
            Dim oFusion As New LuSe.WsTransaccional.ExternalSales
            If pObj.Fecha = "" Then
                pObj.Fecha = Format(Now.Date, "yyyy-MM-dd")

            End If
            If pObj.FechaHasta = "" Then
                pObj.FechaHasta = Format(Now.Date, "yyyy-MM-dd")
            End If
            If pObj.Destino = "" Then
                pObj.Destino = "0"

            End If

            oDs = oFusion.GetTransaccionesWebLiviana(pObj.User, pObj.Pass, pObj.Fecha, pObj.Destino, pObj.FechaHasta)


            Dim mRes As New StringBuilder
            mRes.Append("[")

            For Each Item As DataRow In oDs.Tables(0).Rows
                mRes.Append("{""Producto"":""" & Item("NombreProducto") & """,""Fecha"":""" & Item("Fecha") & """,""Monto"": """ & Item("Monto") & """, ""IdTransaccion"": """ & Item("IdTransaccion") & """,""Destino"": """ & Item("Destino") & """,""Usuario"": """ & Item("UserCode") & """,""IDVenta"": """ & Item("IDVenta") & """,""Estado"": """ & Item("Estado") & """},")

            Next
            Dim oREST As String
            oREST = mRes.ToString.Substring(0, mRes.Length - 1)


            oRta.Estado = True
            oRta.Mensaje = oREST & "]"
            olstRta.Add(oRta)
            Return olstRta
        Catch ex As Exception
            oRta.Estado = False
            oRta.Mensaje = "Error: " & ex.Message
            olstRta.Add(oRta)
            Return olstRta
        End Try

    End Function

    <WebMethod()>
    Public Function GetMovStock(pObj As Parametros) As List(Of Respuesta)

        Dim oRta As New Respuesta
        Dim oDs As DataSet
        Dim oRes As String
        Dim olstRta As New List(Of Respuesta)
        Try
            Dim oFusion As New LuSe.WsTransaccional.ExternalSales
            If pObj.Fecha = "" Then
                pObj.Fecha = Format(Now.Date, "yyyy-MM-dd")
            End If
            If pObj.FechaHasta = "" Then
                pObj.FechaHasta = Format(Now.Date, "yyyy-MM-dd")
            End If
            oRes = oFusion.GetMovStockWebLiviana(pObj.User, pObj.Pass, pObj.Fecha, pObj.FechaHasta)

            oDs = LuSe.Framework.Common.Helper.XmlFunctions.XMLToDataSet(oRes)

            Dim mRes As New StringBuilder
            mRes.Append("[")

            For Each Item As DataRow In oDs.Tables(0).Rows
                mRes.Append("{""Fecha"":""" & Convert.ToDateTime(Item("Fecha")) & """,""Descripcion"":""" & Item("Descripcion") & """,""Monto"": """ & Item("Monto") & """, ""Agencia"": """ & Item("Agencia") & """},")

            Next
            Dim oREST As String
            oREST = mRes.ToString.Substring(0, mRes.Length - 1)


            oRta.Estado = True
            oRta.Mensaje = oREST & "]"
            olstRta.Add(oRta)
            Return olstRta
        Catch ex As Exception
            oRta.Estado = False
            oRta.Mensaje = "Error: " & ex.Message
            olstRta.Add(oRta)
            Return olstRta
        End Try

    End Function


End Class