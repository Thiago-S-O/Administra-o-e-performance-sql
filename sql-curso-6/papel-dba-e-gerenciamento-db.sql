/*
Escolhendo entre versões e configurando o ambiente

Nesse curso usaremos o case do Marcos, contratado por uma grande empresa de varejo para ser o administrador do banco de dados da empresa, o DBA.

Versões do SQL Server
O banco de dados escolhido pela empresa foi o SQL Server. Sendo assim, a primeira missão de Marcos é escolher a versão do SQL Server que será utilizada.

Para isso, ele precisará considerar vários fatores, como:

Requisitos do sistema
É preciso garantir que o hardware e o sistema operacional sejam compatíveis com a versão escolhida.

Funcionalidades necessárias
Cada versão oferece um conjunto diferente de recursos e funcionalidades, é preciso escolher o que mais se adéqua ao seu ambiente de negócios.

Licenciamento
O SQL possui diferentes opções, incluindo licenças por núcleo ou por servidor.

Escalabilidade
É necessário que o SQL escolhido tenha possibilidade de ser escalável, já que ele espera que o uso do banco de dados cresça ao longo do tempo.

Suporte
É preciso entender o tipo de suporte oferecido por cada versão do SQL Server.

Segurança
Dependendo da versão escolhida, Marcos terá acesso a recursos mais ou menos avançados de segurança.

On premise ou nuvem
Por fim, o profissional precisa decidir onde instalar o SQL Server. Podendo ser um premisse, ou seja, no servidor da empresa ou em nuvem.

Essa decisão é fundamental, afinal, se ele optar por uma instalação em nuvem, muitas atividades exercidas serão repassadas pelo administrador da nuvem, como o backup ou administração do espaço físico das bases de dados.

Atualmente, os três mais utilizados são o Azure da Microsoft, o Google Cloud e a AWS da Amazon.

Analisando esse cenário, Marcos decidiu utilizar a versão SQL Server 2022 e realizar a instalação on premise.

Porém, além dessas escolhas, existem tipos diferentes de edições. Sendo:

Enterprise Edition
Essa edição oferece recursos avançados de autodesempenho e segurança. É muito utilizado por empresas corporativas.

Standard Edition
Oferece recursos básicos de gerenciamento de banco de dados, relatórios, integrações e análises de dados. É voltada para empresas de pequeno e médio porte.

Express Edition
Essa é uma edição gratuita, ideal para desenvolvedores e organizações que precisam de uma plataforma de banco de dados básica para aplicativos de pequeno porte.

Developer Edition
Uma versão mais completa, projetada exclusivamente para desenvolvimento e teste.

Conclusões
Analisando essas opções, Marcos percebe que somente Enterprise Edition e Standard Edition são pagas e para uso comercial.

No caso da Express Edition é possível utilizá-la comercialmente, porém é preciso considerar que é limitada a uma base de dados pequenas.

Pensando disso, Marcos escolhe a Enterprise Edition, afinal, a empresa na qual trabalha é muito grande.

Nesse curso, colocaremos em prática todas as atividades do dia a dia do Marcos. Sendo assim, mesmo com a escolha do Marcos, utilizaremos a versão Developer Edition, assim não será preciso pagar nenhuma licença de uso.

---------------------------------------------------------------------------------------------

Preparando o ambiente: instalando o SQL Server versão 2022 - Delevoper Edition

Abra uma sessão de Browser e busque por: download microsoft sql 2022

Nesta página, iremos escolher baixar a versão SQL Server Developer Edition.
Clique no botão Download now .
Execute o arquivo baixado.

Temos 3 tipos de instalações:
Básico: que instala os mecanismos básicos de banco de dados:,
Personalizado: que obriga a você incluir todos os parâmetros de instalação; e
Baixar mídia: para você baixar o instalador e instalar em uma máquina sem acesso a internet.
Iremos escolher a opção Personalizado.

Selecione o local onde o instalador será baixado. Escolha um diretório que haja espaço para baixar o instalador. 
Depois clique em Instalar.

Aguarde o download do instalador.

Após o download você verá esta caixa de diálogo:
Selecione a opção Instalação, localizada à esquerda da tela (no menu com o título de 'Planejamento').

Depois escolha a opção Nova instalação autônoma do SQL Server ou adicionar recursos a uma instalação existente.

Nesta caixa de diálogo mantenha em Especifique a uma edição gratuita a opção Developer . Depois clique em Avançar.

Marque a opção Aceito as condições e os termos de licença e clique em Avançar.

Os requisitos da instalação são conferidos. Ignore o aviso do Firewall do Windows. 
Depois da conferência, se tudo estiver correto, clique em Avançar.

Na próxima caixa de diálogo será perguntado se a extensão para o Azure deve ser instalada.

No seu caso você vai usar a instalação local. Por isso desmarque a opção Extensão do Azure para SQL Server . 
Clique depois em Avançar.

Na próxima caixa de diálogo escolhemos os módulos do SQL Server que deverão ser instalados. Escolha apenas a 
opção Serviços de mecanismos de banco de dados . Caso seja possível mantenha o diretório padrão para a instalação 
do SQL Server. Finalizando clique em Avançar.

Na próxima caixa de diálogo especifique o nome da instância do banco. Um servidor pode ter mais de uma instância. 
No caso aqui, como a máquina está limpa, é apresentada uma sugestão para o nome da instância. Mantenha o nome 
apresentado na caixa de diálogo selecionando a opção Instância padrão . Depois clique em Avançar.

São apresentados os serviços a serem criados no servidor bem como o nome da conta de gerenciamento de cada um deles.
Mantenha o padrão apresentado na tela. Clique em Avançar.

Nesta próxima caixa de diálogo iremos escolher o método de autenticação. Selecione o Modo Misto (Autenticação do SQL 
Server e do Windows). Quando esta opção é selecionada você deve especificar a senha para o usuário sa, que é o usuário
administrador do SQL Server. Digite e confirme a senha deste usuário.

Logo abaixo, você deverá especificar o usuário Windows que será administrador do servidor. Terá os mesmos 
privilégios do usuário sa . Clique sobre o botão Adicionar usuário atual .

Depois clique em Avançar .

Você então verá todas as opções escolhidas para instalação. Confira as opções e clique em Instalar .

Aguarde alguns instantes até a instalação ser finalizada.
---------------------------
Instalando o Microsoft SQL Server Management Studio ou SSMS.
Para isso abra outra sessão do browser e busque por SQL Management Studio Download:

Clique em Free Download for SQL Server Management Studio (SSMS) . Escolha sempre a versão mais atual apresentada no site.

Escolha o local de instalação do SSMS e clique em Instalar.

Aguarde alguns instantes e você verá a caixa de diálogo com mensagem que a instalação do SSMS foi executada com sucesso.

Teste o acesso ao SQL Server.

Procure pelo SQL Server Management Studio.

Digite o login e senha do usuário sa. Você deve usar a senha que criou durante a instalação do SQL Server.

Pronto. Você agora tem acesso ao SQL Server.
*/
----------------------------------

