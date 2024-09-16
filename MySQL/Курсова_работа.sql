CREATE DATABASE restaurant;
USE restaurant;

CREATE TABLE item (
item_id INT PRIMARY KEY AUTO_INCREMENT,
item_name VARCHAR(50) NOT NULL,
item_type VARCHAR(50) NOT NULL,
main_ingredient VARCHAR(50) NOT NULL,
item_price DECIMAL(10, 2) NOT NULL,
allergens VARCHAR(50),
weight FLOAT NOT NULL
);



CREATE TABLE order1 (
order1_id INT PRIMARY KEY AUTO_INCREMENT,
table_number INT NOT NULL,
order1_date DATE NOT NULL,
order1_time TIME NOT NULL,
waiter_name VARCHAR(50) NOT NULL,
item_id INT,
quantity INT NOT NULL,
FOREIGN KEY (item_id) REFERENCES item(item_id)
);

CREATE TABLE ingredient (
ingredient_id INT PRIMARY KEY AUTO_INCREMENT,
ingredient_name VARCHAR(50) NOT NULL
);

CREATE TABLE recipe (
recipe_id INT PRIMARY KEY AUTO_INCREMENT,
recipe_name VARCHAR(50) NOT NULL,
preparation_time INT NOT NULL,
ingredient_id INT,
quantity DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (ingredient_id) REFERENCES ingredient(ingredient_id)
);

CREATE TABLE staff (
staff_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
hire_date DATE NOT NULL,
position VARCHAR(50) NOT NULL,
salary FLOAT NOT NULL
);

