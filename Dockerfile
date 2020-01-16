FROM google/cloud-sdk:276.0.0
COPY ./dlp-check.sh .

RUN chmod +x dlp-check.sh
RUN /bin/bash ./dlp-check.sh

