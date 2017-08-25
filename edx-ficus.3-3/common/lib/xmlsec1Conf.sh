#
# Configuration file for using the XML library in GNOME applications
#
prefix="/opt/lms_edx/edx-ficus.3-3/common"
exec_prefix="${prefix}"
libdir="${exec_prefix}/lib"
includedir="${prefix}/include"

XMLSEC_LIBDIR="${exec_prefix}/lib"
XMLSEC_INCLUDEDIR=" -D__XMLSEC_FUNCTION__=__FUNCTION__ -DXMLSEC_NO_SIZE_T -DXMLSEC_NO_GOST=1 -DXMLSEC_NO_XKMS=1 -DXMLSEC_DL_LIBLTDL=1 -I${prefix}/include/xmlsec1   -I/opt/lms_edx/edx-ficus.3-3/common/include/libxml2  -I/opt/lms_edx/edx-ficus.3-3/common/include -I/opt/lms_edx/edx-ficus.3-3/common/include/libxml2  -I/opt/lms_edx/edx-ficus.3-3/common/include  -DXMLSEC_OPENSSL_100=1 -DXMLSEC_CRYPTO_OPENSSL=1 -DXMLSEC_CRYPTO=\\\"openssl\\\""
XMLSEC_LIBS="-L${exec_prefix}/lib -lxmlsec1-openssl -lxmlsec1 -lltdl  -L/opt/lms_edx/edx-ficus.3-3/common/lib -lxml2  -L/opt/lms_edx/edx-ficus.3-3/common/lib -lxslt -lxml2 -lz -liconv -lm -ldl -lm -lxml2  -L/opt/lms_edx/edx-ficus.3-3/common/lib -lssl -lcrypto "
MODULE_VERSION="xmlsec-1.2.20-openssl"

