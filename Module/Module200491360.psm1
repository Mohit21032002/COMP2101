$env:PATH = "$env:PATH;c:\Users\MOHIT_SCRIPTING\Documents\WindowsPowerShell\Modules\Module200491360"
function welcome{
write-output "Welcome to planet $env:computername Overlord $env:username"
$now = get-date -format 'HH:MM tt on dddd'
write-output "It is $now."
}

function get-cpuinfo{
get-ciminstance cim_processor
Get-WmiObject Win32_Processor |Select-Object Manufacturer, NumberOfCores, NumberOfLogicalProcessors |Format-List
}

function get-mydisks{  wmic diskdrive get Model,Manufacturer,SerialNumber,FirmwareRevision,Size}


function hardware_description{
 echo "Hardware Description:"
 get-wmiobject -class Win32_ComputerSystem | fl Description
}

function Operating_Systeminfo{
 echo "OS Description:"
 get-WMIobject -class Win32_OperatingSystem | fl Name, Version
}

function Processor_Description{
 echo "Processor Description"
 get-WMIobject -class win32_processor | select Description, CurrentClockspeed, NumberOfCores, @{n="L1CacheSize";e={switch($_.L1CacheSize){$null{$var="data unavailable"}};$var}}, L2CacheSize, L3CacheSize | fl
}

function Ram_Specfifications{
 echo "RAM Summary"
 $M = 0
 get-WMIobject -class win32_physicalmemory |
  foreach { 
    New-Object -TypeName psObject -Property @{ 
      Vendor = $_.Manufacturer
      Description = $_.Description
      Size = $_.Capacity/1gb
      Bank = $_.BankLabel
      Slot = $_.DeviceLocator
      }

      $M += $_.capacity/1gb
      }|
ft Vendor, Description, Size, Bank, Slot
"Total RAM: ${M}GB"}

function get-diskinfo{
echo "Disk Description"
$diskdrives = Get-CimInstance -class CIM_diskdrive
foreach ($disk in $diskdrives) {
    $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
    foreach ($partition in $partitions) {
          $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
          foreach ($logicaldisk in $logicaldisks) {
             new-object -typename psobject -property @{
               Model = $disk.Model
               Vendor = $disk.Manufacturer
               Drive = $logicaldisk.deviceid
               "Size(GB)" = $logicaldisk.size / 1gb -as [int]
               "freeSpace(GB)" = $logicaldisk.freespace/1gb -as [int]
               "freeSpace(%)" = ([string]((($logicalDisk.FreeSpace / $logicalDisk.Size) * 100) -as [int]) + '%')} | ft Drive, Vendor, Model, "Size(GB)", "freespace(GB)", "freeSpace(%)"
           }
      }
  }
}

function network_adapter{
get-wmiobject -class win32_networkadapterconfiguration |
Format-Table -autosize Description, Index,
 @{n="IPAddress";e={switch($_.IPAddress){$null{$empty="data unavailable";$empty}};if($null -ne $_.IPAddress){$_.IPAddress}}},
 @{n="IPSubnet";e={switch($_.IPSubnet){$null{$empty="data unavailable";$empty}};if($null -ne $_.IPSubnet){$_.IPSubnet}}},
 @{n="DNSDomain";e={switch($_.DNSDomain){$null{$empty="data unavailable";$empty}};if($null -ne $_.DNSDomain){$_.DNSDomain}}},
 @{n="DNSServerSearchOrder";e={switch($_.DNSServerSearchOrder){$null{$empty="data unavailable";$empty}};if($null -ne $_.DNSServerSearchOrder){$_.DNSServerSearchOrder}}}
}

function Graphics_Info
{
 echo "Graphics Information"
 $horizontalpixels = (get-wmiobject -class Win32_videocontroller).CurrentHorizontalResolution -as [String]
  $verticalpixels = (gwmi -classNAME win32_videocontroller).CurrentVerticalresolution -as [string]
  $resolution = $horizontalpixels + " x " + $verticalpixels
  gwmi -classNAME win32_videocontroller| fl @{n = "Video Card Vendor"; e={$_.AdapterCompatibility}}, Description, @{n="Screen Resolution"; e={$resolution -as [string]}}
}

