# LLM Gateway - DEP AI

## Introduction

Every developer and team that builds a GenAI solution or product needs to implement a set of common NFRs in order to track performance, reduce costs, and be well-rounded for enterprise deployments. Built on top of Open Source technologies, DEP AI's LLM Gateway approach aims to simplify the implementation for asset teams by providing easily integratable components that take care of the following functionality:

- **Routing** - We provide the ability to configure and route your requests to any LLM required with a simple API (conforms to OpenAI API) using LiteLLM. LLM Gateway supports multiple LLM providers including OpenAI, Azure OpenAI, AWS Bedrock, Google Cloud Gemini, and even hosting your own LLMs.
- **Virtual Keys** - Create virtual keys with fine-grained access controls to decide which users/system components have access to which LLMs without exposing the underlying secrets.
- **Caching** - Integrate a caching layer to reduce the number of calls to the LLMs and improve the performance of your application while reducing costs. We support both Simple and Semantic caching with Redis.
- **Tracing** - Track and trace all your LLM calls, monitor requests and responses, and track cost and latencies of your LLM usage using Langfuse.

![LLM Gateway Overview](docs/images/high-level-overview.png "LLM Gateway Overview")

## Getting Started


### Open LLM Gateway in GitHub Codespaces

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=830960718&skip_quickstart=true&machine=standardLinux32gb)

`Recommended Configuration : 4-core , 16 GB RAM`

This dev container experience is the easiest way to experience LLM Gateway. This container includes all the necessary components to run LLM Gateway and is pre-configured with a sample LLM provider.

The devcontainer features used in this repo are listed below with a link to the respective feature documentation:

