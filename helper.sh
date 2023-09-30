#!/bin/bash
cd "$PROJECT_ROOT" \
    && export BAZE="$1" \
    && mkdir -p tmp \
    && cd tmp \
    && unzip "$HOME/Downloads/${BAZE}.zip" \
    && tar -cjf "$PROJECT_ROOT/addons/$BAZE.tar.bz2" . \
    && cd $PROJECT_ROOT \
    && rm -rf tmp \
    && echo "- addons/$BAZE.tar.bz2 AGPLv3 https://" >> README.md \
    && echo " && curl -J -L 'https://github.com/herokukms/odoo-addons/raw/main/addons/$BAZE.tar.bz2' | tar -xvj" >> Dockerfile

echo "CORRECT README AND Dockerfile !!"