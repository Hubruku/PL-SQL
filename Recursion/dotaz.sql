WITH Vydry(cv, jmeno, pohlavi, matka, otec, cesta) AS
        (
        SELECT  v.cv, v.jmeno, v.pohlavi, v.matka, v.otec, v.jmeno
        FROM    vydra v
        WHERE v.pohlavi = 'M'

        UNION ALL

        SELECT v2.cv, v2.jmeno, v2.pohlavi, v2.matka, v2.otec, CTE.cesta || ' -> Jeho otcem je ' || v2.jmeno
        FROM vydra v2 INNER JOIN Vydry CTE ON (CTE.otec = v2.cv)
        )
SELECT cesta FROM vydry WHERE cesta LIKE '%->%' ;

--REKURZE PRO MUZSKE POHLAVI