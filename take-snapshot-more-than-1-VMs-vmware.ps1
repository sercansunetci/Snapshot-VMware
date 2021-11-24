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
        $request = 'Write Snapshot Name'
        $desc = 'Write Snapshot Description'

        # If there isn't any snapshot on VM, it'll take snapshot without memory
        # If there is snapshot on VM, it'll delete old snapshot and then take new one without memory
        $a = Get-Snapshot $vmname
        if($a.IsCurrent -eq $null){
            New-Snapshot -VM $vmname -Name $request -Description $desc -Memory:$false
        }
        elseif($a.IsCurrent -ne $null){
            Get-Snapshot $vmname | Remove-Snapshot -Confirm:$false #Delete all snapshots 
            New-Snapshot -VM $vmname -Name $request -Description $desc -Memory:$false 
        }

    }
} 