#1. Fonctions
#A. Créez une fonction get_total_loaned_books qui prend en paramètre member_id (ID d'un membre) et retourne le nombre total de livres empruntés par ce membre. (2 points)

#B. Créez une fonction get_book_stock qui prend en paramètre book_id (ID d'un livre) et retourne le stock actuel de ce livre. (2 points)

#2. Procédures Stockées
#A. Créez une procédure stockée update_book_stock qui prend en paramètres book_id et quantity et met à jour le stock du livre spécifié en soustrayant la quantité passée en paramètre. (2 points)

#B. Créez une procédure add_loan qui prend en paramètres book_id et member_id, et ajoute un emprunt dans la table loans. (2 points)

#3. Triggers
#A. Créez un trigger after_insert_loan qui se déclenche après l'insertion d'un emprunt dans la table loans. Ce trigger doit diminuer le stock du livre de 1. (2 points)

#B. Créez un trigger after_return_loan qui se déclenche après la mise à jour d'une ligne de la table loans pour marquer un livre comme retourné. Ce trigger doit mettre à jour le stock du livre. (2 points)

#4. Transactions
#Écrivez une procédure stockée new_loan qui crée un nouvel emprunt pour un membre donné, en acceptant comme paramètres le numéro du membre et le numéro du livre. 
#Ajoutez en transaction l'emprunt et mettez à jour le stock du livre concerné.
#La transaction ne doit pas passer si le stock de ce livre est zero (3 points)

#5. Curseur
#Créez une procédure qui utilise un curseur pour afficher la liste de tous les livres disponibles dans la bibliothèque, ainsi que leur statut (disponible ou non disponible). (2 points)

#6. Gestion des Utilisateurs
#Créez un nouvel utilisateur SQL nommé loans_manager avec un mot le mot de passe ‘123456’ et accordez-lui tous les droits sur la table loans. (2 points)
