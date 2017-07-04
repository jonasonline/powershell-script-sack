Param(
    [Parameter(Mandatory = $true)]
    [string]$ServerName,
    [Parameter(Mandatory = $true)]
    [string]$DatabaseName,
    [Parameter(Mandatory = $true)]
    [string]$Query,
    [Parameter(Mandatory = $true)]
    [string]$OutputFile
)
Install-Module Invoke-SqlCmd2 -Scope CurrentUser -Force -ErrorAction SilentlyContinue
Invoke-Sqlcmd2 -ServerInstance $ServerName -Database $DatabaseName -Query $Query | ConvertTo-Csv -NoTypeInformation | Out-File -FilePath $OutputFile -Force