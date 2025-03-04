# importation des différents packages 
import pandas as pd  
import numpy as np
import matplotlib.pyplot as plt  
import seaborn as sns 
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans
from scipy import stats
from scipy.stats import chi2_contingency


# Chargement des données, Lecture du fichier CSV
df = pd.read_csv('customer_segmentation.csv')

#1. Présentation et description des données
print("1. PRÉSENTATION ET DESCRIPTION DES DONNÉES")

# Aperçu des données 
print("Aperçu des données:")
print(df.head())

# Info sur les variables
print("Informations sur les variables:")
print(df.info())
 
# Stats descriptives
print("Statistiques descriptives:")
print(df.describe())

# On vérifie si il y a des valeurs manquantes au sein du dataset
print("Nombre de valeurs manquantes par colonne:")
print(df.isnull().sum())

print("Pourcentage de valeurs manquantes par colonne:")
print((df.isnull().sum() / len(df) * 100).round(2), '%')

# Afin de voir les lignes qui ont des valeurs NaN
print("Exemples de lignes avec des valeurs manquantes:")
missing_rows = df[df.isnull().any(axis=1)]
print(missing_rows.head())

# On remplace les valeurs manquantes par le mode, médiane ou moyenne en fonction de la variable
replacement_values = {
    'AnnualIncome': df['AnnualIncome'].mean(),  # Moyenne
    'Age': df['Age'].median(),  # Médiane
    'SpendingScore': df['SpendingScore'].median(),  # Médiane
    'OnlinePurchases': df['OnlinePurchases'].median(),  # Médiane
    'WebsiteVisits': df['WebsiteVisits'].median(),  # Médiane
    'CategoryPreference': df['CategoryPreference'].mode()[0]  # Mode
}
df.fillna(replacement_values, inplace=True)

# Output finale après remplacement des valeurs manquantes
print("Valeurs manquantes après remplacement:")
print(df.isnull().sum())

# 2. Analyse univariée
# On créé un dictionnaire pour définir le code couleur de chaque variable quanti 
num_colors = {
    'Age': '#ff7f0e',  # Orange
    'AnnualIncome': '#1f77b4',  # Bleu
    'SpendingScore': '#2ca02c',  # Vert
    'OnlinePurchases': '#d62728',  # Rouge
    'WebsiteVisits': '#9467bd'  # Violet
}

print("2. ANALYSE UNIVARIÉE")

# On stocke les variables quantitatives dans num_vars
num_vars = ['Age', 'AnnualIncome', 'SpendingScore', 'OnlinePurchases', 'WebsiteVisits']
# On effectue une boucle pour afficher l'histogramme et la boîte à moustache pour chaque variable dans num_vars
for var in num_vars:
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(15, 5))
    
    # Histogramme
    sns.histplot(data=df, x=var, ax=ax1, color=num_colors[var])
    ax1.set_title(f'Distribution de {var}')
    
    # Boîte à moustaches
    sns.boxplot(data=df, y=var, ax=ax2, color=num_colors[var])
    ax2.set_title(f'Boîte à moustaches de {var}')
    
    plt.show()
    
    # On affiche les statistiques descriptives pour chaque analyse univariée
    print(f"\nStatistiques pour {var}:")
    display(df[var].describe())
    

# 2. Analyse univariée
# On créé un dictionnaire et une liste pour définir les couleurs liées à gender et aux différentes catégories
gender_colors = {'Female': '#ff9999', 'Male': '#6fa3ef'}  # Rouge clair et bleu clair
category_colors = ['#9467bd', '#ff7f0e', '#2ca02c', '#e377c2', '#1f77b4']  # Couleurs pour les catégories

# On stocke les variables qualitatives à analyser dans cat_vars
cat_vars = ['Gender', 'CategoryPreference']

