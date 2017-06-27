'Call the function URLDownloadToFile from system library urlmon
Private Declare Function URLDownloadToFile Lib "urlmon" Alias "URLDownloadToFileA" (ByVal pCaller As Long, ByVal szURL As String, ByVal szFileName As String, ByVal dwReserved As Long, ByVal lpfnCB As Long) As Long

'I have written the code inside the click event of a button

Private Sub CommandButton1_Click()

saveloc = "C:\Users\Subin Abid\Downloads\STG\" 'save location
                
'Create Sub folders if it doesnot exist
If Len(Dir(saveloc & "Mechanical", vbDirectory)) = 0 Then
   MkDir saveloc & "Mechanical"
End If

If Len(Dir(saveloc & "Electrical", vbDirectory)) = 0 Then
   MkDir saveloc & "Electrical"
End If

If Len(Dir(saveloc & "CnI", vbDirectory)) = 0 Then
   MkDir saveloc & "CnI"
End If

If Len(Dir(saveloc & "Quality", vbDirectory)) = 0 Then
   MkDir saveloc & "Quality"
End If

If Len(Dir(saveloc & "Civil", vbDirectory)) = 0 Then
   MkDir saveloc & "Civil"
End If

If Len(Dir(saveloc & "Other", vbDirectory)) = 0 Then
   MkDir saveloc & "Other"
End If
                
MsgBox ("Started Download. Click OK")
Downloaded = 0
failed = 0
        
For i = 2 To 1500 Step 1 'to download from row 2 to 1500. Row 1 is the heading row

    link = ActiveSheet.Range("F" & i).Hyperlinks(1).Address
    drgname = ActiveSheet.Range("B" & i).Text & " " & ActiveSheet.Range("D" & i).Text & ".pdf"
    sorter = ""
    
        'define a sorter to categorise drawings, I am using the PVM/PVI/PVC notation to sort the drawings
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
            downloaded = downloaded + 1
    Else
        ActiveSheet.Range("G" & i).Value = "Error"
        failed = failed + 1
    End If

Next

    MsgBox (downloaded & " drgs downloaded")
MsgBox (failed & " drgs failed")

End Sub

