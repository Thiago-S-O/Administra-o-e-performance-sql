--REALIZA��O DA POL�TICA DE BECKUP

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

-- 4 DA MANH� - INCREMENTAL (LOG WITH NOINT)
-- incluindo dados incremental
EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS = COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (2, 'BACKUP INCREMENTAL 4 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups
-- fazendo beckup incremental
BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

-- 6 DA MANH� - INCREMENTAL (LOG WITH NOINT)
-- incluindo dados
EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (3, 'BACKUP INCREMENTAL 6 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups
-- fazendo beckup incremental
BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

-- 8 DA MANH� - INCREMENTAL (LOG WITH NOINT)
-- incluindo dados
EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (4, 'BACKUP INCREMENTAL 8 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups
-- fazendo beckup incremental
BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

-- 9 DA MANH� - FULL (DATABASE WITH DIFFERENTIAL)
-- incluindo dados
EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (5, 'BACKUP DIFFERENTIAL 9 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups 
-- fazendo beckup (full diferencial)
BACKUP DATABASE dbVendas TO DISK = 'D:\DATA\BACKUP \POLITICA_BACKUP_20220302.BAK' WITH DIFFERENTIAL;

-- 10 DA MANH� - INCREMENTAL (LOG WITH NOINT)
-- incluindo dados
EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota; 
INSERT INTO tb_controle_backups VALUES (6, 'BACKUP INCREMENTAL 10 AM', @NUM_NOTAS); SELECT * FROM tb_controle_backups
-- fazendo beckup incremental
BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

-- 12 DA MANH� - INCREMENTAL (LOG WITH NOINT)
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

-- beckup full do dia, o NORECOVERY indica que h� ainda beckups a ser restaurados
RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 1, NORECOVERY;

-- beckup diferencial mais pr�ximo das 17:30h
RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 9, NORECOVERY;

-- beckups incrementais depois do beckup diferencial mais pr�ximo das 17:30h
RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 10, NORECOVERY;
-- por ser o �ltimo beckup, deve usar o RECOVERY, sinalizando que j� foi recuperado todos os dados at� 17:30h
RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 11, RECOVERY;


-----------------------------------------------------------------------------------------------
/*
descri��o dos comando acima na �ntegra

Implementando a pol�tica de backup

No Management Studio, temos um nota comentada na �rea de consultas lembrando da pol�tica de backup que precisamos implementar:

-- 1 DA MANHA - FULL (DATABASE WITH INT)
-- 4 DA MANH� - INCREMENTAL (LOG WITH NOINT)
-- 6 DA MANH� - INCREMENTAL (LOG WITH NOINT)
-- 8 DA MANH� - INCREMENTAL (LOG WITH NOINT)
-- 9 DA MANH� - FULL (DATABASE WITH DIFFERENTIAL)
-- 10 DA MANH� - INCREMENTAL (LOG WITH NOINT)
-- 12 DA MANH� - INCREMENTAL (LOG WITH NOINT)
-- 2 DA TARDE - INCREMENTAL (LOG WITH NOINT)
-- 2 DA TARDE - FULL (DATABASE WITH DIFFERENTIAL)
-- 3 DA TARDE - INCREMENTAL (LOG WITH NOINT)
-- 5 DA TARDE - INCREMENTAL (LOG WITH NOINT)
-- 7 DA NOITE - INCREMENTAL (LOG WITH NOINT)
-- 9 DA NOITE - INCREMENTAL (LOG WITH NOINT)

A fim de acompanhar o progresso do backup, iremos verificar na base de dados as datas das notas fiscais dispon�veis, 
usando o seguinte comando na �rea de montar as consultas acima da nota:

SELECT DISTINCT [data] FROM tb_nota order by [data] DESC

Para executar a query, selecionamos o c�digo completo e clicamos no bot�o "Executar" localizado na parte superior 
esquerda do Management Studio.

� poss�vel que o seu resultado obtido ap�s a execu��o da query seja diferente do resultado obtido pelo instrutor.

Como retorno, obtemos:

A tabela abaixo foi parcialmente transcrita. Para conferi-la na �ntegra, execute o c�digo na sua m�quina.

#	data
1	2022-03-01
2	2021-01-31
3	2022-01-30
4	2022-01-29
5	2022-01-28
A �ltima data registrada nas notas fiscais dispon�veis � "2022-03-01". Portanto, vamos supor que estejamos 
realizando o backup no dia "2022-03-02", ou seja, um dia ap�s a �ltima data obtida na consulta que fizemos na 
base de dados. Ap�s o select, podemos comentar a data usando a seguinte sintaxe: -- 2022-03-02.

SELECT DISTINCT [data] FROM tb_nota order by [data] DESC

-- 2022-03-02

Tamb�m vamos criar uma tabela chamada tb_controle_backups usando o comando CREATE TABLE:

CREATE TABLE tb_controle_backups 
(ID INTEGER, NOME VARCHAR(100), NUMERO NOTAS INTEGER);

Nessa tabela, a cada backup realizado, registramos uma informa��o para ter um controle interno de todos os
backups gerados. Essa pr�tica nos permite analisar o conte�do dessa tabela ao recuperarmos o backup, garantindo 
que tenhamos realizado a recupera��o corretamente.

Ao executarmos o comando de cria��o da tabela, obtemos:

Comando conclu�do com �xito

At� o momento, temos os seguintes comandos e coment�rios na nossa �rea de consulta:

SELECT DISTINCT [data] FROM tb_nota order by [data] DESC

-- 2022-03-02

CREATE TABLE tb_controle_backups 
(ID INTEGER, NOME VARCHAR(100), NUMERO NOTAS INTEGER);

-- 1 DA MANHA - FULL (DATABASE WITH INT)
-- 4 DA MANH� - INCREMENTAL (LOG WITH NOINT)
-- 6 DA MANH� - INCREMENTAL (LOG WITH NOINT)
-- 8 DA MANH� - INCREMENTAL (LOG WITH NOINT)
-- 9 DA MANH� - FULL (DATABASE WITH DIFFERENTIAL)
-- 10 DA MANH� - INCREMENTAL (LOG WITH NOINT)
-- 12 DA MANH� - INCREMENTAL (LOG WITH NOINT)
-- 2 DA TARDE - INCREMENTAL (LOG WITH NOINT)
-- 2 DA TARDE - FULL (DATABASE WITH DIFFERENTIAL)
-- 3 DA TARDE - INCREMENTAL (LOG WITH NOINT)
-- 5 DA TARDE - INCREMENTAL (LOG WITH NOINT)
-- 7 DA NOITE - INCREMENTAL (LOG WITH NOINT)
-- 9 DA NOITE - INCREMENTAL (LOG WITH NOINT)

Os seguintes comandos ser�o executados sempre que ocorrer um backup:

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

No segundo par�metro do VALUES, registramos o valor 'BACKUP FULL 1 AM', indicando que se trata do primeiro 
backup full completo realizado pela manh�. Por fim, gravamos o n�mero de notas (@NUM_NOTAS) que ser� obtido 
atrav�s da consulta SELECT @NUM_NOTAS = COUNT(*) FROM tb_nota;.

� importante observar que o n�mero de notas resultante ser� maior do que o obtido anteriormente, pois antes 
executamos o comando IncluiNotasDia, o qual adicionou novas notas � tabela.

Por fim, selecionamos tudo da tabela tb_controle_backups para visualizarmos o conte�do completo.

Para executar a consulta completa e gerar as notas do dia 02/03/2022, selecionamos todos os comandos e 
clicamos no bot�o "Executar".

Como retorno, obtemos:

ID	NOME	NUMERO_NOTAS
1	BACKUP FULL 1AM	3453
Portanto, antes do backup full temos 3453 notas fiscais. Para gerarmos o primeiro backup full, usamos o seguinte comando:

Explique o que o seguite comando faz:

BACKUP DATABASE dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH INIT;

Trata-se de um backup do nosso banco de dados (backup database), onde realizamos o backup completo da base de dados 
denominada dbVendas. Em seguida, utilizamos o comando TO DISK para definir que o backup ser� armazenado em um arquivo
de disco, especificando o caminho e o nome do diret�rio onde ser� salvo.

Por fim, utilizamos o comando WITH INIT para indicar que neste arquivo est� sendo realizado o nosso primeiro backup 
inicial, marcando o in�cio da nossa pol�tica de backup.

Em suma, o comando acima faz um backup completo do banco de dados dbVendas e salva-o no arquivo especificado, 
substituindo qualquer backup anterior.

Rodamos o comando selecionando-o e clicando em "Executar". Como retorno, obtemos que foi gerado com sucesso:

Processed 1168 pages for database 'dbVendas', file 'dbVendas' on file 1.

Processed 1 page for database 'dbVendas', file 'dbVendas LOG' on file 1.

BACKUP DATABASE successfully processed 1169 pages in 0.036 seconds (253.512 MB/sec).

Hor�rio de conclus�o: 2023-05-07T19:31:05.3396513-03:00

Ao analisarmos no diret�rio de backups na nossa m�quina, temos o arquivo POLITICA_BACKUP_20220302.BAK salvo.
Observem que consta a data que come�amos a pol�tica de backup.

Voltando ao SQL Server Management, abaixo da linha comentada com o backup incremental gerado �s 4h da manh� 
inserirmos os seguintes comandos:

-- 4 DA MANH� - INCREMENTAL (LOG WITH NOINT)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS = COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (2, 'BACKUP INCREMENTAL 4 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups

BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

No procedimento EXEC IncluiNotasDia, criamos notas fiscais na data especificada. Nesse caso, simulamos a 
inclus�o dessas notas fiscais na base de dados entre 1h da manh� e 4h da manh�.

Em seguida, realizamos novamente o processo anterior, contabilizando o n�mero de notas fiscais. No entanto, 
dessa vez, adicionamos o n�mero 2 com um label para indicar que se trata do backup incremental realizado
�s 4h da manh�. O valor @NUM_NOTAS � inserido como �ltimo par�metro de VALUES para representar a quantidade 
de notas fiscais.

Executamos a primeira parte do comando selecionando at� SELECT * FROM tb_controle_backups e clicando
em "Executar". Como retorno, obtemos:

ID	NOME	NUMERO_NOTAS
1	BACKUP FULL 1AM	3453
2	BACKUP INCREMENTAL 4AM	3596
Observem que �s 4h da manh� o n�mero de notas fiscais � de 3596, �s 1h t�nhamos 3453.

Para gerar o backup incremental, usamos a �ltima linha de comando:

BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

Observem que n�o se trata mais de um tipo de banco de dados (database), mas sim de um log. Em seguida, 
faremos refer�ncia ao mesmo arquivo de backup em que salvamos o inicial, usando a cl�usula WITH NOINIT. 
Dentro do arquivo BAK, teremos todas as pol�ticas de backups uma ap�s a outra, n�o em arquivos separados.

Vamos rodar essa �ltima linha selecionando-a e clicando em "Executar". Como retorno, obtemos a seguinte 
mensagem de sucesso:

Processed 633 pages for database 'dbVendas', file 'dbVendas LOG' on file 2.

BACKUP LOG successfully processed 633 pages in 0.017 seconds (290.613 MB/sec).

Hor�rio de conclus�o: 2023-05-07T19:33:55.7746761-03:00

Ao analisarmos o arquivo POLITICA_BACKUP_20220302.BAK em nossa m�quina, notamos que ele cresceu um pouco e 
agora possui um tamanho de 15.524KB. Isso ocorre porque o arquivo salva apenas as diferen�as entre um backup e outro.

J� os backups de 6h e 8h da manh� ser�o iguais, a �nica diferen�a ser�o os labels:

-- 6 DA MANH� - INCREMENTAL (LOG WITH NOINT)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (3, 'BACKUP INCREMENTAL 6 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups

BACKUP LOG dbVendas TO DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

No backup realizado �s 6h da manh�, criamos algumas notas fiscais no dia 02/03 e as gravamos como backup 
de n�mero 3 com a label "BACKUP INCREMENTAL 6 AM". Em seguida, geramos um backup do tipo log no mesmo arquivo BAK.

Vamos rodar a primeira parte do comando que gera as notas fiscais (at� SELECT * FROM tb_controle_backups). Obtemos:

ID	NOME	NUMERO_NOTAS
1	BACKUP FULL 1AM	3453
2	BACKUP INCREMENTAL 4AM	3596
3	BACKUP INCREMENTAL 6AM	3708

Agora temos 3708 notas fiscais, e vamos gerar um novo backup incremental selecionando a �ltima linha do comando.
Assim, obtemos uma mensagem de sucesso.

Repetiremos o mesmo processo para o backup incremental das 8h da manh�.

-- 8 DA MANH� - INCREMENTAL (LOG WITH NOINT)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (4, 'BACKUP INCREMENTAL 8 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups

BACKUP LOG dbVendas TO DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

Rodando a primeira parte do comando de gera��o de novas notas fiscais, obtemos a tabela:

ID	NOME	NUMERO_NOTAS
1	BACKUP FULL 1AM	3453
2	BACKUP INCREMENTAL 4AM	3596
3	BACKUP INCREMENTAL 6AM	3708
4	BACKUP INCREMENTAL 8 AM	3792
E na sequ�ncia geramos o backup incremental, obteremos a mesma mensagem de sucesso.

Pr�ximos passos
Chegamos ao hor�rio de 9h da manh� e � o momento de gerar um novo backup completo (full). No entanto, a forma 
como iremos gerar esse backup completo, que ocorre no meio do dia, ser� diferente da forma como geramos o backup 
inicial. Utilizaremos uma cl�usula diferente da WITH INIT.

-------------------------------------
Backup Differential

No SQL Server Management, abaixo do coment�rio do backup full das 9h da manh�, inserimos os seguintes comandos:

-- 9 DA MANH� - FULL (DATABASE WITH DIFFERENTIAL)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (5, 'BACKUP DIFFERENTIAL 9 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups 

BACKUP DATABASE dbVendas TO DISK = 'D:\DATA\BACKUP \POLITICA_BACKUP_20220302.BAK' WITH DIFFERENTIAL;

Novamente, geramos novas notas fiscais. A �nica diferen�a � o comando utilizado para gerar o backup completo. 
Utilizamos o backup database referenciando o mesmo arquivo, e na cl�usula final usamos WITH DIFFERENTIAL.

Lembrando que no arquivo POLITICA_BACKUP_20220302 � necess�rio ter todas as pol�ticas de backups do dia. 
Se gerarmos um backup init �s 9h, tudo o que foi gerado anteriormente ser� removido. No entanto, no caso 
em quest�o, temos um novo backup completo no meio do dia, �s 9h da manh�.

Vamos executar a parte de gera��o de notas fiscais. Como retorno temos:

ID	NOME	NUMERO_NOTAS
1	BACKUP FULL 1AM	3453
2	BACKUP INCREMENTAL 4AM	3596
3	BACKUP INCREMENTAL 6AM	3708
4	BACKUP INCREMENTAL 8 AM	3792
5	BACKUP DIFFERENTIAL 9 AM	3893
Agora, temos 3893 notas fiscais. Vamos gerar o backup rodando a segunda parte do c�digo. O retorno ser� uma
mensagem informando que foi gerado com sucesso.

Com isso, sabemos gerar todos os backups daqui em diante. �s 10h, 12h e 14h da tarde s�o backups 
incrementais LOG WITH NOINT. J� �s 14h da tarde, vamos gerar um novo backup differential, 
e entre 15h, 17h, 19h e 21h geraremos backups incrementais LOG WITH NOINT.

Os comandos abaixo foram parcialmente transcritos. Para conferi-los na �ntegra, por favor, 
consulte a atividade desta aula para copiar todos os comandos.

-- 10 DA MANH� - INCREMENTAL (LOG WITH NOINT)

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

Vamos primeiro gerar as notas fiscais das 10h da manh� executando a primeira parte do comando. Obtemos:

ID	NOME	NUMERO_NOTAS
1	BACKUP FULL 1AM	3453
2	BACKUP INCREMENTAL 4AM	3596
3	BACKUP INCREMENTAL 6AM	3708
4	BACKUP INCREMENTAL 8 AM	3792
5	BACKUP DIFFERENTIAL 9 AM	3893
6	BACKUP INCREMENTAL 10 AM	3958
Em seguida, iremos gerar o backup incremental selecionando o comando e clicando em "Executar". 
Por ser incremental, ele � do tipo log e utiliza a cl�usula WITH NOINIT. Obtemos a mensagem de sucesso:

Processed 379 pages for database 'dbVendas, file 'dbVendas LOG' on file 6.

BACKUP LOG successfully processed 379 pages in 0.011 seconds (268.554 MB/sec).

Hor�rio de conclus�o: 2023-05-07T19:50:06.0472465-03:00

No backup das 12h, faremos o mesmo processo.

-- 12 DA MANH� - INCREMENTAL (LOG WITH NOINT)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (7, 'BACKUP INCREMENTAL 12 AM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups 

BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

Executamos primeiro a gera��o de notas fiscais, e vamos ter mais uma linha na tabela de notas fiscais geradas:

ID	NOME	NUMERO_NOTAS
1	BACKUP FULL 1AM	3453
2	BACKUP INCREMENTAL 4AM	3596
3	BACKUP INCREMENTAL 6AM	3708
4	BACKUP INCREMENTAL 8 AM	3792
5	BACKUP DIFFERENTIAL 9 AM	3893
6	BACKUP INCREMENTAL 10 AM	3958
Na sequ�ncia, geramos um novo backup incremental. Obtemos a mensagem de sucesso vista anteriormente.

Prosseguindo, �s 14h teremos um novo backup incremental:

-- 2 DA TARDE - INCREMENTAL (LOG WITH NOINT)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (8, 'BACKUP INCREMENTAL 2 PM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups

BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA BACKUP 20220302.BAK' WITH NOINIT:

Mais uma vez, executamos a gera��o de notas fiscais, o que adicionar� mais uma linha � nossa tabela:

ID	NOME	NUMERO_NOTAS
1	BACKUP FULL 1AM	3453
2	BACKUP INCREMENTAL 4AM	3596
3	BACKUP INCREMENTAL 6AM	3708
4	BACKUP INCREMENTAL 8 AM	3792
5	BACKUP DIFFERENTIAL 9 AM	3893
6	BACKUP INCREMENTAL 10 AM	3958
E agora executamos o backup incremental em si e obtemos a mensagem de sucesso.

Continuando, �s 14h teremos mais um backup differential:

-- 2 DA TARDE - FULL (DATABASE WITH DIFFERENTIAL)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS COUNT(*) FROM tb_nota; 
INSERT INTO tb_controle_backups VALUES (9, 'BACKUP DIFFERENTIAL 2 PM', @NUM_NOTAS); SELECT * FROM tb_controle_backups

BACKUP DATABASE dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH DIFFERENTIAL;

Rodando a gera��o de notas fiscais, temos:

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

�s 15h, temos outro backup incremental e vamos rodar a gera��o de notas fiscais e posteriormente o 
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
Copiar c�digo
Para o backup incremental das 19h, rodamos (o �ltimo incremental do dia):

-- 9 DA NOITE - INCREMENTAL (LOG WITH NOINT)

EXEC IncluiNotasDia '2022-03-02'
DECLARE @NUM_NOTAS INTEGER;
SELECT @NUM_NOTAS = COUNT(*) FROM tb_nota;
INSERT INTO tb_controle_backups VALUES (13, 'BACKUP INCREMENTAL 9 PM', @NUM_NOTAS);
SELECT * FROM tb_controle_backups

BACKUP LOG dbVendas TO DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK' WITH NOINIT;

A nossa tabela final ter� 13 linhas. Para visualiz�-la, executando o comando SELECT:

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
Iniciamos com um backup completo �s 1h da manh�, no qual t�nhamos 3453 notas fiscais. Em seguida, realizamos 
tr�s backups incrementais e o n�mero de notas fiscais foi aumentando. Posteriormente, fizemos o backup diferencial, 
que foi um backup completo realizado no meio do dia.

Em seguida, mais tr�s backups incrementais foram realizados, seguidos por outro backup diferencial �s 14h. 
Por fim, realizamos mais quatro backups incrementais, sendo do per�odo das 15h �s 21h.

Analisando o arquivo final em nossa m�quina, temos um tamanho de 44.848KB. O arquivo POLITICA_BACKUP_20220302 � o 
arquivo da pol�tica de backup do dia 02/03/2022. Ao final do dia, � importante que o Marcos armazene esse arquivo 
para que possa ser utilizado caso haja a necessidade de recuperar alguma informa��o perdida durante o dia.

--------------------------------
RECUPERANDO UM BECUKP

Vamos a um problema: ap�s a implementa��o no dia dois de mar�o, a pessoa usu�ria abre um chamado para recuperar o 
backup das cinco e meia da tarde. 17:30h

N�o temos um backup por minuto, ent�o se precisamos recuperar de cinco e meia da tarde, precisaremos ver tudo o 
que aconteceu antes para entendermos quais s�o os FULL, diferenciais e incrementais que temos para trazer o estado 
da base de dados o mais pr�ximo poss�vel do hor�rio determinado.

Primeiro, teremos que recuperar o backup FULL, depois teremos que pegar o diferencial mais pr�ximo do hor�rio em 
que devemos recuperar o backup.

Em nosso caso, � o nono backup das duas horas da tarde. Logo, quando recuperarmos este (9), todos os anteriores 
ser�o dispensados.

Depois, precisaremos recuperar os incrementais de duas �s tr�s da tarde, e das tr�s da tarde at� �s cinco da tarde.

N�o precisaremos recuperar o backup feito entre cinco e sete da noite, pois sua base de dados est� ap�s as cinco e 
meia da tarde. Portanto, temos que recuperar os backups (9) e (11).

Mas para recuperarmos o estado deste hor�rio, teremos que recuperar o FULL que � o backup (1), depois o primeiro 
diferencial e depois os dois incrementais seguintes.

Iremos recuperar o backup de cinco e meia da tarde, baseado no que foi implementado na Pol�tica de Backup.

Abrindo o Management Studio, criaremos uma nova consulta. Primeiro, veremos como est� a tabela de controle de backups.

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
Ou seja, j� temos treze backups extra�dos durante a aplica��o da Pol�tica.

Para recuperarmos o backup das cinco e meia da tarde, temos que recuperar os seguintes backups que j� falamos 
anteriormente: o FULL da uma da manh�, (1), o diferencial (9), e os incrementais (10) e (11).

Essa numera��o foi obtida atrav�s do controle que fizemos na coluna de ID, mas n�o precis�vamos disso. O criamos
para podermos ver os dados quanto recuperarmos a base.

Dentro do SQL Server, temos uma tabela para essa numera��o como j� conhecemos quando abordamos o backup FULL. 
Ent�o executaremos o seguinte comando chamando o arquivo em que implementamos a Pol�tica de Backup:

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

J� na coluna de "BackupType", temos os tipos de backups, em que 1 � para FULL, 2 � para incremental e o 5 � o backup diferencial.

Anteriormente, quando tiramos um backup FULL apenas quando executamos RESTORE HEADERONLY FROM, s� temos uma linha,
pois s� salvamos o FULL.

J� no arquivo .BAK que estamos trabalhando que est� dentro de "DATA > BACKUP", implementamos v�rios backups dentro dele.

Inclusive, teremos o ponteiro de uni�o de backups, como na coluna "BackupFinishDate" deste mesmo retorno com os 
hor�rios em que foram executados, por exemplo.

Mas o mais importante para n�s � a coluna "Position" da posi��o que determinar� quais os backups que sabemos que temos que salvar.

Para come�armos essa recupera��o, iremos � base para a criarmos novamente. Executaremos os tr�s comandos:

-- c�digo omitido

RESTORE HEADERONLY FROM
DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'

USE MASTER;
ALTER DATABASE dbVendas SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE dbVendas;

Primeiro, sairemos da base enquanto o comando de ALTER BASE ir� "derrubar" todos os usu�rios conectados na base, e a 
trocaremos com o comando seguinte de DROP DATABASE para que n�o esteja mais no servidor.

Ao os executarmos, teremos o retorno:

Nonqualified transactions are being rolled back. Estimated rollback completion: 0%

Nonqualified transactions are being rolled back. Estimated rollback completion: 100%

Hor�rio de conclus�o: 2023-05-07T21:43:17.6208903-03:00

Se formos � lista de arquivos no lado esquerdo da tela, e clicarmos sobre a pasta "Banco De Dados" com o bot�o direito 
do mouse para selecionarmos "Atualizar", nossa base n�o existir� mais.

Executaremos novamente o comando de RESTORE HEADERONLY FROM DISK com o arquivo .BAK e teremos a tabela que foi exibida
anteriormente.

Come�aremos pelo primeiro backup FULL que est� na posi��o "1". J� conhecemos o comando de recupera��o RESTORE DATABASE
do dbVendas, mas teremos uma diferen�a.

-- c�digo omitido

RESTORE HEADERONLY FROM
DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'

USE MASTER;
ALTER DATABASE dbVendas SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE dbVendas;

RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 1, NORECOVERY;

Temos o nome da base e o caminho do backup, mas quando recuperamos o backup FULL anteriormente, apenas executamos 
este comando RESTORE DATABASE e teremos uma cl�usula a mais.

Com WITH FILE = 1, indicamos que queremos recuperar o backup da posi��o "1" e criamos a cl�usula NORECOVERY que 
significa que iremos recuperar o backup 1 e estamos avisando que iremos recuperar outros.

Executando o comando para recuperarmos o FULL inicialmente, teremos o retorno:

Processed 1168 pages for database ''dbVendas', file 'dbVendas' on file 1.

Processed 1 pages for database ''dbVendas', file 'dbVendasLOG' on file 1.

RESTORE DATABASE successfully processed 1169 pages in 0.089 seconds (102544 MB/sec)

Hor�rio de conclus�o: 2023-05-07T21:45:16.6541050-03:00

Portanto a base foi recuperada.

Atualizando a base, iremos procurar seu estado mas ainda n�o est� dispon�vel como � poss�vel ver "(Restaurando...)" 
em "dbVendas" na lista lateral de arquivos � esquerda.

Est� sendo restaurada por que executamos a cl�ssica NORECOVERY. O pr�ximo arquivo que temos que recuperar � o nove,
ent�o copiaremos o comando de RESTORE e substituiremos o n�mero de WITH FILE por 9 que � o primeiro backup diferencial.

-- c�digo omitido

RESTORE HEADERONLY FROM
DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'

USE MASTER;
ALTER DATABASE dbVendas SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE dbVendas;

RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 1, NORECOVERY;

RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 9, NORECOVERY;

Com essa execu��o, o retorno ser�:

Processed 336 pages for database ''dbVendas', file 'dbVendas' on file 9.

Processed 1 pages for database ''dbVendas', file 'dbVendasLOG' on file 9.

RESTORE DATABASE successfully processed 337 pages in 0.198 seconds (13.264 MB/sec)

Hor�rio de conclus�o: 2023-05-07T21:46:15.5484738-03:00

Faremos o mesmo procedimento colocando o comando na linha seguinte, mas com o n�mero de posi��o 10 e depois com o 11.

Por�m,este �ltimo ser� o �ltimo backup que iremos recuperar, ent�o a cl�usula NORECOVERY n�o poder� ser mais 
usada, ent�o substituiremos por RECOVERY.

-- c�digo omitido

RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 9, NORECOVERY;

RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 10, NORECOVERY;

RESTORE DATABASE dbVendas FROM DISK 'D:\DATA\BACKUP\POLITICA_BACKUP_20220302.BAK'
WITH FILE = 11, RECOVERY;

Ao indicarmos essa cl�usula, dizemos que estamos recuperando o 11 e, quando for carregado, pedimos para disponibilizar
a base para ser acessada.

Executando os comandos, a base ainda ter� o "(Restaurando...)", mas executando o 11 e atualizarmos a
pasta "Banco de Dados", essa marca��o n�o existir� mais e a base ficar� dispon�vel.

Entraremos nela com use dbVendas e executaremos. Depois, executando o controle de backups SELECT * FROM tb_controle_backups, 
receberemos os dados dispon�veis at� a posi��o onze.

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
As Notas Fiscais inclu�das depois das cinco da tarde ainda n�o est�o na base, o que est� � tudo o que aconteceu de uma 
hora da manh� at� �s cinco da tarde.

Ent�o recuperamos a base no estado mais pr�ximo das 05:30 e diremos �s pessoas usu�rias que podemos tentar recuperar 
o que estiver faltando.

-------------------------------

recuperando a base atrav�s do menegerment studio

Mostraremos como recuperarmos o backup das cinco e meia da tarde usando apenas o SSMS.

Para o exerc�cio pr�tico, precisaremos baixar o arquivo V�deo 4.6.sql para a m�quina. O copiaremos e 
o colaremos na pasta "DATA" onde estamos colocando todos os scripts.

De volta ao Management Studio, acessaremos "Arquivo > Abrir > Arquivo..." e selecionaremos justamente o V�deo 4.6.sql.

Este script tira o backup de um determinado dia baseado na Pol�tica de Backup implementada. Devemos tomar cuidado
ao dia do backup em SET @DATA, que passar� a ser '2022-03-03'.

J� em SET @ARQUIVO_BKP, teremos o caminho e o local onde o iremos salvar para executarmos o comando.

DECLARE @NUM_NOTAS INTEGER;
DECLARE @ARQUIVO_BKP VARCHAR(100);
DECLARE @DATA DATE

SET @DATA = '2022-03-03'
SET @ARQUIVO_BKP = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220303.BAK'

DELETE FROM tb_controle_backups;

Ao executarmos o script, veremos que criamos um novo arquivo dentro da pasta "BACKUP" para o dia tr�s de Mar�o.

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

Para vermos internamente, iremos � aba de "V�deo 4.6.sql" e, apois SELECT * FROM tb_controle_backups; e executaremos
o RESTORE HEADERONLY usando o arquivo de final 20220303.BAK.

-- c�digo omitido

SELECT * FROM tb_controle.backups
RESTORE HEADERONLY FROM DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220303.BAK'
Copiar c�digo
Como retorno, receberemos a tabela com os treze backups numerados em "Position".

Para recuperarmos o backup das cinco e meia da tarde, recuperaremos o 1, o 9, 10 e 11.

Sairemos da base com USE MASTER, a liberaremos com ALTER DATABASE e a apagaremos com DROP DATABASE.

-- c�digo omitido

SELECT * FROM tb_controle.backups
RESTORE HEADERONLY FROM DISK = 'D:\DATA\BACKUP\POLITICA_BACKUP_20220303.BAK'

USE MASTER;
ALTER DATABASE dbVendas SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE dbVendas;
Copiar c�digo
Atualizando a pasta do Banco de Dados, n�o usaremos o script e sim o Management Studio. Clicando sobre essa mesma 
pasta na lista lateral esquerda da tela com o bot�o direito do mouse, escolheremos a op��o de "Restaurar Banco de Dados...".

Na janela que se abre, selecionaremos a op��o "Dispositivo" e depois no bot�o com os tr�s pontinhos logo ao lado. 
Em seguida, clicaremos no bot�o "Adicionar" e selecionaremos o arquivo com o backup feito do dia tr�s de mar�o.

O selecionaremos na �rea de "M�dia de Backup" e clicaremos em "OK".

Na janela de "Restaurar Banco de Dados - dbVendas", exibiremos uma lista na �rea de "Conjuntos de backup a serem 
restuarados:" com todos os backups salvos dentro do arquivo .BAK.

Por�m, na coluna de "Posi��o", s�o exibidos os valores de 1 que � um backup completo, depois apresenta o 9, 10, 11, 
12 e 13 ignorando os demais, mas n�o importa, pois quando criamos o diferencial da posi��o 9, simplesmente os outros 
backups n�o fazem diferen�a.

Como queremos o backup das cinco e meia da tarde, sabemos que o devemos recuperar at� a posi��o 11.

Nome	Componente	Tipo	Servidor	Banco de Dados	Posi��o	...
Banco de Dados	Completo	W10-VILA22	dbVendas	1	...
Banco de Dados	Diferencial	W10-VILA22	dbVendas	9	...
Log	Log de Transa��es	W10-VILA22	dbVendas	10	...
Log	Log de Transa��es	W10-VILA22	dbVendas	11	...
Log	Log de Transa��es	W10-VILA22	dbVendas	12	...
Log	Log de Transa��es	W10-VILA22	dbVendas	13	...

Em nosso caso, as informa��es de "Data de In�cio" e de "Data de Conclus�o" desta tabela n�o correspondem � realidade, 
mas se fosse um caso real, ter�amos os hor�rios certos que nos guiariam para sabermos qual o backup correto a ser gerado.

Como sabemos que � o 1, 9, 10 e 11, basta desmarcarmos as duas �ltimas linhas da tabela em "Restaurar". Ao fazermos 
isso, dizemos que queremos recuperar apenas este recorte da hora que estamos trabalhando.

A vantagem da linha de comando � que podemos fazer scripts para fazer a recupera��o, mas se fizermos um trabalho 
pontual, usaremos esta caixa de di�logo de Restaurar Banco de Dados do Management Studio.

Nesta mesma janela, na parte esquerda, temos a parte de "Selecionar uma p�gina", e clicaremos em "Op��es".

Na parte de "Op��es de restaura��o", selecionaremos "Substituir o banco de dados existente (WITH REPLACE)", e 
finalizaremos clicando em "OK".

Ap�s o tempo de espera da recupera��o, teremos uma caixa de di�logo confirmado isso e clicaremos em "OK" novamente.

Na parte de execu��o do SSMS, se selecionarmos o "dbVendas" na barra de op��es do topo da lista lateral de arquivos, 
e depois executarmos a consulta com SELECT * FROM do controle de backups, receberemos a tabela com o backup justamente 
at� a posi��o 11.

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

Ent�o fizemos a mesma recupera��o, mas atrav�s apenas do Management Studio.
*/