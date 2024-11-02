#1. Fonctions
#A.	Créez une fonction get_total_order_amount qui prend en paramètre order_id (ID d'une commande) et retourne le montant total de cette commande (la somme des produits dans la commande, en prenant en compte les quantités et les prix). (2 points)

#B.	Créez une fonction get_product_stock qui prend en paramètre product_id (ID d'un produit) et retourne le stock actuel de ce produit. (2 points)

#2. Procédures Stockées
#A.	Créez une procédure stockée update_stock qui prend en paramètres product_id et quantity et met à jour le stock du produit spécifié en soustrayant la quantité passée en paramètre. Attention : la procédure doit vérifier que le stock restant est suffisant avant d’effectuer la soustraction. Si ce n'est pas le cas, elle doit lever une erreur. (2 points)

#B.	Créez une procédure add_order_line qui prend en paramètres order_id, product_id, quantity, et price, puis ajoute une ligne de commande dans la table order_lines. Remarque : la procédure doit vérifier que le produit spécifié a assez de stock disponible. (2 points)

#3. Triggers
#A.	Créez un trigger after_insert_order qui se déclenche après l'insertion d'une commande dans la table orders. Ce trigger doit mettre à jour le statut de la commande en new_order si aucune ligne de commande n’a encore été ajoutée pour cette commande. (2 points)

#B.	Créez un trigger after_insert_line_order qui se déclenche après l'insertion d'une ligne de commande dans la table line_orders. Ce trigger doit mettre à jour le statut de la commande en pending. (2 points)

#4. Transactions
#Écrivez une procédure stockée new_order qui crée une nouvelle commande pour un client donné, cette PS accepte comme paramètres le numéro du client, deux numéros de produits et deux quantités. Ajoute en transaction deux lignes de commande, et met à jour le stock des produits concernés. 
#Avant l’insertion de la ligne de commande il faut chercher le prix du produit concerné pour l’insérer dans la ligne.
#La transaction doit être annulée si le stock d’un des produits est insuffisant pour satisfaire une des lignes de commande. (3 points)


#5. Curseurs
#Créez un curseur dans la procédure stockées get_customer_infos pour afficher le nom, l'adresse, et l'email de chaque client ayant passé une commande au cours des 30 derniers jours. Utilisez le curseur pour afficher chaque client avec ses informations de contact. (3 points)
#6. Gestion des Utilisateurs


#Créez un nouvel utilisateur SQL nommé consultant_order avec un mot le mot de passe ‘123456’ et accordez-lui uniquement les droits de lecture (SELECT) sur la table orders. (2 points)

