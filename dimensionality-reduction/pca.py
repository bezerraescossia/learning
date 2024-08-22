'''
Created on Wed Ago 21 19:44:00 2024
@author: bzesc

Requirements: sklearn==1.0.2, numpy==1.21.6 , matplotlib==3.5.3
'''

# importando bibliotecas
import numpy as np
from sklearn.decomposition import PCA
import matplotlib.pyplot as plt

# Generate some example data
np.random.seed(0)
data = np.random.rand(100, 5)

# Standardize the data
from sklearn.preprocessing import StandardScaler
scaler = StandardScaler()
data_scaled = scaler.fit_transform(data)

# Apply PCA
pca = PCA(n_components=2)
principal_components = pca.fit_transform(data_scaled)
# Plot the results
plt.scatter(principal_components[:, 0], principal_components[:, 1])
plt.xlabel('Principal Component 1')
plt.ylabel('Principal Component 2')
plt.title('PCA Result')
plt.show()