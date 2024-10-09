/*
Escolhendo entre vers�es e configurando o ambiente

Nesse curso usaremos o case do Marcos, contratado por uma grande empresa de varejo para ser o administrador do banco de dados da empresa, o DBA.

Vers�es do SQL Server
O banco de dados escolhido pela empresa foi o SQL Server. Sendo assim, a primeira miss�o de Marcos � escolher a vers�o do SQL Server que ser� utilizada.

Para isso, ele precisar� considerar v�rios fatores, como:

Requisitos do sistema
� preciso garantir que o hardware e o sistema operacional sejam compat�veis com a vers�o escolhida.

Funcionalidades necess�rias
Cada vers�o oferece um conjunto diferente de recursos e funcionalidades, � preciso escolher o que mais se ad�qua ao seu ambiente de neg�cios.

Licenciamento
O SQL possui diferentes op��es, incluindo licen�as por n�cleo ou por servidor.

Escalabilidade
� necess�rio que o SQL escolhido tenha possibilidade de ser escal�vel, j� que ele espera que o uso do banco de dados cres�a ao longo do tempo.

Suporte
� preciso entender o tipo de suporte oferecido por cada vers�o do SQL Server.

Seguran�a
Dependendo da vers�o escolhida, Marcos ter� acesso a recursos mais ou menos avan�ados de seguran�a.

On premise ou nuvem
Por fim, o profissional precisa decidir onde instalar o SQL Server. Podendo ser um premisse, ou seja, no servidor da empresa ou em nuvem.

Essa decis�o � fundamental, afinal, se ele optar por uma instala��o em nuvem, muitas atividades exercidas ser�o repassadas pelo administrador da nuvem, como o backup ou administra��o do espa�o f�sico das bases de dados.

Atualmente, os tr�s mais utilizados s�o o Azure da Microsoft, o Google Cloud e a AWS da Amazon.

Analisando esse cen�rio, Marcos decidiu utilizar a vers�o SQL Server 2022 e realizar a instala��o on premise.

Por�m, al�m dessas escolhas, existem tipos diferentes de edi��es. Sendo:

Enterprise Edition
Essa edi��o oferece recursos avan�ados de autodesempenho e seguran�a. � muito utilizado por empresas corporativas.

Standard Edition
Oferece recursos b�sicos de gerenciamento de banco de dados, relat�rios, integra��es e an�lises de dados. � voltada para empresas de pequeno e m�dio porte.

Express Edition
Essa � uma edi��o gratuita, ideal para desenvolvedores e organiza��es que precisam de uma plataforma de banco de dados b�sica para aplicativos de pequeno porte.

Developer Edition
Uma vers�o mais completa, projetada exclusivamente para desenvolvimento e teste.

Conclus�es
Analisando essas op��es, Marcos percebe que somente Enterprise Edition e Standard Edition s�o pagas e para uso comercial.

No caso da Express Edition � poss�vel utiliz�-la comercialmente, por�m � preciso considerar que � limitada a uma base de dados pequenas.

Pensando disso, Marcos escolhe a Enterprise Edition, afinal, a empresa na qual trabalha � muito grande.

Nesse curso, colocaremos em pr�tica todas as atividades do dia a dia do Marcos. Sendo assim, mesmo com a escolha do Marcos, utilizaremos a vers�o Developer Edition, assim n�o ser� preciso pagar nenhuma licen�a de uso.

---------------------------------------------------------------------------------------------

Preparando o ambiente: instalando o SQL Server vers�o 2022 - Delevoper Edition

Abra uma sess�o de Browser e busque por: download microsoft sql 2022

Nesta p�gina, iremos escolher baixar a vers�o SQL Server Developer Edition.
Clique no bot�o Download now .
Execute o arquivo baixado.

Temos 3 tipos de instala��es:
B�sico: que instala os mecanismos b�sicos de banco de dados:,
Personalizado: que obriga a voc� incluir todos os par�metros de instala��o; e
Baixar m�dia: para voc� baixar o instalador e instalar em uma m�quina sem acesso a internet.
Iremos escolher a op��o Personalizado.

Selecione o local onde o instalador ser� baixado. Escolha um diret�rio que haja espa�o para baixar o instalador. 
Depois clique em Instalar.

Aguarde o download do instalador.

Ap�s o download voc� ver� esta caixa de di�logo:
Selecione a op��o Instala��o, localizada � esquerda da tela (no menu com o t�tulo de 'Planejamento').

Depois escolha a op��o Nova instala��o aut�noma do SQL Server ou adicionar recursos a uma instala��o existente.

Nesta caixa de di�logo mantenha em Especifique a uma edi��o gratuita a op��o Developer . Depois clique em Avan�ar.

Marque a op��o Aceito as condi��es e os termos de licen�a e clique em Avan�ar.

Os requisitos da instala��o s�o conferidos. Ignore o aviso do Firewall do Windows. 
Depois da confer�ncia, se tudo estiver correto, clique em Avan�ar.

Na pr�xima caixa de di�logo ser� perguntado se a extens�o para o Azure deve ser instalada.

No seu caso voc� vai usar a instala��o local. Por isso desmarque a op��o Extens�o do Azure para SQL Server . 
Clique depois em Avan�ar.

Na pr�xima caixa de di�logo escolhemos os m�dulos do SQL Server que dever�o ser instalados. Escolha apenas a 
op��o Servi�os de mecanismos de banco de dados . Caso seja poss�vel mantenha o diret�rio padr�o para a instala��o 
do SQL Server. Finalizando clique em Avan�ar.

Na pr�xima caixa de di�logo especifique o nome da inst�ncia do banco. Um servidor pode ter mais de uma inst�ncia. 
No caso aqui, como a m�quina est� limpa, � apresentada uma sugest�o para o nome da inst�ncia. Mantenha o nome 
apresentado na caixa de di�logo selecionando a op��o Inst�ncia padr�o . Depois clique em Avan�ar.

S�o apresentados os servi�os a serem criados no servidor bem como o nome da conta de gerenciamento de cada um deles.
Mantenha o padr�o apresentado na tela. Clique em Avan�ar.

Nesta pr�xima caixa de di�logo iremos escolher o m�todo de autentica��o. Selecione o Modo Misto (Autentica��o do SQL 
Server e do Windows). Quando esta op��o � selecionada voc� deve especificar a senha para o usu�rio sa, que � o usu�rio
administrador do SQL Server. Digite e confirme a senha deste usu�rio.

Logo abaixo, voc� dever� especificar o usu�rio Windows que ser� administrador do servidor. Ter� os mesmos 
privil�gios do usu�rio sa . Clique sobre o bot�o Adicionar usu�rio atual .

Depois clique em Avan�ar .

Voc� ent�o ver� todas as op��es escolhidas para instala��o. Confira as op��es e clique em Instalar .

Aguarde alguns instantes at� a instala��o ser finalizada.
---------------------------
Instalando o Microsoft SQL Server Management Studio ou SSMS.
Para isso abra outra sess�o do browser e busque por SQL Management Studio Download:

Clique em Free Download for SQL Server Management Studio (SSMS) . Escolha sempre a vers�o mais atual apresentada no site.

Escolha o local de instala��o do SSMS e clique em Instalar.

Aguarde alguns instantes e voc� ver� a caixa de di�logo com mensagem que a instala��o do SSMS foi executada com sucesso.

Teste o acesso ao SQL Server.

Procure pelo SQL Server Management Studio.

Digite o login e senha do usu�rio sa. Voc� deve usar a senha que criou durante a instala��o do SQL Server.

Pronto. Voc� agora tem acesso ao SQL Server.
*/
----------------------------------

