FROM debian:latest

LABEL maintainer="dexter.cz@gmail.com"

ENV STEAMCMDDIR /home/steam/steamcmd
ENV INSTALL_DIR /home/steam/dontstarvetogether_dedicated_server
ENV DONTSTARVE_DIR /home/steam/.klei/DoNotStarveTogether

RUN set -x \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		lib32gcc1 \
		libcurl3-gnutls:i386 \
		libstdc++6:i386 \
		wget \
		ca-certificates \
	&& useradd -m steam \
	&& su steam -c \
		"mkdir -p ${STEAMCMDDIR} \
		&& cd ${STEAMCMDDIR} \
		&& wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - \
		&& mkdir -p ${DONTSTARVE_DIR} \
		&& ./steamcmd.sh +force_install_dir ${INSTALL_DIR} +login anonymous +app_update 343050 validate +quit" \
	&& apt-get remove --purge -y \
		wget \
	&& apt-get clean autoclean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

USER steam

COPY run_dedicated_servers.sh $STEAMCMDDIR

WORKDIR $STEAMCMDDIR

