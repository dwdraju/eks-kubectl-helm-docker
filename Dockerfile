FROM alpine:3.12

# Latest version of kubectl can be found at:
# https://github.com/kubernetes/kubernetes/releases
ENV KUBE_VERSION="v1.18.6"

# Latest version of helm can be found at
# https://github.com/helm/helm/releases
ENV HELM_VERSION="v3.3.0"

RUN apk add --update -t --no-cache ca-certificates bash git openssh curl python3 deps \
    && apk -U add findutils \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && chmod g+rwx /root \
    && mkdir /config \
    && chmod g+rwx /config    
RUN apk add py3-pip \
    && pip3 install awscli

WORKDIR /config
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
