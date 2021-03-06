[CmdletBinding()]
Param(
  [Parameter(Mandatory=$True)]
   [string]$MailServer,
	
   [Parameter(Mandatory=$True)]
   [string]$EmailAdressFrom,

   [Parameter(Mandatory=$True)]
   [string]$EmailAdressTo,

   [Parameter(Mandatory=$True)]
   [string]$Subject,

   [Parameter(Mandatory=$True)]
   [string]$SQLQuery,

   [Parameter(Mandatory=$True)]
   [string]$SQLServerInstance,

   [Parameter(Mandatory=$True)]
   [string]$Database
)

$SmtpClient = New-object system.net.mail.smtpClient 
$MailMessage = New-Object system.net.mail.mailmessage 

$SmtpClient.Host = $MailServer
$mailmessage.From = $EmailAdressFrom
$mailmessage.To.add($EmailAdressTo)
$mailmessage.IsBodyHTML = $true
$mailmessage.Subject = $Subject 

[reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo") | out-null
Import-Module “sqlps” -DisableNameChecking

$response = Invoke-Sqlcmd -Query $SQLQuery -ServerInstance $SQLServerInstance -Database $Database
 
$a = "<style>"
$a = $a + "BODY{background-color:grey;}"
$a = $a + "TABLE{border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}"
$a = $a + "TH{border-width: 1px;padding: 5px;border-style: solid;border-color: black;background-color:#cccccc}"
$a = $a + "TD{border-width: 1px;padding: 5px;border-style: solid;border-color: black;background-color:white}"
$a = $a + "</style>"

$mailmessage.Body += $response | ConvertTo-Html -head $a 
$Smtpclient.Send($mailmessage)
