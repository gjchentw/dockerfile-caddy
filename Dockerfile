FROM gjchen/alpine:edge

ENV	GOPATH="/tmp/go"

RUN	echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
	apk --no-cache --no-progress upgrade -f && \
	apk --no-cache --no-progress add git && \
	#ca-certificates git bash sqlite && \
	apk --no-cache --no-progress add --virtual build-deps sqlite-dev make go g++ musl-dev && \
	mkdir -p /tmp/go && ln -s /usr/local/bin /tmp/go/bin && \
	# wget run.go.plugins
	go get -d github.com/mholt/caddy/caddy && \
	# sed -i "/This is where other plugins get plugged in (imported)/r ${GOPATH}/run.go.plugins" ${GOPATH}/src/github.com/mholt/caddy/caddy/caddymain/run.go && \
	go get github.com/caddyserver/builds && \
	cd ${GOPATH}/src/github.com/mholt/caddy/caddy && \
	go run build.go && \
	install -c caddy /usr/local/bin/
#	rm -rf /tmp/go && \
#	apk --no-progress del build-deps
	

