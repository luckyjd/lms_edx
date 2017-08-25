#!/bin/sh
LDFLAGS="-L/opt/lms_edx/edx-ficus.3-3/common/lib $LDFLAGS"
export LDFLAGS
CFLAGS="-I/opt/lms_edx/edx-ficus.3-3/common/include/ImageMagick -I/opt/lms_edx/edx-ficus.3-3/common/include $CFLAGS"
export CFLAGS
CXXFLAGS="-I/opt/lms_edx/edx-ficus.3-3/common/include $CXXFLAGS"
export CXXFLAGS
		    
PKG_CONFIG_PATH="/opt/lms_edx/edx-ficus.3-3/common/lib/pkgconfig"
export PKG_CONFIG_PATH