/*
Uma base de dados SQL Server é dividida em duas partes:

Arquivo físico onde vão estar os dados
Arquivo físico dos logs de transações que são os comandos salvos para recuperar possíveis dados perdidos durante o processo de inclusão, alterações, exclusão ou consulta.
Quando iniciamos uma transação no banco de dados, salvamos os comandos dentro do log de transação. Dessa forma, ao dar um commit, salvamos os comandos na base de dados. Se damos um rollback, voltamos a posição do banco no momento em que começamos a transação.

O log de transação faz esse gerenciamento de salvar os dados de forma provisória antes de serem confirmados e gravadas na base de dados.
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
primeiro de janeiro de 2022. O mesmo acontece para os comandos para o dia dois e dia três.

O comando cargaBase 2022, 1, 2022, 2 vai simular entradas de dados de notas fiscais em todos 
os dias de janeiro e fevereiro. É como se as pessoas usuárias tivessem usando o sistema 
durante dois meses.
*/
EXEC IncluiNotasDia '2022-01-01'
EXEC IncluiNotasDia '2022-01-02'
EXEC IncluiNotasDia '2022-01-03'
EXEC cargaBase 2022, 1, 2022, 2

SELECT COUNT(*) FROM tb_nota

/*
SHRINKDATABASE reduz a base de dados. Os dados reduzidos são devolvidos para o sistema operacional para usá-los para outros fins.
É como se fosse um comando defrag no disco. Quando utilizamos o disco para armazenar dados, seja porque estamos editando um 
arquivo comum ou um arquivo físico do banco de dados, os blocos de memórias vão ser gravados dentro do disco em uma sequência.
Cada vez que essa bloco de memória grava dados, o arquivo cresce. À medida que excluímos ou alteramos dados dentro desse arquivo, 
vão ficando blocos de memória vazios na área reservada do disco.
Em outras palavras, internamente existem blocos que não são mais usados, mas que ainda contam para o tamanho do arquivo, 
deixando-o maior.
No momento em que executamos o comando defrag, esses blocos de memória são retirados do arquivo e não contam mais para seu 
tamanho. Desse modo, são liberados para o sistema operacional. Com isso, o arquivo reduz o tamanho sem perder dados.
*/
DBCC SHRINKDATABASE ('dbVendas',TRUNCATEONLY);

