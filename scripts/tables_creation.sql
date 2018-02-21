# Database creation
CREATE DATABASE ocpizza_db CHARACTER SET 'utf8'


# Tables creation

# Table 'ingredients' creation
CREATE TABLE ingredients (
                id INT AUTO_INCREMENT NOT NULL,
                name VARCHAR(150) NOT NULL,
                created DATETIME NOT NULL,
                modified DATETIME NOT NULL,
                PRIMARY KEY (id)
); ENGINE=InnoDB DEFAULT CHARSET=latin1;
# Table 'ingredients' index
CREATE INDEX ingredients_idx1
 ON ingredients
 ( name );



# Table 'stores' creation
CREATE TABLE stores (
                id INT AUTO_INCREMENT NOT NULL,
                name VARCHAR(100) NOT NULL,
                address VARCHAR(200) NOT NULL,
                zip_code MEDIUMINT NOT NULL,
                city VARCHAR(50) NOT NULL,
                longitude DECIMAL(10,6) NOT NULL,
                latitude DECIMAL(10,6) NOT NULL,
                phone_number VARCHAR(20) NOT NULL,
                email VARCHAR(150) NOT NULL,
                schedules TEXT NULL,
                created DATETIME NOT NULL,
                modified DATETIME NOT NULL,
                PRIMARY KEY (id)
); ENGINE=InnoDB DEFAULT CHARSET=latin1;
# Table 'stores' index
CREATE INDEX stores_idx
 ON stores
 ( name );



# Table 'stocks' creation
CREATE TABLE stocks (
                store_id INT NOT NULL,
                ingredient_id INT NOT NULL,
                quantity INT NOT NULL,
                dutyfree_sale_price INT NOT NULL,
                dutifree_purchase_price INT NOT NULL,
                vat_purchase INT NOT NULL,
                PRIMARY KEY (store_id, ingredient_id)
); ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Table 'pizzas' creation
CREATE TABLE pizzas (
                id INT AUTO_INCREMENT NOT NULL,
                name VARCHAR(150) NOT NULL,
                availability BOOLEAN DEFAULT 0 NOT NULL,
                description TEXT NULL,
                recipes TEXT NULL,
                created DATETIME NOT NULL,
                modified DATETIME NOT NULL,
                PRIMARY KEY (id)
); ENGINE=InnoDB DEFAULT CHARSET=latin1;
# Table 'pizzas' index
CREATE INDEX pizzas_idx
 ON pizzas
 ( id );

CREATE INDEX pizzas_idx1
 ON pizzas
 ( name );



# Table 'details' creation
CREATE TABLE details (
                article_id INT NOT NULL,
                ingredient_id INT NOT NULL,
                quantity INT NOT NULL,
                PRIMARY KEY (article_id, ingredient_id)
);ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Table 'payment_method' creation
CREATE TABLE payment_method (
                id INT AUTO_INCREMENT NOT NULL,
                modality VARCHAR(25) NOT NULL,
                active BOOLEAN DEFAULT 0 NOT NULL,
                PRIMARY KEY (id)
); ENGINE=InnoDB DEFAULT CHARSET=latin1;
# Table 'payment_method' index
CREATE INDEX payment_method_idx
 ON payment_method
 ( id );



# Table 'user_role' creation
CREATE TABLE user_role (
                role_function VARCHAR(100) NOT NULL,
                PRIMARY KEY (role_function)
); ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Table 'users' creation
CREATE TABLE users (
                id INT AUTO_INCREMENT  NOT NULL,
                role_function VARCHAR(100) NOT NULL,
                login VARCHAR(100) NOT NULL,
                password VARCHAR(255) NOT NULL,
                firstname VARCHAR(100) NOT NULL,
                lastname VARCHAR(100) NOT NULL,
                address VARCHAR(200),
                zip_code MEDIUMINT,
                city VARCHAR(50),
                longitude DECIMAL(10,6) NOT NULL,
                latitude DECIMAL(10,6) NOT NULL,
                phone_number VARCHAR(20),
                email VARCHAR(150),
                created DATETIME NOT NULL,
                modified DATETIME NOT NULL,
                PRIMARY KEY (id)
); ENGINE=InnoDB DEFAULT CHARSET=latin1;
# Table 'users' index
CREATE INDEX users_idx
 ON users
 ( login, password, email );



