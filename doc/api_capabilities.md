# Kategorien

* GET category: category_id, category_title, number of items
* GET item(category_id): [item_id, item_title, item_description,[picture_id, picture_url], item_contact]

# InserateEditor

* GET item(item_id): [item_id, item_title, item_description,[picture_id, picture_url], item_contact]
* POST item: item_title, item_description, [picture_url], item_contact

# Nachrichten

* GET item(item_id): item_id, item_contact, user_contact
* POST chatroom(chat_id): item_title, chat_history, [picture_url]  

# Inserate

* POST item(item_id)[item_title, item_description,[picture_id, picture_url], item_contact] : ID
