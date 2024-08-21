ARG DEEP_IMAGE_REGISTRY_URL=""
ARG DEEP_REGISTRY_TOOLS_PROJECT=""
FROM ${DEEP_IMAGE_REGISTRY_URL}/${DEEP_REGISTRY_TOOLS_NAMESPACE}/ubi:9.3-minimal

USER 0

ENV CLAMAV_CONF_DIR=/usr/local/etc

COPY clamav.rpm clamav.rpm
COPY config/*clam* /usr/local/etc/

RUN microdnf install -y unzip \
 && groupadd clamav \
 && useradd -g clamav -s /bin/false -c "Clam Antivirus" clamav \
 && rpm -ivh clamav.rpm \
 && rm -f clamav.rpm \
 && mkdir -p /usr/local/share/clamav /clamav/run \
 && touch /var/log/freshclam.log \
 && chown -R clamav:clamav /clamav /usr/local/share/clamav /var/log/freshclam.log \
 && chmod 755 -R /clamav /usr/local/share/clamav /var/log/freshclam.log \
 && rm -f *.rpm *.sh

COPY tmp/freshclam /usr/local/share/

USER clamav
WORKDIR /home/clamav
ENTRYPOINT ["bash", "-c", "clamscan"]
