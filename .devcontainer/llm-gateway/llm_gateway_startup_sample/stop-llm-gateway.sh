#!/bin/bash

set -euo pipefail

pid=$(pgrep "litellm")

# Check if the process is running
if [ -z "$pid" ]; then
    echo "LiteLLM is not running."
else
    echo "Killing LiteLLM"
    kill "$pid"
    echo "LiteLLM killed"
fi
