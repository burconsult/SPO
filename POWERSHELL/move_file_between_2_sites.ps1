#Load SharePoint CSOM Assemblies
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"
  
#powershell script to move files in sharepoint online - Function
Function Move-SPOFile([String]$SiteURL, [String]$SourceFileURL, [String]$TargetFileURL)
{
    Try{
        #Setup the context
        $Ctx = New-Object Microsoft.SharePoint.Client.ClientContext($SiteURL)
        $Ctx.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Cred.Username, $Cred.Password)
      
        #sharepoint online powershell to move files
        $MoveCopyOpt = New-Object Microsoft.SharePoint.Client.MoveCopyOptions
        $Overwrite = $True
        [Microsoft.SharePoint.Client.MoveCopyUtil]::MoveFile($Ctx, $SourceFileURL, $TargetFileURL, $Overwrite, $MoveCopyOpt)
        $Ctx.ExecuteQuery()
  
        Write-host -f Green "File Moved Successfully!"
    }
    Catch {
    write-host -f Red "Error Moving the File!" $_.Exception.Message
    }
}
  
#Set Config Parameters
$SiteURL="https://Crescent.sharepoint.com/sites/Marketing"
$SourceFileURL="https://Crescent.sharepoint.com/sites/Marketing/Shared Documents/Discloser Asia.doc"
$TargetFileURL="https://Crescent.sharepoint.com/Shared Documents/Discloser Asia.doc"
  
#Get Credentials to connect
$Cred= Get-Credential
  
#Call the function to Move the File
Move-SPOFile $SiteURL $SourceFileURL $TargetFileURL


#Read more: https://www.sharepointdiary.com/2018/03/sharepoint-online-move-files-using-powershell.html#ixzz7vMAxRLQ4