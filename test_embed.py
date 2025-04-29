import openai
import logging
import pandas as pd

client = openai.OpenAI(
    api_key="sk-password",
    base_url="http://0.0.0.0:4000"
)


sympthoms = """Abdominal pain in adults
Blood in stool in adults
Chest pain in adults
Constipation in adults
Cough in adults
Diarrhea in adults
Difficulty swallowing in adults
Dizziness in adults
Eye discomfort and redness in adults
Eye problems in adults
Foot pain or ankle pain in adults
Foot swelling or leg swelling in adults
Headaches in adults
Heart palpitations in adults
Hip pain in adults
Knee pain in adults
Low back pain in adults
Nasal congestion in adults
Nausea or vomiting in adults
Neck pain in adults
Numbness or tingling in hands in adults
Pelvic pain in adult females
Pelvic pain in adult males
Shortness of breath in adults
Shoulder pain in adults
Sore throat in adults
Urinary problems in adults
Wheezing in adults""". split('\n')



# Generate the prompt content
vecs = {}
for sympthom in sympthoms:
    # Use the client to create a completion
    logging.info(sympthom)
    enmbed_structure = client.embeddings.create(
    model="nomic-embed-text",
    input=sympthom
    )
    data = enmbed_structure.data[0]
    vec = data.embedding
    vecs[sympthom] = vec


print (pd.DataFrame(vecs).T)