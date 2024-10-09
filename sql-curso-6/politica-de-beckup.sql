--REALIZAÇÃO DA POLÍTICA DE BECKUP

SELECT DISTINCT [data] FROM tb_nota order by [data] DESC
-- 2022-03-02
-- tabela de controle
CREATE TABLE tb_controle_backups 
(ID INTEGER, NOME VARCHAR(100), NUMERO NOTAS INTEGER);

-- 1 DA MANHA - FULL (DATABASE WITH INT)
-- incluindo dados
EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS = COUNT(*) FROM tb_nota; 
INSERT INTO tb_controle_backups VALUES (1, 'BACKUP FULL 1 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups
-- fazendo beckup full
BACKUP DATABASE dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH INIT;

-- 4 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)
-- incluindo dados incremental
EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS = COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (2, 'BACKUP INCREMENTAL 4 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups
-- fazendo beckup incremental
BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

-- 6 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)
-- incluindo dados
EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (3, 'BACKUP INCREMENTAL 6 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups
-- fazendo beckup incremental
BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

-- 8 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)
-- incluindo dados
EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (4, 'BACKUP INCREMENTAL 8 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups
-- fazendo beckup incremental
BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

-- 9 DA MANHÃ - FULL (DATABASE WITH DIFFERENTIAL)
-- incluindo dados
EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (5, 'BACKUP DIFFERENTIAL 9 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups 
-- fazendo beckup (full diferencial)
BACKUP DATABASE dbVendas TO DISK = 'D:\DATA\BACKUP \POLITICA_BACKUP_20220302.BAK' WITH DIFFERENTIAL;

-- 10 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)
-- incluindo dados
EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota; 
INSERT INTO tb_controle_backups VALUES (6, 'BACKUP INCREMENTAL 10 AM', @NUM_NOTAS); SELECT * FROM tb_controle_backups
-- fazendo beckup incremental
BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

-- 12 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)
-- incluindo dados
EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (7, 'BACKUP INCREMENTAL 12 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups 
-- fazendo beckup incremental
BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

-- 2 DA TARDE - INCREMENTAL (LOG WITH NOINT)
-- incluindo dados
EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (8, 'BACKUP INCREMENTAL 2 PM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups
-- fazendo beckup incremental
BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA BACKUP 20220302.BAK' WITH NOINIT:

-- 2 DA TARDE - FULL (DATABASE WITH DIFFERENTIAL)
EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota; 
INSERT INTO tb_controle_backups VALUES (9, 'BACKUP DIFFERENTIAL 2 PM', @NUM_NOTAS); SELECT * FROM tb_controle_backups
BACKUP DATABASE dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH DIFFERENTIAL;

-- 3 DA TARDE - INCREMENTAL (LOG WITH NOINT)
EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS = COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (10, 'BACKUP INCREMENTAL 3 PM', @NUM_NOTAS); 
SELECT * FROM tb_controle_backups
BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

-- 5 DA TARDE - INCREMENTAL (LOG WITH NOINT)
EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (11, 'BACKUP INCREMENTAL 5 PM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups 
BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

-- 7 DA NOITE - INCREMENTAL (LOG WITH NOINT)
EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (12, 'BACKUP INCREMENTAL 7 PM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups
BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

-- 9 DA TARDE - INCREMENTAL (LOG WITH NOINT)
-- incluindo dados
EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (13, 'BACKUP INCREMENTAL 9 PM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups
-- fazendo beckup incremental
BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

------------
-- RESTAURANDO OS BECKUPS DE 17:30h 
SELECT * FROM tb_controle_backups;

RESTORE HEADERONLY FROM DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK';

USE MASTER;
ALTER DATABASE dbVendas SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE dbVendas;

-- beckup full do dia, o NORECOVERY indica que há ainda beckups a ser restaurados
RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 1, NORECOVERY;

-- beckup diferencial mais próximo das 17:30h
RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 9, NORECOVERY;

-- beckups incrementais depois do beckup diferencial mais próximo das 17:30h
RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 10, NORECOVERY;
-- por ser o último beckup, deve usar o RECOVERY, sinalizando que já foi recuperado todos os dados até 17:30h
RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 11, RECOVERY;


-----------------------------------------------------------------------------------------------
/*
descrição dos comando acima na íntegra

Implementando a política de backup

No Management Studio, temos um nota comentada na área de consultas lembrando da política de backup que precisamos implementar:

-- 1 DA MANHA - FULL (DATABASE WITH INT)
-- 4 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)
-- 6 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)
-- 8 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)
-- 9 DA MANHÃ - FULL (DATABASE WITH DIFFERENTIAL)
-- 10 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)
-- 12 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)
-- 2 DA TARDE - INCREMENTAL (LOG WITH NOINT)
-- 2 DA TARDE - FULL (DATABASE WITH DIFFERENTIAL)
-- 3 DA TARDE - INCREMENTAL (LOG WITH NOINT)
-- 5 DA TARDE - INCREMENTAL (LOG WITH NOINT)
-- 7 DA NOITE - INCREMENTAL (LOG WITH NOINT)
-- 9 DA NOITE - INCREMENTAL (LOG WITH NOINT)

A fim de acompanhar o progresso do backup, iremos verificar na base de dados as datas das notas fiscais disponíveis, 
usando o seguinte comando na área de montar as consultas acima da nota:

SELECT DISTINCT [data] FROM tb_nota order by [data] DESC

Para executar a query, selecionamos o código completo e clicamos no botão "Executar" localizado na parte superior 
esquerda do Management Studio.

É possível que o seu resultado obtido após a execução da query seja diferente do resultado obtido pelo instrutor.

Como retorno, obtemos:

A tabela abaixo foi parcialmente transcrita. Para conferi-la na íntegra, execute o código na sua máquina.

#	data
1	2022-03-01
2	2021-01-31
3	2022-01-30
4	2022-01-29
5	2022-01-28
A última data registrada nas notas fiscais disponíveis é "2022-03-01". Portanto, vamos supor que estejamos 
realizando o backup no dia "2022-03-02", ou seja, um dia após a última data obtida na consulta que fizemos na 
base de dados. Após o select, podemos comentar a data usando a seguinte sintaxe: -- 2022-03-02.

SELECT DISTINCT [data] FROM tb_nota order by [data] DESC

-- 2022-03-02

Também vamos criar uma tabela chamada tb_controle_backups usando o comando CREATE TABLE:

CREATE TABLE tb_controle_backups 
(ID INTEGER, NOME VARCHAR(100), NUMERO NOTAS INTEGER);

Nessa tabela, a cada backup realizado, registramos uma informação para ter um controle interno de todos os
backups gerados. Essa prática nos permite analisar o conteúdo dessa tabela ao recuperarmos o backup, garantindo 
que tenhamos realizado a recuperação corretamente.

Ao executarmos o comando de criação da tabela, obtemos:

Comando concluído com êxito

Até o momento, temos os seguintes comandos e comentários na nossa área de consulta:

SELECT DISTINCT [data] FROM tb_nota order by [data] DESC

-- 2022-03-02

CREATE TABLE tb_controle_backups 
(ID INTEGER, NOME VARCHAR(100), NUMERO NOTAS INTEGER);

-- 1 DA MANHA - FULL (DATABASE WITH INT)
-- 4 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)
-- 6 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)
-- 8 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)
-- 9 DA MANHÃ - FULL (DATABASE WITH DIFFERENTIAL)
-- 10 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)
-- 12 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)
-- 2 DA TARDE - INCREMENTAL (LOG WITH NOINT)
-- 2 DA TARDE - FULL (DATABASE WITH DIFFERENTIAL)
-- 3 DA TARDE - INCREMENTAL (LOG WITH NOINT)
-- 5 DA TARDE - INCREMENTAL (LOG WITH NOINT)
-- 7 DA NOITE - INCREMENTAL (LOG WITH NOINT)
-- 9 DA NOITE - INCREMENTAL (LOG WITH NOINT)

Os seguintes comandos serão executados sempre que ocorrer um backup:

Neste momento, o instrutor insere os seguintes comandos abaixo da linha do lembrete: -- 1 DA MANHA - FULL (DATABASE WITH INT).

-- 1 DA MANHA - FULL (DATABASE WITH INT)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS = COUNT(*) FROM tb_nota; 
INSERT INTO tb_controle_backups VALUES (1, 'BACKUP FULL 1 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups

No dia 02/03/2022, na primeira linha do trecho de comandos, estamos inserindo algumas notas fiscais. 
Em seguida, gravamos na tabela tb_controle_backups um contador com o valor "1" para representar o 
primeiro backup do dia.

No segundo parâmetro do VALUES, registramos o valor 'BACKUP FULL 1 AM', indicando que se trata do primeiro 
backup full completo realizado pela manhã. Por fim, gravamos o número de notas (@NUM_NOTAS) que será obtido 
através da consulta SELECT @NUM_NOTAS = COUNT(*) FROM tb_nota;.

É importante observar que o número de notas resultante será maior do que o obtido anteriormente, pois antes 
executamos o comando IncluiNotasDia, o qual adicionou novas notas à tabela.

Por fim, selecionamos tudo da tabela tb_controle_backups para visualizarmos o conteúdo completo.

Para executar a consulta completa e gerar as notas do dia 02/03/2022, selecionamos todos os comandos e 
clicamos no botão "Executar".

Como retorno, obtemos:

ID	NOME	NUMERO_NOTAS
1	BACKUP FULL 1AM	3453
Portanto, antes do backup full temos 3453 notas fiscais. Para gerarmos o primeiro backup full, usamos o seguinte comando:

Explique o que o seguite comando faz:

BACKUP DATABASE dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH INIT;

Trata-se de um backup do nosso banco de dados (backup database), onde realizamos o backup completo da base de dados 
denominada dbVendas. Em seguida, utilizamos o comando TO DISK para definir que o backup será armazenado em um arquivo
de disco, especificando o caminho e o nome do diretório onde será salvo.

Por fim, utilizamos o comando WITH INIT para indicar que neste arquivo está sendo realizado o nosso primeiro backup 
inicial, marcando o início da nossa política de backup.

Em suma, o comando acima faz um backup completo do banco de dados dbVendas e salva-o no arquivo especificado, 
substituindo qualquer backup anterior.

Rodamos o comando selecionando-o e clicando em "Executar". Como retorno, obtemos que foi gerado com sucesso:

Processed 1168 pages for database 'dbVendas', file 'dbVendas' on file 1.

Processed 1 page for database 'dbVendas', file 'dbVendas LOG' on file 1.

BACKUP DATABASE successfully processed 1169 pages in 0.036 seconds (253.512 MB/sec).

Horário de conclusão: 2023-05-07T19:31:05.3396513-03:00

Ao analisarmos no diretório de backups na nossa máquina, temos o arquivo POLITICA_BACKUP_20220302.BAK salvo.
Observem que consta a data que começamos a política de backup.

Voltando ao SQL Server Management, abaixo da linha comentada com o backup incremental gerado às 4h da manhã 
inserirmos os seguintes comandos:

-- 4 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS = COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (2, 'BACKUP INCREMENTAL 4 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups

BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

No procedimento EXEC IncluiNotasDia, criamos notas fiscais na data especificada. Nesse caso, simulamos a 
inclusão dessas notas fiscais na base de dados entre 1h da manhã e 4h da manhã.

Em seguida, realizamos novamente o processo anterior, contabilizando o número de notas fiscais. No entanto, 
dessa vez, adicionamos o número 2 com um label para indicar que se trata do backup incremental realizado
às 4h da manhã. O valor @NUM_NOTAS é inserido como último parâmetro de VALUES para representar a quantidade 
de notas fiscais.

Executamos a primeira parte do comando selecionando até SELECT * FROM tb_controle_backups e clicando
em "Executar". Como retorno, obtemos:

ID	NOME	NUMERO_NOTAS
1	BACKUP FULL 1AM	3453
2	BACKUP INCREMENTAL 4AM	3596
Observem que às 4h da manhã o número de notas fiscais é de 3596, às 1h tínhamos 3453.

Para gerar o backup incremental, usamos a última linha de comando:

BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

Observem que não se trata mais de um tipo de banco de dados (database), mas sim de um log. Em seguida, 
faremos referência ao mesmo arquivo de backup em que salvamos o inicial, usando a cláusula WITH NOINIT. 
Dentro do arquivo BAK, teremos todas as políticas de backups uma após a outra, não em arquivos separados.

Vamos rodar essa última linha selecionando-a e clicando em "Executar". Como retorno, obtemos a seguinte 
mensagem de sucesso:

Processed 633 pages for database 'dbVendas', file 'dbVendas LOG' on file 2.

BACKUP LOG successfully processed 633 pages in 0.017 seconds (290.613 MB/sec).

Horário de conclusão: 2023-05-07T19:33:55.7746761-03:00

Ao analisarmos o arquivo POLITICA_BACKUP_20220302.BAK em nossa máquina, notamos que ele cresceu um pouco e 
agora possui um tamanho de 15.524KB. Isso ocorre porque o arquivo salva apenas as diferenças entre um backup e outro.

Já os backups de 6h e 8h da manhã serão iguais, a única diferença serão os labels:

-- 6 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (3, 'BACKUP INCREMENTAL 6 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups

BACKUP LOG dbVendas TO DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

No backup realizado às 6h da manhã, criamos algumas notas fiscais no dia 02/03 e as gravamos como backup 
de número 3 com a label "BACKUP INCREMENTAL 6 AM". Em seguida, geramos um backup do tipo log no mesmo arquivo BAK.

Vamos rodar a primeira parte do comando que gera as notas fiscais (até SELECT * FROM tb_controle_backups). Obtemos:

ID	NOME	NUMERO_NOTAS
1	BACKUP FULL 1AM	3453
2	BACKUP INCREMENTAL 4AM	3596
3	BACKUP INCREMENTAL 6AM	3708

Agora temos 3708 notas fiscais, e vamos gerar um novo backup incremental selecionando a última linha do comando.
Assim, obtemos uma mensagem de sucesso.

Repetiremos o mesmo processo para o backup incremental das 8h da manhã.

-- 8 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (4, 'BACKUP INCREMENTAL 8 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups

BACKUP LOG dbVendas TO DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

Rodando a primeira parte do comando de geração de novas notas fiscais, obtemos a tabela:

ID	NOME	NUMERO_NOTAS
1	BACKUP FULL 1AM	3453
2	BACKUP INCREMENTAL 4AM	3596
3	BACKUP INCREMENTAL 6AM	3708
4	BACKUP INCREMENTAL 8 AM	3792
E na sequência geramos o backup incremental, obteremos a mesma mensagem de sucesso.

Próximos passos
Chegamos ao horário de 9h da manhã e é o momento de gerar um novo backup completo (full). No entanto, a forma 
como iremos gerar esse backup completo, que ocorre no meio do dia, será diferente da forma como geramos o backup 
inicial. Utilizaremos uma cláusula diferente da WITH INIT.

-------------------------------------
Backup Differential

No SQL Server Management, abaixo do comentário do backup full das 9h da manhã, inserimos os seguintes comandos:

-- 9 DA MANHÃ - FULL (DATABASE WITH DIFFERENTIAL)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (5, 'BACKUP DIFFERENTIAL 9 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups 

BACKUP DATABASE dbVendas TO DISK = 'D:\DATA\BACKUP \POLITICA_BACKUP_20220302.BAK' WITH DIFFERENTIAL;

Novamente, geramos novas notas fiscais. A única diferença é o comando utilizado para gerar o backup completo. 
Utilizamos o backup database referenciando o mesmo arquivo, e na cláusula final usamos WITH DIFFERENTIAL.

Lembrando que no arquivo POLITICA_BACKUP_20220302 é necessário ter todas as políticas de backups do dia. 
Se gerarmos um backup init às 9h, tudo o que foi gerado anteriormente será removido. No entanto, no caso 
em questão, temos um novo backup completo no meio do dia, às 9h da manhã.

Vamos executar a parte de geração de notas fiscais. Como retorno temos:

ID	NOME	NUMERO_NOTAS
1	BACKUP FULL 1AM	3453
2	BACKUP INCREMENTAL 4AM	3596
3	BACKUP INCREMENTAL 6AM	3708
4	BACKUP INCREMENTAL 8 AM	3792
5	BACKUP DIFFERENTIAL 9 AM	3893
Agora, temos 3893 notas fiscais. Vamos gerar o backup rodando a segunda parte do código. O retorno será uma
mensagem informando que foi gerado com sucesso.

Com isso, sabemos gerar todos os backups daqui em diante. Às 10h, 12h e 14h da tarde são backups 
incrementais LOG WITH NOINT. Já às 14h da tarde, vamos gerar um novo backup differential, 
e entre 15h, 17h, 19h e 21h geraremos backups incrementais LOG WITH NOINT.

Os comandos abaixo foram parcialmente transcritos. Para conferi-los na íntegra, por favor, 
consulte a atividade desta aula para copiar todos os comandos.

-- 10 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota; 
INSERT INTO tb_controle_backups VALUES (6, 'BACKUP INCREMENTAL 10 AM', @NUM_NOTAS); SELECT * FROM tb_controle_backups

BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

// comanos omitidos

-- 9 DA TARDE - INCREMENTAL (LOG WITH NOINT)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (13, 'BACKUP INCREMENTAL 9 PM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups

BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

Vamos primeiro gerar as notas fiscais das 10h da manhã executando a primeira parte do comando. Obtemos:

ID	NOME	NUMERO_NOTAS
1	BACKUP FULL 1AM	3453
2	BACKUP INCREMENTAL 4AM	3596
3	BACKUP INCREMENTAL 6AM	3708
4	BACKUP INCREMENTAL 8 AM	3792
5	BACKUP DIFFERENTIAL 9 AM	3893
6	BACKUP INCREMENTAL 10 AM	3958
Em seguida, iremos gerar o backup incremental selecionando o comando e clicando em "Executar". 
Por ser incremental, ele é do tipo log e utiliza a cláusula WITH NOINIT. Obtemos a mensagem de sucesso:

Processed 379 pages for database 'dbVendas, file 'dbVendas LOG' on file 6.

BACKUP LOG successfully processed 379 pages in 0.011 seconds (268.554 MB/sec).

Horário de conclusão: 2023-05-07T19:50:06.0472465-03:00

No backup das 12h, faremos o mesmo processo.

-- 12 DA MANHÃ - INCREMENTAL (LOG WITH NOINT)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (7, 'BACKUP INCREMENTAL 12 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups 

BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

Executamos primeiro a geração de notas fiscais, e vamos ter mais uma linha na tabela de notas fiscais geradas:

ID	NOME	NUMERO_NOTAS
1	BACKUP FULL 1AM	3453
2	BACKUP INCREMENTAL 4AM	3596
3	BACKUP INCREMENTAL 6AM	3708
4	BACKUP INCREMENTAL 8 AM	3792
5	BACKUP DIFFERENTIAL 9 AM	3893
6	BACKUP INCREMENTAL 10 AM	3958
Na sequência, geramos um novo backup incremental. Obtemos a mensagem de sucesso vista anteriormente.

Prosseguindo, às 14h teremos um novo backup incremental:

-- 2 DA TARDE - INCREMENTAL (LOG WITH NOINT)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (8, 'BACKUP INCREMENTAL 2 PM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups

BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA BACKUP 20220302.BAK' WITH NOINIT:

Mais uma vez, executamos a geração de notas fiscais, o que adicionará mais uma linha à nossa tabela:

ID	NOME	NUMERO_NOTAS
1	BACKUP FULL 1AM	3453
2	BACKUP INCREMENTAL 4AM	3596
3	BACKUP INCREMENTAL 6AM	3708
4	BACKUP INCREMENTAL 8 AM	3792
5	BACKUP DIFFERENTIAL 9 AM	3893
6	BACKUP INCREMENTAL 10 AM	3958
E agora executamos o backup incremental em si e obtemos a mensagem de sucesso.

Continuando, às 14h teremos mais um backup differential:

-- 2 DA TARDE - FULL (DATABASE WITH DIFFERENTIAL)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota; 
INSERT INTO tb_controle_backups VALUES (9, 'BACKUP DIFFERENTIAL 2 PM', @NUM_NOTAS); SELECT * FROM tb_controle_backups

BACKUP DATABASE dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH DIFFERENTIAL;

Rodando a geração de notas fiscais, temos:

ID	NOME	NUMERO_NOTAS
1	BACKUP FULL 1AM	3453
2	BACKUP INCREMENTAL 4AM	3596
3	BACKUP INCREMENTAL 6AM	3708
4	BACKUP INCREMENTAL 8 AM	3792
5	BACKUP DIFFERENTIAL 9 AM	3893
6	BACKUP INCREMENTAL 10 AM	3958
7	BACKUP INCREMENTAL 12 AM	4036
8	BACKUP INCREMENTAL 2 PM	4151
9	BACKUP DIFFERENTIAL 2 PM	4229
Agora, geramos o backup full e obtemos a mensagem de sucesso.

Às 15h, temos outro backup incremental e vamos rodar a geração de notas fiscais e posteriormente o 
backup em si. Faremos o mesmo processo para o backup de 17h, 19h e 21h.

Lembre-se de sempre gerar primeiro as notas fiscais e posteriormente o backup em si.

-- 3 DA TARDE - INCREMENTAL (LOG WITH NOINT)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS = COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (10, 'BACKUP INCREMENTAL 3 PM', @NUM_NOTAS); 
SELECT * FROM tb_controle_backups

BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

Para o backup incremental das 17h, rodamos:

-- 5 DA TARDE - INCREMENTAL (LOG WITH NOINT)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (11, 'BACKUP INCREMENTAL 5 PM, @NUM_NOTAS);
SELECT * FROM tb_controle_backups 

BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

Para o backup incremental das 19h, rodamos:

-- 7 DA NOITE - INCREMENTAL (LOG WITH NOINT)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (12, 'BACKUP INCREMENTAL 7 PM, @NUM_NOTAS);
SELECT * FROM tb_controle_backups

BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP POLITICA_BACKUP_20220302.BAK' WITH NOINIT;
Copiar código
Para o backup incremental das 19h, rodamos (o último incremental do dia):

-- 9 DA NOITE - INCREMENTAL (LOG WITH NOINT)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS = COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (13, 'BACKUP INCREMENTAL 9 PM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups

BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

A nossa tabela final terá 13 linhas. Para visualizá-la, executando o comando SELECT:

SELECT * FROM tb_controle_backups

Como retorno, temos:

ID	NOME	NUMERO_NOTAS
1	BACKUP FULL 1AM	3453
2	BACKUP INCREMENTAL 4AM	3596
3	BACKUP INCREMENTAL 6AM	3708
4	BACKUP INCREMENTAL 8 AM	3792
5	BACKUP DIFFERENTIAL 9 AM	3893
6	BACKUP INCREMENTAL 10 AM	3958
7	BACKUP INCREMENTAL 12 AM	4036
8	BACKUP INCREMENTAL 2 PM	4151
9	BACKUP DIFFERENTIAL 2 PM	4229
10	BACKUP INCREMENTAL 3 PM	4361
11	BACKUP INCREMENTAL 5 PM	4494
12	BACKUP INCREMENTAL 7 PM	4581
13	BACKUP INCREMENTAL 9 PM	4716
Iniciamos com um backup completo às 1h da manhã, no qual tínhamos 3453 notas fiscais. Em seguida, realizamos 
três backups incrementais e o número de notas fiscais foi aumentando. Posteriormente, fizemos o backup diferencial, 
que foi um backup completo realizado no meio do dia.

Em seguida, mais três backups incrementais foram realizados, seguidos por outro backup diferencial às 14h. 
Por fim, realizamos mais quatro backups incrementais, sendo do período das 15h às 21h.

Analisando o arquivo final em nossa máquina, temos um tamanho de 44.848KB. O arquivo POLITICA_BACKUP_20220302 é o 
arquivo da política de backup do dia 02/03/2022. Ao final do dia, é importante que o Marcos armazene esse arquivo 
para que possa ser utilizado caso haja a necessidade de recuperar alguma informação perdida durante o dia.

--------------------------------
RECUPERANDO UM BECUKP

Vamos a um problema: após a implementação no dia dois de março, a pessoa usuária abre um chamado para recuperar o 
backup das cinco e meia da tarde. 17:30h

Não temos um backup por minuto, então se precisamos recuperar de cinco e meia da tarde, precisaremos ver tudo o 
que aconteceu antes para entendermos quais são os FULL, diferenciais e incrementais que temos para trazer o estado 
da base de dados o mais próximo possível do horário determinado.

Primeiro, teremos que recuperar o backup FULL, depois teremos que pegar o diferencial mais próximo do horário em 
que devemos recuperar o backup.

Em nosso caso, é o nono backup das duas horas da tarde. Logo, quando recuperarmos este (9), todos os anteriores 
serão dispensados.

Depois, precisaremos recuperar os incrementais de duas às três da tarde, e das três da tarde até às cinco da tarde.

Não precisaremos recuperar o backup feito entre cinco e sete da noite, pois sua base de dados está após as cinco e 
meia da tarde. Portanto, temos que recuperar os backups (9) e (11).

Mas para recuperarmos o estado deste horário, teremos que recuperar o FULL que é o backup (1), depois o primeiro 
diferencial e depois os dois incrementais seguintes.

Iremos recuperar o backup de cinco e meia da tarde, baseado no que foi implementado na Política de Backup.

Abrindo o Management Studio, criaremos uma nova consulta. Primeiro, veremos como está a tabela de controle de backups.

SELECT * FROM tb_controle_backups

Como retorno, teremos:

ID	NOME	NUMERO_NOTAS
1	BACKUP FULL 1AM	3453
2	BACKUP INCREMENTAL 4AM	3596
3	BACKUP INCREMENTAL 6AM	3708
4	BACKUP INCREMENTAL 8 AM	3792
5	BACKUP DIFFERENTIAL 9 AM	3893
6	BACKUP INCREMENTAL 10 AM	3958
7	BACKUP INCREMENTAL 12 AM	4036
8	BACKUP INCREMENTAL 2 PM	4151
9	BACKUP DIFFERENTIAL 2 PM	4229
10	BACKUP INCREMENTAL 3 PM	4361
11	BACKUP INCREMENTAL 5 PM	4494
12	BACKUP INCREMENTAL 7 PM	4581
13	BACKUP INCREMENTAL 9 PM	4716
Ou seja, já temos treze backups extraídos durante a aplicação da Política.

Para recuperarmos o backup das cinco e meia da tarde, temos que recuperar os seguintes backups que já falamos 
anteriormente: o FULL da uma da manhã, (1), o diferencial (9), e os incrementais (10) e (11).

Essa numeração foi obtida através do controle que fizemos na coluna de ID, mas não precisávamos disso. O criamos
para podermos ver os dados quanto recuperarmos a base.

Dentro do SQL Server, temos uma tabela para essa numeração como já conhecemos quando abordamos o backup FULL. 
Então executaremos o seguinte comando chamando o arquivo em que implementamos a Política de Backup:

RESTORE HEADERONLY FROM
DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'

Executando esta linha de comando, teremos o seguinte retorno.

BackupName	BackupDescripiton	BackupType	ExpirationDante	Compressed	Position	DeviceType	UserName	ServerName	DatabaseName	DataBaseVersion	...
1	NULL	NULL	1	NULL	0	1	2	sa	W10-VLA22	dbVendas	957	...
2	NULL	NULL	2	NULL	0	2	2	sa	W10-VLA22	dbVendas	957	...
3	NULL	NULL	2	NULL	0	3	2	sa	W10-VLA22	dbVendas	957	...
4	NULL	NULL	2	NULL	0	4	2	sa	W10-VLA22	dbVendas	957	...
5	NULL	NULL	5	NULL	0	5	2	sa	W10-VLA22	dbVendas	957	...
6	NULL	NULL	2	NULL	0	6	2	sa	W10-VLA22	dbVendas	957	...
7	NULL	NULL	2	NULL	0	7	2	sa	W10-VLA22	dbVendas	957	...
8	NULL	NULL	2	NULL	0	8	2	sa	W10-VLA22	dbVendas	957	...
9	NULL	NULL	5	NULL	0	9	2	sa	W10-VLA22	dbVendas	957	...
10	NULL	NULL	2	NULL	0	10	2	sa	W10-VLA22	dbVendas	957	...
11	NULL	NULL	2	NULL	0	11	2	sa	W10-VLA22	dbVendas	957	...
12	NULL	NULL	2	NULL	0	12	2	sa	W10-VLA22	dbVendas	957	...
13	NULL	NULL	2	NULL	0	13	2	sa	W10-VLA22	dbVendas	957	...

Na coluna "Position", temos o backup 1, 2 e 3 e assim por diante.

Já na coluna de "BackupType", temos os tipos de backups, em que 1 é para FULL, 2 é para incremental e o 5 é o backup diferencial.

Anteriormente, quando tiramos um backup FULL apenas quando executamos RESTORE HEADERONLY FROM, só temos uma linha,
pois só salvamos o FULL.

Já no arquivo .BAK que estamos trabalhando que está dentro de "DATA > BACKUP", implementamos vários backups dentro dele.

Inclusive, teremos o ponteiro de união de backups, como na coluna "BackupFinishDate" deste mesmo retorno com os 
horários em que foram executados, por exemplo.

Mas o mais importante para nós é a coluna "Position" da posição que determinará quais os backups que sabemos que temos que salvar.

Para começarmos essa recuperação, iremos à base para a criarmos novamente. Executaremos os três comandos:

-- código omitido

RESTORE HEADERONLY FROM
DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'

USE MASTER;
ALTER DATABASE dbVendas SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE dbVendas;

Primeiro, sairemos da base enquanto o comando de ALTER BASE irá "derrubar" todos os usuários conectados na base, e a 
trocaremos com o comando seguinte de DROP DATABASE para que não esteja mais no servidor.

Ao os executarmos, teremos o retorno:

Nonqualified transactions are being rolled back. Estimated rollback completion: 0%

Nonqualified transactions are being rolled back. Estimated rollback completion: 100%

Horário de conclusão: 2023-05-07T21:43:17.6208903-03:00

Se formos à lista de arquivos no lado esquerdo da tela, e clicarmos sobre a pasta "Banco De Dados" com o botão direito 
do mouse para selecionarmos "Atualizar", nossa base não existirá mais.

Executaremos novamente o comando de RESTORE HEADERONLY FROM DISK com o arquivo .BAK e teremos a tabela que foi exibida
anteriormente.

Começaremos pelo primeiro backup FULL que está na posição "1". Já conhecemos o comando de recuperação RESTORE DATABASE
do dbVendas, mas teremos uma diferença.

-- código omitido

RESTORE HEADERONLY FROM
DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'

USE MASTER;
ALTER DATABASE dbVendas SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE dbVendas;

RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 1, NORECOVERY;

Temos o nome da base e o caminho do backup, mas quando recuperamos o backup FULL anteriormente, apenas executamos 
este comando RESTORE DATABASE e teremos uma cláusula a mais.

Com WITH FILE = 1, indicamos que queremos recuperar o backup da posição "1" e criamos a cláusula NORECOVERY que 
significa que iremos recuperar o backup 1 e estamos avisando que iremos recuperar outros.

Executando o comando para recuperarmos o FULL inicialmente, teremos o retorno:

Processed 1168 pages for database ''dbVendas', file 'dbVendas' on file 1.

Processed 1 pages for database ''dbVendas', file 'dbVendasLOG' on file 1.

RESTORE DATABASE successfully processed 1169 pages in 0.089 seconds (102544 MB/sec)

Horário de conclusão: 2023-05-07T21:45:16.6541050-03:00

Portanto a base foi recuperada.

Atualizando a base, iremos procurar seu estado mas ainda não está disponível como é possível ver "(Restaurando...)" 
em "dbVendas" na lista lateral de arquivos à esquerda.

Está sendo restaurada por que executamos a clássica NORECOVERY. O próximo arquivo que temos que recuperar é o nove,
então copiaremos o comando de RESTORE e substituiremos o número de WITH FILE por 9 que é o primeiro backup diferencial.

-- código omitido

RESTORE HEADERONLY FROM
DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'

USE MASTER;
ALTER DATABASE dbVendas SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE dbVendas;

RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 1, NORECOVERY;

RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 9, NORECOVERY;

Com essa execução, o retorno será:

Processed 336 pages for database ''dbVendas', file 'dbVendas' on file 9.

Processed 1 pages for database ''dbVendas', file 'dbVendasLOG' on file 9.

RESTORE DATABASE successfully processed 337 pages in 0.198 seconds (13.264 MB/sec)

Horário de conclusão: 2023-05-07T21:46:15.5484738-03:00

Faremos o mesmo procedimento colocando o comando na linha seguinte, mas com o número de posição 10 e depois com o 11.

Porém,este último será o último backup que iremos recuperar, então a cláusula NORECOVERY não poderá ser mais 
usada, então substituiremos por RECOVERY.

-- código omitido

RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 9, NORECOVERY;

RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 10, NORECOVERY;

RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 11, RECOVERY;

Ao indicarmos essa cláusula, dizemos que estamos recuperando o 11 e, quando for carregado, pedimos para disponibilizar
a base para ser acessada.

Executando os comandos, a base ainda terá o "(Restaurando...)", mas executando o 11 e atualizarmos a
pasta "Banco de Dados", essa marcação não existirá mais e a base ficará disponível.

Entraremos nela com use dbVendas e executaremos. Depois, executando o controle de backups SELECT * FROM tb_controle_backups, 
receberemos os dados disponíveis até a posição onze.

ID	NOME	NUMERO_NOTAS
1	1	BACKUP FULL 1 AM	3453
2	2	BACKUP INCREMENTAL 4 AM	3596
3	3	BACKUP INCREMENTAL 6 AM	3708
4	4	BACKUP INCREMENTAL 8 AM	3792
5	5	BACKUP DIFFERENTIAL 9 AM	3893
6	6	BACKUP INCREMENTAL 10 AM	3958
7	7	BACKUP INCREMENTAL 12 AM	4036
8	8	BACKUP INCREMENTAL 2 PM	4151
9	9	BACKUP DIFFERENTIAL 2 PM	4229
10	10	BACKUP INCREMENTAL 3 PM	4361
11	11	BACKUP INCREMENTAL 5 PM	4494
As Notas Fiscais incluídas depois das cinco da tarde ainda não estão na base, o que está é tudo o que aconteceu de uma 
hora da manhã até às cinco da tarde.

Então recuperamos a base no estado mais próximo das 05:30 e diremos às pessoas usuárias que podemos tentar recuperar 
o que estiver faltando.

-------------------------------

recuperando a base através do menegerment studio

Mostraremos como recuperarmos o backup das cinco e meia da tarde usando apenas o SSMS.

Para o exercício prático, precisaremos baixar o arquivo Vídeo 4.6.sql para a máquina. O copiaremos e 
o colaremos na pasta "DATA" onde estamos colocando todos os scripts.

De volta ao Management Studio, acessaremos "Arquivo > Abrir > Arquivo..." e selecionaremos justamente o Vídeo 4.6.sql.

Este script tira o backup de um determinado dia baseado na Política de Backup implementada. Devemos tomar cuidado
ao dia do backup em SET @DATA, que passará a ser '2022-03-03'.

Já em SET @ARQUIVO_BKP, teremos o caminho e o local onde o iremos salvar para executarmos o comando.

DECLARE @NUM_NOTAS INTEGER;
DECLARE @ARQUIVO_BKP VARCHAR(100);
DECLARE @DATA DATE

SET @DATA = '2022-03-03'
SET @ARQUIVO_BKP = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220303.BAK'

DELETE FROM tb_controle_backups;

Ao executarmos o script, veremos que criamos um novo arquivo dentro da pasta "BACKUP" para o dia três de Março.

Aguardaremos pois estamos tirando todos os backups FULL, incrementais e diferenciais.

Com isso, teremos o controle de 13 backups.

ID	NOME	NUMERO_NOTAS
1	1	BACKUP FULL 1 AM	10789
2	2	BACKUP INCREMENTAL 4 AM	10849
3	3	BACKUP INCREMENTAL 6 AM	10900
4	4	BACKUP INCREMENTAL 8 AM	11019
5	5	BACKUP DIFFERENTIAL 9 AM	11094
6	6	BACKUP INCREMENTAL 10 AM	11182
7	7	BACKUP INCREMENTAL 12 AM	11279
8	8	BACKUP INCREMENTAL 2 PM	11352
9	9	BACKUP DIFFERENTIAL 2 PM	11465
10	10	BACKUP INCREMENTAL 3 PM	11679
11	11	BACKUP INCREMENTAL 5 PM	11688
12	12	BACKUP INCREMENTAL 7 PM	11758
13	13	BACKUP INCREMENTAL 9 PM	11891

Para vermos internamente, iremos à aba de "Vídeo 4.6.sql" e, apois SELECT * FROM tb_controle_backups; e executaremos
o RESTORE HEADERONLY usando o arquivo de final 20220303.BAK.

-- código omitido

SELECT * FROM tb_controle.backups
RESTORE HEADERONLY FROM DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220303.BAK'
Copiar código
Como retorno, receberemos a tabela com os treze backups numerados em "Position".

Para recuperarmos o backup das cinco e meia da tarde, recuperaremos o 1, o 9, 10 e 11.

Sairemos da base com USE MASTER, a liberaremos com ALTER DATABASE e a apagaremos com DROP DATABASE.

-- código omitido

SELECT * FROM tb_controle.backups
RESTORE HEADERONLY FROM DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220303.BAK'

USE MASTER;
ALTER DATABASE dbVendas SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE dbVendas;
Copiar código
Atualizando a pasta do Banco de Dados, não usaremos o script e sim o Management Studio. Clicando sobre essa mesma 
pasta na lista lateral esquerda da tela com o botão direito do mouse, escolheremos a opção de "Restaurar Banco de Dados...".

Na janela que se abre, selecionaremos a opção "Dispositivo" e depois no botão com os três pontinhos logo ao lado. 
Em seguida, clicaremos no botão "Adicionar" e selecionaremos o arquivo com o backup feito do dia três de março.

O selecionaremos na área de "Mídia de Backup" e clicaremos em "OK".

Na janela de "Restaurar Banco de Dados - dbVendas", exibiremos uma lista na área de "Conjuntos de backup a serem 
restuarados:" com todos os backups salvos dentro do arquivo .BAK.

Porém, na coluna de "Posição", são exibidos os valores de 1 que é um backup completo, depois apresenta o 9, 10, 11, 
12 e 13 ignorando os demais, mas não importa, pois quando criamos o diferencial da posição 9, simplesmente os outros 
backups não fazem diferença.

Como queremos o backup das cinco e meia da tarde, sabemos que o devemos recuperar até a posição 11.

Nome	Componente	Tipo	Servidor	Banco de Dados	Posição	...
Banco de Dados	Completo	W10-VILA22	dbVendas	1	...
Banco de Dados	Diferencial	W10-VILA22	dbVendas	9	...
Log	Log de Transações	W10-VILA22	dbVendas	10	...
Log	Log de Transações	W10-VILA22	dbVendas	11	...
Log	Log de Transações	W10-VILA22	dbVendas	12	...
Log	Log de Transações	W10-VILA22	dbVendas	13	...

Em nosso caso, as informações de "Data de Início" e de "Data de Conclusão" desta tabela não correspondem à realidade, 
mas se fosse um caso real, teríamos os horários certos que nos guiariam para sabermos qual o backup correto a ser gerado.

Como sabemos que é o 1, 9, 10 e 11, basta desmarcarmos as duas últimas linhas da tabela em "Restaurar". Ao fazermos 
isso, dizemos que queremos recuperar apenas este recorte da hora que estamos trabalhando.

A vantagem da linha de comando é que podemos fazer scripts para fazer a recuperação, mas se fizermos um trabalho 
pontual, usaremos esta caixa de diálogo de Restaurar Banco de Dados do Management Studio.

Nesta mesma janela, na parte esquerda, temos a parte de "Selecionar uma página", e clicaremos em "Opções".

Na parte de "Opções de restauração", selecionaremos "Substituir o banco de dados existente (WITH REPLACE)", e 
finalizaremos clicando em "OK".

Após o tempo de espera da recuperação, teremos uma caixa de diálogo confirmado isso e clicaremos em "OK" novamente.

Na parte de execução do SSMS, se selecionarmos o "dbVendas" na barra de opções do topo da lista lateral de arquivos, 
e depois executarmos a consulta com SELECT * FROM do controle de backups, receberemos a tabela com o backup justamente 
até a posição 11.

ID	NOME	NUMERO_NOTAS
1	1	BACKUP FULL 1 AM	10789
2	2	BACKUP INCREMENTAL 4 AM	10849
3	3	BACKUP INCREMENTAL 6 AM	10900
4	4	BACKUP INCREMENTAL 8 AM	11019
5	5	BACKUP DIFFERENTIAL 9 AM	11094
6	6	BACKUP INCREMENTAL 10 AM	11182
7	7	BACKUP INCREMENTAL 12 AM	11279
8	8	BACKUP INCREMENTAL 2 PM	11352
9	9	BACKUP DIFFERENTIAL 2 PM	11465
10	10	BACKUP INCREMENTAL 3 PM	11679
11	11	BACKUP INCREMENTAL 5 PM	11688

Então fizemos a mesma recuperação, mas através apenas do Management Studio.
*/