#On effectue une boucle pour afficher un diagramme en barre et une pie chart pour chaque variable dans cat_vars
for var in cat_vars:
    fig, axes = plt.subplots(1, 2, figsize=(12, 5)) 
    # On compte les valeurs uniques de la variable
    counts = df[var].value_counts()
    
    # Diagramme en barres
    if var == 'Gender':  
        sns.barplot(x=counts.index, y=counts.values, ax=axes[0], 
                    palette=[gender_colors[i] for i in counts.index])  # Si la variable est "Gender", on applique les couleurs du dictionnaire `gender_colors'
    else:  
        sns.barplot(x=counts.index, y=counts.values, ax=axes[0], 
                    palette=category_colors)  # Sinon couleurs de la catégorie

    axes[0].set_title(f'Distribution de {var}')  # Titre du diagramme en barres

    # Pie Chart, autopct de %1.0% afin d'avoir un nombre entier sans décimales
    if var == 'Gender':
        axes[1].pie(counts.values, labels=counts.index, autopct='%1.0f%%', 
                    colors=[gender_colors[i] for i in counts.index]) 
    else:
        axes[1].pie(counts.values, labels=counts.index, autopct='%1.0f%%', 
                    colors=category_colors) 
    axes[1].set_title(f'Répartition de {var}')  # Titre du pie chart

    plt.show()


# 3. Analyse bivariée
print("3. ANALYSE BIVARIÉ")

# On calcule la corrélation entre revenu et dépenses
corr = df['AnnualIncome'].corr(df['SpendingScore'])
print(f"Corrélation: {corr}")

# Graphique de dispersion avec couleur par genre et ligne de régression
plt.figure(figsize=(10, 6))
sns.scatterplot(data=df, x='AnnualIncome', y='SpendingScore', hue='Gender',
                palette=gender_colors, alpha=0.6, edgecolor=None)
sns.regplot(data=df, x='AnnualIncome', y='SpendingScore', scatter=False, color='black', ci=None)
plt.title('Relation entre le Revenu Annuel et le Score de Dépenses, par Genre')
plt.xlabel('Revenu Annuel')
plt.ylabel('Score de Dépenses')
plt.legend(title='Genre')
plt.tight_layout()
plt.show()

# On effectue le test corrélation de Pearson entre les deux variables
pearson_r, p_value = stats.pearsonr(df['AnnualIncome'], df['SpendingScore'])
print("Test de corrélation de Pearson:")
print(f"r: {pearson_r}")
print(f"p-value: {p_value}")


# 3. Analyse bivariée
# On Calcul la corrélation entre WebsiteVisits et OnlinePurchases
corr = df['WebsiteVisits'].corr(df['OnlinePurchases'])

# Création du scatterplot avec régression
plt.figure(figsize=(10, 6))
sns.regplot(
    data=df, x='WebsiteVisits', y='OnlinePurchases', 
    scatter_kws={'color': num_colors['WebsiteVisits'], 'alpha': 0.6},  # Points en violet
    line_kws={'color': num_colors['OnlinePurchases']}  # Ligne de régression en rouge
)

# On affiche la valeur de la corrélation 
plt.annotate(f"Corrélation: {corr}", 
             xy=(0.05, 0.95), 
             xycoords='axes fraction', 
             fontsize=12, 
             bbox=dict(boxstyle="round,pad=0.3", edgecolor='gray', facecolor='white'))

plt.title("Régression : WebsiteVisits vs OnlinePurchases")
plt.xlabel("Nombre de Visites sur le Site")
plt.ylabel("Achats en Ligne")
plt.show()

# 3. Analyse bivariée
# Définition des couleurs pour chaque catégorie via un dictionnaire
category_colors = {
    'Clothing': '#9467bd',  # Violet
    'Electronics': '#ff7f0e',  # Orange
    'Books': '#2ca02c',  # Vert
    'Beauty': '#e377c2',  # Rose
    'Sports': '#1f77b4'  # Bleu foncé
}

# Création de la table de contingence
print("Analyse des préférences de catégorie par genre :")
contingency = pd.crosstab(df['Gender'], df['CategoryPreference'])
print(contingency)

# On effectue un Test du chi² (car deux varibles qualitatives) pour voir s'il y a une association entre genre et préférences
chi2, p_value, dof, expected = stats.chi2_contingency(contingency)

