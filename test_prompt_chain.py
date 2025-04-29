import openai
client = openai.OpenAI(
    api_key="sk-password",
    base_url="http://0.0.0.0:4000"
)

class CustomLLMWrapper:
    def __init__(self, client, model, prompt=None):
        self.client = client
        self.model = model
        self.prompt = prompt

    def generate(self, query):
        response = self.client.chat.completions.create(
            model=self.model,
            messages=[{"role": "user", "content": query}]
        )
        return response['choices'][0]['message']['content']

    def invoke(self, input_data):
        # Use the prompt if provided, otherwise just use the text
        query = self.prompt.format(**input_data) if self.prompt else input_data["text"]
        result_text = self.generate(query)
        return {"text": result_text}

llm = "ollama/phi3"
question = """
        Extract the average yearly temperatures for South America from the following document text.
        If none are found, reply 'No temperatures found.'
        
        Text:
        {text}
        """
text = " Avg temps in Patagonia in 2023 were around 22 degrees celcius and 2022 from 11 to 16 degrees"
chain = CustomLLMWrapper(client=client, model=llm, prompt=question)
chain.invoke({"text": text})["text"]

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


