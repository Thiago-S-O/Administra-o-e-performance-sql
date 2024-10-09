/*
CRIANDO USU�RIOS SQL SERVER

Outra fun��o exercida pelo Marcos � a cria��o e gerenciamento dos usu�rios. � isso que aprenderemos nesse v�deo.

Criando usu�rios SQL Server
No lado superior esquerdo do Management Studio clicamos na pasta "Seguran�a". Dentro dela, clicamos na pasta "Logons". 
Feito isso, encontramos a lista de usu�rios que podem acessar o SQL Server.

Existem dois grupos de usu�rios, os do pr�prio SQL Server, que nesse caso � somente o usu�rio "sa" que criamos a senha 
no momento de instala��o do SQL Server e os usu�rios do sistema operacional.

Repare que nos usu�rios do sistema operacional aparece o nome servidor. Um deles, inclusive, � o que o instrutor usa 
para se conectar � sua m�quina.

Criaremos agora um usu�rio do tipo SQL Server. Para isso, na barra de menu superior, clicamos no bot�o "Nova Consulta".
Depois, executamos o comando CREATE LOGIN seguido do user name do usu�rio marcos e a senha WITH PASSWORD = 'marcos@123'.

CREATE LOGIN marcos WITH PASSWORD = 'marcos@123';Copiar c�digo
Ao executar, o usu�rio � criado com exito. Agora, faremos um teste para verificar se esse usu�rio consegue se conectar na m�quina.

Para isso, no centro inferior da tela, clicamos no �cone do Management Studio e depois em "SQL Server Management Studio" 
para abrirmos outra janela do mesmo studio.

Feito isso, abre uma janela de login. No campo logon, escrevemos "marcos" e na senha "marcos@123", depois clicamos no 
bot�o "Conectar".

Deu certo, nos conectamos ao SQL Server! Perceba que, no canto superior esquerdo da tela, conseguimos ver o usu�rio 
conectado, nesse caso o Marcos.

Minimizamos essa janela e voltamos para a do sa. Com o bot�o direito, clicamos na pasta "Logon" e depois em "Atualizar". 
Repare que ao fazer isso, o usu�rio "marcos" aparece na lista.

Criando usu�rios do Windows
Agora, criaremos o segundo tipo de usu�rio. No campo de busca do computador, escrevemos "gerenciamento" e clicamos 
em "Gerenciamento do computador". Na nova janela, no lado superior esquerdo da tela, clicamos em "Usu�rios e Grupos Locais".

Nisso, encontramos duas pastas a "Usu�rios" e "Grupos". Clicamos com o bot�o direito na primeira e depois em 
"Novo usu�rio". Na nova aba , preenchemos os campos da seguinte forma:

Nome de usu�rio: vvila
Nome completo: vvila
Descri��o: vvila
Senha: * * * *
Confirmar senha: * * * *
Abaixo, temos campos de sele��o. Desmarcamos a op��o "O usu�rio deve alterar a senha no pr�ximo login" e 
"Conta desativada" e marcamos "O usu�rio n�o pode alterar a senha" e "A senha nunca expira". Feito isso, clicamo 
no bot�o "Criar" e fechamos a aba.

Depois, na aba Gerenciamento do Computador, clicamos em "Grupos". Depois, em "Administradores", clicamos com o bot�o 
direito e selecionamos a op��o "Adicionar ao grupo".

No lado esquerdo, clicamos no bot�o "Adicionar" depois em "Avan�ado" e "Localizar agora". Abre uma lista com os usu�rios, 
clicamos em "vvila". Feito isso, aparece a representa��o DESKTOP-G7KVMJN\vvila.

Antes de continuarmos, abra um bloco de notas e copie esse usu�rio. Depois, minimize a tela, utilizaremos isso em breve.

Feito isso, clicamos no bot�o "Ok" e depois novamente em "Ok". Assim o usu�rio vvila foi adicionado ao sistema operacional.

Agora, abriremos uma nova janela no mesmo studio, por�m de forma diferente. Primeiro apertamos o "Shift" e clicamos 
com o bot�o direito em "SQL Server Management Studio", no centro inferior da tela. Depois, clicamos em "Executar como 
usu�rio diferente".

Abre uma aba. Nela, preenchemos com os dados do usu�rio, sendo nome "vvlia" seguido da senha e clicamos em "Ok". 
Feito isso, o mesmo studio � aberto, por�m, agora pelo usu�rio vvila.

Faremos agora uma autentica��o no SQL Server, mas usando a autentica��o do Windows. Assim, quem ir� se autenticar 
� o usu�rio vvila. Para isso, clicamos no bot�o "Conectar".

Repare que aparece uma mensagem de erro dizendo que o usu�rio vvila n�o pode se conectar a base de dados, pois n�o 
est� habilitado para isso.

Para corrigir isso, acessamos a primeira janela que criamos os usu�rios. Para criar um novo escrevemos CREATE LOGIN,
em seguida, adicionamos colchetes.

Dentro dele, colamos o usu�rio que salvamos no bloco de notas e passamos FROM WINDOWS.

CREATE LOGIN [DESKTOP-G7KVMJN\vvila] FROM WINDOWS;Copiar c�digo
Ap�s executar, na lateral esquerda clicamos na pasta "Logons" com o bot�o direito e depois em "Atualizar". Repare 
que agora o vvila aparece na lista de usu�rios que podem entrar na base de dados.

Feito isso, voltamos na caixa de di�logo que tivemos o erro. Clicamos em "Ok" e depois em "Conectar". Deu certo! 
Conectamos no SQL Server com o usu�rio vvila do Windows.

Nesses dois exemplos pr�ticos, aprendemos como criar um usu�rio do pr�prio SQL Server e do Windows.

Para continuarmos os pr�ximos exerc�cios, fecharemos a caixa de di�logo do usu�rio vvila e do Marcos.

--___________________________________________________________________________--

USU�RIO DE CONEX�O A N�VEL SQL SERVER

Agora vamos abordar como conseguimos visualizar mais informa��es sobre usu�rios do tipo SQL Server. Afinal,
queremos entender mais sobre usu�rios que tem conex�o com SQL Server.

Usu�rios de conex�o com SQL Server
No Management Studio, vamos verificar propriedades de usu�rios que se conectam no banco de dados. Basicamente,
informa��es sobre usu�rios SQL Server.

Para isso, vamos consultar uma tabela interna do servidor que fica localizada no banco de dados master (mestre).
Na consulta, vamos digitar o comando para selecionar todas as linhas de MASTER.SYS.sql_logins

SELECT * FROM MASTER.SYS.sql_logins;Copiar c�digo
Assim, vamos ter as informa��es sobre os logins de usu�rios SQL Server como resultado ap�s executar.

#	name	principal_id	sid	type	type_desc	is_disabled	create_date	modify_date	default_database_name	default_language_name	credential_id	is_policy_checked	is_expiration_checked	password_hash
1	sa	1	0x01	S	SQL LOGIN	0	2003-04-08 09:10:35.460	2023-05-01 16:22:26.363	master	Portugu�s (Brasil)	NULL	1	0	Ox020012F807865EEB66253D134EA643374E82618E381E1D6�
2	##MS Policy TsqlExecutionLogin###	257	0x6FDCCB0634728D499251C4F30AD2304E	S	SQL LOGIN	1	2022-10-08 06:32:02.543	2023-05-06 23:00:29.323	master	us_english	NULL	1	0	Ox0200BFE9D30323857EC19CEF5A4C7862466928F7EFA7A80�
3	##MS_PolicyEvent Processing Login###	266	OxFC4F9A2A69153B43A7106DD2D2EC9447	S	SQL LOGIN	1	2023-05-06 23:00:29.307	2023-05-06 23:00:29.320	master	Portugu�s (Brasil)	NULL	1	0	Ox0200C7C94584F15E1BEE8CA2D2C270978C73DC32575437�
4	marcos	268	Ox7E14878ED656114C9BAB40A70DD18980	S	SQL LOGIN	0	2023-05-08 04:06:13.530	2023-05-08 04:06:13.543	master	Portugu�s (Brasil)	NULL	1	0	Ox02005A6F832D9DAE5C24CD06814F919BF5E730B8367C73�
Temos quatro usu�rios: sa, marcos e dois usu�rios de ambiente. N�o conseguimos visualizar mais usu�rios porque os demais usu�rios v�m do sistema operacional Windows que s�o os restantes listados na pasta "Logons".

Quem tem informa��es sobre esses usu�rios � o Windows, n�o o SQL Server. No momento em que criamos o logon FROM WINDOWS, 
s� fazemos uma associa��o entre todo o controle de confiabilidade de valida��o de usu�rio que vem do sistema operacional 
para o SQL Server.

�ltimo login de usu�rio com LOGINPROPERTY()
Podemos verificar mais propriedades sobre esses usu�rios nesta tabela? Sim, note quantos campos que essa tabela possui.

Com isso, podemos verificar dados sobre os �ltimos logins, por exemplo. Isto �, a data e hora que cada usu�rio do SQL 
Server entrou na base.

Para isso, vamos fazer a sele��o do campo name para saber o nome de usu�rio. N�o temos um campo espec�fico que nos d� a 
data do �ltimo login, mas podemos obt�-lo atrav�s de uma fun��o chamada LOGINPROPERTY().

Entre par�nteses, vamos selecionar o login atrav�s do campo name e tamb�m um par�metro chamado PasswordLastSetTime 
entre aspas simples. Fora dos par�nteses, colocamos FROM e a tabela com as informa��es do login.

SELECT name, LOGINPROPERTY(name, 'PasswordLastSetTime') FROM MASTER.SYS.sql_logins;Copiar c�digo
#	name	(Nenhum nome de coluna)
1	sa	2023-05-01 16:22:26.350
2	##MS Policy TsqlExecutionLogin###	2023-05-06 23:00:29.310
3	##MS_PolicyEvent Processing Login###	2023-05-06 23:00:29.307
4	marcos	2023-05-08 04:16:13.530
Ap�s executar, note que na consulta com o par�metro PasswordLastSetTime conseguimos ver a data e hora dos �ltimos
logins. Assim, o usu�rio marcos que � nosso DBA pode acompanhar os acessos dos usu�rios atrav�s dessas consultas.

Senha criptografada
Mas, ser� que conseguimos verificar a senha de usu�rio? Afinal, a senha de cada usu�rio tem que estar salva em algum
lugar do SQL. Ser� que o DBA tem poder para visualiz�-las?

Em uma pr�xima linha, vamos fazer um SELECT do campo name e o campo password_hash da tabela de logins.

SELECT name, password_hash  FROM MASTER.SYS.sql_logins;Copiar c�digo
#	name	password_hash
1	sa	Ox020012F807865EEB66253D134EA643374E82618E381E1D6�
2	##MS Policy TsqlExecutionLogin###	Ox0200BFE9D30323857EC19CEF5A4C7862466928F7EFA7A80�
3	##MS_PolicyEvent Processing Login###	Ox0200C7C94584F15E1BEE8CA2D2C270978C73DC32575437�
4	marcos	Ox02005A6F832D9DAE5C24CD06814F919BF5E730B8367C73�
N�o conseguimos visualizar a senha, apenas a senha hash, ou seja, a senha criptografada.

Ser� que conseguimos obter informa��es desse campo de senha hash? At� que ponto o DBA consegue verificar algumas 
caracter�sticas da senha atrav�s desse campo?

Vamos fazer o seguinte exemplo: vamos criar um novo login de um usu�rio chamado pedro. Propositalmente, vamos 
definir a senha desse usu�rio como pedro.

CREATE LOGIN pedro WITH PASSWORD = 'pedro';Copiar c�digo
Comandos conclu�dos com �xito.

Sabemos que ter o login e a senha iguais � uma falha de seguran�a. A primeira tentativa de um hacker � colocar 
login e senha iguais.

Vamos executar o comando onde selecionamos os campos name e password_hash.

#	name	password_hash
�	�	�
5	pedro	0x020034F3C165AE1D17671D874FF04D2AD00A3AA3A5FBB9�
N�o conseguimos visualizar a senha do pedro, pois est� criptografada.

Mas ser� que conseguimos fazer a seguinte pergunta para o banco: algum usu�rio tem a senha igual ao login?

Sim, podemos. Basta fazer um SELECT do campo name da tabela master de login.

Ser� que podemos fazer um WHERE com password_hash = name? N�o, porque a senha criptografa nunca vai ser igual 
ao nome. Contudo, podemos usar uma fun��o chamada PWDCOMPARE() ap�s o WHERE.

Entre os par�nteses da fun��o, podemos fazer uma compara��o passando name e password_hash. Como essa fun��o � 
um campo l�gico, vai retornar verdadeiro ou falso. Por isso, fora dos par�nteses, colocamos = 1.

Desse modo, se a compara��o entre o hash e o nome usando a fun��o PWDCOMPARE() foi igual � 1, � porque o usu�rio
e senha s�o iguais.

SELECT name FROM MASTER.SYS.sql_logins
WHERE PWDCOMPARE(name, password_hash) = 1;Copiar c�digo
#	name
1	pedro
Foi retornado o pedro.

Vamos conferir se isso acontece com outro usu�rio?

Para isso, criamos o usu�rio chamado joao. Por�m, a senha do Jo�o vai ser joao123.

CREATE LOGIN joao WITH PASSWORD = 'joao123';Copiar c�digo
Ap�s cri�-lo, vamos comparar novamente o campo name e password_hash com a fun��o PWDCOMPARE(). Ap�s selecionar 
e executar esse comando, somente o pedro possui login igual � senha.

Contudo, se concatenamos o campo name com a string 123, vamos procurar todos os usu�rios com a senha terminando com 123.

SELECT name FROM MASTER.SYS.sql_logins
WHERE PWDCOMPARE(name + '123', password_hash) = 1;Copiar c�digo
#	name
1	joao
Ap�s executar esse comando, aparece o Jo�o.

O DBA consegue manipular algumas informa��es de usu�rios e senha, mas n�o pode verificar a senha e alter�-la. 
Por�m, pode verificar algumas leis de informa��o e alertar os usu�rios sobre poss�veis problemas.

--______________________________________________________________________--

AUTORIZA��O DE USU�RIOS A N�VEL SQL SERVER

J� aprendemos a criar usu�rio. Contudo, esse usu�rio que se conecta no SQL Server n�o tem nenhum privil�gio. 
Por isso, vamos aprender como dar autoriza��es a n�vel de SQL Server para um usu�rio.

Autoriza��o a n�vel de SQL SERVER com ALTER SERVER ROLE
Vamos abrir outra janela do SQL Server para conectar com o usu�rio marcos. Para conectar ao servidor, escrevemos 
marcos no logon e sua respectiva senha. Em seguida, clicamos no bot�o "Conectar".

Agora que estamos conectados como o usu�rio marcos, vamos criar uma nova consulta onde vamos tentar criar uma base de dados.

Para isso, digitamos o comando CREATE DATABASE para criar a base chamada dbVendas2.

CREATE DATABASE dbVendas2;
Copiar c�digo
Ao executar para criar a base de dados, recebemos a seguinte mensagem em vermelho:

Mesagem 262, N�vel 14, Estado 1, Linha 2

Permiss�o CREATE DATABASE negada no banco de dados 'master'.

Note que o usu�rio marcos n�o conseguiu criar uma base, porque n�o tem permiss�o para faz�-lo.

Ao criar um usu�rio, apenas possibilitamos sua conex�o no SQL Server. Mas, n�o demos nenhum privil�gio para esse
usu�rio dentro do banco de dados.

Como dar essa autoriza��o para que o usu�rio marcos possa criar uma base de dados?

Para isso, vamos abrir novamente a janela do SQL Serve onde estamos conectados como usu�rio sa.

Agora, vamos executar o comando ALTER SERVER ROLE e vamos adicion�-lo � regra chamada dbcreator entre colchetes.
Em seguida, digitamos ADD MEMBER para adicionar o usu�rio marcos entre colchetes.

ALTER SERVER ROLE [dbcreator] ADD MEMBER [marcos];
Copiar c�digo
Ao executar esse comando, damos autoriza��o para o Marcos criar banco de dados.

Comandos conclu�dos com �xito.

Vamos voltar ao SQL Server conectado com o usu�rio marcos. Agora, vamos tentar criar a base de dados dbVendas2 novamente.

Comandos conclu�dos com �xito.

Note que agora o Marcos conseguiu criar a base.

Remover autoriza��o
Podemos dar essa regra para o usu�rio marcos, mas tamb�m podemos tir�-la.

No Server SQl do usu�rio sa, digitamos novamente o comando ALTER SERVER ROLE. Por�m, ao inv�s de ADD MEMBER,
vamos colocar DROP MEMBER seguido do nome do usu�rio que desejamos retirar a autoriza��o.

ALTER SERVER ROLE [dbcreator] DROP MEMBER [marcos];
Copiar c�digo
Comandos conclu�dos com �xito.

Feito isso, vamos voltar ao para o SQL Server conectado com o usu�rio marcos.

Se ele tentar criar a base de dados dbVendas3, n�o vai mais conseguir, j� que perdeu esse acesso.

CREATE DATABASE dbVendas3;
Copiar c�digo
Mesagem 262, N�vel 14, Estado 1, Linha 4

Permiss�o CREATE DATABASE negada no banco de dados 'master'.

Lista de regras do SQL Server
Podemos verificar todas essas regras que existem no SQL Server para que o usu�rio possa ter a��es sobre o servidor,
basta rodar um SELECT * FROM e o nome da tabela sys.server_principals.

Tamb�m precisamos digitar um WHERE somente para regras com o campo is_fixed_role igual � 1.

SELECT * FROM sys.server_principals WHERE is_fixed_role = 1;
Copiar c�digo
#	name	principal_id	sid	type	type_desc	is_disabled	create_date	modify_date	default_database_name	�
1	sysadmin	3	Ox03	R	SERVER ROLE	0	2009-04-13 12:59:06.030	2009-04-13 12:59:06.030	NULL	�
2	securityadmin	4	Ox04	R	SERVER ROLE	0	2009-04-13 12:59:06.030	2009-04-13 12:59:06.030	NULL	�
3	serveradmin	5	Ox05	R	SERVER ROLE	0	2009-04-13 12:59:06.030	2009-04-13 12:59:06.030	NULL	�
4	setupadmin	6	Ox06	R	SERVER ROLE	0	2009-04-13 12:59:06.030	2009-04-13 12:59:06.030	NULL	�
5	processadmin	7	Ox07	R	SERVER ROLE	0	2009-04-13 12:59:06.030	2009-04-13 12:59:06.030	NULL	�
6	diskadmin	8	Ox08	R	SERVER ROLE	0	2009-04-13 12:59:06.030	2009-04-13 12:59:06.030	NULL	�
7	dbcreator	9	Ox09	R	SERVER ROLE	0	2009-04-13 12:59:06.030	2009-04-13 12:59:06.030	NULL	�
8	bulkadmin	10	Ox0A	R	SERVER ROLE	0	2009-04-13 12:59:06.030	2009-04-13 12:59:06.030	NULL	�
�	�	�	�	�	�	�	�	�	�	�
Assim, temos uma lista das principais regras existentes no SQL Server. Vamos entender o que significa cada uma dessas regras?

Regra sysadmin: usu�rios com controle total sobre o servidor e de todos os objetos do banco de dados. Por exemplo, o usu�rio sa � sysadmin;
Regra securityadmin: usu�rios com poder de gerenciar as fun��es de servidor de logins e de permiss�es. Desse modo, pode criar usu�rio e dar permiss�es a esses usu�rios;
Regra serveradmin: usu�rios com poder de gerenciar as configura��es a n�vel de servidor e tamb�m gerenciar o servidor como um todo.
Regra setupadmin: usu�rios com poder de gerenciar as instala��es de SQL Servers;
Regra processadmin: usu�rios com poder de gerenciar de processos que s�o executados dentro do servidor do SQL Server;
Regra diskadmin: usu�rios com poder de gerenciar os discos associados as bases de dados do SQL Server;
Regra dbcreator: usu�rios com poder de criar, alterar, excluir e restaurar banco de dados;
Regra bulkadmin: usu�rios com poder de executar opera��es de importa��o e exporta��o de dados em massa, usando uma fun��o interna do SQL Server chamada BULK INSERT.

--______________________________________________________________________--

AUTORIZA��O DE USU�RIOS A N�VEL DE BANCO DE DADOS 

Aprendemos anteriormente sobre autoriza��es a n�vel de SQL Server que d�o privil�gios para que usu�rios 
fa�am tarefas no servidor. Mas, temos outro grupo de autoriza��es muito importante: autoriza��es a n�vel de banco de dados.

Diferen�a entre entidade de login e usu�rio
No Management Studio com o usu�rio sa, vamos usar o comando CREATE LOGIN para criar um novo usu�rio chamado 
jorge com a senha igual � jorge@123.

CREATE LOGIN jorge WITH PASSWORD = 'jorge@123';
Copiar c�digo
Comandos conclu�dos com �xito.

Daqui para frente, vamos tomar mais cuidado com as palavras usadas. Falamos que �amos "criar um usu�rio jorge",
mas o que est�vamos fazendo � criando o login jorge. N�o � o usu�rio jorge.

S� que existe a entidade usu�rio no SQL Server. Isso significa que ap�s criar o login jorge, precisamos criar o
usu�rio jorge e associ�-lo ao login jorge.

Para isso, usamos o comando CREATE USER para criar o usu�rio chamado jorge. Em seguida, digitamos FOR LOGIN 
jorge para fazer essa associa��o.

CREATE USER jorge FOR LOGIN jorge;
Copiar c�digo
Comandos conclu�dos com �xito.

Pronto.

Login e usu�rios s�o entidades diferentes no SQL Server. Mas, a rela��o entre login e user � de 1:1, ou seja,
sempre 1 usu�rio tem associado � ele 1 login.

Contudo, o nome do usu�rio e do login n�o precisam ser os mesmos.

Algumas regras de seguran�a s�o associadas ao login e outras s�o associadas ao usu�rio.

Para exemplificar, vamos abrir outra janela do Management Studio onde aparece a caixa de di�logo de login. 
Nela, colocamos o login jorge e sua senha.

Logon: jorge
Senha: jorge@123
No momento em que apertamos o bot�o "Conectar", o SQL Server internamente associa esse login ao usu�rio associado. 
Com isso, algumas regras de seguran�a s�o configuradas.

As regras de seguran�a do SQL Server que conhecemos anteriormente s�o associadas ao login. J� as regras de 
seguran�a a n�vel de banco de dados s�o associadas ao usu�rio.

Apesar de n�o ser necess�rio, � uma boa pr�tica colocar login e usu�rio com o mesmo nome.

Autoriza��o a nivel de banco de dados
Agora que estamos conectados como jorge, vamos criar uma nova consulta para fazer um teste.

Vamos entrar na base dbVendas com o seguinte comando:

USE dbVendas
Copiar c�digo
Comandos conclu�dos com �xito.

Em seguida, vamos tentar verificar o conte�do da tabela "tb_cidade".

SELECT * FROM tb_cidade;
Copiar c�digo
Mensagem 229, N�vel 14, Estado 5, Linha 4

A permiss�o SELECT foi negada no objeto 'tb_cidade', banco de dados 'dbVendas', esquema 'dbo'.

O que significa esse erro que recebemos? O usu�rio jorge consegue entrar na base de dados, mas n�o consegue 
ler as tabelas. Para isso, � preciso dar um privil�gio de acesso � leitura das tabelas para o usu�rio 
jorge - n�o para o login jorge.

Voltamos para o SQL Server conectado com o usu�rio sa e conectado na base de dados na qual vamos transmitir 
o privil�gio de seguran�a. Nesse caso, dbVendas.

Em uma nova linha, vamos executar com o comando EXEC uma stored procedure chamada sp_addrolemember. 
Em seguida, vamos colocar como par�metro o nome da regra que permite que Jorge leia as tabelas, ou seja,
db_datareader entre aspas simples.

Acrescentamos uma v�rgula para colocar o usu�rio para o qual damos esse privil�gio, jorge entre aspas simples.

EXEC sp_addrolemember 'db_datareader','jorge';
Copiar c�digo
N�o � preciso dizer a qual base uma vez que j� estamos conectados a essa base.

Comandos conclu�do com �xito.

Ap�s executar o comando, vamos voltar a janela do SQL Server com a conex�o do jorge para tentar executar 
novamente a sele��o da tabela "tb_cidade".

SELECT * FROM tb_cidade;
Copiar c�digo
#	cidade	sigla_estado
1	Andradina	SP
2	Aparecida de Goi�nia	GO
�	�	�
Agora, conseguimos visualizar o conte�do da tabela.

Vamos testar outro caso. Jorge resolveu digitar o comando INSERT INTO tb_cidade nos campos cidade e 
sigla_estado para inserir os valores cidade x e SP, ambos entre aspas.

INSERT INTO tb_cidade (cidade, sigla_estado) VALUES ('cidade x', 'SP');
Copiar c�digo
Mensagem 229, N�vel 14, Estado 5, Linha 6

A permiss�o INSERT foi negada no objeto 'tb_cidade', banco de dados 'dbVendas', esquema 'dbo'.

Ao executar esse comando, note que Jorge n�o tem privil�gio de incluir dados nesta tabela. Afinal, s� 
demos o privil�gio de leitura da tabela para jorge. E, para incluir dados, � preciso dar privil�gios de escrita.

Na janela do SQL Server com a conex�o do usu�rio sa, vamos fazer outro comando EXEC sp_addrolemember. 
Ao inv�s de db_datareader, vamos usar db_datawriter.

EXEC sp_addrolemember 'db_datawriter','jorge';
Copiar c�digo
Comandos conclu�dos com �xito.

Pronto.

Se voltamos para a janela da conex�o do jorge, podemos tentar executar o comando INSERT novamente.

(1 linha afetada)

Agora, conseguimos incluir os dados na tabela "tb_cidade".

Estas s�o algumas das diretivas associadas ao banco de dados:

dbowner - Os membros dessa fun��o t�m controle total do banco de dados, incluindo a capacidade de executar tarefas de gerenciamento de banco de dados, criar, modificar ou excluir objetos do banco de dados e conceder permiss�es a outros usu�rios.

db_datareader - Os membros dessa fun��o t�m permiss�o para ler qualquer tabela em um banco de dados espec�fico.

db_datawriter - Os membros dessa fun��o t�m permiss�o para modificar dados em qualquer tabela em um banco de dados espec�fico.

db executor - Os membros dessa fun��o t�m permiss�o para executar qualquer procedimento armazenado no banco de dados.

db_ddladmin - Os membros dessa fun��o t�m permiss�o para executar qualquer comando DDL (Data Definition Language) em um banco de dados espec�fico.

db securityadmin - Os membros dessa fun��o t�m permiss�o para gerenciar permiss�es no banco de dados.

db_accessadmin - Os membros dessa fun��o t�m permiss�o para gerenciar a atribui��o de permiss�es para usu�rios e fun��es.

db_backupoperator - Os membros dessa fun��o t�m permiss�o para realizar backups de banco de dados.

db_datareader e db_datawriter - Os membros dessa fun��o t�m permiss�o para ler e modificar dados em qualquer tabela em um banco de dados espec�fico.

--______________________________________________________________________--

CONFIGURA��ES DE AUTORIZA��ES USANDO O SSMS

Cria��o de login atrav�s do SQL Server Management Studio
Estamos no Management Studio como usu�rio sa. No painel "Pesquisador de Objetos" � esquerda, vamos clicar com o
bot�o direito do mouse na pasta chamada "Logons" para escolher a op��o "Novo Logon".

Na caixa de di�logo que se abre, vamos criar um novo logon claudia na p�gina "Geral".

Tamb�m podemos escolher o tipo de autentica��o, Windows ou SQL Server. Nesse caso, vamos selecionar a 
"Autentica��o do SQL Server" e, em seguida, configurar uma senha.

Al�m disso, podemos selecionar caixas de sele��o para impor uma pol�tica de senha, impor um vencimento de
senha e estabelecer que o usu�rio deve alterar a senha no pr�ximo logon. Vamos desmarcas essas tr�s caixas de sele��o.

Em seguida, temos outros tipos de forma de autentica��o, por�m, n�o vamos alter�-las. Vamos manter a
autentica��o do SQL Server.

Vamos clicar no dropdown da op��o "Script" na parte superior e escolher "A��o do Script para a Nova 
Janela de Consulta" (ou atalho "Ctrl + Shift + N").

Dessa forma, abre-se uma janela de consulta com o comando que a caixa de di�logo vai executar:

USE [master]
GO
CREATE LOGIN [claudia] WITH PASSWORD=N'claudia', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
Copiar c�digo
� um c�digo parecido com o comando CREATE LOGIN que aprendemos, colocando o nome do login e a senha. 
Por�m, h� alguns par�metros padr�es (default) que s�o configurados quando n�o colocamos no CREATE LOGIN.

O par�metro DEFAULT_DATABASE define a base padr�o de conex�o, o CHECK_EXPIRATION define se a senha vai 
ter expira��o e o CHECK_POLICY define se vai ter a pol�tica de forma��o de senha.

N�o queremos executar esse comando, mas, sim, a caixa de di�logo. Para isso, basta apertar o 
bot�o "OK" no canto inferior direito da caixa de di�logo "Logon - Novo".

Com isso, o usu�rio claudia � criado e aparece listado dentro da pasta "Logons".

Autoriza��o atrav�s do SQL Server Management Studio
Clicamos com o bot�o direito na pasta "Logons" no painel � esquerda para dar um "Atualizar". 
Assim, podemos escolher o usu�rio jorge que criamos anteriormente.

Nele, vamos clicar com o bot�o direito do mouse em "jorge > Propriedades". Desse modo, abre-se
uma caixa de di�logo com as credenciais do Jorge.

Em "Selecionar uma p�gina", vamos escolher a p�gina "Fun��es de Servidor" para visualizar todos
os privil�gios que o Jorge pode ter a n�vel de servidor.

Atualmente, ele s� pode ver objetos p�blicos j� que a �nica caixa marcada � public.

Contudo, se quis�ssemos que o Jorge pudesse criar bases, bastaria selecionar a caixa com a op��o 
dbcreator. Se quis�ssemos que ele pudesse configurar as seguran�as de outros usu�rios do banco de dados,
poder�amos escolher a caixa securityadmin.

Desse modo, podemos configurar os privil�gios que o Jorge vai ter a n�vel de servidor SQL Server.

Agora, selecionamos a p�gina "Mapeamento de Usu�rio" onde podemos visualizar o que Jorge pode fazer 
a n�vel de banco de dados.

Em "Usu�rios mapeados para este logon", note que atualmente o Jorge pode acessar dbVendas.

Se clicamos em dbVendas, logo abaixo em "Associa��o � fun��o de banco de dados para: dbVendas",
aparecem marcadas as caixas das op��es db_datareader, db_datawriter e public.

Dessa forma, sabemos que ele pode escrever e ler na base de dados, bem como ter acesso �s bases 
p�blicas. Essa foi a configura��o que n�s fizemos anteriormente.

Al�m disso, podemos escolher o tipo de configura��o que o Jorge pode ter nessa base ao selecionar
mais caixas.

Contudo, se escolhemos outra base como a DW_TESTE, as caixas de "Associa��o � fun��o de banco de 
dados para: DW_TESTE" mudam. Pois, podemos escolher outros privil�gios de acesso de Jorge nesta 
outra base.

Da mesma maneira que pudemos visualizar o script de cria��o quando criamos o usu�rio claudia, 
tamb�m podemos visualizar o script de altera��o quando modificamos os par�metros para o Jorge.

Basta clicar em "Script > A��o do Script para a Nova Janela de Consulta". Assim, temos os 
privil�gios de mudan�a:

ALTER SERVER ROLE [dbcreator] ADD MEMBER [jorge]
GO
ALTER SERVER ROLE [securityadmin] ADD MEMBER [jorge]
GO
USE [DW_TESTE]
GO
CREATE USER [jorge] FOR LOGIN [jorge]
GO
Copiar c�digo
Com o comando ALTER SERVER ROLE, alteramos a regra dbcreator e securityadmin para adicionar o 
jorge. Depois, vamos criar o usu�rio jorge e associ�-lo ao login jorge.

O DBA pode configurar as seguran�as n�o somente atrav�s de linhas de comando, mas tamb�m atrav�s
da caixa de di�logo amig�vel do Management Studio.

Na caixa de di�logo "Propriedades de Logon - jorge", vamos apertar o bot�o "OK" no canto inferior
direito para alterar as configura��es do Jorge.

*/