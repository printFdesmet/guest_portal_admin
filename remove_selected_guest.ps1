Add-Type -AssemblyName 'System.Web'
# creates a variable that stores a string that is password enabled
$password = Get-Content "C:\Users\fdesmet\Documents\guest_portal\static\password.txt"
$secure_password = ConvertTo-SecureString $password -AsPlainText -Force

# creates a login object making it possible to login remotly behind the scenes.
$cred = New-Object System.Management.Automation.PSCredential ("agplastics\administrator", $secure_password)

## this enables remoting on the device where the script is executed.
Enable-PSRemoting -Force
## this sets the computer as a trusted host in the list, this enables communication over the network with Kerberos.
Set-item wsman:localhost\client\trustedhosts -value * -Force
## this invokes a command on multiple remote locations, using the previously created credentials.
invoke-command -ComputerName 'SRV-DC-VS-01' -Credential $cred -scriptblock {
    # Commands to be executed on remote machine
    Add-Type -AssemblyName 'System.Web'
    Enable-PSRemoting -Force


    $ou_path = "OU=Guests,OU=Users,OU=AG Plastics,DC=AgPlastics,DC=local"

    Get-ADUser -Filter * -SearchBase $ou_path | Select-Object GivenName,Name | ConvertTo-Json | Out-File "\\sflpvs01\burotica\ict\#scripts\admin_guest_list.json"

    # Send-MailMessage -From 'info@skylux.be' -To 'frds@skylux.be', "$mail" -subject 'test account created mail' `
    # -Body "Welkom bij Skylux hieronder uw login gegevens.`n account: $principal_name`n passwoord: $random_password" `
    # -SmtpServer "relay.skylux.be"
}