- [ollama](https://github.com/Deloitte-US-Consulting/engacc-devcontainer-features/blob/main/src/ollama/README.md)
- [llm-gateway](https://github.com/Deloitte-US-Consulting/engacc-devcontainer-features/blob/main/src/llm-gateway/README.md)

## Components:

Listed below are some of the LLM Gateway components that are configured in this dev container and the credentials to access them for this demonstration.

| S.No. | Component | Port | Notes |
|----------:|:----------|:----------|:----------|
| 1   | LiteLLM   | 4000 | Used as the core routing agent to configure LLM deployments. <ul><li>UI is available at **https://<CODESPACE_NAME>-4000.app.github.dev/ui**  </li><li>Credentials: admin, sk-password</li></ul> |
| 2    | Redis   | 6379 | Used as the caching layer for LLM calls.  |
| 3    | Postgres   | 5432 | Database layer to store LiteLLM and Langfuse metadata  |
| 4    | Langfuse   | 3001 | Tracing component used to keep track of LLM calls, latencies, and costs<ul><li>UI is available at **https://<CODESPACE_NAME>-3001.app.github.dev**</li><li>Credentials: admin@dep.com, password</li></ul>   |
| 5    | Ollama   | 11434 | Model serving library used to serve open-source models such as `phi3` and `nomic-embed-text` for this experience.    |

## Basic Usage:

This repo has been configured to start with the LLM Gateway components listed above (Except presidio service. See section on enabling presidio), along with some open-source models using Ollama, upon opening in a codespace. Credentials for services such as LiteLLM and Langfuse are pre-set and can be accessed through the URLs listed in the components table above, or by using the PORTS tab (click on the globe icon near the forwarded address column on the corresponding port number to open in the browser).

![Codespace UI](docs/images/codespace-ui.png)

#### LiteLLM Dashboard

You can access the LiteLLM dashboard by navigating to the URL `https://<CODESPACE_NAME>-4000.app.github.dev/ui` in your browser. The admin username is `admin` and the password is `sk-password` (which is the master password for litellm and is set with `LITELLM_MASTER_KEY` variable in `/opt/llm_gateway/.env`). 

![LiteLLM Dashboard](docs/images/litellm-dashboard.png)

The LiteLLM dashboard allows you to configure models, virtual keys, and teams. One virtual key is pre-configured with this codespace. See the code in demo notebook under the 'Virtual Keys' section.

For more information on how to use virtual keys, refer to the [LiteLLM documentation](https://docs.litellm.ai/docs/proxy/virtual_keys). 

#### Langfuse Dashboard

This codespace is pre-configured with Langfuse, a tracing component that allows you to track and trace all your LLM calls, monitor requests and responses, and track cost and latencies of your LLM usage. You can access the Langfuse dashboard by navigating to the URL `https://<CODESPACE_NAME>-3001.app.github.dev` in your browser.  

![Langfuse Dashboard](docs/images/langfuse-dashboard.png)

A langfuse project is pre-configured with this codespace and the login credentials to the project are 'admin@dep.com' and 'password'. LLM Gateway requires API keys (public key and secret key) to be set as environment variables. The API keys for the preconfigured project are set in the `.env` file at `/opt/llm_gateway/.env`.

`Note: Langfuse is pre-configured with a project and API keys. You can create a new project and set the API keys in the .env file to use Langfuse with your own project.`

### Customize models

The first step is to configure all the LLMs that you would like to route through the LLM Gateway. This can be done with a `model-config.yaml` file as shown below. 

This config file configures models from OpenAI, Bedrock, and Ollama to be routed through the LLM Gateway. It also configures caching with Redis and tracing with Langfuse.

### Sample configuration for LiteLLM

```yaml filename="model-config.yaml"
model_list:
  - model_name: gpt-3.5-turbo
    litellm_params:
      model: openai/gpt-3.5-turbo
      api_key: os.environ/OPENAI_API_KEY
  - model_name: bedrock-llama2-13b 
    litellm_params: 
      model: bedrock/meta.llama2-13b-chat-v1 
      aws_region_name: us-east-1
  - model_name: gemini-pro
    litellm_params:
      model: vertex_ai/gemini-1.5-pro
      vertex_project: <GCP Project Name>
      vertex_location: "us-east1"
  - model_name: phi3 
    litellm_params:
      model: ollama/phi3 
      api_base: http://0.0.0.0:11434
      api_key: "dummy"
  - model_name: nomic-embed-text
    litellm_params:
      model: ollama/nomic-embed-text
      api_base: http://0.0.0.0:11434
      api_key: "dummy"
litellm_settings:
  success_callback: ["langfuse"] # Optional callback when Langfuse is enabled in feature, and required env variables are set in the environment
  failure_callback: ["langfuse"]
  langfuse_default_tags: ["cache_hit"]
  drop_params: True
  telemetry: False
  set_verbose: True
  cache: True          # set cache responses to True, litellm defaults to using a redis cache
  cache_params:
    type: "redis"
    ttl: 60            # Sets cache expiry to 1 minute
```

Sample config files to add LLMs from various providers can be found in the `configs/sample-provider-configs` folder of this repo. You can set the appropriate environment variables in the `.env` file at `/opt/llm_gateway/.env` (such as OpenAI API keys) and use the `start-llm-gateway.sh` script to start the LLM Gateway.

```bash
/opt/llm_gateway/start-llm-gateway.sh --config <PATH-TO-MODEL-CONFIG>
```

#### OpenAI

A sample model list for OpenAI is available at `configs/sample-provider-configs/model-config-openai.yaml`.

```yaml
model_list:
  - model_name: gpt-3.5-turbo             # Model alias to be used when calling the LLM Gateway
    litellm_params:
      model: openai/gpt-3.5-turbo         # Model name from the provider
      api_key: os.environ/OPENAI_API_KEY
  - model_name: gpt-4
    litellm_params:
      model: openai/gpt-4
      api_key: os.environ/OPENAI_API_KEY
```

Create a model-config file and add or change the required model names, aliases and additional litellm parameters from the model-config sample given above. Set the OpenAI API key in the `/opt/llm_gateway/.env` file

```bash
code /opt/llm_gateway/.env
```
Add the following line to the `.env` file

```bash
OPENAI_API_KEY=<YOUR_OPENAI_API_KEY>
```

and start the LLM Gateway with the following command

```bash
/opt/llm_gateway/start-llm-gateway.sh --config <PATH-TO-MODEL-CONFIG>
```

#### AWS Bedrock

AWS authentication is required to access the Bedrock models. You can use the `okta-cli` to authenticate with AWS and get temporary credentials. After authenticating with okta-cli, LLM Gateway may be started with a model config file.

A sample config for Bedrock is available at `configs/sample-provider-configs/model-config-bedrock.yaml`.

```yaml
model_list:
  - model_name: meta.llama2-13b-chat-v1       # Model alias to be used when calling the LLM Gateway
    litellm_params: # all params accepted by litellm.completion() - https://docs.litellm.ai/docs/completion/input
      model: bedrock/meta.llama2-13b-chat-v1  # Model name from the provider
      aws_region_name: us-east-1
  - model_name: amazon.titan-embed-text-v1
    litellm_params:
      model: bedrock/amazon.titan-embed-text-v1
```

Add or change the required model names, aliases and litellm configurations and start the LLM Gateway with the following command

```bash
/opt/llm_gateway/start-llm-gateway.sh --config <PATH-TO-MODEL-CONFIG>
```

Note: As the temporary credentials expire, you may need to re-authenticate with okta-cli to get new credentials and restart the LLM Gateway to apply the new credentials.

#### GCP Vertex AI

Setup environment:
install gcloud CLI in the codespace and run this to add vertex credentials to your env.

```bash
gcloud auth application-default login
```

Install Vertex AI API client library using below command. 

```bash
pip install google-cloud-aiplatform
```

A sample model list for Gemini is available at `configs/sample-provider-configs/model-config-gemini.yaml`.

```yaml
model_list:
  - model_name: gemini-pro                # Model alias to be used when calling the LLM Gateway   
    litellm_params:
      model: vertex_ai/gemini-1.5-pro     # Model name from the provider
      vertex_project: <GCP Project Name>
      vertex_location: "us-east1"
```
Add or change the required model names, aliases and litellm configurations and start the LLM Gateway with the following command

```bash
/opt/llm_gateway/start-llm-gateway.sh --config <PATH-TO-MODEL-CONFIG>
```

### Caching

A simple cache is configured in the default model config file that comes with this codespace. Semantic caching can be enabled by setting the `cache_params` in the model config file if supported embedding models are available. The version of Litellm that is configured currently only supports embedding models that can generate embedding vectors of size 1536. The following is a sample configuration for semantic caching using the `text-embedding-3-small` model from OpenAI.

```yaml

model_list:
  - model_name: gpt-3.5-turbo
    litellm_params:
      model: openai/gpt-3.5-turbo
      api_key: os.environ/OPENAI_API_KEY
  - model_name: text-embedding-3-small
    litellm_params:
      model: text-embedding-3-small
      api_key: os.environ/OPENAI_API_KEY
litellm_settings:
  cache: True
  cache_params:
    type: "redis-semantic"
    redis_semantic_cache_use_async: True
    similarity_threshold: 0.9                                    # similarity threshold for semantic cache
    redis_semantic_cache_embedding_model: text-embedding-3-small # set this to a model_name set in model_list
    ttl: 60                                                      # Sets cache expiry to 1 minute
```

### Troubleshooting

Try the following steps if you encounter any issues while with LLM Gateway services in this codespace:

- Check the logs at `/opt/llm_gateway/logs/llm-gateway.log`
- Ensure the model config file is correctly configured, refer to the sample config files in `configs/sample-provider-configs` folder.
- Rebuild the codespace if any of the LLM Gateway components have not started properly.
- If the LiteLLM service is not running after the codespace starts or the service is unavailable in the PORTS tab, start the LLM Gateway with default configs by running the `postStart.sh` script manually by running `.devcontainer/postStart.sh` in the terminal

### References

This codespace LLM Gateway is built on top of the following open-source technologies:
- [LiteLLM](https://docs.litellm.ai/docs/)
- [Langfuse](https://langfuse.com/docs)
- [Ollama](https://ollama.com/)
- [Redis-Stack](https://redis.io/blog/introducing-redis-stack/)
- [Langchain](https://python.langchain.com/v0.2/docs/introduction/)

