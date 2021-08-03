# Install multi 1v1 plugin from cm2network/csgo:sourcemod
FROM cm2network/steamcmd:root

LABEL maintainer = "wz2483156090@gmail.com"

# Base env
ENV STEAMAPPID 740
ENV STEAMAPP csgo
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
ENV DLURL https://raw.githubusercontent.com/FisherWY/CSGO

# Set sourcemod env
ENV METAMOD_VERSION 1.10
ENV SOURCEMOD_VERSION 1.10

# Multi 1v1 plugin env
ENV MULTI1v1_VERSION 1.1.9
ENV DOWNLOAD_URL "https://github.com/splewis/csgo-multi-1v1/releases/download/${MULTI1v1_VERSION}/multi1v1_${MULTI1v1_VERSION}.zip"

# Create autoupdate config
# Add entry script & ESL config
# Remove packages and tidy up
# Download and extract plugin
RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget=1.20.1-1.1 \
		ca-certificates \
		lib32z1=1:1.2.11.dfsg-1 \
        unzip \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& wget --max-redirect=30 "${DLURL}/master/buster-sourcemod-multi1v1/entry.sh" -O "${HOMEDIR}/entry.sh" \
	&& { \
		echo '@ShutdownOnFailedCommand 1'; \
		echo '@NoPromptForPassword 1'; \
		echo 'login anonymous'; \
		echo 'force_install_dir '"${STEAMAPPDIR}"''; \
		echo 'app_update '"${STEAMAPPID}"''; \
		echo 'quit'; \
	   } > "${HOMEDIR}/${STEAMAPP}_update.txt" \
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" "${HOMEDIR}/${STEAMAPP}_update.txt" \	
	&& rm -rf /var/lib/apt/lists/*

# Server config env
ENV SRCDS_FPSMAX=300 \
	SRCDS_TICKRATE=128 \
	SRCDS_PORT=27015 \
	SRCDS_TV_PORT=27020 \
	SRCDS_CLIENT_PORT=27005 \
	SRCDS_NET_PUBLIC_ADDRESS="0.0.0.0" \
	SRCDS_IP="0.0.0.0" \
	SRCDS_MAXPLAYERS=14 \
	SRCDS_TOKEN=0 \
	SRCDS_RCONPW="changeme" \
	SRCDS_PW="changeme" \
	SRCDS_STARTMAP="" \
	SRCDS_REGION=3 \
	SRCDS_MAPGROUP="" \
	SRCDS_GAMETYPE=0 \
	SRCDS_GAMEMODE=1 \
	SRCDS_HOSTNAME="New \"${STEAMAPP}\" Server" \
	SRCDS_WORKSHOP_START_MAP="279177142" \
	SRCDS_HOST_WORKSHOP_COLLECTION="249376192" \
	SRCDS_WORKSHOP_AUTHKEY="" \
	ADDITIONAL_ARGS=""

USER ${USER}

VOLUME ${STEAMAPPDIR}

WORKDIR ${HOMEDIR}

# Start csgo server
CMD ["bash", "entry.sh"]

# Expose ports
EXPOSE 27015/tcp \
	27015/udp \
	27020/udp
