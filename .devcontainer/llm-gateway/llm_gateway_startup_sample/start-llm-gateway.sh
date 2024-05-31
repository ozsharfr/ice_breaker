#!/bin/bash

# shellcheck source=/dev/null
set -ea && source /opt/llm_gateway/.env

while [[ $# -gt 0 ]]; do
    case "$1" in
        --config)
            config_file="$2"
            shift 2
            ;;
        --help)
            echo "Usage: $0 --config <path_to_config_file>"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use $0 --help for usage"
            exit 1
            ;;
    esac
done

if [[ -z "$config_file" ]]; then
    echo "Sets the env variables defined in .env file and starts the LiteLLM proxy server with the given configuration file."
    echo "Options:"
    echo "         --config <path_to_config_file>"
    exit 1
fi

# Wait for postgres to become available
while ! nc -z localhost 5432; do
    sleep 1
done

nohup litellm --config "$config_file" >> llm_gateway.log 2>&1 &
