#!/bin/bash
echo "Installing llm-gateway feature"

set -euo pipefail

mkdir -p /opt/llm_gateway
cp -r llm_gateway_startup_sample/* /opt/llm_gateway
cp llm_gateway_startup_sample/.env /opt/llm_gateway
chown -R "$_REMOTE_USER" /opt/llm_gateway
chmod -R u+rw /opt/llm_gateway/*
chmod +x /opt/llm_gateway/start-llm-gateway.sh
chmod +x /opt/llm_gateway/stop-llm-gateway.sh

cp README.md /opt/llm_gateway

LLM_GATEWAY_PKG_DIR="$_REMOTE_USER_HOME/llm_gateway_packages"
mkdir -p "$LLM_GATEWAY_PKG_DIR"
cp requirements.txt "$LLM_GATEWAY_PKG_DIR/requirements.txt"
cp docker-compose.yaml "$LLM_GATEWAY_PKG_DIR/docker-compose.yaml"

ENABLEPRESIDIO=${ENABLEPRESIDIO:-"false"}
ENABLEREDIS=${ENABLEREDIS:-"true"}
ENABLELANGFUSE=${ENABLELANGFUSE:-"true"}
STARTWITHDEFAULTS=${STARTWITHDEFAULTS:-"false"}


DEPLOY_SCRIPT="docker-compose -f $LLM_GATEWAY_PKG_DIR/docker-compose.yaml up db"

if [ "$ENABLEPRESIDIO" = true ]; then
    DEPLOY_SCRIPT="$DEPLOY_SCRIPT presidio-analyzer presidio-anonymizer"
fi

if [ "$ENABLEREDIS" = true ]; then
    DEPLOY_SCRIPT="$DEPLOY_SCRIPT redis"
fi
if [ "$ENABLELANGFUSE" = true ]; then
    DEPLOY_SCRIPT="$DEPLOY_SCRIPT langfuse"
fi

cat << 'EOF' >> /usr/local/bin/deploy-gateway-components.sh
if [ -z "$CODESPACE_NAME" ]; then
    NEXTAUTH_URL="http://localhost:3000"
else
    NEXTAUTH_URL=https://${CODESPACE_NAME}-3000.app.github.dev/
fi
export NEXTAUTH_URL=$NEXTAUTH_URL
EOF

echo "$DEPLOY_SCRIPT -d" >> /usr/local/bin/deploy-gateway-components.sh

echo "pip install redisvl==0.0.7 --no-deps --user" >> /usr/local/bin/install-gateway-packages.sh
echo "pip install -r $LLM_GATEWAY_PKG_DIR/requirements.txt --user" >> /usr/local/bin/install-gateway-packages.sh

chmod +x /usr/local/bin/deploy-gateway-components.sh
chmod +x /usr/local/bin/install-gateway-packages.sh

if [ "$STARTWITHDEFAULTS" = true ]; then
    cp -r postgresql-init-script "$LLM_GATEWAY_PKG_DIR/"
else
    echo "STARTWITHDEFAULTS is not true. Skipping copying postgresql-init-script."
    mkdir -p "$LLM_GATEWAY_PKG_DIR/postgresql-init-script"
fi

apt update
apt install -y netcat

echo "Successfully installed llm-gateway components. Open the README.md at /opt/llm_gateway to get started!" >> /usr/local/etc/vscode-dev-containers/first-run-notice.txt
echo 'Successfully installed llm-gateway feature!'
