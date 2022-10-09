## System Recommander (MF)

Mise en place d'un systéme de recommandation par factorisation matricielle (Matrix Factorization) :

Jeu de donnée :

Pour le jeu de donnée, on a 6049 utilisateurs et 3952 films, les notes des utilisateurs vont de 1 à 5. 5 étant la note quand l’utilisateur a apprécié le film.
Le nombre total des notes est 800163, la figure ci-dessous montre la distribution de ces notes.
![image](https://user-images.githubusercontent.com/26902337/194694356-dec9a4e4-09bd-41b3-a156-32560d664b05.png)

--------------------
Factorisation matricielle

Soit X une matrice (m x n) qui contient les notes des m utilisateurs aux n films.
On décompose la matrice X en le produit de deux matrices de dimension inférieure, une matrice U peut être considérée comme la matrice des utilisateurs où les lignes représentent les utilisateurs et les colonnes sont les facteurs latents, l’autre matrice V est la matrice d’éléments où les lignes représentent les films et les colonnes sont les facteurs latents.

La factorisation matricielle consiste à chercher une approximation de la matrice X de sorte que : X≈UV^T

----------------------
pour lancer : run_MF.m 

%% Parameters a changer :
 alg = "SGD";               % L'algorithme     : 'GD' - 'SGD' - 'ALS'
 
 init = 'svd';              % L'initialisation : 'random' - 'ones' - 'average' - 'svd'
 
 biais = true;              % biais : true / false
 
 lambda = 0.025;            % paramétre de régularisation
 
 NMF = false;               % NMF : true / false
 
 lr = 0.002;                % pas d'apprentissage : leranin rate
 
 iter = +inf;               % Nombre d'itérations maximum
 
 rank = 6; 
 
 ![image](https://user-images.githubusercontent.com/26902337/194698978-c58ee274-349f-4477-a81a-6c4073a7599c.png)