print("\nTest du χ² d'indépendance :")
print("Statistique χ² :", round(chi2, 2))
print("p-value :", round(p_value, 4))
print("Degrés de liberté :", dof)

# Calcul du V de Cramer pour mesurer l'intensité de cette association (pour déterminer si ces variables sont liées et à quel point)
def calculate_cramer_v(contingency_table):
    chi2, _, _, _ = stats.chi2_contingency(contingency_table)
    n = contingency_table.sum().sum()  # Nombre total d'observations
    min_dim = min(contingency_table.shape) - 1  # Minimum entre nombre de lignes et colonnes - 1 (le tableau a 2 lignes (male, female) et 5 colonnes (5 catégories différentes), on prend min(2, 5) - 1 = 1 
    return np.sqrt(chi2 / (n * min_dim))

cramer_v = calculate_cramer_v(contingency)
print("V de Cramer :", round(cramer_v, 3))


# 4. Analyse comportementale
# Définition des couleurs via dictionnaires et listes 
gender_colors = {'Female': '#ff9999', 'Male': '#6fa3ef'}  # Rouge clair et bleu clair
spending_order = ['Faible', 'Moyen', 'Élevé']
spending_colors = ['#76c893', '#f4a261', '#e63946']  # Vert, Orange, Rouge foncé

# Analyse des visiteurs fréquents
print("4.1 ANALYSE DES VISITEURS FRÉQUENTS")

# Définition des visiteurs fréquents (top 25%)
visits_threshold = df['WebsiteVisits'].quantile(0.75)
df['VisitorType'] = df['WebsiteVisits'].apply(lambda x: 'Fréquent' if x >= visits_threshold else 'Normal')

# Affichage du profil des visiteurs fréquents
print("Profil des visiteurs fréquents:")
print(df.groupby('VisitorType')[['Age', 'AnnualIncome', 'SpendingScore', 'OnlinePurchases']].mean().round(2))

# Score de dépense selon le type de visiteur
plt.figure(figsize=(10, 5))
sns.boxplot(data=df, x='VisitorType', y='SpendingScore', palette=['#2ca02c', "#B0BEC5"])
plt.title('Score de dépense selon le type de visiteur')
plt.show()

# Analyse des catégories préférées par sexe et âge
print("4.2 ANALYSE DES CATÉGORIES PRÉFÉRÉES")

# Création des groupes d'âge
df['GroupeAge'] = pd.cut(df['Age'], bins=[0, 30, 45, 60, 100], labels=['18-30', '31-45', '46-60', '60+'])

# Affichage des préférences
preferences = df.pivot_table(index=['Gender', 'GroupeAge'], columns='CategoryPreference', aggfunc='size', fill_value=0)
preferences_percent = preferences.div(preferences.sum(axis=1), axis=0) * 100
print("Préférences de catégories par genre et âge (%):")
print(preferences_percent.round(1))

# Distribution des catégories préférées par genre
plt.figure(figsize=(10, 5))
sns.countplot(data=df, x='CategoryPreference', hue='Gender', palette=gender_colors)
plt.title('Distribution des catégories préférées par genre')
plt.xticks(rotation=45)
plt.legend(title='Genre')
plt.show()

# Classification des clients selon leur aptitude à dépenser 
print("4.3 CLASSIFICATION PAR NIVEAU DE DÉPENSE")

# Fonction pour classifier les dépenses
def classifier_depense(score):
    if score < 33:
        return 'Faible'
    elif score < 66:
        return 'Moyen'
    else:
        return 'Élevé'

# Application de la fonction de classification
df['NiveauDepense'] = df['SpendingScore'].apply(classifier_depense)

# Affichage des caractéristiques moyennes
print("Caractéristiques moyennes par niveau de dépense:")
print(df.groupby('NiveauDepense')[['Age', 'AnnualIncome', 'OnlinePurchases', 'WebsiteVisits']].mean().round(2))

# Définition de l'ordre des niveaux de dépense
fig, axes = plt.subplots(1, 2, figsize=(12, 5))

