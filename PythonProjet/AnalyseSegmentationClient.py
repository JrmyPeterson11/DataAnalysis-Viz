import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler


# Charger le dataset
df = pd.read_csv("customer_segmentation.csv")

# Afficher les statistiques descriptives
descriptive_stats = df.describe(include='all')
print("\nStatistiques descriptives :")
print(descriptive_stats)
# Optionnel de Sauvegarder le tableau sous format CSV pour une visualisation facile
descriptive_stats.to_csv("statistiques_descriptives.csv")

# On peut également le faire ainsi
print("\nStatistiques descriptives :")
print(df.describe())

# 1. Présentation et description des données
print("\nAperçu des données :")
print(df.head())
print("\nInformations générales :")
print(df.info())

# 2. Analyse univariée
plt.figure(figsize=(12,6))
df.hist(bins=20, figsize=(12,8), color='skyblue', edgecolor='black')
plt.suptitle("Distribution des variables numériques")
plt.show()

# Analyse des variables catégoriques
plt.figure(figsize=(8,6))
sns.countplot(data=df, x='Gender', hue='Gender', legend=False)
plt.title("Répartition des genres")
plt.show()

plt.figure(figsize=(10,6))
sns.countplot(data=df, x='CategoryPreference', hue='CategoryPreference', order=df['CategoryPreference'].value_counts().index, palette='viridis', legend=False)
plt.title("Distribution des préférences de catégorie")
plt.xticks(rotation=45)
plt.show()

# 3. Analyse bivariée
# Relation entre Revenu Annuel et Spending Score
plt.figure(figsize=(8,6))
sns.scatterplot(data=df, x='AnnualIncome', y='SpendingScore', hue='Gender')
plt.title("Revenu annuel vs Score de dépense")
plt.show()

# Relation entre Visites du site et Achats en ligne
plt.figure(figsize=(8,6))
sns.scatterplot(data=df, x='WebsiteVisits', y='OnlinePurchases', hue='Gender')
plt.title("Nombre de visites vs Nombre d'achats")
plt.show()

# Différence de Spending Score entre genres
plt.figure(figsize=(8,6))
sns.boxplot(data=df, x='Gender', y='SpendingScore')
plt.title("Différences du Score de Dépense entre Genres")
plt.show()

# 4. Analyse comportementale
# Clients qui visitent le site fréquemment
high_visitors = df[df['WebsiteVisits'] > df['WebsiteVisits'].quantile(0.75)]
print("\nClients avec des visites fréquentes sur le site:")
print(high_visitors.describe())

# Catégories préférées par sexe et âge
plt.figure(figsize=(10,5))
sns.countplot(data=df, x='CategoryPreference', hue='Gender')
plt.title("Préférences par Catégorie et Genre")
plt.xticks(rotation=45)
plt.show()

# Classification en Low, Medium, High spending
bins = [0, 33, 66, 100]
labels = ['Low', 'Medium', 'High']
df['SpendingCategory'] = pd.cut(df['SpendingScore'], bins=bins, labels=labels)
print("\nRépartition des clients selon la dépense :")
print(df['SpendingCategory'].value_counts())

# 5. Clustering des clients
features = df[['AnnualIncome', 'SpendingScore']]
scaler = StandardScaler()
features_scaled = scaler.fit_transform(features)

# Détermination du nombre optimal de clusters
wcss = []
for i in range(1, 11):
    kmeans = KMeans(n_clusters=i, random_state=42, n_init=10)
    kmeans.fit(features_scaled)
    wcss.append(kmeans.inertia_)

plt.figure(figsize=(8,6))
plt.plot(range(1, 11), wcss, marker='o')
plt.title("Méthode du coude")
plt.xlabel("Nombre de clusters")
plt.ylabel("WCSS")
plt.show()

# Appliquer K-Means avec le bon nombre de clusters
kmeans = KMeans(n_clusters=3, random_state=42, n_init=10)
df['Cluster'] = kmeans.fit_predict(features_scaled)

plt.figure(figsize=(8,6))
sns.scatterplot(x=df['AnnualIncome'], y=df['SpendingScore'], hue=df['Cluster'], palette='viridis')
plt.title("Clustering des clients")
plt.show()

print("\nAnalyse terminée !")
