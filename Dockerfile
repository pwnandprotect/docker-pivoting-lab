FROM nimmis/alpine

RUN apk add --update --no-cache openssh 
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
RUN adduser -h /home/maikroservice -s /bin/sh -D maikroservice
RUN echo -n 'maikroservice:maikroservice' | chpasswd
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 22
COPY entrypoint.sh /

# https://www.cyberciti.biz/faq/how-to-install-openssh-server-on-alpine-linux-including-docker/