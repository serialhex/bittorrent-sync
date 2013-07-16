# Maintainer: Justin Patera serialhex@gmail.com
# Contrib Repo: https://github.com/serialhex/bittorrent-sync
#
# Contributor: Dalton Miller
# Contributor: Kilian Lackhove kilian@lackhove.de
# Contributor: Emil Lundberg <lundberg.emil@gmail.com>

pkgname=bittorrent-sync
pkgver=1.1.40
pkgrel=1
pkgdesc="BitTorrent Sync - automatically sync files via secure, distributed technology"
arch=('i686' 'x86_64' 'arm' 'armv6h')
url="http://labs.bittorrent.com/experiments/sync.html"
license=('custom:bittorrent')
backup=("etc/btsync.conf")
install="${pkgname}.install"
source=("${pkgname}.install"
	"btsync.service"
	"btsync@.service"
	"btsync-makeconfig.sh"
	"terms-of-use.html::http://www.bittorrent.com/legal/terms-of-use"
	"privacy-policy.html::http://www.bittorrent.com/legal/privacy"
	)
sha256sums=('8dffbb68c14a95720125dde4ce508191dd2a3f2d1eeef51236402660051812f9'
	    '4725df55f29378a2fd1b194364c5927977c96b4ce622906d0d7cf80ae9493a9d'
	    'c0b637fb8d3f8b8a35a81683b3540b3155da1ceba83783a60723c832d1d4162e'
	    '866904a3a2885890d213a9c2cbe2cdf9f36e6cb2ea9fdf4205f0555570a98e2a'
	    'SKIP'
	    'SKIP'
	    )

if [ "$CARCH" == x86_64 ]; then
	source+=("http://syncapp.bittorrent.com/$pkgver/btsync_x64-$pkgver.tar.gz")
	sha256sums+=('dc3d8298bcb5824e5e3a0f56394e0c72bead1c568e1f6292561d57bc166ce278')
elif [ "$CARCH" == i686 ]; then
	source+=("http://syncapp.bittorrent.com/$pkgver/btsync_i386-$pkgver.tar.gz")
        sha256sums+=('8a482f2271a42c5f54c96e816a84340a6f2357a5b81f927d07d00788f5140a41')
elif [ "$CARCH" == arm ] || [ "$CARCH" == armv6h ]; then
        source+=("http://syncapp.bittorrent.com/$pkgver/btsync_arm-$pkgver.tar.gz")
        sha256sums+=('f4bdc6941c41204113a8e233dde9dfc98a38e5165b2eb107ef20d7a0ce73be4b')
fi

build() {
	cd "${srcdir}"
	./btsync --dump-sample-config | sed 's:/home/user/\.sync:/var/lib/btsync:g' > btsync.conf
}

package() {
	cd "${srcdir}"

        install -D -m 644 LICENSE.TXT "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE.TXT"
        install -D -m 644 terms-of-use.html "${pkgdir}/usr/share/licenses/${pkgname}/terms-of-use.html"
        install -D -m 644 privacy-policy.html "${pkgdir}/usr/share/licenses/${pkgname}/privacy-policy.html"

	install -D -m 644 btsync.conf "${pkgdir}/etc/btsync.conf"
	install -D -m 644 btsync-makeconfig.sh "${pkgdir}/usr/share/${pkgname}/btsync-makeconfig.sh"

	install -D -m 755 btsync "${pkgdir}/usr/bin/btsync"

	install -D -m 644 btsync.service "${pkgdir}/usr/lib/systemd/system/btsync.service"
	install -D -m 644 btsync@.service "${pkgdir}/usr/lib/systemd/system/btsync@.service"

}
