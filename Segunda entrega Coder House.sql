CREATE TABLE clientes(
cliente_id SERIAL PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
email VARCHAR(50) NOT NULL UNIQUE,
edad INT CONSTRAINT chk_edad_minima CHECK (edad >=18)
);

CREATE TABLE productos(
producto_id SERIAL PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
precio DECIMAL(10,2) CONSTRAINT chk_precio_minimo CHECK (precio > 0),
stock INT CONSTRAINT chk_stock_minimo CHECK (stock >=0)
);

CREATE TABLE ventas(
cliente_id INT,
producto_id INT,
PRIMARY KEY (cliente_id, producto_id),
FOREIGN KEY (cliente_id) REFERENCES clientes (cliente_id) ON DELETE RESTRICT,
FOREIGN KEY (producto_id) REFERENCES productos (producto_id) ON DELETE RESTRICT,
cantidad INT CONSTRAINT chk_cantidad_minima CHECK (cantidad >0),
fecha DATE NOT NULL
);

BEGIN;

INSERT INTO clientes (nombre, email, edad)
VALUES
('Franco Iglesias', 'fran12@hotmail.com', 19),
('Juana Romero', 'juanirom@gmail.com', 22),
('Luz Olivera', 'luzzz@yahoo.com.ar', 19),
('Tomas Dominico', 'tomdom@gmail.com', 25),
('Susana Fabela', 'susanaf@hotmail.com', 30);

INSERT INTO productos (nombre, precio, stock)
VALUES
('Cerveza', 3000.00, 100),
('Vino', 4500.00, 80),
('Vodka', 6000.00, 120),
('Ron', 5800.00, 75),
('Tequila', 9000.00, 60),
('Producto prueba', 10000.00, 50);

INSERT INTO ventas (cliente_id, producto_id, cantidad, fecha)
VALUES
(1, 3, 3, '2026-10-05'),
(2, 1, 12, '2026-09-04'),
(3,  4, 2, '2026-05-03'),
(4, 2, 3, '2026-09-03'),
(5, 5, 1, '2026-10-06');

COMMIT;

UPDATE productos
SET precio = precio * 1.10
WHERE precio < 5000;

DELETE FROM productos
WHERE nombre = 'Producto prueba';