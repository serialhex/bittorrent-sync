# Maintainer: Justin Patera serialhex@gmail.com
# Contrib Repo: https://github.com/serialhex/bittorrent-sync
#
# Contributor: Dalton Miller
# Contributor: Kilian Lackhove kilian@lackhove.de
# Contributor: Emil Lundberg <lundberg.emil@gmail.com>

pkgname=bittorrent-sync
pkgver=1.1.40
pkgrel=2
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
	"btsync-wrapper.sh"
	"btsync.conf.doc"
	"terms-of-use.html::http://www.bittorrent.com/legal/terms-of-use"
	"privacy-policy.html::http://www.bittorrent.com/legal/privacy"
	)
sha256sums=('7ffd62c83bd6cb6d083972b811e662323515153d6c543006ec7c18762566dd3d'
	    '29db7228c3363bafddc797b97209b3fe3e07497521dac2de11811db7d80d6c09'
	    '74e43597fb523206908ed4ed28811e6939185f6ae89d21e1b48058ab2f3fed47'
	    '640ffaf885f00de78d97925201be8ccde753a43714064336a8355bc89d7332db'
	    '6fe65cffe191db2090251ba2e0ed496b922847891645fc0248adebb7b64be803'
	    '9df5e6b5db86b5d58b5e24038fc70f3789c0a44a31dd5ecb29fb59f7d018a485'
	    'SKIP'
	    'SKIP'
	    )

if [ "$CARCH" == x86_64 ]; then
	source+=("http://syncapp.bittorrent.com/$pkgver/btsync_x64-$pkgver.tar.gz")
	sha256sums+=('dc3d8298bcb5824e5e3a0f56394e0c72bead1c568e1f6292561d57bc166ce278')
elif [ "$CARCH" == i686 ]; then
	source+=("http://syncapp.bittorrent.com/$pkgver/btsync_i386-$pkgver.tar.gz")
<<<<<<< HEAD
        sha256sums+=('8a482f2271a42c5f54c96e816a84340a6f2357a5b81f927d07d00788f5140a41')
=======
        sha256sums+=('df26cb78f4509b206c1433ae4d4628ad7e75ac608bfb83996380be46c734836d')
>>>>>>> emlun-dev
elif [ "$CARCH" == arm ] || [ "$CARCH" == armv6h ]; then
        source+=("http://syncapp.bittorrent.com/$pkgver/btsync_arm-$pkgver.tar.gz")
        sha256sums+=('f4bdc6941c41204113a8e233dde9dfc98a38e5165b2eb107ef20d7a0ce73be4b')
fi

build() {
	cd "${srcdir}"
	./btsync-makeconfig.sh --storage-path /var/lib/btsync --login admin --device-name $HOSTNAME > btsync.conf
}

package() {
	cd "${srcdir}"

        install -D -m 644 LICENSE.TXT "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE.TXT"
        install -D -m 644 terms-of-use.html "${pkgdir}/usr/share/licenses/${pkgname}/terms-of-use.html"
        install -D -m 644 privacy-policy.html "${pkgdir}/usr/share/licenses/${pkgname}/privacy-policy.html"

	install -D -m 644 btsync.conf "${pkgdir}/etc/btsync.conf"
	install -D -m 644 btsync.conf.doc "${pkgdir}/usr/share/${pkgname}/btsync.conf.doc"
	install -D -m 755 btsync-makeconfig.sh "${pkgdir}/usr/share/${pkgname}/btsync-makeconfig.sh"

	install -D -m 755 btsync "${pkgdir}/usr/bin/btsync"
	install -D -m 755 btsync-wrapper.sh "${pkgdir}/usr/bin/btsync-wrapper"

	install -D -m 644 btsync.service "${pkgdir}/usr/lib/systemd/system/btsync.service"
	install -D -m 644 btsync@.service "${pkgdir}/usr/lib/systemd/system/btsync@.service"

}
