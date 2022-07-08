INSERT INTO todos (name, list_id) values ('carrots', 2), ('spinach', 2), ('cheese', 2), ('cs', 1);


SELECT * FROM todos WHERE list_id IN (SELECT id FROM lists WHERE id = 2);