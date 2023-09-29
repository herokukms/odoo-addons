FROM ubuntu:latest as builder
RUN apt update -y \
    && apt install -y curl tar bzip2 \
    && mkdir -p /bitnami/odoo/addons \
    && cd /bitnami/odoo/addons/ \
    && curl -J -L https://github.com/herokukms/odoo-addons/raw/main/addons/base_accounting_kit-16.0.2.0.9.tar.bz2 | tar -xvj

FROM alpine:latest
COPY --from=builder /bitnami/odoo/addons /tmp/sidecar-addons
CMD ["/bin/sh","-c","mv /tmp/sidecar-addons/* /bitnami/odoo/addons/"]