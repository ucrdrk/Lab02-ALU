FROM ubuntu:latest

RUN apt update && DEBIAN_FRONTEND=noninteractive TZ=US/LosAngeles apt install -y verilog git gtkwave openjdk-21-jre

ENV VNC_RESOLUTION="1920x1200x16" \
    VNC_DPI="96"

COPY menu /root/.fluxbox/menu