/*
Uma base de dados SQL Server � dividida em duas partes:

Arquivo f�sico onde v�o estar os dados
Arquivo f�sico dos logs de transa��es que s�o os comandos salvos para recuperar poss�veis dados perdidos durante o processo de inclus�o, altera��es, exclus�o ou consulta.
Quando iniciamos uma transa��o no banco de dados, salvamos os comandos dentro do log de transa��o. Dessa forma, ao dar um commit, salvamos os comandos na base de dados. Se damos um rollback, voltamos a posi��o do banco no momento em que come�amos a transa��o.

O log de transa��o faz esse gerenciamento de salvar os dados de forma provis�ria antes de serem confirmados e gravadas na base de dados.
*/

CREATE DATABASE [dbVendas]
 ON  PRIMARY ( 
 NAME = N'dbVendas', 
 FILENAME = N'D:\DATA\ARQUIVO_DADOS\dbVendas.MDF', 
 SIZE = 100MB, 
 MAXSIZE = 200MB, 
 FILEGROWTH = 50MB )
 LOG ON ( 
 NAME = N'dbVendasLOG', 
 FILENAME = N'D:\DATA\LOG_TRANSACOES\dbVendasLOG.LDF', 
 SIZE = 100MB, 
 MAXSIZE = 200MB, 
 FILEGROWTH = 50MB );
