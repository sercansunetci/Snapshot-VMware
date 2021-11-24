$fqdn = Read-Host "Enter vCenter FQDN"
$user = Read-Host "Enter username with domain"
$pass = Read-Host "Enter password" #-AsSecureString
#$pwd = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pass))
$control = Connect-VIServer -Server $fqdn -User $user -Password $pass
if($control -eq $null){
        Write-Output("Check your Username & Password")
    }

else{
    $filepath = Read-Host "Enter file path"
    $vms = $filePath



    foreach($vmname in $vms){
        $vmname = $vmname.name
        Get-Snapshot $vmname | Remove-Snapshot -Confirm:$false #Delete all snapshot
    }
} 