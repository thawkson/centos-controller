#!/bin/bash
### Quick and Dirty Script to get Installers
curl -c cookies.txt -d 'username={{ appd_support_user }}&password={{ appd_support_pass }}' https://login.appdynamics.com/sso/login/
sleep 5
# Now grab the page or pages we care about.
wget --load-cookies cookies.txt -p https://aperture.appdynamics.com/download/prox/download-file/controller/4.2.2.2/controller_64bit_linux-4.2.2.2.sh -O /tmp/controller_64bit_linux.sh
wget --load-cookies cookies.txt -p https://aperture.appdynamics.com/download/prox/download-file/euem-processor/4.2.2.2/euem-64bit-linux-4.2.2.2.sh -O /tmp/euem-64bit-linux.sh
wget --load-cookies cookies.txt -p https://aperture.appdynamics.com/download/prox/download-file/events-service/4.2.2.2/events-service-4.2.2.2.zip -O /tmp/events-service.zip