CREATE TABLE shift (
shift_id INT PRIMARY KEY AUTO_INCREMENT,
shift_date DATE NOT NULL,
start_time TIME NOT NULL,
end_time TIME NOT NULL,
staff_id INT,
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE reservation (
reservation_id INT PRIMARY KEY AUTO_INCREMENT,
reservation_date DATE NOT NULL,
reservation_time TIME NOT NULL,
table_number INT NOT NULL,
customer_name VARCHAR(50) NOT NULL,
phone_number VARCHAR(15) NOT NULL
);

CREATE TABLE order1_item (
  order1_id INT NOT NULL,
  item_id INT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (order1_id, item_id),
  FOREIGN KEY (order1_id) REFERENCES order1(order1_id),
  FOREIGN KEY (item_id) REFERENCES item(item_id)
);

ALTER TABLE order1
ADD COLUMN reservation_id INT,
ADD CONSTRAINT order1_reservation
  FOREIGN KEY (reservation_id) REFERENCES reservation(reservation_id);

ALTER TABLE recipe 
ADD FOREIGN KEY (ingredient_id) REFERENCES ingredient(ingredient_id);

ALTER TABLE order1
ADD COLUMN staff_id INT,
ADD CONSTRAINT staff
FOREIGN KEY (staff_id) REFERENCES staff(staff_id);


SELECT item_name, allergens
FROM item
WHERE allergens LIKE '%Глутен%';


SELECT item_type, COUNT(*)
FROM item
GROUP BY item_type;


SELECT order1.order1_id, order1.table_number, order1.order1_date, item.item_name, order1.quantity
FROM order1
INNER JOIN item ON order1.item_id = item.item_id;


SELECT item_name, item_type, weight
FROM item
WHERE weight > (SELECT AVG(weight) FROM item);


SELECT shift.shift_date, staff.staff_id, staff.first_name, staff.last_name, SUM(staff.salary) AS total_salary
FROM shift
JOIN staff ON shift.staff_id = staff.staff_id
GROUP BY shift.shift_date, staff.staff_id;


SELECT *
FROM reservation
WHERE customer_name = COALESCE(@customer_name, customer_name);


SELECT ingredient.ingredient_name, SUM(recipe.quantity) AS total_weight
FROM recipe
JOIN ingredient ON recipe.ingredient_id = ingredient.ingredient_id
GROUP BY ingredient.ingredient_name;


SELECT ingredient.ingredient_name, recipe.recipe_name
FROM ingredient
LEFT OUTER JOIN recipe ON ingredient.ingredient_id = recipe.ingredient_id;


SELECT *
FROM staff
WHERE staff.staff_id NOT IN (
  SELECT DISTINCT shift.staff_id
  FROM shift
  WHERE shift.shift_date >= DATE_SUB(NOW(), INTERVAL 1 WEEK)
);


/**/
INSERT INTO item (item_name, item_type, main_ingredient, item_price, allergens, weight)
VALUES ('Breakfast бургер', 'храна', 'италианска наденица Салсиче', 12.99, 'Глутен, Млечни продукти', 230),
       ('Сандвич със свинско', 'храна', 'свинско месо', 14.99, 'Глутен', 270),
       ('Кесадия с пилешко', 'храна', 'пилешко месо, хумус', 14.99, 'Глутен, Млечни продукти', 290),
       ('Оризови спагети със зеленчуци', 'храна', 'спагети, гъби', 17.99, 'Глутен', 330),
       ('Дърпано свинско', 'храна', 'свинско, пържени сладки картофи', 19.99, 'Глутен', 420),
       ('Ризото с пиле', 'храна', 'пилешко месо, ориз', 14.99, 'Няма', 280),
       ('Бъфало пиле', 'храна', 'пилешко месо,домашен сос тартар', 17.99, 'Няма', 350),
       ('Салата Цезар', 'храна', 'айсберг, пармезан', 11.99, 'Млечни продукти', 230),
       ('Гръцка салата', 'храна', 'сирене, маслини', 10.99, 'Млечни продукти', 250),
       ('Кока-Кола', 'напитка', 'лед, кола, лимон', 2.99, 'Няма', 300),
       ('LONELY ISLAND', 'напитка', 'подправен ром , бял ром, пюре от ананас', 14.99, 'Няма', 300),
       ('HOTZILLA', 'напитка', 'бърбън, сироп от мащерка', 12.99, 'Няма', 300),
       ('SMOKEY VOODOO', 'напитка', 'подправен ром, уиски', 13.99, 'Няма', 300),
       ('Домашна лимонада', 'напитка', 'малина, ягода, вишна, горски плодове, бъз', 5.99, 'Няма', 400);
           
           
INSERT INTO order1 (table_number, order1_date, order1_time, waiter_name, item_id, quantity)
VALUES (3, '2023-05-01', '18:00:00', 'Никола', 4, 2),
       (6, '2023-05-02', '19:30:00', 'Александра', 2, 2),
       (2, '2023-05-01', '17:45:00', 'Александра', 1, 2),
       (4, '2023-05-04', '16:45:00', 'Никола', 14, 3),
       (7, '2023-05-01', '12:30:00', 'Никола', 1, 2),
       (3, '2023-05-02', '19:30:00', 'Александра', 7, 4),
       (6, '2023-05-04', '14:15:00', 'Александра', 8, 2);
       

INSERT INTO reservation (table_number, customer_name, phone_number, reservation_date, reservation_time)
VALUES (3, 'Георги Божинов', 0988164524, '2023-05-01', '18:00:00'),
       (6, 'Йордан Дамянов', 0898164522, '2023-05-02', '19:30:00'),
       (2, 'Христо Андреев', 0878164525, '2023-05-01', '17:45:00'),
       (4, 'Димитър Дончев', 0878164523, '2023-05-04', '16:45:00'),
       (7, 'Стилиян Петров', 0988164522, '2023-05-01', '12:30:00'),
       (3, 'Ивайло Начев', 0898174526, '2023-05-02', '19:30:00'),
       (6, 'Илиян Бончовски', 0898164523, '2023-05-04', '14:15:00');


INSERT INTO ingredient (ingredient_name)
VALUES ('Свинско'),
       ('Спагети'),
       ('наденица Салсиче'),
       ('Пилешко'),
       ('Сирене'),
       ('Маслини'),
       ('Картофи'),
       ('Ориз'),
       ('Айсберг'),
       ('Домат');

INSERT INTO recipe (recipe_name, ingredient_id, preparation_time, quantity)
VALUES ('Breakfast бургер', 3, 7, 0.35),
       ('Сандвич със свинско', 2, 10, 0.3),
       ('Кесадия с пилешко', 4, 10, 0.3),
       ('Оризови спагети със зеленчуци', 2, 12, 1),
       ('Дърпано свинско', 1, 15, 0.5),
       ('Ризото с пиле', 4, 12, 0.4),
       ('Бъфало пиле', 4, 12, 0.4),
       ('Салата Цезар', 9, 6, 1),
       ('Гръцка салата', 10, 5, 1);

INSERT INTO staff (first_name, last_name, hire_date, position, salary)
VALUES ('Димитър', 'Писарски', '2023-01-01', 'Мениджър', 4000),
       ('Синтия', 'Божинова', '2023-01-15', 'хостеса', 2500),
       ('Натали', 'Иванова', '2023-01-11', 'Шеф-кухня', 3500),
       ('Цветан', 'Димитров', '2023-01-19', 'готвач', 2200),
       ('Огнян', 'Танчев', '2023-01-18', 'готвач', 2200),
       ('Александър', 'Петров', '2023-01-10', 'Барман', 1750),
       ('Алексей', 'Алексиев', '2023-01-11', 'Барман', 1750),
       ('Никола', 'Александров', '2023-01-11', 'Сервитьори', 1750),
       ('Александра', 'Попчева', '2023-01-11', 'Сервитьори', 1750);

INSERT INTO shift (staff_id, shift_date, start_time, end_time)
VALUES (4, '2023-05-01', '09:00:00', '17:00:00'),
       (5, '2023-05-02', '11:00:00', '20:00:00'),
       (6, '2023-05-03', '08:00:00', '16:00:00'),
       (7, '2023-05-04', '15:00:00', '23:00:00');
       
INSERT INTO order1_item (order1_id, item_id, quantity)
VALUES (22, 4, 2),
	   (23, 2, 2),
       (24, 1, 2),
       (25, 14, 3),
       (26, 1, 2),
       (27, 7, 4),
       (28, 8, 2);
       
DROP TRIGGER if exists item_insert_trigger;
delimiter |
CREATE TRIGGER item_insert_trigger BEFORE INSERT ON item
FOR EACH ROW
BEGIN
IF NEW.weight < 1 THEN
    SIGNAL SQLSTATE '45000'  SET MESSAGE_TEXT = 'Invalid weight value';
  END IF;
END ;
|
delimiter ;

INSERT INTO item (item_name, item_type, main_ingredient, item_price, allergens, weight)
VALUES ('Test Item', 'Main', 'Beef', 10.99, 'None', -1.5);


DELIMITER //

CREATE PROCEDURE get_order_details(IN order1_id_param INT)
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE item_name VARCHAR(255);
  DECLARE item_quantity INT;
  
  -- declare cursor to get items for the order
  DECLARE cur1 CURSOR FOR
    SELECT i.item_name, oi.quantity
    FROM item i
    JOIN order1_item oi ON oi.item_id = i.item_id
    WHERE oi.order1_id = order1_id_param;
  
  -- declare handlers for the cursor
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  
  OPEN cur1;
  
  get_items: LOOP
    FETCH cur1 INTO item_name, item_quantity;
    IF done THEN
      LEAVE get_items;
    END IF;
    
    SELECT CONCAT(item_quantity, ' x ', item_name) AS item_details;
  END LOOP;
  
  CLOSE cur1;
END //

DELIMITER ;

CALL get_order_details(22);


CALL get_order_details(23);
