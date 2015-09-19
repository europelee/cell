FROM ubuntu:14.04
MAINTAINER advanderveer@gmail.com

RUN apt-get update; apt-get install -y curl git-core; apt-get clean;

#installing Go
RUN curl -L https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz > /tmp/go.tar.gz; tar -C /usr/local -xzf /tmp/go.tar.gz; rm /tmp/go.tar.gz;
ENV GOPATH $HOME/gopath
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin
ENV GO15VENDOREXPERIMENT 1

#build cellstate
ADD . $GOPATH/src/github.com/cellstate/cell
WORKDIR $GOPATH/src/github.com/cellstate/cell
RUN go build -o $GOPATH/bin/cell main.go

#setup git repo storage
RUN mkdir -p /opt/git

EXPOSE 3838
ENTRYPOINT ["cell"]
CMD ["agent"]