﻿'------------------------------------------------------------------------------
' <autogenerated>
'     This code was generated by a tool.
'
'     Changes to this file may cause incorrect behavior and will be lost if
'     the code is regenerated.
' </autogenerated>
'------------------------------------------------------------------------------

Option Strict On
Option Explicit On


Namespace My
    
    Partial Class MyApplication
        
        <Global.System.Diagnostics.DebuggerStepThrough()> Public Sub New()
            MyBase.New(ApplicationServices.AuthenticationMode.Windows)
            Me.IsSingleInstance = False
            Me.EnableVisualStyles = True
            Me.SaveMySettingsOnExit = True
            Me.ShutDownStyle = Global.Microsoft.VisualBasic.ApplicationServices.ShutdownMode.AfterMainFormCloses
        End Sub
        
        <Global.System.Diagnostics.DebuggerStepThrough()> Protected Overrides Sub OnCreateMainForm()
            Me.MainForm = Global.DisplayWebBrowserCodeVB.Form1
        End Sub
    End Class
End Namespace