# Revenu par niveau de dépense
sns.boxplot(data=df, x='NiveauDepense', y='AnnualIncome', ax=axes[0], 
            order=spending_order, palette=spending_colors)
axes[0].set_title('Revenu par niveau de dépense')

# Visites web par niveau de dépense
sns.boxplot(data=df, x='NiveauDepense', y='WebsiteVisits', ax=axes[1], 
            order=spending_order, palette=spending_colors)
axes[1].set_title('Visites web par niveau de dépense')

plt.show()


# 4. Analyse comportementale

# Définition des couleurs via dictionnaires et listes 
gender_colors = {'Female': '#ff9999', 'Male': '#6fa3ef'}  # Rouge clair et bleu clair
spending_order = ['Faible', 'Moyen', 'Élevé']
spending_colors = ['#76c893', '#f4a261', '#e63946']  # Vert, Orange, Rouge foncé

# Analyse des visiteurs fréquents
print("4.1 ANALYSE DES VISITEURS FRÉQUENTS")

# Définition des visiteurs fréquents (top 25%)
visits_threshold = df['WebsiteVisits'].quantile(0.75)
df['VisitorType'] = df['WebsiteVisits'].apply(lambda x: 'Fréquent' if x >= visits_threshold else 'Normal')

# Affichage du profil des visiteurs fréquents
print("Profil des visiteurs fréquents:")
print(df.groupby('VisitorType')[['Age', 'AnnualIncome', 'SpendingScore', 'OnlinePurchases']].mean().round(2))

# Score de dépense selon le type de visiteur
plt.figure(figsize=(10, 5))
sns.boxplot(data=df, x='VisitorType', y='SpendingScore', palette=['#2ca02c', "#B0BEC5"])
plt.title('Score de dépense selon le type de visiteur')
plt.show()

# Analyse des catégories préférées par sexe et âge
print("4.2 ANALYSE DES CATÉGORIES PRÉFÉRÉES")

# Création des groupes d'âge
df['GroupeAge'] = pd.cut(df['Age'], bins=[0, 30, 45, 60, 100], labels=['18-30', '31-45', '46-60', '60+'])

# Affichage des préférences
preferences = df.pivot_table(index=['Gender', 'GroupeAge'], columns='CategoryPreference', aggfunc='size', fill_value=0)
preferences_percent = preferences.div(preferences.sum(axis=1), axis=0) * 100
print("Préférences de catégories par genre et âge (%):")
print(preferences_percent.round(1))

# Distribution des catégories préférées par genre
plt.figure(figsize=(10, 5))
sns.countplot(data=df, x='CategoryPreference', hue='Gender', palette=gender_colors)
plt.title('Distribution des catégories préférées par genre')
plt.xticks(rotation=45)
plt.legend(title='Genre')
plt.show()

# Classification des clients selon leur aptitude à dépenser 

print("4.3 CLASSIFICATION PAR NIVEAU DE DÉPENSE")

# Fonction pour classifier les dépenses
def classifier_depense(score):
    if score < 33:
        return 'Faible'
    elif score < 66:
        return 'Moyen'
    else:
        return 'Élevé'

# Application de la fonction de classification
df['NiveauDepense'] = df['SpendingScore'].apply(classifier_depense)

# Affichage des caractéristiques moyennes
print("Caractéristiques moyennes par niveau de dépense:")
print(df.groupby('NiveauDepense')[['Age', 'AnnualIncome', 'OnlinePurchases', 'WebsiteVisits']].mean().round(2))

# Définition de l'ordre des niveaux de dépense
fig, axes = plt.subplots(1, 2, figsize=(12, 5))

# Revenu par niveau de dépense
sns.boxplot(data=df, x='NiveauDepense', y='AnnualIncome', ax=axes[0], 
            order=spending_order, palette=spending_colors)
axes[0].set_title('Revenu par niveau de dépense')

# Visites web par niveau de dépense
sns.boxplot(data=df, x='NiveauDepense', y='WebsiteVisits', ax=axes[1], 
            order=spending_order, palette=spending_colors)
axes[1].set_title('Visites web par niveau de dépense')

plt.show()



