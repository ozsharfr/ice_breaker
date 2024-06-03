#!/bin/bash

nohup /opt/llm_gateway/start-llm-gateway.sh --config /opt/llm_gateway/configs/model-config-ollama.yaml

nohup ollama pull nomic-embed-text >> /opt/llm_gateway/ollama.log