select COUNT(*) from tb_nota
-------------------------------------
/*
criando e apagando uma base de dados, por via de comando e através do Managerment Studio
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
salvando os dados para o caso de ocorrer algum problema, realização do BACKUP
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
-- para recuperar uma base utilizando o beckup, é necessário excluir a base que será restaurada
USE MASTER
DROP DATABASE dbVendas
-- comando para recuperar a base, incluindo transações 
RESTORE DATABASE dbVendas FROM DISK = 'F:\DATA\BACKUP\DBVENDAS_2.BAK' WITH RECOVERY;
-----------------------------
/*
Fazendo backup usando o SSMS (SQL Server Management Studio).

No menu lateral esquerdo, clicaremos com o botão direito na pasta "Banco de dados" e selecionaremos a opção "Atualizar".
Em seguida, clicaremos com o botão direito do mouse sobre a nossa base de dados, no caso, "dbVendas" e navegaremos 
para "Tarefas > Fazer Backup". Com isso, abrimos a janela "Backup de Banco de Dados - dbVendas".

Nessa janela, temos a seção "Destino", onde tem o campo "Efetuar backup para:". Na caixa abaixo desse campo, temos o 
endereço do último backup que foi executado para essa base. Com ele selecionado, clicaremos no botão "Remover", na 
lateral direita dessa caixa.

Em seguida, clicaremos no botão "Adicionar", também do lado direito da caixa. Ao fazermos isso, abrimos a 
janela "Selecionar Destino do Backup", onde temos um campo para adicionarmos o endereço com o nome do arquivo.
Ao lado direito desse campo, tem um botão com reticências "…", no qual iremos clicar. Assim abrimos a 
janela "Localizar Arquivos de Banco de Dados".

Nessa janela, navegaremos pelos nossos diretórios até encontrarmos a pasta "BACKUP" que criamos e, na parte 
inferior da janela, no campo "Nome do arquivo", escreveremos "DBVENDA_1.BAK". Em seguida, clicaremos
em "OK", para fechar essa janela e voltar para a de seleção do destino, onde também clicaremos no 
botão "OK" para fechá-la.
*/
-----------------------
/*
Recuperando o backup usando o SSMS (SQL Server Management Studio).

Para recuperarmos o backup, acessaremos o menu da esquerda e clicaremos com botão direito do mouse sobre o banco "dbVendas".
Selecionaremos a opção "Excluir", que abrirá a janela "Excluir Objeto". Na parte inferior da janela, marcaremos a 
caixa "Fechar conexões existentes" e clicaremos no botão "OK", no canto inferior direito da janela.

Dessa forma, excluímos o banco de dados "dbVendas", como podemos observar na coluna da esquerda. Feito isso, clicaremos 
na pasta "Banco de Dados" com o botão direito do mouse e selecionamos a opção "Restaurar Banco de Dados", abrindo a janela 
de mesmo nome.

Nessa janela, temos a seção "Origem", com duas opções de seleção: Banco de dados e Dispositivo. Selecionamos a opção 
Dispositivo, desbloqueando a caixa de texto da opção. No lado direito dessa caixa de texto, temos o botão com 
reticências "…", no qual clicaremos, abrindo a janela "Selecione dispositivos de backup".

Nessa janela, clicaremos no botão "Adicionar", que está no lado direito da caixa branca. Assim, abrimos a 
janela "Localizar Arquivo de Backup", onde navegaremos no menu da esquerda até nossa pasta "BACKUP". Ao encontrarmos 
a pasta, os arquivos de backup dentro dela aparecerão no lado direito.

Começaremos selecionando o DBVENDA_2.BAK, e clicaremos em "OK". Na janela "Selecione dispositivos de backup", também 
clicaremos em OK". Fazendo isso, voltamos para janela "Restaurar Banco de Dados". Nela, temos a 
seção "Plano de Restauração", onde tem a caixa "Conjuntos de backup a serem restaurados".

Nessa caixa, apareceu uma tabela que, pelos dados, observamos que é o mesmo comando que foi mostrado no vídeo sobre 
recuperação de backup, com o qual conseguimos ver quantos backups nós temos. No caso, temos apenas um backup salvo 
associado ao arquivo DBVENDA_2.BAK. Rolando a tabela da direita para esquerda, encontramos os campos com a data desse backup.

Na lateral esquerda dessa janela, temos uma menu de seleção de página com as opções: Geral, Arquivos e Opções. 
Ao clicarmos em Arquivos, encontramos uma tabela com algumas informações do backup.

Com isso, observamos que o próprio backup salva a localização onde o arquivo será recuperado. Por isso que, 
quando usamos linha de comando, os arquivos de DATA e LOG foram salvos em diretórios específicos onde deveriam estar.

Uma opção interessante é substituirmos o banco de dados existente. Para isso, clicamos em "Opções", no menu 
lateral esquerdo. Ele abre uma nova página no lado direito da janela, onde temos a seção "Opções de restauração". 
Nela, podemos marcar a caixa de seleção "Substituir o banco de dados existente (WITH REPLACE)".

Isso significa que não precisaríamos ter deletado a base de dados, porque o banco existente seria substituído. 
Isso porque ele roda a cláusula WITH REPLACE, que poderíamos ter executado na linha de comando. No próximo backup, 
podemos tentar recuperar sem deletar a base. Agora, basta clicarmos no botão "OK", no canto inferior direito da janela.

Recebemos a mensagem informando que o banco de dados foi restaurado com êxito. Clicando no "OK" da janela de 
mensagem, fechamos as janelas abertas e voltamos para o Management Studio. Na coluna da esquerda, podemos observar 
que o banco "dbVendas" voltou para a lista.
*/
--------------
/*
Sobre arquivos de beckups

O processo de backup é fundamental para garantir a segurança e a integridade dos dados em um banco de dados, 
pois consiste em fazer cópias dos dados e logs de transação para que, em caso de falhas, seja possível recuperá-los. 
Além disso, o backup pode ser usado em migrações de bancos de dados entre ambientes.

Existem três tipos de backup no SQL Server:

o backup full;
o backup diferencial e;
o backup de transações log ou transact backup.
Ao executar um backup completo, o SQL Server armazena todas as informações em um arquivo externo, 
incluindo nome do banco de dados, data de criação, opções definidas, caminhos dos arquivos e outros 
metadados importantes. Além disso, o backup full armazena todas as páginas de dados, números e informações 
propriamente ditas, bem como todos os logs de transações existentes no arquivo log.

É importante ressaltar que os backups não são arquivos instaladores e não criam pastas, eles apenas reescrevem
o arquivo sobre o arquivo de dados do banco de dados atual. O nome do arquivo de backup é arbitrário, podendo 
ser especificado qualquer nome, mas é recomendado usar a extensão .BAK. É possível armazenar mais de um arquivo
de backup dentro do mesmo arquivo .BAK.
*/

