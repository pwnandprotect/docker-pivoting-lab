FROM nimmis/alpine

# add dependencies of metasploit 
RUN apk add --update --no-cache \
    build-base ruby ruby-bigdecimal \
    ruby-bundler ruby-io-console ruby-webrick \
    ruby-dev libffi-dev openssl-dev \
    readline-dev sqlite-dev postgresql-dev \
    libpcap-dev libxml2-dev libxslt-dev \
    yaml-dev zlib-dev ncurses-dev autoconf \
    bison subversion git sqlite nmap \
    libxslt postgresql ncurses openssh \
    curl

# enable ssh
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# setup user maikroservice with password maikroservice
RUN adduser -h /home/maikroservice -s /bin/sh -D maikroservice
RUN echo -n 'maikroservice:maikroservice' | chpasswd

# setup metasploit (tested with v6.1.42)
USER maikroservice
RUN mkdir /home/maikroservice/tools 

WORKDIR /home/maikroservice/tools


# does this work ? https://github.com/rapid7/metasploit-framework/zipball/master
# or this: https://docs.metasploit.com/docs/using-metasploit/getting-started/nightly-installers.html
# download metasploit
RUN wget https://github.com/rapid7/metasploit-framework/archive/refs/tags/6.1.42.zip -O /home/maikroservice/tools/metasploit-framework-6.1.42.zip


USER root

RUN chown -R maikroservice /home/maikroservice/tools
USER maikroservice
RUN unzip /home/maikroservice/tools/metasploit-framework-6.1.42.zip
RUN rm /home/maikroservice/tools/metasploit-framework-6.1.42.zip
RUN mv /home/maikroservice/tools/metasploit-framework-6.1.42/ /home/maikroservice/tools/metasploit
WORKDIR /home/maikroservice/tools/metasploit

# RUN bundle config set --local path /home/maikroservice/tools
RUN bundle install --path /home/maikroservice/tools



# # remove unneeded dependencies after installing metasploit
USER root

RUN apk del build-base ruby-dev libffi-dev openssl-dev \
    readline-dev sqlite-dev postgresql-dev \
    libpcap-dev libxml2-dev libxslt-dev yaml-dev \
    zlib-dev ncurses-dev bison autoconf \
    && rm -rf /var/cache/apk/*

# set entrypoint and open port 22 for ssh connection
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 22
COPY entrypoint.sh /

# Sources:
# https://www.cyberciti.biz/faq/how-to-install-openssh-server-on-alpine-linux-including-docker/
# https://unix.stackexchange.com/questions/575516/metasploit-error-on-alpine
# https://github.com/fcolista/alpine-metasploit