--------------------------------------

/*
Entrada de dados:
O comando EXEC IncluiNotasDia vai simular a entrada de dados na base de dados para o dia 
primeiro de janeiro de 2022. O mesmo acontece para os comandos para o dia dois e dia tr�s.

O comando cargaBase 2022, 1, 2022, 2 vai simular entradas de dados de notas fiscais em todos 
os dias de janeiro e fevereiro. � como se as pessoas usu�rias tivessem usando o sistema 
durante dois meses.
*/
EXEC IncluiNotasDia '2022-01-01'
EXEC IncluiNotasDia '2022-01-02'
EXEC IncluiNotasDia '2022-01-03'
EXEC cargaBase 2022, 1, 2022, 2

SELECT COUNT(*) FROM tb_nota

/*
SHRINKDATABASE reduz a base de dados. Os dados reduzidos s�o devolvidos para o sistema operacional para us�-los para outros fins.
� como se fosse um comando defrag no disco. Quando utilizamos o disco para armazenar dados, seja porque estamos editando um 
arquivo comum ou um arquivo f�sico do banco de dados, os blocos de mem�rias v�o ser gravados dentro do disco em uma sequ�ncia.
Cada vez que essa bloco de mem�ria grava dados, o arquivo cresce. � medida que exclu�mos ou alteramos dados dentro desse arquivo, 
v�o ficando blocos de mem�ria vazios na �rea reservada do disco.
Em outras palavras, internamente existem blocos que n�o s�o mais usados, mas que ainda contam para o tamanho do arquivo, 
deixando-o maior.
No momento em que executamos o comando defrag, esses blocos de mem�ria s�o retirados do arquivo e n�o contam mais para seu 
tamanho. Desse modo, s�o liberados para o sistema operacional. Com isso, o arquivo reduz o tamanho sem perder dados.
*/
DBCC SHRINKDATABASE ('dbVendas',TRUNCATEONLY);

select COUNT(*) from tb_nota
-------------------------------------
/*
criando e apagando uma base de dados, por via de comando e atrav�s do Managerment Studio
*/
-- criando a dbVendas3...
CREATE DATABASE [dbVendas3]
 ON  PRIMARY ( 
 NAME = N'dbVendas3', 
 FILENAME = N'F:\DATA\ARQUIVO_DADOS\dbVendas3.MDF', 
 SIZE = 100MB, 
 MAXSIZE = 200MB, 
 FILEGROWTH = 50MB )
 LOG ON ( 
 NAME = N'dbVendas3LOG', 
 FILENAME = N'F:\DATA\LOG_TRANSACOES\dbVendas3LOG.LDF', 
 SIZE = 100MB, 
 MAXSIZE = 200MB, 
 FILEGROWTH = 50MB );
 -- excluindo a dbVendas3...
 DROP DATABASE dbVendas3;
 ------------------------------

/*
salvando os dados para o caso de ocorrer algum problema, realiza��o do BACKUP
*/
SELECT COUNT(*) FROM tb_nota;

-- 3411 notas
-- fazendo um beckup do db, no caso, um beckup full
BACKUP DATABASE dbVendas TO DISK = 'D:\DATA\BACKUP\DBVENDAS.BAK';
-- adicionando dados
EXEC IncluiNotasDia '2022-03-01'
-- fazendo outro beckup do db paraa aquele dia (digamos que seja feito um beckup todo dia)
BACKUP DATABASE dbVendas TO DISK = 'F:\DATA\BACKUP\DBVENDAS_2.BAK';

