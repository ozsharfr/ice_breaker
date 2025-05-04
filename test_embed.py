import openai
import logging
import pandas as pd
from annoy import AnnoyIndex

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

X = df_vecs = pd.DataFrame(vecs).T    

###### consider index of annoy 
# from sklearn.cluster import KMeans
# import numpy as np
# kmeans = KMeans()
# annoy_index = AnnoyIndex(df_vecs.shape[1], 'euclidean') # Choose appropriate distance
# for j, centroid in enumerate(kmeans.cluster_centers_):
#     annoy_index.add_item(j, centroid)
# annoy_index.build(10) # Number of trees
# # Approximate assignment step using Annoy
# new_labels = np.zeros(X.shape[0], dtype=np.int32)
# for p_index, point in enumerate(X):
#     nearest_centroid_index = annoy_index.get_nns_by_vector(point, 1)[0]
#     new_labels[p_index] = nearest_centroid_index




# get 333
print ('aa')
print (pd.DataFrame(vecs).T)