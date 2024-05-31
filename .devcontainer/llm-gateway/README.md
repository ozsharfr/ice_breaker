
# LLM Gateway

A feature to add llm-gateway components to codespaces.

## Example Usage

```json
{
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "features": {
  "ghcr.io/deloitte-us-engineering/engacc-devcontainer-features/llm-gateway:latest": {
            "enablePresidio" : false,
            "enableRedis" : true,
            "enableLangfuse" : true,
            "startWithDefaults": false
        }
    }
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| enablePresidio | Adds Microsoft's Presidio Anonymizer and Analyzer to the codespace | boolean | false |
| enableRedis | Adds Redis-stack to the codespace to enable caching with litellm| boolean | true |
| enableLangfuse | Adds Langfuse to the codespace to enable llm tracing| boolean | true |
| startWithDefaults | Sets default configurations (credentials, prjects, virtual keys etc) for Langfuse and LiteLLM | boolean | false |

## Usage

The LLM Gateway acts as a facade for the LLM and Embedding model calls. It exposes an OpenAI-compatible API endpoint which can be called from the user's backend code. The gateway acts as the interface for abstracting caching and monitoring features.

### LiteLLM
LiteLLM is an open-source locally run/dockerised proxy server that provides an OpenAI-compatible API. It interfaces with numerous providers that do the inference. We use the LiteLLM as the backend for the LLM Gateway. Read more about LiteLLM [here](https://litellm.vercel.app/docs/).

The required environment variables can be set in the *.env* file present in the */opt/llm_gateway* directory.

```bash
DATABASE_URL="postgresql://postgres:postgres@localhost:5432/litellm" # Default database URL
LANGFUSE_PUBLIC_KEY=""                                               # Langfuse public key generated from the Langfuse dashboard
LANGFUSE_SECRET_KEY=""                                               # Langfuse secret key generated from the Langfuse dashboard                                      
LANGFUSE_HOST="http://localhost:3000"                                # Default Langfuse host
REDIS_HOST="localhost"                                               # Default Redis host
REDIS_PASSWORD=""                                                    # Default Redis password, left empty for codespace
REDIS_PORT="6379"                                                    # Default Redis port
OPENAI_API_KEY=""                                                    # OpenAI API key, required for OpenAI models
PRESIDIO_ANALYZER_API_BASE="http://localhost:5001"                   # Default Presidio Analyzer API base URL
PRESIDIO_ANONYMIZER_API_BASE="http://localhost:5002"                 # Default Presidio Anonymizer API base URL
LITELLM_MASTER_KEY="sk-password"                                     # LiteLLM admin password for accessing UI at localhost:4000/ui
```

The LLM Gateway can be started by changing to the */opt/llm_gateway* running the following command:
```bash
./start_llm_gateway.sh --config <path_to_config_file>
```
The starter set of configuration files can be found in the *configs* directory in */opt/llm_gateway* . Sample configurations for AWS Bedrock, OpenAI and locally hosted OpenAI compatible models are provided (Note that multiple models from different providers can be configured in the same config file).

One of the sample configs may be used by running, for eg:
```bash
./start_llm_gateway.sh --config configs/model-config-bedrock.yaml
```

Refer to the [LiteLLM documentation](https://litellm.vercel.app/docs/proxy/configs) for more information on how to set up a config file.

#### Start with Defaults
If the *startWithDefaults* option is set to true, the LLM Gateway will be set to start with default configurations for Langfuse and LiteLLM. The default configurations include setting up a sample user and project in langfuse with credentials {email: admin@dep.com , password: password} and API keys set in sample *.env* file at */opt/llm_gateway*. This will also set up LiteLLM with a default master and virtual key {master_key: sk-password, virtual_key: sk-TE5BPNfSh4IOCNpW3I5EDQ}. The master key is set from the *.env* file.

Once LiteLLM is started with startup scripts at */opt/llm_gateway* , the configured models may be accessed by passing the model name to openai client as shown below:

```python
import openai
client = openai.OpenAI(
    api_key="sk-password", # or virtual key
    base_url="http://0.0.0.0:4000"
)

response = client.chat.completions.create(model="model-name", messages = [
    {
        "role": "user",
        "content": "this is a test request"
    }
])

print(response)
```

#### Creating Virtual Keys
Virtual keys can be created by logging in to the LiteLLM UI. The default master key is set from the *.env* file and can be used to login to LiteLLM dashboard. once logged in, virtual keys can be created by clicking on the * Create New Key* button in the *API Keys* section of the dashboard.

#### Models

Models to be proxied by LiteLLM can be set in model_list section of model-config. sample config:
```yaml
model_list:
  - model_name: gpt-3.5-turbo
    litellm_params:
      model: openai/gpt-3.5-turbo
      api_key: os.environ/OPENAI_API_KEY
  - model_name: meta.llama2-13b-chat-v1 
    litellm_params: 
      model: bedrock/meta.llama2-13b-chat-v1 
      aws_region_name: us-east-1
```
*Note*: 
- OPENAI_API_KEY needs to be set as an environment variable to use OpenAI models with above configuration. Can be set manually or part of .env file at */opt/llm_gateway* directory. 
- Sign in to AWS to enable models from bedrock as LiteLLM uses AWS profile credentials to access the models.

Once LiteLLM is started, the models can be accessed by passing the model name and setting the api base to LiteLLM host address in the choice of implementation. This can be the openai client, langchain openai client or completions client from LiteLLM.

#### Caching
LiteLLM has a built-in caching mechanism that caches the responses from the providers. LiteLLM supports local, redis, redis-semantic and S3 caching. Apart from the local in memory caching that comes with LiteLLM, We are providing a Redis caching mechanism for the LLM Gateway, which can either be configured with a semantic cache or a normal cache. Read more about the caching mechanism [here](https://docs.litellm.ai/docs/proxy/caching).

Set the cache params section of model-config file to choose a caching mechanism. Sample settings for redis-semantic cache is given below.
```yaml
litellm_settings:
  cache: True          # set cache responses to True, litellm defaults to using a redis cache
  cache_params:
    type: "redis-semantic"
    redis_semantic_cache_use_async: True
    similarity_threshold: 0.9   # similarity threshold for semantic cache
    redis_semantic_cache_embedding_model: text-embedding-3-small # set this to a model_name set in model_list
```

#### Observability
The LLM Gateway provides integrations with a wide range of observability tools. Complete list of supported tools can be found in the Logging & Observability section [here](https://litellm.vercel.app/docs).

The llm-gateway feature comes with an optional installation of Langfuse, once enabled, llm tracing through the proxy can be enabled by setting the success_callback settings in model-config. sample config:
```yaml
litellm_settings:
  success_callback: ["langfuse"]
```
Note: LANGFUSE_PUBLIC_KEY and LANGFUSE_SECRET_KEY env variables need to be set before Langfuse tracing can be enabled in the model-config file. If enabled in the feature options:
- Access the Langfuse dashboard from the PORTS section of codespace terminal (Labelled Langfue(3000)). 
- Sign up with a username, email(any) and password (only stored in local) 
- Create a project in Langfuse dashboard
- Create API keys by clicking the *Create new API keys* button under *API Keys* section in project settings
- Copy the Public Key and Secret Key from the dashboard and set them in the .env file at */opt/llm_gateway/.env*

#### PII masking
LiteLLM supports Microsoft Presidio for PII masking. More information can be found [here](https://litellm.vercel.app/docs/proxy/pii_masking).

When Presidio is enabled, enable integration with Presidio by setting the *callbacks* section in model-config. Sample config :
```yaml
litellm_settings:
  callbacks : ["presidio"]
```
