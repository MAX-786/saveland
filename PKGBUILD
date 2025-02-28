# Maintainer: Mohammad K. Hussain <hussainmohammad328@gmail.com>

pkgname=saveland
pkgver=0.0.1
pkgrel=1
pkgdesc="Save and restore window layouts across Linux desktop environments"
arch=('any')
url="https://github.com/MAX-786/saveland"
license=('MIT')
depends=('bash' 'jq')
optdepends=('wmctrl: For GNOME support'
            'xdotool: For GNOME support')
provides=('saveland')
source=("$pkgname-$pkgver.tar.gz::https://github.com/MAX-786/$pkgname/archive/v$pkgver.tar.gz")

package() {
  cd "$pkgname-$pkgver"
  
  # Install the main executable
  install -Dm755 saveland "$pkgdir/usr/bin/saveland"
  
  # Install documentation
  install -Dm644 README.md "$pkgdir/usr/share/doc/$pkgname/README.md"
  install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}