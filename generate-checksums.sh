pkgver=$(grep -E "^pkgver" PKGBUILD | cut -d = -f 2)

mkdir -p tmp
for arch in x64 i386 arm; do
	wget -N --quiet -P tmp http://syncapp.bittorrent.com/${pkgver}/btsync_${arch}-${pkgver}.tar.gz
done
sha256sum tmp/btsync_*-${pkgver}.tar.gz
