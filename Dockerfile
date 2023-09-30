FROM alpine:latest as builder
# only one accounting kit 
#     
RUN apk update \
    && apk add curl \
    && mkdir -p /bitnami/odoo/addons \
    && cd /bitnami/odoo/addons/ \
    && curl -J -L https://github.com/herokukms/odoo-addons/raw/main/addons/ohrms_core-16.0.1.0.0.tar.bz2 | tar -xvj \
    && curl -J -L https://github.com/herokukms/odoo-addons/raw/main/addons/base_accounting_kit-16.0.2.0.9.tar.bz2 | tar -xvj \
    && curl -J -L https://github.com/herokukms/odoo-addons/raw/main/addons/om_account_accountant-16.0.1.0.0.tar.bz2 | tar -xvj \
    && curl -J -L https://github.com/herokukms/odoo-addons/raw/main/addons/accounting_pdf_reports-16.0.2.0.4.tar.bz2 | tar -xvj \
    && curl -J -L https://github.com/herokukms/odoo-addons/raw/main/addons/OCA-16.0.0.0.tar.bz2 | tar -xvj \
    && curl -J -L 'https://github.com/herokukms/odoo-addons/raw/main/addons/mail_debrand-16.0.230212.212209.tar.bz2' | tar -xvj \
    && curl -J -L 'https://github.com/herokukms/odoo-addons/raw/main/addons/base_location-16.0.1.0.1.tar.bz2' | tar -xvj \
    && curl -J -L 'https://github.com/herokukms/odoo-addons/raw/main/addons/currency_rate_update-16.0.1.1.2.tar.bz2' | tar -xvj \
    && curl -J -L 'https://github.com/herokukms/odoo-addons/raw/main/addons/om_account_bank_statement_import-16.0.2.0.0.tar.bz2' | tar -xvj

FROM alpine:latest
COPY --from=builder /bitnami/odoo/addons /sidecar-addons
COPY deploy-addons.sh /sidecar-addons/
RUN chmod ugo+x /sidecar-addons/deploy-addons.sh
CMD ["/bin/sh","-c","sleep infinity"] 
 
