# odoo-addons
AGPL3 odoo 16 addons

# Addons
## Base accounting
- addons/base_accounting_kit-16.0.2.0.9.tar.bz2 LGPLv3 https://apps.odoo.com/apps/modules/16.0/base_accounting_kit/
- addons/om_account_accountant-16.0.1.0.0.tar.bz2 LGPLv3 https://apps.odoo.com/apps/modules/16.0/om_account_accountant/
- addons/ohrms_core-16.0.1.0.0 AGPLv3 https://www.openhrms.com/
- addons/accounting_pdf_reports-16.0.2.0.4.tar.bz2 LGPLv3 https://apps.odoo.com/apps/modules/16.0/accounting_pdf_reports/

# Installation
```sh
helm install odoo oci://registry-1.docker.io/bitnamicharts/odoo --values - << EOF
persistence:
  size: 1Gi
command:
  - /bin/sh
  - "-c"
  - "ln -svf /addons/* /opt/bitnami/odoo/lib/odoo-16.0.post20230915-py3.10.egg/odoo/addons/ && /opt/bitnami/scripts/odoo/entrypoint.sh /opt/bitnami/scripts/odoo/run.sh"
ingress:
  annotations:
    cert-manager.io/cluster-issuer: ``ca-issuer
  enabled: true
  ingressClassName: nginx
  hostname: odoo.example.org
  tls: true
extraVolumes:
  - name: sidecar-shared-data
    emptyDir: {}
extraVolumeMounts:
  - name: sidecar-shared-data
    mountPath: /addons
initContainers:
  - name: sidecar-addons
    image: herokukms/odoo-addons:latest
    imagePullPolicy: Always
    volumeMounts:
      - name: sidecar-shared-data
        mountPath: /addons
    command: ["/bin/sh"]
    args: ["-c", "mv /sidecar-addons/* /addons/ && exit 0"]
EOF
```
