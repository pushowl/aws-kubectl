FROM alpine:3.10

# install AWS CLI to configure kubectl
RUN apk --update --no-cache add python py-pip
RUN pip install awscli

# install kubectl
ENV KUBE_LATEST_VERSION="v1.15.2"
RUN apk add --no-cache bash ca-certificates git \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

# Delete un-necessary packages
RUN apk del --purge py-pip git

# Copy run.sh to /code
WORKDIR /code
COPY run.sh .

ENTRYPOINT [ "sh", "run.sh" ]