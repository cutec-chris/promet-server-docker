FROM hurricane/dockergui:x11rdp1.3
MAINTAINER Christian U. <dockerus@chris.ullihome.de>
# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=99
ENV GROUP_ID=100
# Gui App Name default is "GUI_APPLICATION"
ENV APP_NAME="Promet-ERP"