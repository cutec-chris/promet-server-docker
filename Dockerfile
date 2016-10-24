FROM hurricane/dockergui:x11rdp1.3
MAINTAINER Christian U. <dockerus@chris.ullihome.de>
# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=99
ENV GROUP_ID=100
# Gui App Name default is "GUI_APPLICATION"
ENV APP_NAME="Promet-ERP"
# Default resolution, change if you like
ENV WIDTH=1280
ENV HEIGHT=720
RUN \
echo "deb http://archive.ubuntu.com/ubuntu trusty main universe restricted" > /etc/apt/sources.list && \
echo "deb http://archive.ubuntu.com/ubuntu trusty-updates main universe restricted" >> /etc/apt/sources.list && \
mkdir -p /etc/my_init.d && \

# Install packages needed for app
export DEBCONF_NONINTERACTIVE_SEEN=true DEBIAN_FRONTEND=noninteractive && \
apt-get update && \
echo "nobody ALL=(ALL)	NOPASSWD: ALL" >> /etc/sudoers

# Installing packages
RUN apt-get install wget sqlite3 lxappearance -y
RUN apt-get install libfreetype6 libdbus-1-3 bsdiff libgtk2.0-0 libsane -y
RUN wget http://downloads.free-erp.de/promet-erp_P7.0.433_amd64-gtk2.deb && dpkg -i promet-erp_P7.0.433_amd64-gtk2.deb && rm promet-erp_P7.0.433_amd64-gtk2.deb
RUN apt-get clean && apt-get autoremove -y

RUN usermod -a -G adm,sudo,fuse nobody
RUN chown -R nobody:users /nobody/
RUN chown -R nobody:users /srv/

# Copy X app start script to right location
COPY startapp.sh /startapp.sh
COPY firstrun.sh /etc/my_init.d/firstrun.sh
RUN chmod +x /etc/my_init.d/firstrun.sh
# Fix gtk settings to show an correct theme
RUN mkdir -p /nobody/.config/gtk-3.0/
RUN chown nobody:users /nobody/.config/gtk-3.0
COPY gtk3settings.ini /nobody/.config/gtk-3.0/settings.ini
RUN chown nobody:users /nobody/.config/gtk-3.0/settings.ini
COPY gtk3settings.ini /nobody/.gtkrc-2.0
RUN chown nobody:users /nobody/.gtkrc-2.0
COPY openboxrc.xml /nobody/.config/openbox/rc.xml
RUN chown nobody:users /nobody/.config/openbox/rc.xml
EXPOSE 3389 8080