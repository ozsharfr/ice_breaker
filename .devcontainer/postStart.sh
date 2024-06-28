#!/bin/bash

/opt/llm_gateway/start-llm-gateway.sh --config /workspaces/engacc-llm-gateway/configs/model-config-ollama.yaml >> /opt/llm_gateway/llm_gateway.log 2>&1
