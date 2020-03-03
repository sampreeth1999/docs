﻿' System.Web.Services.Protocols.LogicalMethodInfo.BeginInvoke(object,object(),AsyncCallback,object) 
' System.Web.Services.Protocols.LogicalMethodInfo.EndInvoke(object,IAsyncResult)

' The following example demonstrates 'BeginInvoke' and 'EndInvoke' methods of
' 'System.Web.Services.Protocols.LogicalMethodInfo' class. 
' The 'Add' method of Math web service is called in asynchronous mode. 'BeginInvoke'
' begins asynchronous invocation of method and 'EndInvoke' terminates the invocation 
' started by 'BeginInvoke'. The return value returned by 'Endinvoke' is displayed.
'
' Note:  The MyMath class is a proxy class generated by the Wsdl.exe utility for
' the Math Web Service. This class can also be found in the SoapHttpClientProtocol  
' class example.

Imports System.Reflection
Imports System.Web.Services.Protocols
Imports System.Diagnostics
Imports System.Xml.Serialization
Imports System.Web.Services

Public Class BeginInvokeClass

' <Snippet1>
' <Snippet2>
   Public Shared Sub Main()

      ' Get the type information.
      ' Note: The MyMath class is a proxy class generated by the Wsdl.exe 
      ' utility for the Math Web Service. This class can also be found in
      ' the SoapHttpClientProtocol class example. 
      Dim myType As Type = GetType(MyMath.MyMath)

      ' Get the method info.
      Dim myBeginMethod As MethodInfo = myType.GetMethod("BeginAdd")
      Dim myEndMethod As MethodInfo = myType.GetMethod("EndAdd")

      ' Create an instance of the LogicalMethodInfo class.
      Dim myLogicalMethodInfo As LogicalMethodInfo = _
         LogicalMethodInfo.Create(New MethodInfo() {myBeginMethod, myEndMethod}, _
         LogicalMethodTypes.Async)(0)

      ' Get an instance of the proxy class.
      Dim myMathService As New MyMath.MyMath()

      ' Call the MyEndIntimationMethod method to intimate the end of 
      ' the asynchronous call.
      Dim myAsyncCallback As New AsyncCallback(AddressOf MyEndIntimationMethod)

      ' Beging to invoke the Add method.
      Dim myAsyncResult As IAsyncResult = _
         myLogicalMethodInfo.BeginInvoke( _
         myMathService, New Object() {10, 10}, myAsyncCallback, Nothing)

      ' Wait until invoke is complete.
      myAsyncResult.AsyncWaitHandle.WaitOne()

      ' Get the result.
      Dim myReturnValue() As Object
      myReturnValue = myLogicalMethodInfo.EndInvoke(myMathService, myAsyncResult)

      Console.WriteLine(("Sum of 10 and 10 is " & myReturnValue(0)))
   End Sub

   ' This method will be called at the end of asynchronous call.
   Shared Sub MyEndIntimationMethod(ByVal Result As IAsyncResult)
      Console.WriteLine("Asynchronous call on method 'Add' finished.")
   End Sub

' </Snippet1>
' </Snippet2>

End Class

' Automatically generated proxy class for Math Web service.
' This class can also be found in the SoapHttpClientProtocol class example.
Namespace MyMath

   <System.Web.Services.WebServiceBindingAttribute( _
      Name:="MyMathSoap", [Namespace]:="http://tempuri.org/")> _
   Public Class MyMath
      Inherits System.Web.Services.Protocols.SoapHttpClientProtocol

      Public Sub New()
         Me.Url = "http://localhost/Math.asmx"
      End Sub

      <System.Web.Services.Protocols.SoapDocumentMethodAttribute( _
         "http://tempuri.org/Add", _
         Use:=System.Web.Services.Description.SoapBindingUse.Literal, _
         ParameterStyle:=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)> _
      Public Function Add(ByVal x As Integer, ByVal y As Integer) As Integer
         Dim results As Object() = Me.Invoke("Add", New Object() {x, y})
         Return CInt(results(0))
      End Function 'Add

      Public Function BeginAdd(ByVal x As Integer, ByVal y As Integer, _
         ByVal callback As System.AsyncCallback, _
         ByVal asyncState As Object) As System.IAsyncResult
         Return Me.BeginInvoke("Add", New Object() {x, y}, callback, asyncState)
      End Function 'BeginAdd

      Public Function EndAdd(ByVal asyncResult As System.IAsyncResult) As Integer
         Dim results As Object() = Me.EndInvoke(asyncResult)
         Return CInt(results(0))
      End Function 'EndAdd
   End Class
End Namespace 'MyMath