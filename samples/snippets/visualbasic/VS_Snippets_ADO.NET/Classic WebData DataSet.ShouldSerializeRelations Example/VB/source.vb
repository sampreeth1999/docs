﻿Imports System.Xml
Imports System.Data
Imports System.Data.Common
Imports System.Windows.Forms

' <Snippet1>
Public Class DerivedDataSet
    Inherits System.Data.DataSet
    
    Public Sub ResetDataSetRelations()
        ' Check the ShouldSerializeRelations methods 
        ' before invoking Reset.
        If Not Me.ShouldSerializeRelations() Then
            Me.Reset()
        End If
    End Sub
End Class
' </Snippet1>