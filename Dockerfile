FROM alpine:latest

# Add env
ENV LANG C.UTF-8

# Platform from Buildx
ARG TARGETPLATFORM
RUN DOCKER_ARCH=$(case ${TARGETPLATFORM:-linux/amd64} in \
    "linux/amd64")   echo "x86-64"  ;; \
    "linux/arm/v7")  echo "arm"   ;; \
    "linux/arm64")   echo "aarch64" ;; \
    *)               echo ""        ;; esac) \
  && echo "DOCKER_ARCH=$DOCKER_ARCH" \
  && mkdir -p /opt/airconnect \
  && set -x; wget -q "https://raw.githubusercontent.com/philippe44/AirConnect/master/bin/aircast-${DOCKER_ARCH}" -qO "/opt/airconnect/aircast" \
  && ls -al /opt/airconnect

# Start DHCP server
CMD ["/opt/airconnect/aircast"]