--_____________________________________________________________--
/*
-- RESUMO 

Nesse curso, colocamos em prática as funções realizadas pelo Marcos, DBA em SQL Server em uma grande empresa de varejo.

A partir disso, começamos aprendendo quais são as principais funções da pessoa Administradora de Banco de Dados, como:

Avaliar o hardware na qual a base de dados será executada;
Instalar o software;
Criar o banco de dados;
Fazer backups;
Gerenciar usuários;
Gerenciar a performance do banco de dados.
Depois analisamos as opções disponíveis do SQL Server e instalamos a versão 2022 Developer e fizemos uma conexão com a base de dados.

Em seguida, conhecemos a estrutura e gerenciamento da base de dados. Descobrimos que podem existir arquivos primários que possuem dados, objetos e podem ter nome e localização especificados e também a estrutura de log para recuperação dos dados.

Nisso, aprendemos como acontece o crescimento da base de dados e como podemos deixá-la menor, maior e até mesmo como excluí-la.

Na aula seguinte, estudamos o backup full, que faz uma cópia completa da base de dados, e como recuperar os backups por meio do comando RESTORE.

Depois, estudamos as políticas do backup que mesclam os backups full, de log e incrementais que garantem a integridade da base de dados. Para exemplificar, apresentamos um exemplo de política criada pelo Marcos conforme a demanda do sistema.

Após conhecemos os tipos de acesso dos usuários do próprio SQL Server e também como criar usuários do Windows, associando-os ao SQL Server.

Por fim, estudamos os dois tipos autorizações no SQL Server, sendo ao nível de servidor, que permite autorização para o usuário criar outros usuários, por exemplo. Além das autorizações a nível de dados que permite a visualização ou manipulação de dados de uma tabela.

Encerramos aqui. Te esperamos em outros cursos da plataforma.

*/
