FROM ubuntu:24.04

LABEL   maintainer="Razvan-Ioan Petrescu <razvan@openthreat.ro>" \
        description="Imapsync with Web Interface on Ubuntu 24.04 LTS"

# Instalare pachete necesare pentru imapsync
RUN set -xe && \
  apt update && \
  apt install -y \
  libauthen-ntlm-perl \
  libclass-load-perl \
  libcrypt-openssl-rsa-perl \
  libcrypt-ssleay-perl \
  libdata-uniqid-perl \
  libdigest-hmac-perl \
  libdist-checkconflicts-perl \
  libencode-imaputf7-perl \
  libfile-copy-recursive-perl \
  libfile-tail-perl \
  libio-compress-perl \
  libio-socket-inet6-perl \
  libio-socket-ssl-perl \
  libio-tee-perl \
  libjson-webtoken-perl \
  libmail-imapclient-perl \
  libmodule-scandeps-perl \
  libnet-dbus-perl \
  libnet-ssleay-perl \
  libpar-packer-perl \
  libproc-processtable-perl \
  libreadonly-perl \
  libregexp-common-perl \
  libsys-meminfo-perl \
  libterm-readkey-perl \
  libtest-fatal-perl \
  libtest-mock-guard-perl \
  libtest-mockobject-perl \
  libtest-pod-perl \
  libtest-requires-perl \
  libtest-simple-perl \
  libunicode-string-perl \
  liburi-perl \
  libtest-nowarnings-perl \
  libtest-deep-perl \
  libtest-warn-perl \
  make \
  time \
  cpanminus \
  wget \
  curl \
  gnupg \
  build-essential && \
  cpanm IO::Socket::SSL

# Instalare imapsync
RUN set -xe && \
  cd /usr/bin && \
  wget https://raw.githubusercontent.com/imapsync/imapsync/refs/heads/master/imapsync -O /usr/bin/imapsync && \
  chmod +x /usr/bin/imapsync

# Instalare Node.js pentru backend
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
  apt install -y nodejs && \
  npm install -g pm2 && \
  rm -rf /var/lib/apt/lists/*

# Setare director de lucru
WORKDIR /app

# Copiere fișiere aplicație
COPY . /app

# Instalare dependențe backend
RUN npm install

# Expunere port pentru aplicație
EXPOSE 3000

# Pornire aplicație
CMD ["pm2-runtime", "index.js"]