/*recuperando o db com beckup*/
-- verificar o que tem dentro do arquivo
RESTORE HEADERONLY FROM DISK = 'F:\DATA\BACKUP\DBVENDAS_2.BAK';
-- para recuperar uma base utilizando o beckup, � necess�rio excluir a base que ser� restaurada
USE MASTER
DROP DATABASE dbVendas
-- comando para recuperar a base, incluindo transa��es 
RESTORE DATABASE dbVendas FROM DISK = 'F:\DATA\BACKUP\DBVENDAS_2.BAK' WITH RECOVERY;
-----------------------------
/*
Fazendo backup usando o SSMS (SQL Server Management Studio).

No menu lateral esquerdo, clicaremos com o bot�o direito na pasta "Banco de dados" e selecionaremos a op��o "Atualizar".
Em seguida, clicaremos com o bot�o direito do mouse sobre a nossa base de dados, no caso, "dbVendas" e navegaremos 
para "Tarefas > Fazer Backup". Com isso, abrimos a janela "Backup de Banco de Dados - dbVendas".

Nessa janela, temos a se��o "Destino", onde tem o campo "Efetuar backup para:". Na caixa abaixo desse campo, temos o 
endere�o do �ltimo backup que foi executado para essa base. Com ele selecionado, clicaremos no bot�o "Remover", na 
lateral direita dessa caixa.

Em seguida, clicaremos no bot�o "Adicionar", tamb�m do lado direito da caixa. Ao fazermos isso, abrimos a 
janela "Selecionar Destino do Backup", onde temos um campo para adicionarmos o endere�o com o nome do arquivo.
Ao lado direito desse campo, tem um bot�o com retic�ncias "�", no qual iremos clicar. Assim abrimos a 
janela "Localizar Arquivos de Banco de Dados".

Nessa janela, navegaremos pelos nossos diret�rios at� encontrarmos a pasta "BACKUP" que criamos e, na parte 
inferior da janela, no campo "Nome do arquivo", escreveremos "DBVENDA_1.BAK". Em seguida, clicaremos
em "OK", para fechar essa janela e voltar para a de sele��o do destino, onde tamb�m clicaremos no 
bot�o "OK" para fech�-la.
*/
-----------------------
/*
Recuperando o backup usando o SSMS (SQL Server Management Studio).

Para recuperarmos o backup, acessaremos o menu da esquerda e clicaremos com bot�o direito do mouse sobre o banco "dbVendas".
Selecionaremos a op��o "Excluir", que abrir� a janela "Excluir Objeto". Na parte inferior da janela, marcaremos a 
caixa "Fechar conex�es existentes" e clicaremos no bot�o "OK", no canto inferior direito da janela.

Dessa forma, exclu�mos o banco de dados "dbVendas", como podemos observar na coluna da esquerda. Feito isso, clicaremos 
na pasta "Banco de Dados" com o bot�o direito do mouse e selecionamos a op��o "Restaurar Banco de Dados", abrindo a janela 
de mesmo nome.

Nessa janela, temos a se��o "Origem", com duas op��es de sele��o: Banco de dados e Dispositivo. Selecionamos a op��o 
Dispositivo, desbloqueando a caixa de texto da op��o. No lado direito dessa caixa de texto, temos o bot�o com 
retic�ncias "�", no qual clicaremos, abrindo a janela "Selecione dispositivos de backup".

Nessa janela, clicaremos no bot�o "Adicionar", que est� no lado direito da caixa branca. Assim, abrimos a 
janela "Localizar Arquivo de Backup", onde navegaremos no menu da esquerda at� nossa pasta "BACKUP". Ao encontrarmos 
a pasta, os arquivos de backup dentro dela aparecer�o no lado direito.

Come�aremos selecionando o DBVENDA_2.BAK, e clicaremos em "OK". Na janela "Selecione dispositivos de backup", tamb�m 
clicaremos em OK". Fazendo isso, voltamos para janela "Restaurar Banco de Dados". Nela, temos a 
se��o "Plano de Restaura��o", onde tem a caixa "Conjuntos de backup a serem restaurados".

Nessa caixa, apareceu uma tabela que, pelos dados, observamos que � o mesmo comando que foi mostrado no v�deo sobre 
recupera��o de backup, com o qual conseguimos ver quantos backups n�s temos. No caso, temos apenas um backup salvo 
associado ao arquivo DBVENDA_2.BAK. Rolando a tabela da direita para esquerda, encontramos os campos com a data desse backup.

Na lateral esquerda dessa janela, temos uma menu de sele��o de p�gina com as op��es: Geral, Arquivos e Op��es. 
Ao clicarmos em Arquivos, encontramos uma tabela com algumas informa��es do backup.

Com isso, observamos que o pr�prio backup salva a localiza��o onde o arquivo ser� recuperado. Por isso que, 
quando usamos linha de comando, os arquivos de DATA e LOG foram salvos em diret�rios espec�ficos onde deveriam estar.

Uma op��o interessante � substituirmos o banco de dados existente. Para isso, clicamos em "Op��es", no menu 
lateral esquerdo. Ele abre uma nova p�gina no lado direito da janela, onde temos a se��o "Op��es de restaura��o". 
Nela, podemos marcar a caixa de sele��o "Substituir o banco de dados existente (WITH REPLACE)".

Isso significa que n�o precisar�amos ter deletado a base de dados, porque o banco existente seria substitu�do. 
Isso porque ele roda a cl�usula WITH REPLACE, que poder�amos ter executado na linha de comando. No pr�ximo backup, 
podemos tentar recuperar sem deletar a base. Agora, basta clicarmos no bot�o "OK", no canto inferior direito da janela.

Recebemos a mensagem informando que o banco de dados foi restaurado com �xito. Clicando no "OK" da janela de 
mensagem, fechamos as janelas abertas e voltamos para o Management Studio. Na coluna da esquerda, podemos observar 
que o banco "dbVendas" voltou para a lista.
*/
--------------
/*
Sobre arquivos de beckups

O processo de backup � fundamental para garantir a seguran�a e a integridade dos dados em um banco de dados, 
pois consiste em fazer c�pias dos dados e logs de transa��o para que, em caso de falhas, seja poss�vel recuper�-los. 
Al�m disso, o backup pode ser usado em migra��es de bancos de dados entre ambientes.

Existem tr�s tipos de backup no SQL Server:

o backup full;
o backup diferencial e;
o backup de transa��es log ou transact backup.
Ao executar um backup completo, o SQL Server armazena todas as informa��es em um arquivo externo, 
incluindo nome do banco de dados, data de cria��o, op��es definidas, caminhos dos arquivos e outros 
metadados importantes. Al�m disso, o backup full armazena todas as p�ginas de dados, n�meros e informa��es 
propriamente ditas, bem como todos os logs de transa��es existentes no arquivo log.

� importante ressaltar que os backups n�o s�o arquivos instaladores e n�o criam pastas, eles apenas reescrevem
o arquivo sobre o arquivo de dados do banco de dados atual. O nome do arquivo de backup � arbitr�rio, podendo 
ser especificado qualquer nome, mas � recomendado usar a extens�o .BAK. � poss�vel armazenar mais de um arquivo
de backup dentro do mesmo arquivo .BAK.
*/

