#!/bin/bash

nohup /opt/llm_gateway/start-llm-gateway.sh --config /opt/llm_gateway/configs/model-config-ollama.yaml >> /opt/llm_gateway/llm_gateway.log 2>&1 &
