#!/bin/bash
VERSION=$(find /opt/bitnami/odoo/lib/ -name "*addons" | sed -ne 's/.*\/lib\/\(.*\)\.egg.*addons$/\1/p' | head -n1)
ln -svf /addons/* "/opt/bitnami/odoo/lib/$VERSION.egg/odoo/addons/"
/opt/bitnami/scripts/odoo/entrypoint.sh /opt/bitnami/scripts/odoo/run.sh