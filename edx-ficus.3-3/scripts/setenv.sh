#!/bin/sh
echo $PATH | egrep "/opt/lms_edx/edx-ficus.3-3/common" > /dev/null
if [ $? -ne 0 ] ; then
PATH="/opt/lms_edx/edx-ficus.3-3/apps/edx/edx-platform/node_modules/.bin:/opt/lms_edx/edx-ficus.3-3/apps/edx/bin:/opt/lms_edx/edx-ficus.3-3/postgresql/bin:/opt/lms_edx/edx-ficus.3-3/git/bin:/opt/lms_edx/edx-ficus.3-3/perl/bin:/opt/lms_edx/edx-ficus.3-3/nodejs/bin:/opt/lms_edx/edx-ficus.3-3/java/bin:/opt/lms_edx/edx-ficus.3-3/erlang/bin:/opt/lms_edx/edx-ficus.3-3/ruby/bin:/opt/lms_edx/edx-ficus.3-3/python/bin:/opt/lms_edx/edx-ficus.3-3/elasticsearch/bin:/opt/lms_edx/edx-ficus.3-3/memcached/bin:/opt/lms_edx/edx-ficus.3-3/mongodb/bin:/opt/lms_edx/edx-ficus.3-3/sqlite/bin:/opt/lms_edx/edx-ficus.3-3/mysql/bin:/opt/lms_edx/edx-ficus.3-3/apache2/bin:/opt/lms_edx/edx-ficus.3-3/common/bin:$PATH"
export PATH
fi
echo $LD_LIBRARY_PATH | egrep "/opt/lms_edx/edx-ficus.3-3/common" > /dev/null
if [ $? -ne 0 ] ; then
LD_LIBRARY_PATH="/opt/lms_edx/edx-ficus.3-3/ruby/lib/ruby/gems/2.3.0/gems/passenger-5.1.2/lib:/opt/lms_edx/edx-ficus.3-3/postgresql/lib:/opt/lms_edx/edx-ficus.3-3/git/lib:/opt/lms_edx/edx-ficus.3-3/perl/lib:/opt/lms_edx/edx-ficus.3-3/perl/lib/5.16.3/x86_64-linux-thread-multi/CORE:/opt/lms_edx/edx-ficus.3-3/erlang/lib:/opt/lms_edx/edx-ficus.3-3/ruby/lib:/opt/lms_edx/edx-ficus.3-3/python/lib:/opt/lms_edx/edx-ficus.3-3/memcached/lib:/opt/lms_edx/edx-ficus.3-3/mongodb/lib:/opt/lms_edx/edx-ficus.3-3/sqlite/lib:/opt/lms_edx/edx-ficus.3-3/mysql/lib:/opt/lms_edx/edx-ficus.3-3/apache2/lib:/opt/lms_edx/edx-ficus.3-3/common/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH
fi

TERMINFO=/opt/lms_edx/edx-ficus.3-3/common/share/terminfo
export TERMINFO
##### GIT ENV #####
GIT_EXEC_PATH=/opt/lms_edx/edx-ficus.3-3/git/libexec/git-core/
export GIT_EXEC_PATH
GIT_TEMPLATE_DIR=/opt/lms_edx/edx-ficus.3-3/git/share/git-core/templates
export GIT_TEMPLATE_DIR
GIT_SSL_CAINFO=/opt/lms_edx/edx-ficus.3-3/common/openssl/certs/curl-ca-bundle.crt
export GIT_SSL_CAINFO


PERL5LIB="/opt/lms_edx/edx-ficus.3-3/git/lib/site_perl/5.16.3:$PERL5LIB"
export PERL5LIB
GITPERLLIB="/opt/lms_edx/edx-ficus.3-3/git/lib/site_perl/5.16.3"
export GITPERLLIB
                    ##### GHOSTSCRIPT ENV #####
GS_LIB="/opt/lms_edx/edx-ficus.3-3/common/share/ghostscript/fonts"
export GS_LIB
##### IMAGEMAGICK ENV #####
MAGICK_HOME="/opt/lms_edx/edx-ficus.3-3/common"
export MAGICK_HOME

MAGICK_CONFIGURE_PATH="/opt/lms_edx/edx-ficus.3-3/common/lib/ImageMagick-6.9.8/config-Q16:/opt/lms_edx/edx-ficus.3-3/common/"
export MAGICK_CONFIGURE_PATH

