#!/bin/bash
 curl -c cookies.txt -d 'username={{ appd_support_user }}&password={{ appd_support_pass }}' https://login.appdynamics.com/sso/login/
 sleep 5
 wget https://docs.appdynamics.com/download/attachments/33428071/HA.shar -o /tmp/HA.shar
 # Now grab the page or pages we care about.
 wget --load-cookies cookies.txt -p https://aperture.appdynamics.com/download/prox/download-file/controller/4.2.2.2/controller_64bit_linux-4.2.2.2.sh -O /tmp/controller_64bit_linux.sh
 wget --load-cookies cookies.txt -p https://aperture.appdynamics.com/download/prox/download-file/euem-processor/4.2.2.2/euem-64bit-linux-4.2.2.2.sh -O /tmp/euem-64bit-linux.sh
 #Set hostname in varfiles
 sed -e "s/SERVERHOSTNAME/`echo $HOSTNAME`/g" /tmp/controller.varfile > /tmp/controller.varfile.1
 sed -e "s/SERVERHOSTNAME/`echo $HOSTNAME`/g" /tmp/eum.varfile > /tmp/eum.varfile.1
 # Create controller install directory
 export APPD_INSTALL_DIR=/opt/appdynamics
 mkdir -p $APPD_INSTALL_DIR/Controller
 mkdir -p $APPD_INSTALL_DIR/HA
 # Install License
 cp /tmp/license.lic $APPD_INSTALL_DIR/Controller
 #Install Controller
 chmod 744 /tmp/controller_64bit_linux.sh
 /tmp/controller_64bit_linux.sh -q -varfile /tmp/controller.varfile.1
 #Configure Events Service (hosts are space delimited)
 Events_Service_Nodes="IP"
 /tmp/Configure-Clustered-EventsService.sh $Events_Service_Nodes
 #Install End User Monitoring
 mkdir -p $APPD_INSTALL_DIR/EUEM
 chmod 744 /tmp/euem-64bit-linux.sh
 /tmp/euem-64bit-linux.sh -q -varfile /tmp/eum.varfile.1
 chown -R appdynamics:appdynamics /opt/appdynamics
