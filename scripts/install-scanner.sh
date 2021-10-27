apt update

echo "Installing virus scanner"
apt install clamav
clamscan --version

echo "Stopping freshclam daemon"
systemctl stop clamav-freshclam

echo "Manually updating signatures db"
freshclam
