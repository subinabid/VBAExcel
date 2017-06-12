'Call the function URLDownloadToFile from system library urlmon
Private Declare Function URLDownloadToFile Lib "urlmon" Alias "URLDownloadToFileA" (ByVal pCaller As Long, ByVal szURL As String, ByVal szFileName As String, ByVal dwReserved As Long, ByVal lpfnCB As Long) As Long

'I have written the code inside the click event of a button

Private Sub CommandButton1_Click()

saveloc = "C:\Users\Subin Abid\Downloads\STG\" 'save location
MsgBox ("Started Download. Click OK")
Downloaded = 0
failed = 0

For i = 2 To 50 Step 1

    link = ActiveSheet.Range("F" & i).Hyperlinks(1).Address
    drgname = ActiveSheet.Range("B" & i).Text & " " & ActiveSheet.Range("D" & i).Text & ".pdf"
    sorter = ""
    
    'define a sorter to categorise drawings
    drgtype = Mid(drgname, 12, 1)
    If drgtype = "M" Then
        sorter = "Mechanical\"
    ElseIf drgtype = "E" Then
        sorter = "Electrical\"
    ElseIf drgtype = "I" Then
        sorter = "CnI\"
    ElseIf drgtype = "Q" Then
        sorter = "Quality\"
    Else
        sorter = "Other\"
    End If
    
    
    'download the drg
    chk = URLDownloadToFile(0, link, saveloc & sorter & drgname, 0, 0)

    'Check if drg is downloaded
    If (chk = 0) Then
        ActiveSheet.Range("G" & i).Value = "OK"
        Downloaded = Downloaded + 1
    Else
        ActiveSheet.Range("G" & i).Value = "Error"
        failed = failed + 1
    End If

Next

MsgBox (Downloaded & " drgs downloaded")
MsgBox (failed & " drgs failed")

End Sub

