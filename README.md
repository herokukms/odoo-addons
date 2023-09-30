# odoo-addons
AGPL3 odoo 16 addons

# Addons
## Base accounting
- addons/OCA-16.0.0.0.tar.bz2 AGPLv3 https://odoo-community.org/
- addons/mail_debrand-16.0.230212.212209.tar.bz2 AGPLv3 https://odoo-community.org/
- addons/base_location-16.0.1.0.1.tar.bz2 AGPLv3 https://odoo-community.org/
- addons/currency_rate_update-16.0.1.1.2.tar.bz2 AGPLv3 https://odoo-community.org/
- all odoomates

# Installation
```sh
helm install odoo oci://registry-1.docker.io/bitnamicharts/odoo --values - << EOF
persistence:
  size: 1Gi
command:
  - /bin/sh
  - "-c"
  - "/addons/deploy-addons.sh"
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

