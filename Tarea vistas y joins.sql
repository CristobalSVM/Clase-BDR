CREATE SCHEMA MCD

---CREACION DE VISTAS
CREATE VIEW mcd.cheques AS
SELECT fecha, cliente_ide, fecha_alta, estado, actividad_economica,producto,tipo_empresa,sum(saldo) as saldo
FROM ccl.opcheques
WHERE fecha = '20220930'
GROUP BY fecha, cliente_ide, fecha_alta, estado, actividad_economica,producto,tipo_empresa
ORDER BY saldo desc
LIMIT 100000


CREATE VIEW mcd.inversiones AS
SELECT fecha, cliente_ide, fecha_alta, estado, actividad_economica,producto,tipo_empresa,sum(saldo_cuenta+saldo_intereses) as saldo
FROM ccl.opinversiones
WHERE fecha = '20220930'
GROUP BY fecha, cliente_ide, fecha_alta, estado, actividad_economica,producto,tipo_empresa
ORDER BY saldo desc
LIMIT 100000

--CONSULTAS CON JOINS
--LEFT JOIN
 SELECT A.cliente_ide AS clienteide_cheques, B.cliente_ide AS clienteide_inversiones, 
                    SUM(A.saldo) AS monto_cheques, SUM(B.saldo) AS monto_inversiones
        FROM mcd.cheques AS A
LEFT JOIN mcd.inversiones AS B ON A.fecha = B.fecha AND A.cliente_ide = B.cliente_ide 
GROUP BY A.cliente_ide, B.cliente_ide
ORDER BY A.cliente_ide, monto_cheques

--RIGHT JOIN
SELECT A.cliente_ide AS clienteide_cheques, B.cliente_ide AS clienteide_inversiones, 
                    SUM(A.saldo) AS monto_cheques, SUM(B.saldo) AS monto_inversiones
        FROM mcd.cheques AS A
RIGHT JOIN mcd.inversiones AS B ON A.fecha = B.fecha AND A.cliente_ide = B.cliente_ide 
GROUP BY A.cliente_ide, B.cliente_ide
ORDER BY A.cliente_ide, monto_cheques


--INNER JOIN
 SELECT A.cliente_ide, SUM(A.saldo) AS monto_cheques, SUM(B.saldo) AS monto_inversiones
          FROM mcd.cheques AS A
INNER JOIN mcd.inversiones AS B ON A.fecha = B.fecha AND A.cliente_ide = B.cliente_ide 
 GROUP BY A.cliente_ide
 ORDER BY A.cliente_ide

--UNION

SELECT fecha, cliente_ide, fecha_alta, estado, actividad_economica,producto,tipo_empresa, sum(saldo) as saldo,'Cheques' as fuente
FROM mcd.cheques
GROUP BY fecha, cliente_ide, fecha_alta, estado, actividad_economica,producto,tipo_empresa

UNION 

SELECT fecha, cliente_ide, fecha_alta, estado, actividad_economica,producto,tipo_empresa, sum(saldo) as saldo, 'Inversiones' as fuente
FROM mcd.inversiones
GROUP BY fecha, cliente_ide, fecha_alta, estado, actividad_economica,producto,tipo_empresa
ORDER BY saldo desc
LIMIT 100

--SUBCONSULTA
SELECT fecha, cliente_ide, actividad_economica,tipo_empresa, sum(A.saldo) as saldo
FROM(
	SELECT fecha, cliente_ide, fecha_alta, estado, actividad_economica,producto,tipo_empresa, sum(saldo) as saldo,'Cheques' as fuente
	FROM mcd.cheques
	GROUP BY fecha, cliente_ide, fecha_alta, estado, actividad_economica,producto,tipo_empresa

	UNION 

	SELECT fecha, cliente_ide, fecha_alta, estado, actividad_economica,producto,tipo_empresa, sum(saldo) as saldo, 'Inversiones' as fuente
	FROM mcd.inversiones
	GROUP BY fecha, cliente_ide, fecha_alta, estado, actividad_economica,producto,tipo_empresa
	ORDER BY saldo desc
	LIMIT 100
     ) as A
WHERE tipo_empresa in ('F','G')
GROUP BY fecha, cliente_ide, actividad_economica,tipo_empresa
ORDER BY saldo desc

--TRIGGGER
SELECT fecha, cliente_ide, fecha_alta, estado, actividad_economica,producto,tipo_empresa,sum(saldo) as saldo

CREATE TABLE clientes_nuevos (fecha_alta date,
			      cliente_ide varchar (10),
			      saldo numeric)

CREATE TRIGGER cheques_historico
AFTER INSERT 
ON mcd.cheques FOR EACH ROW
BEGIN

	IF saldo < 0 THEN
	INSERT INTO clientes_nuevos(fecha_alta, cliente_ide, saldo)
	VALUES ('20220930','00000000',0)
	ELSE
	VALUES ('20220930','00000000',saldo)

END;$$


INSERT INTO mcd.cheques VALUES ('20220930','12312312','20220930','NUEVO LEON', 'GOBIERNO', 'CHEQUES SIN INTERESES','G',3500000)




