import openai

# Initialize the OpenAI client
client = openai.OpenAI(
    api_key="sk-password",
    base_url="http://0.0.0.0:4000"
)

def generate_text(prompt):
    """
    Generate text based on a given prompt using OpenAI's text generation tool.
    """
    response = client.completions.create(
        model="ollama/phi3",  # Use the correct model name
        prompt=prompt,
        max_tokens=300
    )
    return response.choices[0].text.strip()

def calculate(text):
    """
    Generating algebric operations in case the text suggests such need
    """
    response = client.completions.create(
        model="ollama/phi3",  # Use the correct model name
        prompt=f"Calculate by either multiplication, division, substraction or addition - or any combination of them:\n\n{text}\n\nResult:",
        max_tokens=150
    )
    return response.choices[0].text.strip()

def summarize_text(text):
    """
    Summarize a given text using OpenAI's summarization tool.
    """
    response = client.completions.create(
        model="ollama/phi3",  # Use the correct model name
        prompt=f"Summarize the following text:\n\n{text}\n\nSummary:",
        max_tokens=50
    )
    return response.choices[0].text.strip()

def main():
    # Example usage of the agent
    prompt = "Write a short story about a robot learning to love."
    generated_text = generate_text(prompt)
    print("Generated Text:\n", generated_text)

    summary = summarize_text(generated_text)
    print("\nSummary:\n", summary)

    # Example usage of the agent - calculation + summary
    prompt = "What is the result of area of france in squared KM divided by 1000?"
    generated_text = calculate(prompt)
    print("Generated Text:\n", generated_text)
    summary = summarize_text(generated_text)
    print("\nSummary:\n", summary)

if __name__ == "__main__":
    main()
