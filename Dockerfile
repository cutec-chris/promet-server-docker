FROM debian:latest
MAINTAINER Christian U. <info@cu-tec.de>
# Installing packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get install wget sqlite3 bsdiff libsane mysql-client postgresql-client unzip -y
RUN wget http://downloads.free-erp.de/promet-erp-services_7.0.437_amd64-gtk2.deb --level=22196 && dpkg -i promet-erp-services_7.0.437_amd64-gtk2.deb && rm promet-erp-services_7.0.437_amd64-gtk2.deb
RUN wget http://downloads.free-erp.de/tools_x86_64-linux-7.0.437.zip --level=22196 && unzip -o tools_x86_64-linux-7.0.437.zip -d /usr/lib/promet-erp
RUN apt-get clean && apt-get autoremove -y
EXPOSE 8085
VOLUME ["/usr/lib/promet-erp/web"]
ENTRYPOINT ["/usr/lib/promet-erp/pappserver"]
