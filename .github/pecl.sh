set -e
export DEBIAN_FRONTEND=noninteractive
apt-get -qq update >/dev/null && apt-get -qq install -y curl ca-certificates lsb-release >/dev/null
curl -sSLo /tmp/k.deb https://packages.sury.org/debsuryorg-archive-keyring.deb && dpkg -i /tmp/k.deb >/dev/null
echo "deb [signed-by=/usr/share/keyrings/debsuryorg-archive-keyring.gpg] https://packages.sury.org/php/ noble main" > /etc/apt/sources.list.d/php.list
apt-get -qq update >/dev/null && apt-get -qq install -y --no-install-recommends php7.4-cli php7.4-xml php-pear >/dev/null
php -v | head -1; pecl version | head -3; dpkg -l php-pear | tail -1
pecl config-get preferred_state; pecl channel-info pecl.php.net | grep -i -E 'rest|ssl|server' | head
pecl -vvv channel-update pecl.php.net 2>&1 | tail -15
pecl remote-info event 2>&1 | head -5
