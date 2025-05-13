-- CRIAÇÃO DAS TABELAS

CREATE TABLE Municipios_Brasileiros(
Cidade NVARCHAR(50) NOT NULL,
Estado NVARCHAR(2) NOT NULL,
Regiao NVARCHAR(20) NOT NULL,
Municipio_ID INTEGER PRIMARY KEY AUTOINCREMENT
)

CREATE TABLE Municipio_Status (
    status_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    populacao_residente INTEGER NOT NULL,
    IDHM_rank INTEGER NOT NULL,
    educacao INTEGER NOT NULL,
    renda INTEGER NOT NULL,
    municipio_ID INTEGER NOT NULL,
    CONSTRAINT fk_municipio FOREIGN KEY (municipio_ID) REFERENCES Municipios_Brasileiros(municipio_ID)
);

CREATE TABLE Gerencia_Regiao (
    gerencia_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Regiao TEXT(10) NOT NULL,
    pessoas_brancas INTEGER NOT NULL,
    pessoas_pretas_pardas INTEGER NOT NULL,
    gerencia_branca INTEGER NOT NULL,
    gerencia_preta_parda INTEGER NOT NULL,
    CONSTRAINT fk_regiao FOREIGN KEY (Regiao) REFERENCES Municipios_Brasileiros(Regiao)
);

-- INSERINDO DADOS NAS TABELAS
INSERT INTO Gerencia_Regiao (regiao, 
pessoas_brancas, 
pessoas_pretas_pardas, 
gerencia_branca, 
gerencia_preta_parda) VALUES
('Norte', 1480, 6367, 43, 78),
('Nordeste', 5418, 16211, 146, 179),
('Sudeste', 22265, 20783, 928, 371 ),
('Sul', 11298, 3945, 421, 49),
('Centro-Oeste', 2888, 5274, 104, 95 );

-- ALTERAR TABELA

ALTER TABLE Municipios_Brasileiros ADD COLUMN pais;

-- ATUALIZAÇÃO DE TABELA

UPDATE Municipios_Brasileiros SET pais='Brasil';

-- EXCLUINDO UMA COLUNA

ALTER TABLE Municipios_Brasileiros  DROP COLUMN pais

-- FILTRANDO INFORMAÇÕES

SELECT * FROM Municipios_Brasileiros WHERE Cidade='Itaquaquecetuba' 

SELECT * FROM Municipios_Brasileiros WHERE Cidade LIKE'Itaqua%'

SELECT * FROM Municipio_Status WHERE populacao_residente>50000

-- JUNÇÃO DE TABELAS:
SELECT municipios_brasileiros.Cidade, Municipios_Status.populacao_residente 
FROM municipios_brasileiros  
INNER JOIN Municipios_Status ON municipios_brasileiros.municipio_ID = Municipios_Status.municipio_ID;

-- AGRUPAMENTO 
    -- QUANTIDADE DE CIDADES POR ESTADOS
SELECT Estado, COUNT(Cidade) FROM municipios_brasileiros  GROUP BY Estado ORDER BY 2 DESC ;

-- SOMA

SELECT SUM(pessoas_brancas), SUM(pessoas_pretas_pardas) FROM Gerencia_Regiao

-- MÁXIMO
SELECT Regiao, MAX(pessoas_pretas_pardas) FROM Gerencia_Regiao

-- FILTRO DAS REGIÕES COM GERENCIA BRANCA MAIOR QUE GERENCIA PRETA E PARDA
SELECT Regiao FROM Gerencia_Regiao WHERE gerencia_branca > gerencia_preta_parda

-- somar a população total de um estado e ordenar pelo estado com menor população
SELECT Municipios_Brasileiros.Estado, SUM(Municipios_Status.populacao_residente) AS Populacao FROM Municipios_Brasileiros
INNER JOIN Municipios_Status ON Municipios_Brasileiros.Municipio_ID = Municipios_Status.Municipio_ID
GROUP BY Municipios_Brasileiros.Estado
ORDER BY Populacao ASC;