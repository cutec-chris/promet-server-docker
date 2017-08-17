FROM debian:latest
MAINTAINER Christian U. <info@cu-tec.de>
# Installing packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get install wget sqlite3 bsdiff libsane mysql-client postgresql-client -y
RUN wget http://downloads.free-erp.de/promet-erp-services_7.0.437_amd64-gtk2.deb --level=13963 && dpkg -i promet-erp-services_7.0.437_amd64-gtk2.deb && rm promet-erp-services_7.0.437_amd64-gtk2.deb
RUN apt-get clean && apt-get autoremove -y
EXPOSE 8085
VOLUME ["/usr/lib/promet-erp/web"]
ENTRYPOINT ["/usr/lib/promet-erp/pappserver"]
