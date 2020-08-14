Imports System.Web.Services
Imports System.ComponentModel
Imports System.Data
Imports System.Web.Configuration


Imports System.Web

Imports System.Web.Services.Protocols
Imports System.Web.Script.Serialization
Imports System.Net
Imports System.IO
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq
Imports Newtonsoft.Json.Converters
Imports Newtonsoft.Json.Serialization
Imports Newtonsoft
Imports System.Data.SqlClient

' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class Servicios
    Inherits System.Web.Services.WebService



    Public Function AcceptAllCertifications(sender As Object, certification As System.Security.Cryptography.X509Certificates.X509Certificate, chain As System.Security.Cryptography.X509Certificates.X509Chain, sslPolicyErrors As System.Net.Security.SslPolicyErrors) As Boolean

        Return True
    End Function

    Dim oConn As New SqlConnection(WebConfigurationManager.AppSettings("ConnStringEldar").ToString())
    Dim ocmd As New SqlCommand()

    Public Function GrabarVenta(IDAgencia As Long, IDAcceso As Long, pMonto As Decimal, pEmpresa As String, pCodPuesto As String,
                                     pCodBarra As String, pIDTransaccion As String, pRefOperador As String) As Boolean

        oConn.Open()
        Try

            ocmd = New SqlCommand("Venta_iRapipago", oConn)
            ocmd.CommandType = CommandType.StoredProcedure
            ocmd.Parameters.AddWithValue("@IDAgencia", IDAgencia)
            ocmd.Parameters.AddWithValue("@IDAcceso", IDAcceso)
            ocmd.Parameters.AddWithValue("@Monto", pMonto)
            ocmd.Parameters.AddWithValue("@Empresa", pEmpresa)
            ocmd.Parameters.AddWithValue("@CodPuesto", pCodPuesto)
            ocmd.Parameters.AddWithValue("@CodBarra", pCodBarra)
            ocmd.Parameters.AddWithValue("@IDTransaccion", pIDTransaccion)
            ocmd.Parameters.AddWithValue("@RefOperador", pRefOperador)

            If ocmd.ExecuteNonQuery() > 0 Then
                Return True
            Else
                Return False
            End If

        Catch ex As Exception
            Throw ex
        Finally
            oConn.Close()
        End Try
    End Function


    Public Class FormasPago
        Public Property PES As String
    End Class

    Public Class DatosFormulario
    End Class

    Public Class ItemEnviar
        Public Property barra As String
        Public Property idMod As String
        Public Property codEmp As String
        Public Property Empresa As String
        Public Property fechaHoraLectura As String
        Public Property importeItem As String
        Public Property idItem As String
        Public Property formasPago As FormasPago
        Public Property datosFormulario As DatosFormulario
    End Class

    Public Class CabeceraEnviar
        Public Property items As ItemEnviar()
        Public Property codPuesto As String
        Public Property idMobile As String
        Public Property importeTotal As String
        Public Property idTrxAnterior As String
    End Class


    <WebMethod()>
    Public Function Pagar(datosFormulario As String, pIDAgencia As String, pIDAcceso As String) As Pago

        Dim ser As New JavaScriptSerializer()
        Dim oResError As New RespuestaRapipago
        Dim oRes As New Pago
        Dim oRespuestaPago As New Pago
        Dim oResEnvio As New CabeceraEnviar
        Dim postStream As Stream = Nothing
        Dim request As HttpWebRequest
        Dim response As HttpWebResponse = Nothing
        Dim address As Uri
        Dim dataSend As String
        Dim byteData() As Byte

        address = New Uri(WebConfigurationManager.AppSettings("UrlRapipago").ToString() & "factura/pago")
        Try
            ' Create the web request  
            request = DirectCast(WebRequest.Create(address), HttpWebRequest)

            ' SETEA A POST  
            request.Method = "POST"

            request.ContentType = "application/json"

            dataSend = datosFormulario

            oResEnvio = JsonConvert.DeserializeObject(Of CabeceraEnviar)(datosFormulario)


            ' Create a byte array of the data we want to send  
            byteData = UTF8Encoding.UTF8.GetBytes(dataSend)

            ' Set the content length in the request headers  
            request.ContentLength = byteData.Length

            ' Write data  
            Try
                postStream = request.GetRequestStream()
                postStream.Write(byteData, 0, byteData.Length)
            Finally
                If Not postStream Is Nothing Then postStream.Close()
            End Try
            ' Get response  
            response = DirectCast(request.GetResponse(), HttpWebResponse)

            ' Get the response stream into a reader  
            Using StreamReader As New StreamReader(response.GetResponseStream())

                Dim result As String = StreamReader.ReadToEnd()


                oRes = JsonConvert.DeserializeObject(Of Pago)(result)

                If oRes.codResul = 0 Then
                    ConfirmarOperacion(oRes.codPuesto, oRes.idTrx)
                End If

                'Enviar Recarga Eldar
                For Each item As Item In oRes.items.ToList
                    If item.codResulItem = 0 Then
                        For Each itemCab As ItemEnviar In oResEnvio.items
                            If item.barra = itemCab.barra Then
                                GrabarVenta(pIDAgencia, pIDAcceso, Convert.ToDecimal(itemCab.importeItem.Replace(".", ",")), itemCab.Empresa,
                                oRes.codPuesto, item.barra, item.idItem, oRes.idTrx)
                            End If
                        Next
                    End If

                Next

                'Enviar Recarga Eldar
                oRespuestaPago = New Pago
                Dim ThisToken As JObject = Newtonsoft.Json.JsonConvert.DeserializeObject(Of JObject)(result)
                If ThisToken("items").HasValues Then
                    For i = 0 To ThisToken("items").Count - 1


                        Dim ThisTokenTicket As JArray = Newtonsoft.Json.JsonConvert.DeserializeObject(Of JArray)(JsonConvert.SerializeObject(ThisToken("items")))
                        Dim oItem As New Item
                        If ThisTokenTicket.Item(i).Item("ticket").HasValues Then
                            For a = 0 To ThisTokenTicket.Item(i).Item("ticket").Count - 1

                                For c = 0 To ThisTokenTicket.Item(i).Item("ticket").Item(a).Count - 1
                                    Dim oJValue As New JValue(ThisTokenTicket.Item(i).Item("ticket").Item(a).Item(c).ToString)

                                    oItem.tic.Add(oJValue.Value)
                                Next

                            Next
                        End If


                        oItem.codResulItem = ThisTokenTicket.Item(i).Item("codResulItem").ToString
                        oItem.descResulItem = ThisTokenTicket.Item(i).Item("descResulItem").ToString
                        oItem.barra = ThisTokenTicket.Item(i).Item("barra").ToString
                        oItem.idItem = ThisTokenTicket.Item(i).Item("idItem").ToString

                        oRespuestaPago.items.Add(oItem)
                        If oItem.codResulItem <> 0 Then

                            Dim oRespuesta As New RespuestaRapipago
                            Dim oObj As New ParametrosRapiPago
                            oObj.CodBarra = oItem.barra
                            oObj.codPuesto = oRes.codPuesto
                            oRespuesta = GetFacturas(oObj)
                            If oRespuesta.cantColisiones = 1 Then
                                oItem.Empresa = oRespuesta.facturas(0).descEmp
                                oItem.Importe = oRespuesta.facturas(0).importe
                                'ElseIf oRespuesta.cantColisiones = 9999 Then
                                '    'Hay una operacion sin confirmar la busco y actualizo
                                'Respuesta: por mas que mande 10 facturas a pagar todas se hacen bajo un mismo idtrx
                                'por lo que si oRes.CodResul=0 significa que por lo menos una de las operaciones se hizo OK
                                '    For p = 1 To 10
                                '        'Busco Operaciones Pendientes

                                '    Next


                                '    oItem.NombreEmpresa = oRespuesta.facturas(0).descEmp
                                '    oItem.Importe = oRespuesta.facturas(0).importe
                            Else
                                oItem.Empresa = oItem.barra
                                oItem.Importe = 0
                            End If

                        End If
                    Next
                End If
                Return oRespuestaPago

            End Using

        Finally
            If Not response Is Nothing Then response.Close()
        End Try

    End Function


    <WebMethod()>
    Public Function AnularFacturas(datosFormulario As String) As Pago

        Dim ser As New JavaScriptSerializer()
        Dim oResError As New RespuestaRapipago
        Dim oRes As New Pago
        Dim postStream As Stream = Nothing
        Dim request As HttpWebRequest
        Dim response As HttpWebResponse = Nothing
        Dim address As Uri
        Dim dataSend As String
        Dim byteData() As Byte

        address = New Uri(WebConfigurationManager.AppSettings("UrlRapipago").ToString() & "factura/anulacion")
        Try
            ' Create the web request  
            request = DirectCast(WebRequest.Create(address), HttpWebRequest)

            ' SETEA A POST  
            request.Method = "POST"

            request.ContentType = "application/json"

            dataSend = datosFormulario

            ' Create a byte array of the data we want to send  
            byteData = UTF8Encoding.UTF8.GetBytes(dataSend)

            ' Set the content length in the request headers  
            request.ContentLength = byteData.Length

            ' Write data  
            Try
                postStream = request.GetRequestStream()
                postStream.Write(byteData, 0, byteData.Length)
            Finally
                If Not postStream Is Nothing Then postStream.Close()
            End Try
            ' Get response  
            response = DirectCast(request.GetResponse(), HttpWebResponse)

            ' Get the response stream into a reader  
            Using StreamReader As New StreamReader(response.GetResponseStream())

                Dim result As String = StreamReader.ReadToEnd()


                oRes = JsonConvert.DeserializeObject(Of Pago)(result)

                If oRes.codResul = 0 Then
                    ConfirmarOperacion(oRes.codPuesto, oRes.idTrx)
                End If


                Dim ThisToken As JObject = Newtonsoft.Json.JsonConvert.DeserializeObject(Of JObject)(result)
                If ThisToken("facturas").HasValues Then
                    For i = 0 To ThisToken("facturas").Count - 1


                        Dim ThisTokenTicket As JArray = Newtonsoft.Json.JsonConvert.DeserializeObject(Of JArray)(JsonConvert.SerializeObject(ThisToken("facturas")))
                        Dim oItem As New Item
                        If ThisTokenTicket.Item(i).Item("ticket").HasValues Then
                            For a = 0 To ThisTokenTicket.Item(i).Item("ticket").Count - 1

                                For c = 0 To ThisTokenTicket.Item(i).Item("ticket").Item(a).Count - 1
                                    Dim oJValue As New JValue(ThisTokenTicket.Item(i).Item("ticket").Item(a).Item(c).ToString)

                                    oItem.tic.Add(oJValue.Value)
                                Next

                            Next
                        End If


                        oItem.codResulItem = ThisTokenTicket.Item(i).Item("codResulItem").ToString
                        oItem.descResulItem = ThisTokenTicket.Item(i).Item("descResulItem").ToString
                        oItem.barra = ThisTokenTicket.Item(i).Item("barra").ToString
                        ''oItem.idItem = ThisTokenTicket.Item(i).Item("idItem").ToString
                        oRes.items.Add(oItem)
                        If oItem.codResulItem <> 0 Then

                            Dim oRespuesta As New RespuestaRapipago
                            Dim oObj As New ParametrosRapiPago
                            oObj.CodBarra = oItem.barra
                            oObj.codPuesto = oRes.codPuesto
                            oRespuesta = GetFacturas(oObj)
                            If oRespuesta.cantColisiones = 1 Then
                                oItem.Empresa = oRespuesta.facturas(0).descEmp
                                oItem.Importe = oRespuesta.facturas(0).importe
                                'ElseIf oRespuesta.cantColisiones = 9999 Then
                                '    'Hay una operacion sin confirmar la busco y actualizo
                                'Respuesta: por mas que mande 10 facturas a pagar todas se hacen bajo un mismo idtrx
                                'por lo que si oRes.CodResul=0 significa que por lo menos una de las operaciones se hizo OK
                                '    For p = 1 To 10
                                '        'Busco Operaciones Pendientes

                                '    Next


                                '    oItem.NombreEmpresa = oRespuesta.facturas(0).descEmp
                                '    oItem.Importe = oRespuesta.facturas(0).importe
                            Else
                                oItem.Empresa = oItem.barra
                                oItem.Importe = 0
                            End If

                        End If
                    Next
                End If
                Return oRes

            End Using

        Finally
            If Not response Is Nothing Then response.Close()
        End Try

    End Function


    Public Function ConfirmarOperacion(codPuesto As String, idTrxAnterior As String) As Boolean
        Try


            Dim ser As New JavaScriptSerializer()
            Dim oResError As New RespuestaRapipago
            Dim oRes As New Grilla
            Dim postStream As Stream = Nothing

            Dim request As HttpWebRequest
            Dim response As HttpWebResponse = Nothing
            Dim address As Uri
            Dim dataSend As String

            Dim data As StringBuilder
            Dim byteData() As Byte



            address = New Uri(WebConfigurationManager.AppSettings("UrlRapipago").ToString() & "transaccion/confirmar")
            Try
                ' Create the web request  
                request = DirectCast(WebRequest.Create(address), HttpWebRequest)

                ' SETEA A POST  
                request.Method = "POST"

                request.ContentType = "application/json"

                dataSend = "{""codPuesto"":""" & codPuesto & """,""idTrxAnterior"": """ & idTrxAnterior & """}"

                ' Create a byte array of the data we want to send  
                byteData = UTF8Encoding.UTF8.GetBytes(dataSend)

                ' Set the content length in the request headers  
                request.ContentLength = byteData.Length

                ' Write data  
                Try
                    postStream = request.GetRequestStream()
                    postStream.Write(byteData, 0, byteData.Length)
                Finally
                    If Not postStream Is Nothing Then postStream.Close()
                End Try


                ' Get response  
                response = DirectCast(request.GetResponse(), HttpWebResponse)

                ' Get the response stream into a reader  
                Using StreamReader As New StreamReader(response.GetResponseStream())

                    Dim result As String = StreamReader.ReadToEnd()


                    oRes = JsonConvert.DeserializeObject(Of Grilla)(result)

                    If oRes.codResul = 0 Then
                        Return True
                    Else
                        Return False
                    End If

                End Using

            Finally
                If Not response Is Nothing Then response.Close()
            End Try
        Catch ex As Exception

        End Try
    End Function

    <WebMethod()>
    Public Function GetGrilla(codPuesto As String, idMod As String, idTrxAnterior As String, datosFormulario As String) As Grilla

        Dim ser As New JavaScriptSerializer()
        Dim oResError As New RespuestaRapipago
        Dim oRes As New Grilla
        Dim postStream As Stream = Nothing

        Dim request As HttpWebRequest
        Dim response As HttpWebResponse = Nothing
        Dim address As Uri
        Dim dataSend As String

        Dim data As StringBuilder
        Dim byteData() As Byte



        address = New Uri(WebConfigurationManager.AppSettings("UrlRapipago").ToString() & "factura/grilla")
        Try
            ' Create the web request  
            request = DirectCast(WebRequest.Create(address), HttpWebRequest)

            ' SETEA A POST  
            request.Method = "POST"

            request.ContentType = "application/json"

            dataSend = "{""codPuesto"":""" & codPuesto & """, ""idMod"":  """ & idMod & """,""idTrxAnterior"": """" , ""datosFormulario"": " & datosFormulario & "}"

            ' Create a byte array of the data we want to send  
            byteData = UTF8Encoding.UTF8.GetBytes(dataSend)

            ' Set the content length in the request headers  
            request.ContentLength = byteData.Length

            ' Write data  
            Try
                postStream = request.GetRequestStream()
                postStream.Write(byteData, 0, byteData.Length)
            Finally
                If Not postStream Is Nothing Then postStream.Close()
            End Try


            ' Get response  
            response = DirectCast(request.GetResponse(), HttpWebResponse)

            ' Get the response stream into a reader  
            Using StreamReader As New StreamReader(response.GetResponseStream())

                Dim result As String = StreamReader.ReadToEnd()


                oRes = JsonConvert.DeserializeObject(Of Grilla)(result)

                If oRes.codResul = 0 Then

                    Dim ThisToken As JObject = Newtonsoft.Json.JsonConvert.DeserializeObject(Of JObject)(result)
                    If ThisToken("valoresGrilla").HasValues Then
                        For i = 0 To ThisToken("valoresGrilla").Count - 1


                            Dim ThisTokenValoresGrilla As JArray = Newtonsoft.Json.JsonConvert.DeserializeObject(Of JArray)(JsonConvert.SerializeObject(ThisToken("valoresGrilla")))
                            Dim oItem As New Valoresgrilla
                            Dim oJValuecod As JValue
                            Dim oJValueval As JValue
                            If ThisTokenValoresGrilla.Item(i).HasValues Then
                                For a = 0 To ThisTokenValoresGrilla.Item(i).Count - 1
                                    oItem = New Valoresgrilla
                                    oJValuecod = New JValue(ThisTokenValoresGrilla.Item(i).Item(a).Item("codCampo").ToString)
                                    oJValueval = New JValue(ThisTokenValoresGrilla.Item(i).Item(a).Item("valor").ToString)
                                    oItem.codCampo = oJValuecod.Value
                                    oItem.valor = oJValueval.Value
                                    oRes.valoresGri.Add(oItem)

                                Next
                            End If
                        Next
                    End If

                End If

                Return oRes

            End Using

        Finally
            If Not response Is Nothing Then response.Close()
        End Try

    End Function

    <WebMethod()>
    Public Function GetForm(pObj As ParametrosRapiPago) As Formulario

        Dim ser As New JavaScriptSerializer()
        Dim oResError As New RespuestaRapipago
        Dim sUrlRequest As String
        Dim oRes As New Formulario
        Dim postStream As Stream = Nothing

        sUrlRequest = WebConfigurationManager.AppSettings("UrlRapipago").ToString() & "formulario?codPuesto=" & pObj.codPuesto & "&idMod=" & pObj.idMod


        Dim request As HttpWebRequest
        Dim response As HttpWebResponse = Nothing

        Try
            ' Create the web request  
            request = DirectCast(WebRequest.Create(sUrlRequest), HttpWebRequest)

            ' Get response  
            response = DirectCast(request.GetResponse(), HttpWebResponse)

            ' Get the response stream into a reader  
            Using StreamReader As New StreamReader(response.GetResponseStream())

                Dim result As String = StreamReader.ReadToEnd()

                oRes = JsonConvert.DeserializeObject(Of Formulario)(result)
                ' oRes = ser.Deserialize(Of Rootobject)(result)

                Return oRes

            End Using

        Finally
            If Not response Is Nothing Then response.Close()
        End Try

    End Function

    <WebMethod()>
    Public Function GetFacturas(pObj As ParametrosRapiPago) As RespuestaRapipago

        Dim ser As New JavaScriptSerializer()
        Dim oResError As New RespuestaRapipago
        Dim sUrlRequest As String
        Dim oRes As New RespuestaRapipago
        Dim postStream As Stream = Nothing
        If (pObj.CodBarra = " ") Then
            sUrlRequest = WebConfigurationManager.AppSettings("UrlRapipago").ToString() & "factura?codPuesto=" & pObj.codPuesto & "&barra=''&codEmp=" & pObj.codEmpresa
        Else
            sUrlRequest = WebConfigurationManager.AppSettings("UrlRapipago").ToString() & "factura?codPuesto=" & pObj.codPuesto & "&barra=" & pObj.CodBarra '& "&codEmp=" & pObj.codEmpresa
        End If

        Dim request As HttpWebRequest
        Dim response As HttpWebResponse = Nothing

        Try
            ' Create the web request  
            request = DirectCast(WebRequest.Create(sUrlRequest), HttpWebRequest)

            ' Get response  
            response = DirectCast(request.GetResponse(), HttpWebResponse)

            ' Get the response stream into a reader  
            Using StreamReader As New StreamReader(response.GetResponseStream())

                Dim result As String = StreamReader.ReadToEnd()

                oRes = ser.Deserialize(Of RespuestaRapipago)(result)

                ''120-No se ha ingresado el Id de transacción anterior, el puesto tiene una transacción pendiente a confirmar.
                'If oRes.codResul = 120 Then
                '    oRes.cantColisiones = 9999
                'End If

                Return oRes
            End Using

        Finally
            If Not response Is Nothing Then response.Close()
        End Try

    End Function

    <WebMethod()>
    Public Function GetEmpresas(pObj As ParametrosRapiPago) As CabeceraEmpresas

        Dim ser As New JavaScriptSerializer()
        Dim oResError As New RespuestaRapipago
        Dim sUrlRequest As String
        Dim oRes As New CabeceraEmpresas
        Dim postStream As Stream = Nothing


        If pObj.codEmpresa <> "" Then
            sUrlRequest = WebConfigurationManager.AppSettings("UrlRapipago").ToString() & "empresa?codPuesto=" & pObj.codPuesto & "&descEmp=" & pObj.codEmpresa
        Else
            sUrlRequest = WebConfigurationManager.AppSettings("UrlRapipago").ToString() & "empresa?codPuesto=" & pObj.codPuesto
        End If




        Dim request As HttpWebRequest
        Dim response As HttpWebResponse = Nothing

        Try
            ' Create the web request  
            request = DirectCast(WebRequest.Create(sUrlRequest), HttpWebRequest)

            ' Get response  
            response = DirectCast(request.GetResponse(), HttpWebResponse)

            ' Get the response stream into a reader  
            Using StreamReader As New StreamReader(response.GetResponseStream())

                Dim result As String = StreamReader.ReadToEnd()

                oRes = ser.Deserialize(Of CabeceraEmpresas)(result)

                Return oRes

            End Using

        Finally
            If Not response Is Nothing Then response.Close()
        End Try

    End Function


    <WebMethod()>
    Public Function GetFacturasNew(pObj As ParametrosRapiPago) As RespuestaRapipago

        Dim ser As New JavaScriptSerializer()
        Dim oResError As New RespuestaRapipago
        Dim sUrlRequest As String
        Dim oRes As New RespuestaRapipago
        Dim postStream As Stream = Nothing
        If (pObj.CodBarra = " ") Then
            sUrlRequest = WebConfigurationManager.AppSettings("UrlRapipago").ToString() & "factura?codPuesto=" & pObj.codPuesto & "&barra=''&codEmp=" & pObj.codEmpresa
        Else
            sUrlRequest = WebConfigurationManager.AppSettings("UrlRapipago").ToString() & "factura?codPuesto=" & pObj.codPuesto & "&barra=" & pObj.CodBarra & "&codEmp=" & pObj.codEmpresa
        End If

        Dim request As HttpWebRequest
        Dim response As HttpWebResponse = Nothing

        Try
            ' Create the web request  
            request = DirectCast(WebRequest.Create(sUrlRequest), HttpWebRequest)

            ' Get response  
            response = DirectCast(request.GetResponse(), HttpWebResponse)

            ' Get the response stream into a reader  
            Using StreamReader As New StreamReader(response.GetResponseStream())

                Dim result As String = StreamReader.ReadToEnd()

                oRes = ser.Deserialize(Of RespuestaRapipago)(result)

                ''120-No se ha ingresado el Id de transacción anterior, el puesto tiene una transacción pendiente a confirmar.
                'If oRes.codResul = 120 Then
                '    oRes.cantColisiones = 9999
                'End If

                Return oRes
            End Using

        Finally
            If Not response Is Nothing Then response.Close()
        End Try

    End Function


    Public Class Pago
        Public Property codPuesto As Integer
        Public Property items() As New List(Of Item)
        Public Property codResul As Integer
        Public Property descResul As String
        Public Property idTrx As String
    End Class

    Public Class Item
        Public Property barra As String
        Public Property tic() As New List(Of String)
        Public Property codResulItem As Integer
        Public Property descResulItem As String
        Public Property idItem As String
        Public Property Empresa As String
        Public Property Importe As String
    End Class

    Public Class Grilla
        Public Property codPuesto As Integer
        Public Property codResul As Integer
        Public Property descResul As String
        Public Property titulo As String
        Public Property camposGrilla As List(Of Camposgrilla)
        Public Property valoresGri() As New List(Of Valoresgrilla)
        Public Property codEmp As String
    End Class

    Public Class Camposgrilla
        Public Property codCampo As String
        Public Property descCampo As String
    End Class

    Public Class Valoresgrilla
        Public Property codCampo As String
        Public Property valor As String


    End Class


    Public Class Empresas


        Private mtopes As List(Of topes)
        Public Property topes() As List(Of topes)
            Get
                Return mtopes
            End Get
            Set(ByVal value As List(Of topes))
                mtopes = value
            End Set
        End Property

        Private mcodEmp As String
        Public Property codEmp() As String
            Get
                Return mcodEmp
            End Get
            Set(ByVal value As String)
                mcodEmp = value
            End Set
        End Property

        Private mdescEmp As String
        Public Property descEmp() As String
            Get
                Return mdescEmp
            End Get
            Set(ByVal value As String)
                mdescEmp = value
            End Set
        End Property

        Private mmodalidades As List(Of Modalidades)
        Public Property modalidades() As List(Of Modalidades)
            Get
                Return mmodalidades
            End Get
            Set(ByVal value As List(Of Modalidades))
                mmodalidades = value
            End Set
        End Property



    End Class

    Public Class Modalidades
        Private manula As String
        Public Property anula() As String
            Get
                Return manula
            End Get
            Set(ByVal value As String)
                manula = value
            End Set
        End Property

        Private mdescMod As String
        Public Property descMod() As String
            Get
                Return mdescMod
            End Get
            Set(ByVal value As String)
                mdescMod = value
            End Set
        End Property

        Private mesCobroOnline As String
        Public Property esCobroOnline() As String
            Get
                Return mesCobroOnline
            End Get
            Set(ByVal value As String)
                mesCobroOnline = value
            End Set
        End Property

        Private mesPago As String
        Public Property esPago() As String
            Get
                Return mesPago
            End Get
            Set(ByVal value As String)
                mesPago = value
            End Set
        End Property

        Private mesRecarga As String
        Public Property esRecarga() As String
            Get
                Return mesRecarga
            End Get
            Set(ByVal value As String)
                mesRecarga = value
            End Set
        End Property

        Private midMod As String
        Public Property idMod() As String
            Get
                Return midMod
            End Get
            Set(ByVal value As String)
                midMod = value
            End Set
        End Property

        Private mtipoCobranza As String
        Public Property tipoCobranza() As String
            Get
                Return mtipoCobranza
            End Get
            Set(ByVal value As String)
                mtipoCobranza = value
            End Set
        End Property

    End Class
    Public Class CabeceraEmpresas
        Private mcodPuesto As String
        Public Property codPuesto() As String
            Get
                Return mcodPuesto
            End Get
            Set(ByVal value As String)
                mcodPuesto = value
            End Set
        End Property

        Private mcodResul As Integer
        Public Property codResul() As Integer
            Get
                Return mcodResul
            End Get
            Set(ByVal value As Integer)
                mcodResul = value
            End Set
        End Property

        Private mdescResul As String
        Public Property descResul() As String
            Get
                Return mdescResul
            End Get
            Set(ByVal value As String)
                mdescResul = value
            End Set
        End Property

        Private mempresas As List(Of Empresas)
        Public Property empresas() As List(Of Empresas)
            Get
                Return mempresas
            End Get
            Set(ByVal value As List(Of Empresas))
                mempresas = value
            End Set
        End Property

    End Class


    Public Class Formulario
        Public Property codPuesto As Integer
        Public Property titulo As String
        Public Property campos As List(Of Campos)
        Public Property codResul As Integer
        Public Property descResul As String
    End Class

    Public Class Campos
        Public Property etiqueta As String
        Public Property nombre As String
        Public Property tipo As String
        Public Property longitud As Integer
        Public Property listaValores() As Listavalores
        Public Property tipoComponenteVisual As String
        Public Property idFormaSeparacionCampos As String
    End Class

    Public Class Listavalores
        <JsonProperty("1")>
        Public Property _1 As String
        <JsonProperty("2")>
        Public Property _2 As String
        <JsonProperty("3")>
        Public Property _3 As String
    End Class

    Public Class facturas



        Public Property anula As String

        Public Property barra As String

        Public Property codEmp As String

        Public Property codResulItem As Integer


        Public Property codTI As String

        Public Property descEmp As String

        Public Property descMod As String

        Public Property descResulItem As String


        Public Property descTI As String

        Public Property idMod As String

        Public Property importe As String

        Public Property tipoCobranza As String

        Public Property topes As List(Of topes)

    End Class

    Public Class topes


        Public Property maximoNegativo As String

        Public Property maximoPositivo As String

        Public Property minimoNegativo As String

        Public Property minimoPositivo As String


    End Class

    Public Class ParametrosRapiPago

        Private midTrxAnterior As String

        Public Property idTrxAnterior() As String
            Get

                Return midTrxAnterior
            End Get
            Set(ByVal value As String)
                midTrxAnterior = value
            End Set
        End Property
        Private midMod As String
        Public Property idMod() As String
            Get
                Return midMod
            End Get
            Set(ByVal value As String)
                midMod = value
            End Set
        End Property

        Private mcodEmpresa As String
        Public Property codEmpresa() As String
            Get
                Return mcodEmpresa
            End Get
            Set(ByVal value As String)
                mcodEmpresa = value
            End Set
        End Property

        Private mcodPuesto As String
        Public Property codPuesto() As String
            Get
                Return mcodPuesto
            End Get
            Set(ByVal value As String)
                mcodPuesto = value
            End Set
        End Property

        Private mCodBarra As String
        Public Property CodBarra() As String
            Get
                Return mCodBarra
            End Get
            Set(ByVal value As String)
                mCodBarra = value
            End Set
        End Property

        Private mNroOrdenComercial As String
        Public Property NroOrdenComercial() As String
            Get
                Return mNroOrdenComercial
            End Get
            Set(ByVal value As String)
                mNroOrdenComercial = value
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

        Private mNroComercio As String
        Public Property NroComercio() As String
            Get
                Return mNroComercio
            End Get
            Set(ByVal value As String)
                mNroComercio = value
            End Set
        End Property

        Private mLotes As String
        Public Property Lotes() As String
            Get
                Return mLotes
            End Get
            Set(ByVal value As String)
                mLotes = value
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

        Private mdatosFormulario As String
        Public Property datosFormulario() As String
            Get
                Return mdatosFormulario
            End Get
            Set(ByVal value As String)
                mdatosFormulario = value
            End Set
        End Property
        Public Sub New()

        End Sub
    End Class

    Public Class RespuestaRapipago


        Public Property errorcode As String

        Public Property message As String

        Public Property dataObject As String

        Public Property statusCode() As String

        Public Property cantColisiones As Integer?

        Public Property codPuesto As String

        Public Property codResul As Integer

        Public Property descResul As String

        Public Property facturas As New List(Of facturas)

    End Class

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

        Private mIDPrestamo As Long
        Public Property IDPrestamo() As Long
            Get
                Return mIDPrestamo
            End Get
            Set(ByVal value As Long)
                mIDPrestamo = value
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

    <WebMethod()>
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
        oMontosDisponibles.IDMonto = 60
        oMontosDisponibles.Descripcion = "60"
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
    Public Function GetVentasResumida(pObj As Parametros) As List(Of Respuesta)

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
            oDs = oFusion.GetTransaccionesWebLivianaResumido(pObj.User, pObj.Pass, pObj.Fecha, pObj.FechaHasta)


            Dim mRes As New StringBuilder
            mRes.Append("[")

            For Each Item As DataRow In oDs.Tables(0).Rows
                mRes.Append("{""Proveedor"":""" & Item("NombreProveedor") & """,""Monto"": """ & Item("Monto") & """, ""Cantidad"": """ & Item("Cantidad") & """},")

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
                mRes.Append("{""Producto"":""" & Item("NombreProducto") & """,""Fecha"":""" & Item("Fecha") & """,""Monto"": """ & Item("Monto") & """, ""IdTransaccion"": """ & Item("IdTransaccion") & """,""Destino"": """ & Item("Destino") & """,""Respuesta"": """ & Item("Respuesta") & """,""Usuario"": """ & Item("UserCode") & """,""IDVenta"": """ & Item("IDVenta") & """,""Estado"": """ & Item("Estado") & """},")

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
    Public Function GetCuotasPrestamo(pObj As Parametros) As List(Of Respuesta)

        Dim oRta As New Respuesta
        Dim oDs As DataSet
        Dim olstRta As New List(Of Respuesta)
        Try
            Dim oFusion As New LuSe.WsTransaccional.ExternalSales


            oDs = oFusion.GetCuotasPrestamo(pObj.User, pObj.Pass, pObj.IDPrestamo)


            Dim mRes As New StringBuilder
            mRes.Append("[")

            For Each Item As DataRow In oDs.Tables(0).Rows
                mRes.Append("{""NroCuota"":""" & Item("NroCuota") & """,""FechaProgramada"":""" & Item("FechaProgramada") & """,""FechaEjecucion"":""" & Item("FechaEjecucion") & """,""Reintentos"": """ & Item("Reintentos") & """, ""Monto"": """ & Item("Monto") & """, ""Ejecutada"": """ & Item("Ejecutada") & """},")

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
    Public Function GetPrestamos(pObj As Parametros) As List(Of Respuesta)

        Dim oRta As New Respuesta
        Dim oDs As DataSet
        Dim olstRta As New List(Of Respuesta)
        Try
            Dim oFusion As New LuSe.WsTransaccional.ExternalSales

            oDs = oFusion.GetPrestamo(pObj.User, pObj.Pass, pObj.IDAgencia)


            Dim mRes As New StringBuilder
            mRes.Append("[")

            For Each Item As DataRow In oDs.Tables(0).Rows
                mRes.Append("{""NroPrestamo"":""" & Item("IDRecaudador") & """,""FechaVencimiento"":""" & Item("FechaVencimiento") & """,""Monto"": """ & Item("CapitalPrestamo") & """, ""CuotasCobrada"": """ & Item("CuotasCobrada") & """},")

            Next
            Dim oREST As String

            oREST = mRes.ToString.Substring(0, mRes.Length - 1)


            oRta.Estado = True
            oRta.Mensaje = oREST & "]"
            If oRta.Mensaje = "]" Then
                oRta.Mensaje = "[]"
            End If
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
    Public Function GetMovCtaCte(pObj As Parametros) As List(Of Respuesta)

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
            oRes = oFusion.GetMovCtaCteWebLiviana(pObj.User, pObj.Pass, pObj.Fecha, pObj.FechaHasta)

            oDs = LuSe.Framework.Common.Helper.XmlFunctions.XMLToDataSet(oRes)

            Dim mRes As New StringBuilder
            mRes.Append("[")
            Dim mSaldoInicial As String = ""
            Dim mSaldo As String = ""
            Dim blnHayVentas As Boolean = False
            If mSaldoInicial = "" Then
                mSaldoInicial = Math.Round(Convert.ToDecimal(oDs.Tables(0).Rows(oDs.Tables(0).Rows.Count - 1)("Saldo").ToString.Replace(".", ",")), 2) - Math.Round(Convert.ToDecimal(oDs.Tables(0).Rows(oDs.Tables(0).Rows.Count - 1)("Importe").ToString.Replace(".", ",")), 2)
            End If
            For Each Item As DataRow In oDs.Tables(0).Rows
                blnHayVentas = True
                If mSaldo = "" Then
                    mSaldo = Math.Round(Convert.ToDecimal(Item(4).ToString.Replace(".", ",")), 2)
                    mRes.Append("{""Fecha"":"""",""Descripcion"":""Saldo Actual"",""Monto"": """ & mSaldo & """, ""Saldo"": """"},")
                End If
                mRes.Append("{""Fecha"":""" & Convert.ToDateTime(Item("Fecha")) & """,""Descripcion"":""" & Item("Observaciones") & """,""Monto"": """ & Math.Round(Convert.ToDecimal(Item("Importe").ToString.Replace(".", ",")), 2) & """, ""Saldo"": """ & Math.Round(Convert.ToDecimal(Item("Saldo").ToString.Replace(".", ",")), 2) & """},")

            Next
            mRes.Append("{""Fecha"":"""",""Descripcion"":""Saldo Inicial"",""Monto"": """ & mSaldoInicial & """, ""Saldo"": """"},")


            If Not blnHayVentas Then

                Throw New Exception("Sin Movimientos por el momento")
            End If

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
    Public Function GetMovRapiPago(pObj As Parametros) As List(Of Respuesta)

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
            oRes = oFusion.GetMovRapiPagoWebLiviana(pObj.User, pObj.Pass, pObj.Fecha, pObj.FechaHasta)

            oDs = LuSe.Framework.Common.Helper.XmlFunctions.XMLToDataSet(oRes)

            Dim mRes As New StringBuilder
            mRes.Append("[")
            Dim mSaldoInicial As String = ""
            Dim mSaldo As String = ""
            Dim blnHayVentas As Boolean = False
            If mSaldoInicial = "" Then
                mSaldoInicial = Math.Round(Convert.ToDecimal(oDs.Tables(0).Rows(oDs.Tables(0).Rows.Count - 1)("Saldo").ToString.Replace(".", ",")), 2) - Math.Round(Convert.ToDecimal(oDs.Tables(0).Rows(oDs.Tables(0).Rows.Count - 1)("Importe").ToString.Replace(".", ",")), 2)
            End If
            For Each Item As DataRow In oDs.Tables(0).Rows
                blnHayVentas = True
                If mSaldo = "" Then
                    mSaldo = Math.Round(Convert.ToDecimal(Item(3).ToString.Replace(".", ",")), 2)
                    mRes.Append("{""Fecha"":"""",""Descripcion"":""Saldo Actual"",""Monto"": """ & mSaldo & """, ""Saldo"": """"},")
                End If
                mRes.Append("{""Fecha"":""" & Convert.ToDateTime(Item("Fecha")) & """,""Descripcion"":""" & Item("Observaciones") & """,""Monto"": """ & Math.Round(Convert.ToDecimal(Item("Importe").ToString.Replace(".", ",")), 2) & """, ""Saldo"": """ & Math.Round(Convert.ToDecimal(Item("Saldo").ToString.Replace(".", ",")), 2) & """},")

            Next
            mRes.Append("{""Fecha"":"""",""Descripcion"":""Saldo Inicial"",""Monto"": """ & mSaldoInicial & """, ""Saldo"": """"},")


            If Not blnHayVentas Then

                Throw New Exception("Sin Movimientos por el momento")
            End If

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