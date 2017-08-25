		    Bitnamim Open edX Stack ficus.3-3
		  =============================

1. OVERVIEW

The Bitnami Project was created to help spread the adoption of freely
available, high quality open source web applications. Bitnami aims to make
it easier than ever to discover, download and install Open Source software
such as document and content management systems, wikis and blogging
software.

You can learn more about Bitnami at https://bitnami.com

EdX is a massive open online course (MOOC) provider and online learning
platform. It hosts online university-level courses in a wide range of
disciplines to a worldwide audience. Open edX has been developed as
open-source software and made available to other institutions of higher
learning that want to make similar offerings.

You can learn more about Open edX at http://code.edx.org/

The Bitnami Open edX Stack is an installer that greatly simplifies the
installation of Open edX and runtime dependencies. It includes ready-to-run
versions of Apache, Elasticsearch, Erlang, Java, Memcached, Mysql, MongoDB,
Node, RabbitMQ, Erlang, Python and Ruby on Rails. Open edX Stack is
distributed for free under the Affero GPL license. Please see the appendix
for the specific licenses of all Open Source components included.

You can learn more about Bitnami Stacks at https://bitnami.com/stacks/

2. FEATURES

- Easy to Install

Bitnami Stacks are built with one goal in mind: to make it as easy as
possible to install open source software. Our installers completely automate
the process of installing and configuring all of the software included in
each Stack, so you can have everything up and running in just a few clicks.

- Independent

Bitnami Stacks are completely self-contained, and therefore do not interfere
with any software already installed on your system. For example, you can
upgrade your system's Mysql or Apache without fear of 'breaking' your
Bitnami Stack.

- Integrated

By the time you click the 'finish' button on the installer, the whole stack
will be integrated, configured and ready to go.

- Relocatable

Bitnami Stacks can be installed in any directory. This allows you to have
multiple instances of the same stack, without them interfering with each other.

3. COMPONENTS

Bitnami Open edX Stack ships with the following software versions:

  - Open edX ficus.3
  - Apache 2.4.27
  - Elasticsearch 0.90.11
  - Erlang 18.0
  - Java 1.8.0_131
  - Memcached 1.4.39
  - MongoDB 2.6.12
  - Mysql 5.6.37
  - Node.js 6.11.1
  - Python 2.7.13
  - RabbitMQ 3.6.10
  - Rails 4.2.8
  - Ruby 2.3.4
  - RubyGems 1.8.12


4. REQUIREMENTS

To install Bitnami Open edX Stack you will need:

    - Intel x86 or compatible processor
    - Minimum of 6144 GB RAM
    - Minimum of 25 GB hard drive space
    - TCP/IP protocol support
    - Compatible operating systems:
      - An x86 or x64 Linux operating system.

5. INSTALLATION

The Bitnami Open edX Stack is distributed as a binary executable installer.
It can be downloaded from:

https://bitnami.com/stacks/

The downloaded file will be named something similar to:

bitnami-edx-ficus.3-3-linux-installer.run on Linux or
bitnami-edx-ficus.3-3-linux-x64-installer.run on Linux 64 bit or

On Linux, you will need to give it executable permissions:

chmod 755 bitnami-edx-ficus.3-3-linux-installer.run

To begin the installation process, invoke from a shell or double-click on
the file you have downloaded, and you will be greeted by the 'Welcome'
screen. You will be asked to choose the installation folder. If the
destination directory does not exist, it will be created as part of the
installation.

The default listening port for Apache is 8080, for Elasticsearch 9300,
for Memcached 11211, for MongoDB 27017, for MySQL is 3306, for RabbitMQ 5672,
for Open edX XQueue 18040 and 18010 for Open edX CMS.
If those ports are already in use by other applications, you will be
prompted for alternate ports to use.

The next screen will prompt you for data necessary to send emails:

SMTP Address: The address of SMTP server.

SMTP Hostname: The name of SMTP server.

SMTP Port: The port of SMTP server.

SMTP Username and Password: User and password to SMTP server.

Once the installation process has been completed, you will see the
'Installation Finished' page. You can choose to launch Bitnami
Open edX Stack at this point. If you do so, your default web browser
will point you to the Bitnami local site.

If you receive an error message during installation, please refer to
the Troubleshooting section.

The rest of this guide assumes that you installed Bitnami Open edX
Stack in /home/user/edx-ficus.3-3 on Linux or
/Application/edx-ficus.3-3 on OS X and use port
8080 for Apache on Unix systems and 5432 for Mysql.

6. STARTING AND STOPPING BITNAMI OPEN EDX STACK

To enter to Open edX you can point your browser to
http://127.0.0.1:8080/ on Unix systems.

To start/stop/restart application on Linux you can use the included
ctlscript.sh utility, as shown below:

       ./ctlscript.sh (start|stop|restart)
       ./ctlscript.sh (start|stop|restart) apache
       ./ctlscript.sh (start|stop|restart) edx
       ./ctlscript.sh (start|stop|restart) elasticsearch
       ./ctlscript.sh (start|stop|restart) memcached
       ./ctlscript.sh (start|stop|restart) mongodb
       ./ctlscript.sh (start|stop|restart) mysql
       ./ctlscript.sh (start|stop|restart) rabbitmq
       ./ctlscript.sh (start|stop|restart) xqueue


  start      - start the service(s)
  stop       - stop  the service(s)
  restart    - restart or start the service(s)

That will start Apache, edX Celery Workers, Elasticsearch,
Memcached, MongoDB, MySQL, RabbitMQ and XQueue consumer services.
Once started, you can open your browser and access the following URL:

http://127.0.0.1:8080/ on Unix systems or

If you selected an alternate port during installation, for example 18080, the
URL will look like:

http://127.0.0.1:18080/


7. DIRECTORY STRUCTURE

The installation process will create several subfolders under the main
installation directory:

  apache2/: Apache Web server.
  apps/edx/: edX LMS and CMS files.
  apps/forum/: cs_comments_service files.
  apps/xqueue/: XQueue files.
  common/: Common libraries.
  elasticsearch/: Elasticsearch files.
  licenses/: Licenses files.
  memcached/: Memcached files.
  mysql/: Mysql Database.
  mongodb/: MongoDB Database.
  python/: Python files.
  rabbitmq/: RabbitMQ files.
  ruby/: Ruby files.
  scripts/: Script with enviromnent vars.

8. DEFAULT USERNAMES AND PASSWORDS

The Open edX administrative user and password are the ones you set at
installation time.

Mysql and MongoDB admin user is called 'root', and its password is also one
you set at installation time.

The default non-root account used to access the database is named
bitnami, and its password is also bitnami.

9. TROUBLESHOOTING

In addition to the resources provided below, we encourage you to post
your questions and suggestions at:

https://community.bitnami.com/

We also encourage you to sign up for our newsletter, which we'll use to
announce new releases and new stacks. To do so, just register at:
https://bitnami.com/newsletter.

9.1 Installer

# Installer Payload Error

If you get the following error while trying to run the installer from the
command line:

"Installer payload initialization failed. This is likely due to an
incomplete or corrupt downloaded file"

The installer binary is not complete, likely because the file was
not downloaded correctly. You will need to download the file and
repeat the installation process.

# Installer execution error on Linux

If you get the following error while trying to run the installer:

"Cannot open bitnami-edx-ficus.3-3-linux.run: No application suitable for
automatic installation is available for handling this kind of file."

In some operatings systems you can change permissions with right click ->
properties -> permissions -> execution enable.

Or from the command line:

$ chmod 755 bitnami-edx-ficus.3-3-linux.run


9.2 Apache

If you find any problem starting Apache, the first place you should check is
the Apache error log file:

/home/user/edx-ficus.3-3/apache2/logs/error.log on Linux or
/Applications/edx-ficus.3-3/apache2/error.log on OS X.

Most errors are related to not being able to listen to the default port.
Make sure there are no other server programs listening at the same port
before trying to start Apache. Some programs, such as Skype, may also use
port 80. For issues not covered in this Quick Start guide, please refer to
the Apache documentation, which is located at http://httpd.apache.org/docs/

9.3 Open edX

For any problem related to Open edX project, please visit
https://groups.google.com/forum/#!forum/edx-code

10. LICENSES

Open edX and its modules are distributed under the Affero GNU General Public
License, which is located at http://www.gnu.org/licenses/agpl-3.0.html

Apache Web Server is distributed under the Apache License v2.0, which
is located at http://www.apache.org/licenses/LICENSE-2.0

Elasticsearch is distributed under the Apache License v2.0, which
is located at http://www.apache.org/licenses/LICENSE-2.0

Erlang is distributed under the Erlang Public License (EPL), which is
located at http://www.erlang.org/EPLICENSE

Java and related libraries are distributed under the Common Development
and Distribution License (CDDL), Version 1.0 and the Sun Microsystems, Inc.
("Sun") Software License Agreement, wich are located at
http://java.sun.com/j2se/1.5.0/docs/relnotes/license.html

Memcached is released under the BSD License, which is located at
http://www.opensource.org/licenses/bsd-license.php

MongoDB is distributed under the GNU AGPL v3.0 License, which is located at
http://www.mongodb.org/about/licensing/

Mysql is distributed under the GNU General Public License v2, which is
located at http://www.gnu.org/licenses/old-licenses/gpl-2.0.html

Django is released under the BSD license, which is located
https://github.com/django/django/blob/master/LICENSE

Python is distributed under the Python License, which is located at
http://www.python.org/download/releases/2.6.5/license/

Node.js is distributed under the MIT License, which is located at
https://github.com/nodejs/node/blob/master/LICENSE

RabbitMQ is distributed under the Mozilla Public License (MPL) v1.1, which is
located at https://www.mozilla.org/MPL/1.1/

Rails is released under the MIT license, which is located
http://www.opensource.org/licenses/mit-license.php

Ruby is released under the Ruby License (BSDL), wich is located at
http://www.ruby-lang.org/en/license.txt

RubyGems is released under the Ruby License, which is located at
http://www.ruby-lang.org/en/LICENSE.txt

Rake is released under the Ruby License, which is located at
http://www.ruby-lang.org/en/LICENSE.txt

ImageMagick has its own license, which is located at
https://www.imagemagick.org/subversion/ImageMagick/trunk/LICENSE

Rmagick is released under the MIT license, which is located
http://www.opensource.org/licenses/mit-license.php

OpenSSL is released under the terms of the Apache License, which is
located at http://www.openssl.org/source/license.html

Ncurses is released under the MIT license, which is located at
http://www.opensource.org/licenses/mit-license.php

Readline is released under the GPL license, which is located at
http://www.gnu.org/copyleft/gpl.html

Zlib is released under the zlib License (a free software license/compatible
with GPL), which is located at http://www.gzip.org/zlib/zlib_license.html

Libiconv is released under the LGPL license, which is located at
http://www.gnu.org/licenses/lgpl.html

Expat is released under the MIT license, which is located at
http://www.opensource.org/licenses/mit-license.php

Freetype is released under The Freetype Project License, that is located at
http://freetype.sourceforge.net/FTL.TXT
