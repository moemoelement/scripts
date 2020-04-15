# variables utilisées plus tard dans le script
param ($VMName, $MemorySize, $VHDSize)
$InstallMedia = 'D:\ISO Windows Server\Windows Server 2016 Standard.ISO'

# création de la VM
New-VM -Name $VMName -MemoryStartupBytes $MemorySize -Generation 2 -NewVHDPath "C:\VM\$VMName\$VMName.vhdx" -NewVHDSizeBytes $VHDSize -Path "C:\VM\$VMName"

# ajout du lecteur de DVD
Add-VMScsiController -VMName $VMName
Add-VMDvdDrive -VMName $VMName -ControllerNumber 1 -ControllerLocation 0 -Path $InstallMedia

# montage de l'image iso Windows Server 2016 sur le lecteur DVD
$DVDDrive = Get-VMDvdDrive -VMName $VMName

# boot de la VM sur le lecteur DVD au démarrage
Set-VMFirmware -VMName $VMName -FirstBootDevice $DVDDrive

# connexion au service de visualisation avec la commande "VMConnect.exe"
# le seul problème est qu'il faut appuyer sur une touche quelconque pour lancer le boot sur DVD lors du démarrage de la VM (moyen de s'en affranchir ?)