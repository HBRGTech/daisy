#!/usr/bin/env bash

# =====================================
# Set cwd to Daisy
# =====================================
DIR="$( dirname $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) )"
ORIG=`pwd`
cd $DIR

# =====================================
# Process command line flags
# =====================================

for i in "$@"
do
case $i in
    --domain=*)
        DAISY_DOMAIN=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
    ;;
    *)
        # unknown option
    ;;
esac
done

# =====================================
# Daisy - brought to you by HBR Tech
# =====================================
echo "
|/////////////|  | |  | |                             | |
|:\/E:R|:T/\S:|  | |__| | __ _ _ ____   ____ _ _ __ __| |
|+++++++++++++|  |  __  |/ _\` | '__\ \ / / _\` | '__/ _\` |
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
"

# =====================================
# Check for prerequisites
# =====================================
if [[ ! `which vagrant` || ! `which VBoxManage` ]]; then
    echo "Please install the prerequisites"
    echo "* Vagrant"
    echo "* VirtualBox"
    exit 1
fi

# =====================================
# Acquire root access for the rest of the script
# =====================================
sudo -k
sudo -p "This script needs sudo access to continue. Please enter your password:" whoami 1>/dev/null || exit
echo ""

# =====================================
# Ask for domain
# =====================================
if [[ -z "$DAISY_DOMAIN" ]]; then
    echo "=================================="
    echo "= Domain Setup"
    echo "=================================="

    read -e -p "What domain would you like to use? [daisy.pattern.lab]:" DAISY_DOMAIN
    DAISY_DOMAIN="${DAISY_DOMAIN:-daisy.pattern.lab}"
    echo ""
fi

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
# Should match IP configured in Vagrantfile
cat /etc/hosts | grep DAISY_DOMAIN || sudo printf "\n# Daisy Pattern Lab\n192.168.33.20 ${DAISY_DOMAIN}\n" | sudo tee -a /etc/hosts
echo ""

# =====================================
# Outro/next steps
# =====================================
echo "=================================="
echo "= Next Steps"
echo "=================================="

echo "* Go to http://$DAISY_DOMAIN in your browser"
echo ""

# =====================================
# Kill sudo timestamp
# =====================================
sudo -k

# =====================================
# Reset cwd
# =====================================
cd $ORIG
