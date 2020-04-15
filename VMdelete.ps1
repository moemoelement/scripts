param ($VMName)
$confirmation = Read-Host "Are you sure you want to delete all files for $VMName ? (y/n)"
if ($confirmation -eq 'y') {
Remove-VMDvdDrive -VMName $VMName -ControllerNumber 1 -ControllerLocation 0
Remove-VMHardDiskDrive -VMName $VMName -ControllerType SCSI -ControllerNumber 0 -ControllerLocation 0
Remove-VM -Name $VMName -Force
write-host "$VMName has been successfully deleted"
} else {
write-host "The action has been cancelled"}