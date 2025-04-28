import openai
client = openai.OpenAI(
    api_key="sk-password",
    base_url="http://0.0.0.0:4000"
)

from langchain_core.prompts import ChatPromptTemplate

# Define the template and create the prompt
template = """Question: {question}
Answer: Let's think step by step."""
prompt = ChatPromptTemplate.from_template(template)

# Generate the prompt content
question = "What is LangChain?"
generated_prompt = prompt.format(question=question)

# Use the client to create a completion
response = client.chat.completions.create(
    model="ollama/phi3",
    messages=[
        {
            "role": "user",
            "content": generated_prompt
        }
    ]
)

# Extract and print the response
print(response.choices[0].message.content)


from langchain_core.prompts import ChatPromptTemplate
from langchain_ollama.llms import OllamaLLM

template = """Question: {question}

Answer: Let's think step by step."""

prompt = ChatPromptTemplate.from_template(template)

model = OllamaLLM(model="ollama/phi3")

chain = prompt | model

chain.invoke({"question": "What is LangChain?"})




query = "Write a short story in less than 30 words" # Change this to your query/prompt

response = client.chat.completions.create(model="ollama/phi3", messages = [
    {
        "role": "user",
        "content": query
    }
])

print(response.choices[0].message.content)