#!/bin/bash

nohup /opt/llm_gateway/start-llm-gateway.sh --config /opt/llm_gateway/configs/model-config-ollama.yaml >> llm_gateway.log 2>&1 &

nohup ollama pull nomic-embed-text >> /opt/llm_gateway/ollama.log 2>&1 &