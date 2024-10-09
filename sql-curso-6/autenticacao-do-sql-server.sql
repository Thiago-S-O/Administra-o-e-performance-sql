/*
CRIANDO USUÁRIOS SQL SERVER

Outra função exercida pelo Marcos é a criação e gerenciamento dos usuários. É isso que aprenderemos nesse vídeo.

Criando usuários SQL Server
No lado superior esquerdo do Management Studio clicamos na pasta "Segurança". Dentro dela, clicamos na pasta "Logons". 
Feito isso, encontramos a lista de usuários que podem acessar o SQL Server.

Existem dois grupos de usuários, os do próprio SQL Server, que nesse caso é somente o usuário "sa" que criamos a senha 
no momento de instalação do SQL Server e os usuários do sistema operacional.

Repare que nos usuários do sistema operacional aparece o nome servidor. Um deles, inclusive, é o que o instrutor usa 
para se conectar à sua máquina.

Criaremos agora um usuário do tipo SQL Server. Para isso, na barra de menu superior, clicamos no botão "Nova Consulta".
Depois, executamos o comando CREATE LOGIN seguido do user name do usuário marcos e a senha WITH PASSWORD = 'marcos@123'.

CREATE LOGIN marcos WITH PASSWORD = 'marcos@123';Copiar código
Ao executar, o usuário é criado com exito. Agora, faremos um teste para verificar se esse usuário consegue se conectar na máquina.

Para isso, no centro inferior da tela, clicamos no ícone do Management Studio e depois em "SQL Server Management Studio" 
para abrirmos outra janela do mesmo studio.

Feito isso, abre uma janela de login. No campo logon, escrevemos "marcos" e na senha "marcos@123", depois clicamos no 
botão "Conectar".

Deu certo, nos conectamos ao SQL Server! Perceba que, no canto superior esquerdo da tela, conseguimos ver o usuário 
conectado, nesse caso o Marcos.

Minimizamos essa janela e voltamos para a do sa. Com o botão direito, clicamos na pasta "Logon" e depois em "Atualizar". 
Repare que ao fazer isso, o usuário "marcos" aparece na lista.

Criando usuários do Windows
Agora, criaremos o segundo tipo de usuário. No campo de busca do computador, escrevemos "gerenciamento" e clicamos 
em "Gerenciamento do computador". Na nova janela, no lado superior esquerdo da tela, clicamos em "Usuários e Grupos Locais".

Nisso, encontramos duas pastas a "Usuários" e "Grupos". Clicamos com o botão direito na primeira e depois em 
"Novo usuário". Na nova aba , preenchemos os campos da seguinte forma:

Nome de usuário: vvila
Nome completo: vvila
Descrição: vvila
Senha: * * * *
Confirmar senha: * * * *
Abaixo, temos campos de seleção. Desmarcamos a opção "O usuário deve alterar a senha no próximo login" e 
"Conta desativada" e marcamos "O usuário não pode alterar a senha" e "A senha nunca expira". Feito isso, clicamo 
no botão "Criar" e fechamos a aba.

Depois, na aba Gerenciamento do Computador, clicamos em "Grupos". Depois, em "Administradores", clicamos com o botão 
direito e selecionamos a opção "Adicionar ao grupo".

No lado esquerdo, clicamos no botão "Adicionar" depois em "Avançado" e "Localizar agora". Abre uma lista com os usuários, 
clicamos em "vvila". Feito isso, aparece a representação DESKTOP-G7KVMJN\vvila.

Antes de continuarmos, abra um bloco de notas e copie esse usuário. Depois, minimize a tela, utilizaremos isso em breve.

Feito isso, clicamos no botão "Ok" e depois novamente em "Ok". Assim o usuário vvila foi adicionado ao sistema operacional.

Agora, abriremos uma nova janela no mesmo studio, porém de forma diferente. Primeiro apertamos o "Shift" e clicamos 
com o botão direito em "SQL Server Management Studio", no centro inferior da tela. Depois, clicamos em "Executar como 
usuário diferente".

Abre uma aba. Nela, preenchemos com os dados do usuário, sendo nome "vvlia" seguido da senha e clicamos em "Ok". 
Feito isso, o mesmo studio é aberto, porém, agora pelo usuário vvila.

Faremos agora uma autenticação no SQL Server, mas usando a autenticação do Windows. Assim, quem irá se autenticar 
é o usuário vvila. Para isso, clicamos no botão "Conectar".

Repare que aparece uma mensagem de erro dizendo que o usuário vvila não pode se conectar a base de dados, pois não 
está habilitado para isso.

Para corrigir isso, acessamos a primeira janela que criamos os usuários. Para criar um novo escrevemos CREATE LOGIN,
em seguida, adicionamos colchetes.

Dentro dele, colamos o usuário que salvamos no bloco de notas e passamos FROM WINDOWS.

CREATE LOGIN [DESKTOP-G7KVMJN\vvila] FROM WINDOWS;Copiar código
Após executar, na lateral esquerda clicamos na pasta "Logons" com o botão direito e depois em "Atualizar". Repare 
que agora o vvila aparece na lista de usuários que podem entrar na base de dados.

Feito isso, voltamos na caixa de diálogo que tivemos o erro. Clicamos em "Ok" e depois em "Conectar". Deu certo! 
Conectamos no SQL Server com o usuário vvila do Windows.

Nesses dois exemplos práticos, aprendemos como criar um usuário do próprio SQL Server e do Windows.

Para continuarmos os próximos exercícios, fecharemos a caixa de diálogo do usuário vvila e do Marcos.

--___________________________________________________________________________--

USUÁRIO DE CONEXÃO A NÍVEL SQL SERVER

Agora vamos abordar como conseguimos visualizar mais informações sobre usuários do tipo SQL Server. Afinal,
queremos entender mais sobre usuários que tem conexão com SQL Server.

Usuários de conexão com SQL Server
No Management Studio, vamos verificar propriedades de usuários que se conectam no banco de dados. Basicamente,
informações sobre usuários SQL Server.

Para isso, vamos consultar uma tabela interna do servidor que fica localizada no banco de dados master (mestre).
Na consulta, vamos digitar o comando para selecionar todas as linhas de MASTER.SYS.sql_logins

SELECT * FROM MASTER.SYS.sql_logins;Copiar código
Assim, vamos ter as informações sobre os logins de usuários SQL Server como resultado após executar.

#	name	principal_id	sid	type	type_desc	is_disabled	create_date	modify_date	default_database_name	default_language_name	credential_id	is_policy_checked	is_expiration_checked	password_hash
1	sa	1	0x01	S	SQL LOGIN	0	2003-04-08 09:10:35.460	2023-05-01 16:22:26.363	master	Português (Brasil)	NULL	1	0	Ox020012F807865EEB66253D134EA643374E82618E381E1D6…
2	##MS Policy TsqlExecutionLogin###	257	0x6FDCCB0634728D499251C4F30AD2304E	S	SQL LOGIN	1	2022-10-08 06:32:02.543	2023-05-06 23:00:29.323	master	us_english	NULL	1	0	Ox0200BFE9D30323857EC19CEF5A4C7862466928F7EFA7A80…
3	##MS_PolicyEvent Processing Login###	266	OxFC4F9A2A69153B43A7106DD2D2EC9447	S	SQL LOGIN	1	2023-05-06 23:00:29.307	2023-05-06 23:00:29.320	master	Português (Brasil)	NULL	1	0	Ox0200C7C94584F15E1BEE8CA2D2C270978C73DC32575437…
4	marcos	268	Ox7E14878ED656114C9BAB40A70DD18980	S	SQL LOGIN	0	2023-05-08 04:06:13.530	2023-05-08 04:06:13.543	master	Português (Brasil)	NULL	1	0	Ox02005A6F832D9DAE5C24CD06814F919BF5E730B8367C73…
Temos quatro usuários: sa, marcos e dois usuários de ambiente. Não conseguimos visualizar mais usuários porque os demais usuários vêm do sistema operacional Windows que são os restantes listados na pasta "Logons".

Quem tem informações sobre esses usuários é o Windows, não o SQL Server. No momento em que criamos o logon FROM WINDOWS, 
só fazemos uma associação entre todo o controle de confiabilidade de validação de usuário que vem do sistema operacional 
para o SQL Server.

Último login de usuário com LOGINPROPERTY()
Podemos verificar mais propriedades sobre esses usuários nesta tabela? Sim, note quantos campos que essa tabela possui.

Com isso, podemos verificar dados sobre os últimos logins, por exemplo. Isto é, a data e hora que cada usuário do SQL 
Server entrou na base.

Para isso, vamos fazer a seleção do campo name para saber o nome de usuário. Não temos um campo específico que nos dá a 
data do último login, mas podemos obtê-lo através de uma função chamada LOGINPROPERTY().

Entre parênteses, vamos selecionar o login através do campo name e também um parâmetro chamado PasswordLastSetTime 
entre aspas simples. Fora dos parênteses, colocamos FROM e a tabela com as informações do login.

SELECT name, LOGINPROPERTY(name, 'PasswordLastSetTime') FROM MASTER.SYS.sql_logins;Copiar código
#	name	(Nenhum nome de coluna)
1	sa	2023-05-01 16:22:26.350
2	##MS Policy TsqlExecutionLogin###	2023-05-06 23:00:29.310
3	##MS_PolicyEvent Processing Login###	2023-05-06 23:00:29.307
4	marcos	2023-05-08 04:16:13.530
Após executar, note que na consulta com o parâmetro PasswordLastSetTime conseguimos ver a data e hora dos últimos
logins. Assim, o usuário marcos que é nosso DBA pode acompanhar os acessos dos usuários através dessas consultas.

Senha criptografada
Mas, será que conseguimos verificar a senha de usuário? Afinal, a senha de cada usuário tem que estar salva em algum
lugar do SQL. Será que o DBA tem poder para visualizá-las?

Em uma próxima linha, vamos fazer um SELECT do campo name e o campo password_hash da tabela de logins.

SELECT name, password_hash  FROM MASTER.SYS.sql_logins;Copiar código
#	name	password_hash
1	sa	Ox020012F807865EEB66253D134EA643374E82618E381E1D6…
2	##MS Policy TsqlExecutionLogin###	Ox0200BFE9D30323857EC19CEF5A4C7862466928F7EFA7A80…
3	##MS_PolicyEvent Processing Login###	Ox0200C7C94584F15E1BEE8CA2D2C270978C73DC32575437…
4	marcos	Ox02005A6F832D9DAE5C24CD06814F919BF5E730B8367C73…
Não conseguimos visualizar a senha, apenas a senha hash, ou seja, a senha criptografada.

Será que conseguimos obter informações desse campo de senha hash? Até que ponto o DBA consegue verificar algumas 
características da senha através desse campo?

Vamos fazer o seguinte exemplo: vamos criar um novo login de um usuário chamado pedro. Propositalmente, vamos 
definir a senha desse usuário como pedro.

CREATE LOGIN pedro WITH PASSWORD = 'pedro';Copiar código
Comandos concluídos com êxito.

Sabemos que ter o login e a senha iguais é uma falha de segurança. A primeira tentativa de um hacker é colocar 
login e senha iguais.

Vamos executar o comando onde selecionamos os campos name e password_hash.

#	name	password_hash
…	…	…
5	pedro	0x020034F3C165AE1D17671D874FF04D2AD00A3AA3A5FBB9…
Não conseguimos visualizar a senha do pedro, pois está criptografada.

Mas será que conseguimos fazer a seguinte pergunta para o banco: algum usuário tem a senha igual ao login?

Sim, podemos. Basta fazer um SELECT do campo name da tabela master de login.

Será que podemos fazer um WHERE com password_hash = name? Não, porque a senha criptografa nunca vai ser igual 
ao nome. Contudo, podemos usar uma função chamada PWDCOMPARE() após o WHERE.

Entre os parênteses da função, podemos fazer uma comparação passando name e password_hash. Como essa função é 
um campo lógico, vai retornar verdadeiro ou falso. Por isso, fora dos parênteses, colocamos = 1.

Desse modo, se a comparação entre o hash e o nome usando a função PWDCOMPARE() foi igual à 1, é porque o usuário
e senha são iguais.

SELECT name FROM MASTER.SYS.sql_logins
WHERE PWDCOMPARE(name, password_hash) = 1;Copiar código
#	name
1	pedro
Foi retornado o pedro.

Vamos conferir se isso acontece com outro usuário?

Para isso, criamos o usuário chamado joao. Porém, a senha do João vai ser joao123.

CREATE LOGIN joao WITH PASSWORD = 'joao123';Copiar código
Após criá-lo, vamos comparar novamente o campo name e password_hash com a função PWDCOMPARE(). Após selecionar 
e executar esse comando, somente o pedro possui login igual à senha.

Contudo, se concatenamos o campo name com a string 123, vamos procurar todos os usuários com a senha terminando com 123.

SELECT name FROM MASTER.SYS.sql_logins
WHERE PWDCOMPARE(name + '123', password_hash) = 1;Copiar código
#	name
1	joao
Após executar esse comando, aparece o João.

O DBA consegue manipular algumas informações de usuários e senha, mas não pode verificar a senha e alterá-la. 
Porém, pode verificar algumas leis de informação e alertar os usuários sobre possíveis problemas.

--______________________________________________________________________--

AUTORIZAÇÃO DE USUÁRIOS A NÍVEL SQL SERVER

Já aprendemos a criar usuário. Contudo, esse usuário que se conecta no SQL Server não tem nenhum privilégio. 
Por isso, vamos aprender como dar autorizações a nível de SQL Server para um usuário.

Autorização a nível de SQL SERVER com ALTER SERVER ROLE
Vamos abrir outra janela do SQL Server para conectar com o usuário marcos. Para conectar ao servidor, escrevemos 
marcos no logon e sua respectiva senha. Em seguida, clicamos no botão "Conectar".

Agora que estamos conectados como o usuário marcos, vamos criar uma nova consulta onde vamos tentar criar uma base de dados.

Para isso, digitamos o comando CREATE DATABASE para criar a base chamada dbVendas2.

CREATE DATABASE dbVendas2;
Copiar código
Ao executar para criar a base de dados, recebemos a seguinte mensagem em vermelho:

Mesagem 262, Nível 14, Estado 1, Linha 2

Permissão CREATE DATABASE negada no banco de dados 'master'.

Note que o usuário marcos não conseguiu criar uma base, porque não tem permissão para fazê-lo.

Ao criar um usuário, apenas possibilitamos sua conexão no SQL Server. Mas, não demos nenhum privilégio para esse
usuário dentro do banco de dados.

Como dar essa autorização para que o usuário marcos possa criar uma base de dados?

Para isso, vamos abrir novamente a janela do SQL Serve onde estamos conectados como usuário sa.

Agora, vamos executar o comando ALTER SERVER ROLE e vamos adicioná-lo à regra chamada dbcreator entre colchetes.
Em seguida, digitamos ADD MEMBER para adicionar o usuário marcos entre colchetes.

ALTER SERVER ROLE [dbcreator] ADD MEMBER [marcos];
Copiar código
Ao executar esse comando, damos autorização para o Marcos criar banco de dados.

Comandos concluídos com êxito.

Vamos voltar ao SQL Server conectado com o usuário marcos. Agora, vamos tentar criar a base de dados dbVendas2 novamente.

Comandos concluídos com êxito.

Note que agora o Marcos conseguiu criar a base.

Remover autorização
Podemos dar essa regra para o usuário marcos, mas também podemos tirá-la.

No Server SQl do usuário sa, digitamos novamente o comando ALTER SERVER ROLE. Porém, ao invés de ADD MEMBER,
vamos colocar DROP MEMBER seguido do nome do usuário que desejamos retirar a autorização.

ALTER SERVER ROLE [dbcreator] DROP MEMBER [marcos];
Copiar código
Comandos concluídos com êxito.

Feito isso, vamos voltar ao para o SQL Server conectado com o usuário marcos.

Se ele tentar criar a base de dados dbVendas3, não vai mais conseguir, já que perdeu esse acesso.

CREATE DATABASE dbVendas3;
Copiar código
Mesagem 262, Nível 14, Estado 1, Linha 4

Permissão CREATE DATABASE negada no banco de dados 'master'.

Lista de regras do SQL Server
Podemos verificar todas essas regras que existem no SQL Server para que o usuário possa ter ações sobre o servidor,
basta rodar um SELECT * FROM e o nome da tabela sys.server_principals.

Também precisamos digitar um WHERE somente para regras com o campo is_fixed_role igual à 1.

SELECT * FROM sys.server_principals WHERE is_fixed_role = 1;
Copiar código
#	name	principal_id	sid	type	type_desc	is_disabled	create_date	modify_date	default_database_name	…
1	sysadmin	3	Ox03	R	SERVER ROLE	0	2009-04-13 12:59:06.030	2009-04-13 12:59:06.030	NULL	…
2	securityadmin	4	Ox04	R	SERVER ROLE	0	2009-04-13 12:59:06.030	2009-04-13 12:59:06.030	NULL	…
3	serveradmin	5	Ox05	R	SERVER ROLE	0	2009-04-13 12:59:06.030	2009-04-13 12:59:06.030	NULL	…
4	setupadmin	6	Ox06	R	SERVER ROLE	0	2009-04-13 12:59:06.030	2009-04-13 12:59:06.030	NULL	…
5	processadmin	7	Ox07	R	SERVER ROLE	0	2009-04-13 12:59:06.030	2009-04-13 12:59:06.030	NULL	…
6	diskadmin	8	Ox08	R	SERVER ROLE	0	2009-04-13 12:59:06.030	2009-04-13 12:59:06.030	NULL	…
7	dbcreator	9	Ox09	R	SERVER ROLE	0	2009-04-13 12:59:06.030	2009-04-13 12:59:06.030	NULL	…
8	bulkadmin	10	Ox0A	R	SERVER ROLE	0	2009-04-13 12:59:06.030	2009-04-13 12:59:06.030	NULL	…
…	…	…	…	…	…	…	…	…	…	…
Assim, temos uma lista das principais regras existentes no SQL Server. Vamos entender o que significa cada uma dessas regras?

Regra sysadmin: usuários com controle total sobre o servidor e de todos os objetos do banco de dados. Por exemplo, o usuário sa é sysadmin;
Regra securityadmin: usuários com poder de gerenciar as funções de servidor de logins e de permissões. Desse modo, pode criar usuário e dar permissões a esses usuários;
Regra serveradmin: usuários com poder de gerenciar as configurações a nível de servidor e também gerenciar o servidor como um todo.
Regra setupadmin: usuários com poder de gerenciar as instalações de SQL Servers;
Regra processadmin: usuários com poder de gerenciar de processos que são executados dentro do servidor do SQL Server;
Regra diskadmin: usuários com poder de gerenciar os discos associados as bases de dados do SQL Server;
Regra dbcreator: usuários com poder de criar, alterar, excluir e restaurar banco de dados;
Regra bulkadmin: usuários com poder de executar operações de importação e exportação de dados em massa, usando uma função interna do SQL Server chamada BULK INSERT.

--______________________________________________________________________--

AUTORIZAÇÃO DE USUÁRIOS A NÍVEL DE BANCO DE DADOS 

Aprendemos anteriormente sobre autorizações a nível de SQL Server que dão privilégios para que usuários 
façam tarefas no servidor. Mas, temos outro grupo de autorizações muito importante: autorizações a nível de banco de dados.

Diferença entre entidade de login e usuário
No Management Studio com o usuário sa, vamos usar o comando CREATE LOGIN para criar um novo usuário chamado 
jorge com a senha igual à jorge@123.

CREATE LOGIN jorge WITH PASSWORD = 'jorge@123';
Copiar código
Comandos concluídos com êxito.

Daqui para frente, vamos tomar mais cuidado com as palavras usadas. Falamos que íamos "criar um usuário jorge",
mas o que estávamos fazendo é criando o login jorge. Não é o usuário jorge.

Só que existe a entidade usuário no SQL Server. Isso significa que após criar o login jorge, precisamos criar o
usuário jorge e associá-lo ao login jorge.

Para isso, usamos o comando CREATE USER para criar o usuário chamado jorge. Em seguida, digitamos FOR LOGIN 
jorge para fazer essa associação.

CREATE USER jorge FOR LOGIN jorge;
Copiar código
Comandos concluídos com êxito.

Pronto.

Login e usuários são entidades diferentes no SQL Server. Mas, a relação entre login e user é de 1:1, ou seja,
sempre 1 usuário tem associado à ele 1 login.

Contudo, o nome do usuário e do login não precisam ser os mesmos.

Algumas regras de segurança são associadas ao login e outras são associadas ao usuário.

Para exemplificar, vamos abrir outra janela do Management Studio onde aparece a caixa de diálogo de login. 
Nela, colocamos o login jorge e sua senha.

Logon: jorge
Senha: jorge@123
No momento em que apertamos o botão "Conectar", o SQL Server internamente associa esse login ao usuário associado. 
Com isso, algumas regras de segurança são configuradas.

As regras de segurança do SQL Server que conhecemos anteriormente são associadas ao login. Já as regras de 
segurança a nível de banco de dados são associadas ao usuário.

Apesar de não ser necessário, é uma boa prática colocar login e usuário com o mesmo nome.

Autorização a nivel de banco de dados
Agora que estamos conectados como jorge, vamos criar uma nova consulta para fazer um teste.

Vamos entrar na base dbVendas com o seguinte comando:

USE dbVendas
Copiar código
Comandos concluídos com êxito.

Em seguida, vamos tentar verificar o conteúdo da tabela "tb_cidade".

SELECT * FROM tb_cidade;
Copiar código
Mensagem 229, Nível 14, Estado 5, Linha 4

A permissão SELECT foi negada no objeto 'tb_cidade', banco de dados 'dbVendas', esquema 'dbo'.

O que significa esse erro que recebemos? O usuário jorge consegue entrar na base de dados, mas não consegue 
ler as tabelas. Para isso, é preciso dar um privilégio de acesso à leitura das tabelas para o usuário 
jorge - não para o login jorge.

Voltamos para o SQL Server conectado com o usuário sa e conectado na base de dados na qual vamos transmitir 
o privilégio de segurança. Nesse caso, dbVendas.

Em uma nova linha, vamos executar com o comando EXEC uma stored procedure chamada sp_addrolemember. 
Em seguida, vamos colocar como parâmetro o nome da regra que permite que Jorge leia as tabelas, ou seja,
db_datareader entre aspas simples.

Acrescentamos uma vírgula para colocar o usuário para o qual damos esse privilégio, jorge entre aspas simples.

EXEC sp_addrolemember 'db_datareader','jorge';
Copiar código
Não é preciso dizer a qual base uma vez que já estamos conectados a essa base.

Comandos concluído com êxito.

Após executar o comando, vamos voltar a janela do SQL Server com a conexão do jorge para tentar executar 
novamente a seleção da tabela "tb_cidade".

SELECT * FROM tb_cidade;
Copiar código
#	cidade	sigla_estado
1	Andradina	SP
2	Aparecida de Goiânia	GO
…	…	…
Agora, conseguimos visualizar o conteúdo da tabela.

Vamos testar outro caso. Jorge resolveu digitar o comando INSERT INTO tb_cidade nos campos cidade e 
sigla_estado para inserir os valores cidade x e SP, ambos entre aspas.

INSERT INTO tb_cidade (cidade, sigla_estado) VALUES ('cidade x', 'SP');
Copiar código
Mensagem 229, Nível 14, Estado 5, Linha 6

A permissão INSERT foi negada no objeto 'tb_cidade', banco de dados 'dbVendas', esquema 'dbo'.

Ao executar esse comando, note que Jorge não tem privilégio de incluir dados nesta tabela. Afinal, só 
demos o privilégio de leitura da tabela para jorge. E, para incluir dados, é preciso dar privilégios de escrita.

Na janela do SQL Server com a conexão do usuário sa, vamos fazer outro comando EXEC sp_addrolemember. 
Ao invés de db_datareader, vamos usar db_datawriter.

EXEC sp_addrolemember 'db_datawriter','jorge';
Copiar código
Comandos concluídos com êxito.

Pronto.

Se voltamos para a janela da conexão do jorge, podemos tentar executar o comando INSERT novamente.

(1 linha afetada)

Agora, conseguimos incluir os dados na tabela "tb_cidade".

Estas são algumas das diretivas associadas ao banco de dados:

dbowner - Os membros dessa função têm controle total do banco de dados, incluindo a capacidade de executar tarefas de gerenciamento de banco de dados, criar, modificar ou excluir objetos do banco de dados e conceder permissões a outros usuários.

db_datareader - Os membros dessa função têm permissão para ler qualquer tabela em um banco de dados específico.

db_datawriter - Os membros dessa função têm permissão para modificar dados em qualquer tabela em um banco de dados específico.

db executor - Os membros dessa função têm permissão para executar qualquer procedimento armazenado no banco de dados.

db_ddladmin - Os membros dessa função têm permissão para executar qualquer comando DDL (Data Definition Language) em um banco de dados específico.

db securityadmin - Os membros dessa função têm permissão para gerenciar permissões no banco de dados.

db_accessadmin - Os membros dessa função têm permissão para gerenciar a atribuição de permissões para usuários e funções.

db_backupoperator - Os membros dessa função têm permissão para realizar backups de banco de dados.

db_datareader e db_datawriter - Os membros dessa função têm permissão para ler e modificar dados em qualquer tabela em um banco de dados específico.

--______________________________________________________________________--

CONFIGURAÇÕES DE AUTORIZAÇÕES USANDO O SSMS

Criação de login através do SQL Server Management Studio
Estamos no Management Studio como usuário sa. No painel "Pesquisador de Objetos" à esquerda, vamos clicar com o
botão direito do mouse na pasta chamada "Logons" para escolher a opção "Novo Logon".

Na caixa de diálogo que se abre, vamos criar um novo logon claudia na página "Geral".

Também podemos escolher o tipo de autenticação, Windows ou SQL Server. Nesse caso, vamos selecionar a 
"Autenticação do SQL Server" e, em seguida, configurar uma senha.

Além disso, podemos selecionar caixas de seleção para impor uma política de senha, impor um vencimento de
senha e estabelecer que o usuário deve alterar a senha no próximo logon. Vamos desmarcas essas três caixas de seleção.

Em seguida, temos outros tipos de forma de autenticação, porém, não vamos alterá-las. Vamos manter a
autenticação do SQL Server.

Vamos clicar no dropdown da opção "Script" na parte superior e escolher "Ação do Script para a Nova 
Janela de Consulta" (ou atalho "Ctrl + Shift + N").

Dessa forma, abre-se uma janela de consulta com o comando que a caixa de diálogo vai executar:

USE [master]
GO
CREATE LOGIN [claudia] WITH PASSWORD=N'claudia', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
Copiar código
É um código parecido com o comando CREATE LOGIN que aprendemos, colocando o nome do login e a senha. 
Porém, há alguns parâmetros padrões (default) que são configurados quando não colocamos no CREATE LOGIN.

O parâmetro DEFAULT_DATABASE define a base padrão de conexão, o CHECK_EXPIRATION define se a senha vai 
ter expiração e o CHECK_POLICY define se vai ter a política de formação de senha.

Não queremos executar esse comando, mas, sim, a caixa de diálogo. Para isso, basta apertar o 
botão "OK" no canto inferior direito da caixa de diálogo "Logon - Novo".

Com isso, o usuário claudia é criado e aparece listado dentro da pasta "Logons".

Autorização através do SQL Server Management Studio
Clicamos com o botão direito na pasta "Logons" no painel à esquerda para dar um "Atualizar". 
Assim, podemos escolher o usuário jorge que criamos anteriormente.

Nele, vamos clicar com o botão direito do mouse em "jorge > Propriedades". Desse modo, abre-se
uma caixa de diálogo com as credenciais do Jorge.

Em "Selecionar uma página", vamos escolher a página "Funções de Servidor" para visualizar todos
os privilégios que o Jorge pode ter a nível de servidor.

Atualmente, ele só pode ver objetos públicos já que a única caixa marcada é public.

Contudo, se quiséssemos que o Jorge pudesse criar bases, bastaria selecionar a caixa com a opção 
dbcreator. Se quiséssemos que ele pudesse configurar as seguranças de outros usuários do banco de dados,
poderíamos escolher a caixa securityadmin.

Desse modo, podemos configurar os privilégios que o Jorge vai ter a nível de servidor SQL Server.

Agora, selecionamos a página "Mapeamento de Usuário" onde podemos visualizar o que Jorge pode fazer 
a nível de banco de dados.

Em "Usuários mapeados para este logon", note que atualmente o Jorge pode acessar dbVendas.

Se clicamos em dbVendas, logo abaixo em "Associação à função de banco de dados para: dbVendas",
aparecem marcadas as caixas das opções db_datareader, db_datawriter e public.

Dessa forma, sabemos que ele pode escrever e ler na base de dados, bem como ter acesso às bases 
públicas. Essa foi a configuração que nós fizemos anteriormente.

Além disso, podemos escolher o tipo de configuração que o Jorge pode ter nessa base ao selecionar
mais caixas.

Contudo, se escolhemos outra base como a DW_TESTE, as caixas de "Associação à função de banco de 
dados para: DW_TESTE" mudam. Pois, podemos escolher outros privilégios de acesso de Jorge nesta 
outra base.

Da mesma maneira que pudemos visualizar o script de criação quando criamos o usuário claudia, 
também podemos visualizar o script de alteração quando modificamos os parâmetros para o Jorge.

Basta clicar em "Script > Ação do Script para a Nova Janela de Consulta". Assim, temos os 
privilégios de mudança:

ALTER SERVER ROLE [dbcreator] ADD MEMBER [jorge]
GO
ALTER SERVER ROLE [securityadmin] ADD MEMBER [jorge]
GO
USE [DW_TESTE]
GO
CREATE USER [jorge] FOR LOGIN [jorge]
GO
Copiar código
Com o comando ALTER SERVER ROLE, alteramos a regra dbcreator e securityadmin para adicionar o 
jorge. Depois, vamos criar o usuário jorge e associá-lo ao login jorge.

O DBA pode configurar as seguranças não somente através de linhas de comando, mas também através
da caixa de diálogo amigável do Management Studio.

Na caixa de diálogo "Propriedades de Logon - jorge", vamos apertar o botão "OK" no canto inferior
direito para alterar as configurações do Jorge.

*/