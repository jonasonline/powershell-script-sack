[CmdletBinding()]
Param(
  [Parameter(Mandatory=$True)]
   [String]$StorageAccountName,
	
   [Parameter(Mandatory=$True)]
   [String]$StorageAccountKey,

   [Parameter(Mandatory=$True)]
   [String]$StorageContainerName,

   [Parameter(Mandatory=$True)]
   [String]$FolderPath
)

$context = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey
$container = Get-AzureStorageContainer -Name $StorageContainerName -Context $context
Get-ChildItem -Path $FolderPath | Set-AzureStorageBlobContent -Container $container.Name -Context $context
