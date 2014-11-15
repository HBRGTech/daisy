cls

@'

|/////////////|  | |  | |                             | |
|:\/E:R|:T/\S:|  | |__| | __ _ _ ____   ____ _ _ __ __| |
|+++++++++++++|  |  __  |/ _` | '__\ \ / / _` | '__/ _` |
|\:*:\   /:*:/|  | |  | | (_| | |   \ V / (_| | | | (_| |
| \:::\ /:::/ |  |_|__|_|\__,_|_| _  \_/ \__,_|_|  \__,_|
\  \ ::*:: /  /  |  _ \          (_)
 \ /::/ \::\ /   | |_) |_   _ ___ _ _ __   ___  ___ ___
  \*:/   \:*/    |  _ <| | | / __| | '_ \ / _ \/ __/ __|
   \/_____\/     | |_) | |_| \__ \ | | | |  __/\__ \__ \
To improve the   |____/ \__,_|___/_|_| |_|\___||___/___/
practice of      |  __ \          (_)
management and   | |__) |_____   ___  _____      __
its impact in a  |  _  // _ \ \ / / |/ _ \ \ /\ / /
changing world.  | | \ \  __/\ V /| |  __/\ V  V /
est. 1922        |_|  \_\___| \_/ |_|\___| \_/\_/

'@

# =====================================
# Change to the Daisy dir
# =====================================
$dir = Split-Path $MyInvocation.MyCommand.Path
cd $dir
cd ..

# =====================================
# Check for requirements
# =====================================
if ( (-Not (Get-Command vagrant -errorAction SilentlyContinue)) -or (-Not (Get-WmiObject -Class Win32_Product | Select-Object -Property Name | Select-string "VirtualBox")) ) {
	echo "Please install prerequisites"
	echo "* Vagrant"
	echo "* VirtualBox"
	exit
}

# =====================================
# Start the VM (always provision, even if it's already running)
# =====================================
echo "=================================="
echo "= Provisioning the VM"
echo "=================================="

vagrant up --no-provision
vagrant provision
echo ""

# =====================================
# Add daisy.pattern.lab entry to hosts file
# =====================================
echo "=================================="
echo "= Configuring the hosts file"
echo "=================================="

$command = @'
$file = Join-Path -Path $env:WINDIR -ChildPath "system32\drivers\etc\hosts";

if ( -not ( Get-Content $file | Select-String daisy.pattern.lab ) ) {
	$data = Get-Content $file;
	$data += '';
	$data += '# Daisy';
	$data += '192.168.33.20 daisy.pattern.lab';
	Set-Content -Value $data -Path $file -Force -Encoding ASCII;
}
'@

$exitCode = -1;

$pinfo = New-Object System.Diagnostics.ProcessStartInfo "PowerShell"
$pinfo.Verb = "runas"
$pinfo.Arguments = "-command $command"

$p = New-Object System.Diagnostics.Process
$p.StartInfo = $pinfo

try { # Start() may throw an error if the user declines the UAC prompt
	$p.Start() | Out-Null
	$p.WaitForExit()
	$exitCode = $p.ExitCode
} catch {
	# User declined UAC prompt, set exit code to prompt failed
	$exitCode = 1
}

$hostFileSuccess = $false;
if ( $exitCode -eq 0 ) {
	$hostFileSuccess = $true;
	echo "* hosts file successfully configured"
} elseif ( $exitCode -eq 1 ) {
	$file = Join-Path -Path $env:WINDIR -ChildPath "system32\drivers\etc\hosts"
	echo "* The hosts file wasn't updated because it requires admin permission"
	echo "* Please set daisy.pattern.lab to 192.168.33.20 in $file or re-run this script with administrator permissions"
} elseif ( $exitCode -eq 2 ) {
	$hostFileSuccess = $true;
	echo "* No update needed for hosts file"
} else {
	echo "* Unknown error updating hosts file"
}



echo ""

# =====================================
# Outro/next steps
# =====================================
echo "=================================="
echo "= Next Steps"
echo "=================================="

if ( $hostFileSuccess ) {
	echo "* Go to http://daisy.pattern.lab in your browser"
	echo ""
	Start-Process "http://daisy.pattern.lab"
} else {
	echo "* Please fix the hosts file then go to http://daisy.pattern.lab in your browser"
	echo ""
}
