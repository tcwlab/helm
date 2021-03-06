#####
# STEP 1: build base image
#####
FROM alpine:3.16@sha256:7580ece7963bfa863801466c0a488f11c86f85d9988051a9f9c68cb27f6b7872 AS base
RUN apk add -U --no-cache bash coreutils git && \
    apk upgrade && \
    rm -rf /var/cache/apk/*

#####
# STEP 2: install dependencies
#####
FROM base AS dependencies
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apk add -U --no-cache curl && \
    curl -Ls 'https://get.helm.sh/helm-'"$(curl -s 'https://api.github.com/repos/helm/helm/releases' | grep 'tag_name' | cut -d '"' -f 4 | sort -V | grep -v 'rc.' | tail -n 1)"'-linux-amd64.tar.gz' -o helm.tgz && \
    tar xzf helm.tgz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +rx /usr/bin/helm

#####
# STEP 3: build production image
#####
FROM base AS release
COPY --from=dependencies /usr/bin /usr/bin
RUN addgroup -S helmusr && adduser -S helmusr -G helmusr
COPY /entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh && \
    mkdir /.kube && \
    ln -s /.kube /home/helmusr/.kube && \
    chown -R helmusr:helmusr /home/helmusr && \
    chown -R helmusr:helmusr /.kube
USER helmusr
VOLUME ["/.kube"]
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