MAGICK_CODER_MODULE_PATH="/opt/lms_edx/edx-ficus.3-3/common/lib/ImageMagick-6.9.8/modules-Q16/coders"
export MAGICK_CODER_MODULE_PATH
SASL_CONF_PATH=/opt/lms_edx/edx-ficus.3-3/common/etc
export SASL_CONF_PATH
SASL_PATH=/opt/lms_edx/edx-ficus.3-3/common/lib/sasl2 
export SASL_PATH
LDAPCONF=/opt/lms_edx/edx-ficus.3-3/common/etc/openldap/ldap.conf
export LDAPCONF
##### PERL ENV #####
PERL5LIB="/opt/lms_edx/edx-ficus.3-3/perl/lib/5.16.3:/opt/lms_edx/edx-ficus.3-3/perl/lib/site_perl/5.16.3:/opt/lms_edx/edx-ficus.3-3/perl/lib/5.16.3/x86_64-linux-thread-multi:/opt/lms_edx/edx-ficus.3-3/perl/lib/site_perl/5.16.3/x86_64-linux-thread-multi"
export PERL5LIB
##### NODEJS ENV #####

export NODE_PATH=/opt/lms_edx/edx-ficus.3-3/nodejs/lib/node_modules

            ##### JAVA ENV #####
JAVA_HOME=/opt/lms_edx/edx-ficus.3-3/java
export JAVA_HOME

##### RUBY ENV #####
                GEM_HOME="/opt/lms_edx/edx-ficus.3-3/ruby/lib/ruby/gems/2.3.0"
                GEM_PATH="/opt/lms_edx/edx-ficus.3-3/ruby/lib/ruby/gems/2.3.0"
                RUBY_HOME="/opt/lms_edx/edx-ficus.3-3/ruby"
                RUBYLIB="/opt/lms_edx/edx-ficus.3-3/ruby/lib/ruby/site_ruby/2.3.0:/opt/lms_edx/edx-ficus.3-3/ruby/lib/ruby/site_ruby/2.3.0/x86_64-linux:/opt/lms_edx/edx-ficus.3-3/ruby/lib/ruby/site_ruby/:/opt/lms_edx/edx-ficus.3-3/ruby/lib/ruby/vendor_ruby/2.3.0:/opt/lms_edx/edx-ficus.3-3/ruby/lib/ruby/vendor_ruby/2.3.0/x86_64-linux:/opt/lms_edx/edx-ficus.3-3/ruby/lib/ruby/vendor_ruby/:/opt/lms_edx/edx-ficus.3-3/ruby/lib/ruby/2.3.0:/opt/lms_edx/edx-ficus.3-3/ruby/lib/ruby/2.3.0/x86_64-linux:/opt/lms_edx/edx-ficus.3-3/ruby/lib/ruby/:/opt/lms_edx/edx-ficus.3-3/ruby/lib"
                BUNDLE_CONFIG="/opt/lms_edx/edx-ficus.3-3/ruby/.bundler/config"
                export GEM_HOME
                export GEM_PATH
                export RUBY_HOME
                export RUBYLIB
                export BUNDLE_CONFIG
            ##### MEMCACHED ENV #####
		
      ##### MONGODB ENV #####

      ##### SQLITE ENV #####
			
##### MYSQL ENV #####

##### APACHE ENV #####

##### CURL ENV #####
CURL_CA_BUNDLE=/opt/lms_edx/edx-ficus.3-3/common/openssl/certs/curl-ca-bundle.crt
export CURL_CA_BUNDLE
##### SSL ENV #####
SSL_CERT_FILE=/opt/lms_edx/edx-ficus.3-3/common/openssl/certs/curl-ca-bundle.crt
export SSL_CERT_FILE
OPENSSL_CONF=/opt/lms_edx/edx-ficus.3-3/common/openssl/openssl.cnf
export OPENSSL_CONF
OPENSSL_ENGINES=/opt/lms_edx/edx-ficus.3-3/common/lib/engines
export OPENSSL_ENGINES


. /opt/lms_edx/edx-ficus.3-3/scripts/build-setenv.sh
PYTHONHOME=/opt/lms_edx/edx-ficus.3-3/python
export PYTHONHOME

PYTHON_EGG_CACHE=/opt/lms_edx/edx-ficus.3-3/.tmp
export PYTHON_EGG_CACHE