# Table 'staff' creation
CREATE TABLE staff (
                user_id INT NOT NULL,
                store_id INT NOT NULL,
                PRIMARY KEY (user_id, store_id)
);ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Table 'orders' creation
CREATE TABLE orders (
                number INT AUTO_INCREMENT NOT NULL,
                user_id INT NOT NULL,
                store_id INT NOT NULL,
                customer_id INT NOT NULL,
                courier_id INT NOT NULL,
                online BOOLEAN NOT NULL,
                status TINYINT DEFAULT 0 NOT NULL,
                status_gestion CHAR(20) NOT NULL,
                delivery_time DATETIME NOT NULL,
                delivery BOOLEAN NOT NULL,
                dutyfree_price INT NOT NULL,
                vat INT NOT NULL,
                created DATETIME NOT NULL,
                modified DATETIME NOT NULL,
                PRIMARY KEY (number)
); ENGINE=InnoDB DEFAULT CHARSET=latin1;
# Table 'orders' index
CREATE INDEX orders_idx
 ON orders
 ( number );



# Table 'invoice' creation
CREATE TABLE invoice (
                invoice_nb INT AUTO_INCREMENT NOT NULL,
                order_nb INT NOT NULL,
                status BOOLEAN DEFAULT 0 NOT NULL,
                created DATETIME NOT NULL,
                modified DATETIME NOT NULL,
                PRIMARY KEY (invoice_nb)
); ENGINE=InnoDB DEFAULT CHARSET=latin1;
# Table 'invoice' index
CREATE INDEX invoice_idx
 ON invoice
 ( invoice_nb );



# Table 'payment' creation
CREATE TABLE payment (
                invoice_nb INT NOT NULL,
                payment_method_id INT NOT NULL,
                final_price INT NOT NULL,
                PRIMARY KEY (invoice_nb, payment_method_id)
); ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Table 'articles' creation
CREATE TABLE articles (
                article_id INT NOT NULL,
                order_nb INT NOT NULL,
                quantity INT NOT NULL,
                PRIMARY KEY (article_id, order_nb)
); ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Foreign keys and references addition
ALTER TABLE details ADD CONSTRAINT ingredients_details_fk
FOREIGN KEY (ingredient_id)
REFERENCES ingredients (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE stocks ADD CONSTRAINT ingredients_stocks_fk
FOREIGN KEY (ingredient_id)
REFERENCES ingredients (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE orders ADD CONSTRAINT stores_orders_fk
FOREIGN KEY (store_id)
REFERENCES stores (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE stocks ADD CONSTRAINT stores_stocks_fk
FOREIGN KEY (store_id)
REFERENCES stores (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE staff ADD CONSTRAINT stores_staff_fk
FOREIGN KEY (store_id)
REFERENCES stores (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE articles ADD CONSTRAINT pizzas_articles_fk
FOREIGN KEY (article_id)
REFERENCES pizzas (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE details ADD CONSTRAINT pizzas_details_fk
FOREIGN KEY (article_id)
REFERENCES pizzas (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE payment ADD CONSTRAINT payment_method_payment_fk
FOREIGN KEY (payment_method_id)
REFERENCES payment_method (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE users ADD CONSTRAINT user_role__users_fk
FOREIGN KEY (role_function)
REFERENCES user_role (role_function)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE orders ADD CONSTRAINT users_orders_fk2
FOREIGN KEY (customer_id)
REFERENCES users (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE orders ADD CONSTRAINT users_orders_fk1
FOREIGN KEY (user_id)
REFERENCES users (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE orders ADD CONSTRAINT users_orders_fk
FOREIGN KEY (courier_id)
REFERENCES users (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE staff ADD CONSTRAINT users_staff_fk
FOREIGN KEY (user_id)
REFERENCES users (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE articles ADD CONSTRAINT orders_articles_fk
FOREIGN KEY (order_nb)
REFERENCES orders (number)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE invoice ADD CONSTRAINT orders_invoice_fk
FOREIGN KEY (order_nb)
REFERENCES orders (number)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE payment ADD CONSTRAINT invoice_payment_fk
FOREIGN KEY (invoice_nb)
REFERENCES invoice (invoice_nb)
ON DELETE NO ACTION
ON UPDATE NO ACTION;