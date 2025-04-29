import openai

client = openai.OpenAI(
    api_key="sk-password",
    base_url="http://0.0.0.0:4000"
)

from langchain_community.document_loaders import TextLoader
from langchain_openai import OpenAIEmbeddings,ChatOpenAI
from langchain_text_splitters import CharacterTextSplitter
from langchain.chains import RetrievalQA
from langchain_community.vectorstores import Annoy


import os
os.environ['PYDEVD_INTERRUPT_THREAD_TIMEOUT'] = '10'

loader = TextLoader("data/state_of_the_union.txt")
documents = loader.load()
text_splitter = CharacterTextSplitter(chunk_size=1000, chunk_overlap=0)
docs = text_splitter.split_documents(documents)


embeddings = OpenAIEmbeddings(api_key="sk-password",
    base_url="http://0.0.0.0:4000",
    model="nomic-embed-text")

llm = ChatOpenAI(model_name="ollama/phi3", temperature=0,api_key="sk-password",
    base_url="http://0.0.0.0:4000")

vector_store = Annoy.from_documents(
    docs,
    embeddings
)

prompt = "What did the president say about the economy?" # Change this to your query/prompt

qa_chain = RetrievalQA.from_chain_type(
    llm,
    retriever=vector_store.as_retriever(top_k=4), ## define K-nearest docs
    chain_type = "stuff",
)

result = qa_chain.invoke(prompt)

print (result['result'])
