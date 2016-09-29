[CmdletBinding()]
Param(
  [Parameter(Mandatory=$True)]
   [string]$StorageAccountName,
	
   [Parameter(Mandatory=$True)]
   [string]$StorageAccountKey,

   [Parameter(Mandatory=$True)]
   [string]$StorageContainerName,

   [Parameter(Mandatory=$True)]
   [datetime]$OlderThanDate
)
$context = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey
$container = Get-AzureStorageContainer -Name $StorageContainerName -Context $context
Get-AzureStorageBlob -Container $container.Name -Context $context | Where-Object {$_.LastModified -lt $OlderThanDate} | Remove-AzureStorageBlob