param(
  [string]$OutputPath = "ansible/inventory/hosts.yml"
)

$env:PATH += ";C:\Program Files\Oracle\VirtualBox"

$ip01 = (VBoxManage guestproperty get vm01 "/VirtualBox/GuestInfo/Net/1/V4/IP") -replace "Value: ", ""
$ip02 = (VBoxManage guestproperty get vm02 "/VirtualBox/GuestInfo/Net/1/V4/IP") -replace "Value: ", ""
$ip03 = (VBoxManage guestproperty get vm03 "/VirtualBox/GuestInfo/Net/1/V4/IP") -replace "Value: ", ""

$ip01 = $ip01.Trim()
$ip02 = $ip02.Trim()
$ip03 = $ip03.Trim()

Write-Host "vm01 IP: $ip01"
Write-Host "vm02 IP: $ip02"
Write-Host "vm03 IP: $ip03"

$inventory = "all:`n"
$inventory += "  vars:`n"
$inventory += "    ansible_user: vagrant`n"
$inventory += "    ansible_ssh_private_key_file: ~/.vagrant-keys/vagrant.key.ed25519`n"
$inventory += "    ansible_ssh_common_args: '-o StrictHostKeyChecking=no'`n"
$inventory += "    ansible_become: yes`n"
$inventory += "    ansible_become_method: sudo`n"
$inventory += "`n"
$inventory += "  children:`n"
$inventory += "    vms:`n"
$inventory += "      hosts:`n"
$inventory += "        vm01:`n"
$inventory += "          ansible_host: $ip01`n"
$inventory += "          vm_ip: 192.168.51.11`n"
$inventory += "          keepalived_state: MASTER`n"
$inventory += "          keepalived_priority: 110`n"
$inventory += "        vm02:`n"
$inventory += "          ansible_host: $ip02`n"
$inventory += "          vm_ip: 192.168.51.12`n"
$inventory += "          keepalived_state: BACKUP`n"
$inventory += "          keepalived_priority: 100`n"
$inventory += "        vm03:`n"
$inventory += "          ansible_host: $ip03`n"
$inventory += "          vm_ip: 192.168.51.13`n"
$inventory += "          keepalived_state: BACKUP`n"
$inventory += "          keepalived_priority: 90`n"
$inventory += "`n"
$inventory += "    vm01_group:`n"
$inventory += "      hosts:`n"
$inventory += "        vm01:`n"
$inventory += "    vm02_group:`n"
$inventory += "      hosts:`n"
$inventory += "        vm02:`n"
$inventory += "    vm03_group:`n"
$inventory += "      hosts:`n"
$inventory += "        vm03:`n"

$inventory | Out-File -FilePath $OutputPath -Encoding UTF8 -NoNewline
Write-Host "✅ Inventory gerado em $OutputPath"
Write-Host "Conteudo gerado:"
Get-Content $OutputPath