--_____________________________________________________________--
/*
-- RESUMO 

Nesse curso, colocamos em pr�tica as fun��es realizadas pelo Marcos, DBA em SQL Server em uma grande empresa de varejo.

A partir disso, come�amos aprendendo quais s�o as principais fun��es da pessoa Administradora de Banco de Dados, como:

Avaliar o hardware na qual a base de dados ser� executada;
Instalar o software;
Criar o banco de dados;
Fazer backups;
Gerenciar usu�rios;
Gerenciar a performance do banco de dados.
Depois analisamos as op��es dispon�veis do SQL Server e instalamos a vers�o 2022 Developer e fizemos uma conex�o com a base de dados.

Em seguida, conhecemos a estrutura e gerenciamento da base de dados. Descobrimos que podem existir arquivos prim�rios que possuem dados, objetos e podem ter nome e localiza��o especificados e tamb�m a estrutura de log para recupera��o dos dados.

Nisso, aprendemos como acontece o crescimento da base de dados e como podemos deix�-la menor, maior e at� mesmo como exclu�-la.

Na aula seguinte, estudamos o backup full, que faz uma c�pia completa da base de dados, e como recuperar os backups por meio do comando RESTORE.

Depois, estudamos as pol�ticas do backup que mesclam os backups full, de log e incrementais que garantem a integridade da base de dados. Para exemplificar, apresentamos um exemplo de pol�tica criada pelo Marcos conforme a demanda do sistema.

Ap�s conhecemos os tipos de acesso dos usu�rios do pr�prio SQL Server e tamb�m como criar usu�rios do Windows, associando-os ao SQL Server.

Por fim, estudamos os dois tipos autoriza��es no SQL Server, sendo ao n�vel de servidor, que permite autoriza��o para o usu�rio criar outros usu�rios, por exemplo. Al�m das autoriza��es a n�vel de dados que permite a visualiza��o ou manipula��o de dados de uma tabela.

Encerramos aqui. Te esperamos em outros cursos da plataforma.

*/
