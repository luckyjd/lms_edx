GENCCODE_ASSEMBLY_TYPE=-a gcc
SO=so
SOBJ=so
A=a
LIBPREFIX=lib
LIB_EXT_ORDER=.52.1
COMPILE=gcc -DAI_ADDRCONFIG=0 -I/bitnami/megastack-linux-x64/output/sqlite/include -I/opt/lms_edx/edx-ficus.3-3/common/include  -I/opt/lms_edx/edx-ficus.3-3/common/include/sasl -I/opt/lms_edx/edx-ficus.3-3/common/include -D_REENTRANT  -DU_HAVE_ELF_H=1 -DU_HAVE_ATOMIC=1  -DU_ATTRIBUTE_DEPRECATED= -fPIC -I/opt/lms_edx/edx-ficus.3-3/common/include -fPIC -I/opt/lms_edx/edx-ficus.3-3/common/include -I/opt/lms_edx/edx-ficus.3-3/common/include -fPIC -m64 -I/bitnami/megastack-linux-x64/output/ImageMagick/include/ImageMagick-6 -I/bitnami/megastack-linux-x64/output/ImageMagick/include/ImageMagick-6/wand/ -I/bitnami/megastack-linux-x64/output/ImageMagick/include/ImageMagick-6/MagickCore/ -I/bitnami/megastack-linux-x64/output/ImageMagick/include/ImageMagick-6 -I/bitnami/megastack-linux-x64/output/ImageMagick/include/ImageMagick-6/wand/ -I/bitnami/megastack-linux-x64/output/ImageMagick/include/ImageMagick-6/MagickCore/ -std=c99 -Wall -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings   -c
LIBFLAGS=-I/opt/lms_edx/edx-ficus.3-3/common/include -DPIC -fPIC
GENLIB=gcc -fPIC -I/opt/lms_edx/edx-ficus.3-3/common/include -fPIC -I/opt/lms_edx/edx-ficus.3-3/common/include -I/opt/lms_edx/edx-ficus.3-3/common/include -fPIC -m64 -I/bitnami/megastack-linux-x64/output/ImageMagick/include/ImageMagick-6 -I/bitnami/megastack-linux-x64/output/ImageMagick/include/ImageMagick-6/wand/ -I/bitnami/megastack-linux-x64/output/ImageMagick/include/ImageMagick-6/MagickCore/ -I/bitnami/megastack-linux-x64/output/ImageMagick/include/ImageMagick-6 -I/bitnami/megastack-linux-x64/output/ImageMagick/include/ImageMagick-6/wand/ -I/bitnami/megastack-linux-x64/output/ImageMagick/include/ImageMagick-6/MagickCore/ -std=c99 -Wall -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings   -L/opt/lms_edx/edx-ficus.3-3/common/lib -L/opt/lms_edx/edx-ficus.3-3/common/lib -L/bitnami/megastack-linux-x64/output/sqlite/lib -L/opt/lms_edx/edx-ficus.3-3/python/lib -L/opt/lms_edx/edx-ficus.3-3/common/lib -L/bitnami/megastack-linux-x64/output/ImageMagick/lib -L/bitnami/megastack-linux-x64/output/ImageMagick/lib  -shared -Wl,-Bsymbolic
LDICUDTFLAGS=-nodefaultlibs -nostdlib
LD_SONAME=-Wl,-soname -Wl,
RPATH_FLAGS=
BIR_LDFLAGS=-Wl,-Bsymbolic
AR=ar
ARFLAGS=r
RANLIB=ranlib
INSTALL_CMD=/bin/install -c
