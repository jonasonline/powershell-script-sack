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

$maxReturn = 5000
$total = 0
$token = $Null
$context = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey
$container = Get-AzureStorageContainer -Name $StorageContainerName -Context $context
do {
  $blobs = Get-AzureStorageBlob -Container $container.Name -Context $context -ContinuationToken $token -MaxCount $maxReturn 
  Write-Output "Fetched $($blobs.Length) blob records."
  if($blobs.Length -le 0) { Break;}
  $token = $blobs[$blobs.Count -1].ContinuationToken;
  Write-Output "Removing $($($blobs | Where-Object {$_.LastModified -lt (Get-Date).AddHours(-$CleanupTime)} | Measure-Object).Count) blob records."
  $blobs | Where-Object {$_.LastModified -lt (Get-Date).AddHours(-$CleanupTime)} | Remove-AzureStorageBlob
} while ($token -ne $Null)
