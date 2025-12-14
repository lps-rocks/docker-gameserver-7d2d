FROM ghcr.io/parkervcp/steamcmd:debian

ENV AUTO_UPDATE=1
ENV GAME_DIFFICULTY=2
ENV SERVER_DISABLED_NETWORK_PROTOCOLS=""
ENV PASSWORD="changeme"
ENV LD_LIBRARY_PATH="."
ENV SRCDS_APPID=294420
ENV SRCDS_BETAID=""
ENV TELNET_PORT=8081
ENV MAX_PLAYERS=8
ENV STARTUP='./7DaysToDieServer.x86_64 -configfile=serverconfig.xml -quit -batchmode -nographics -dedicated -ServerDisabledNetworkProtocols={{SERVER_DISABLED_NETWORK_PROTOCOLS}} -ServerMaxPlayerCount={{MAX_PLAYERS}} -GameDifficulty={{GAME_DIFFICULTY}} -ControlPanelEnabled=false -TelnetEnabled=true -TelnetPort={{TELNET_PORT}} -TelnetPassword={{PASSWORD}} -logfile logs/latest.log'

VOLUME /home/container

USER root

COPY entrypoint.sh /entrypoint.sh
COPY healthcheck.sh /healthcheck.sh

RUN chmod +x /entrypoint.sh /healthcheck.sh

USER container

ENTRYPOINT ["/entrypoint.sh"]

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD /healthcheck.sh
