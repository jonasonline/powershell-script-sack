[CmdletBinding()]
Param(
  [Parameter(Mandatory=$True)]
   [String]$StorageAccountName,
	
   [Parameter(Mandatory=$True)]
   [String]$StorageAccountKey,

   [Parameter(Mandatory=$True)]
   [String]$StorageContainerName,

   [Parameter(Mandatory=$True)]
   [Int]$CleanupTime
)
$context = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey
$container = Get-AzureStorageContainer -Name $StorageContainerName -Context $context
Get-AzureStorageBlob -Container $container.Name -Context $context | Where-Object {$_.LastModified -lt (Get-Date).AddHours(-$CleanupTime)} | Remove-AzureStorageBlob