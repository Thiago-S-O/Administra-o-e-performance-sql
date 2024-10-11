DECLARE @ESTE_MES INT DECLARE @ESTADO VARCHAR(2)
SET @ESTE_MES = 2
SET @ESTADO = 'SP'
SELECT VENDAS.classificacao AS CLASSIFICACAO,
       ROUND(VENDAS.VALOR_MES, 2) AS VALOR,
       ROUND((VENDAS.VALOR_MES/ TOTAL.VALOR_TOTAL) * 100, 2) AS PERCENTUAL
FROM
  (SELECT SUM(tb_item.quantidade * tb_item.preco) AS VALOR_TOTAL
   FROM tb_item
   INNER JOIN tb_nota ON tb_item.numero = tb_nota.numero
   INNER JOIN tb_cliente ON tb_nota.cpf = tb_cliente.cpf
   INNER JOIN tb_cidade ON tb_cliente.cidade = tb_cidade.cidade
   INNER JOIN tb_estado ON tb_cidade.sigla_estado = tb_estado.sigla_estado
   WHERE YEAR(tb_nota.data) = 2020
     AND MONTH(tb_nota.data) = @ESTE_MES
     AND tb_estado.sigla_estado = @ESTADO) TOTAL,

  (SELECT tb_classificacao.classificacao AS CLASSIFICACAO,
          SUM(tb_item.quantidade * tb_item.preco) AS VALOR_MES
   FROM tb_item
   INNER JOIN tb_nota ON tb_item.numero = tb_nota.numero
   INNER JOIN tb_produto ON tb_item.codigo_produto = tb_produto.codigo_produto
   INNER JOIN tb_classificacao ON tb_produto.codigo_classificacao = tb_classificacao.codigo_classificacao
   INNER JOIN tb_cliente ON tb_nota.cpf = tb_cliente.cpf
   INNER JOIN tb_cidade ON tb_cliente.cidade = tb_cidade.cidade
   INNER JOIN tb_estado ON tb_cidade.sigla_estado = tb_estado.sigla_estado
   WHERE YEAR(tb_nota.data) = 2020
     AND MONTH(tb_nota.data) = @ESTE_MES
     AND tb_estado.sigla_estado = @ESTADO
   GROUP BY tb_classificacao.classificacao) VENDAS
ORDER BY (VENDAS.VALOR_MES/ TOTAL.VALOR_TOTAL) * 100 DESC


/*
Estamos no Management Studio e, antes de continuar, abaixo do v�deo atual h� uma atividade com o link para fazer o download do arquivo Relatorio Faturamento Classificacao.sql. Fa�a o download, copie e cole o arquivo no diret�rio "C: temp". N�s estamos usando este diret�rio como �rea de trabalho, mas voc� pode utilizar qualquer outro.

Voltando ao Management Studio, clicamos em "Arquivo > Abrir Arquivo" no canto superior esquerdo da tela e selecionamos o arquivo no diret�rio "C: temp" com a extens�o .sql que acabamos de baixar. Esse arquivo � um relat�rio. Vamos executar essa consulta para gerar esse relat�rio, clicando em "Executar" na barra de a��es superior da tela.

Enquanto aguardamos a consulta ser executada, vamos entender o que � essa consulta: ela representa as vendas por classifica��o de produtos em um determinado per�odo em uma loja. Obviamente, a pessoa usu�ria n�o acessa o Management Studio para observar os dados gerados nessa consulta. Ela utiliza uma aplica��o da empresa que, por meio de uma interface amig�vel, envia a consulta para o banco de dados e retorna o resultado com tabelas e gr�ficos.

Ao executar a consulta, notamos no canto inferior direito do MS que ela levou 10 segundos para obter o resultado. Isso � muito ou pouco?

Devemos lembrar que a pessoa usu�ria n�o est� executando essa consulta diretamente no MS, mas num software cliente. Pelo clique de Execu��o nessa tela, � enviado para o servidor, via tr�fego de rede, a ordem para executar o relat�rio. O relat�rio � executado e os dados resultantes voltam para o cliente, que os organiza e apresenta de forma visual para a pessoa usu�ria. Ent�o, com certeza, ser�o mais de 10 segundos at� que o resultado chegue at� essa pessoa.

Embora esse tempo seja aceit�vel, precisamos entender que, para o usu�rio que aguarda o resultado na tela da aplica��o, com aquela tela de carregamento, esse tempo pode parecer uma eternidade. Portanto, quem vai dizer se o ambiente tem ou n�o problema de performance ser� a experi�ncia do usu�rio com a aplica��o.

Como DBA respons�vel pelo ambiente, quando recebo um chamado do usu�rio para rever o tempo de execu��o, preciso identificar a origem do problema e entender por que esse tempo est� causando desconforto. Mas, antes de come�ar a investigar, precisamos conhecer como o ambiente funciona em uma situa��o normal, sem problemas de performance.

� como comparar o barulho do motor de um carro zero quil�metro com o mesmo carro ap�s alguns meses de uso � um barulho diferente no motor nos indica um problema, porque conhecemos o barulho do carro em seu estado normal. O mesmo vale para o SQL Server: antes de investigar o motivo da lentid�o de uma consulta, precisamos conhecer como funciona nosso ambiente de SQL Server, ou seja, como funciona o banco de dados no estado normal, sem problemas.

O primeiro passo para identificar o que est� causando lentid�o � verificar se o nosso banco de dados est� apresentando algum comportamento estranho. Vamos aprender a fazer isso no pr�ximo v�deo: como conhecer o ambiente do nosso SQL Server num estado normal, que � como um motor de carro novo, funcionando de forma limpa e silenciosa? Com isso, podemos identificar poss�veis problemas.

------------------------------------

Neste v�deo, vamos falar sobre o Active Monitor. No v�deo anterior, aprendemos que � importante conhecer o comportamento normal do sistema operacional e do SQL Server para identificar poss�veis anomalias no nosso ambiente e tentar resolver problemas de desempenho de forma eficiente.

Definir uma linha base � uma boa pr�tica para identificar problemas de desempenho rapidamente, quando o ambiente do banco estiver se comportando de maneira diferente do esperado. Isso permite que o DBA tente resolv�-los antes que realmente aconte�am.

A primeira abordagem � ter um monitoramento e estabelecer a linha base de desempenho do servidor SQL Server que estamos administrando. Quando houver algum pico repentino, por exemplo, de gasto de CPU ou de mem�ria, a linha base nos ajudar� a saber quando esse problema aconteceu e o motivo, para resolv�-lo rapidamente.

O Active Monitor � a ferramenta que o DBA tem � disposi��o para analisar essa linha base no ambiente do SQL Server. Ele serve para monitorar e diagnosticar o servidor do Microsoft SQL Server. Essa � uma ferramenta projetada para fornecer ao DBA informa��es detalhadas sobre a sa�de e o desempenho do banco de dados, a fim de ajudar a identificar rapidamente quaisquer problemas que possam estar afetando o desempenho do banco de dados.

O Active Monitor � composto de v�rias componentes, incluindo:

Coletor de dados;
Servi�o de gerenciamento;
Interface de usu�rio.
O coletor de dados do Active Monitor coleta informa��es sobre o desempenho do SQL Server, incluindo informa��es sobre entrada e sa�da (I/O), a utiliza��o de CPU, a utiliza��o de mem�ria e v�rias outras m�tricas de desempenho.

Como o Active Monitor funciona?
Para entender como o SQL Server se comporta na linha base, � necess�rio conhecer o comportamento normal do servidor em seu estado de cruzeiro, considerando a quantidade de usu�rios conectados todo dia e o hardware dispon�vel para executar o SQL Server.

Quando h� uma necessidade de verifica��o (quando determinadas consultas est�o com uma performance muito baixa), a primeira coisa a ser analisada � se a linha base mudou no momento em que o usu�rio executou a consulta. Nesse caso, o problema pode n�o estar na consulta ou no SQL Server, mas no ambiente.

Vamos abrir a nossa consulta no SQL Server. Para demonstrar o funcionamento do Active Monitor, clicamos com o bot�o direito do mouse sobre o nome do servidor ("W10-VILA22", no caso do instrutor) e selecionamos o "Monitor de Atividade".

Ao fazer isso, abre-se uma aba que exibe quatro janelas diferentes, uma ao lado da outra. Elas s�o pretas e gradeadas, exibindo uma escala de n�meros � direita A primeira exibe as informa��es sobre o Tempo do Processador, a segunda sobre Tarefas de Espera, a terceira sobre Entrada e Sa�da do Banco de Dados e a quarta sobre Solicita��es em Lotes.

Para visualizar a evolu��o do gr�fico mais rapidamente, clicamos em qualquer �rea vazia entre esses quatro quadros escuros com o bot�o direito do mouse e selecionamos a op��o "Intervalo de atualiza��o > 1 segundo".

Ao fazer isso, come�amos a verificar uma evolu��o nas solicita��es em lotes: uma barra verde sobe da base at� o n�mero quatro, estabilizando ali. J� o tempo de processamento, tarefas em espera e E/S do banco ficam praticamente zerados. Isso ocorre porque o servidor est� no seu estado quase "adormecido" e nada est� executando, exceto os seus processos internos.

Para mostrar isso claramente, enquanto o monitor exibe os resultados, vamos clicar na aba do relat�rio de vendas e mudar os par�metros de consulta. Em vez de m�s 2, vamos colocar o m�s 3 em @ESTE_MES; em vez de S�o Paulo em @ESTADO, vamos colocar 'RJ' de Rio de Janeiro e executar o relat�rio:

Relatorio Faturamento Classificacao.sql

DECLARE @ESTE_MES INT DECLARE @ESTADO VARCHAR(2)
SET @ESTE_MES = 3
SET @ESTADO = 'RJ'
# c�digo omitidoCopiar c�digo
Ao executar, note o que aconteceu no monitor de atividade: houve um pico de quase 99% do uso de CPU, como verificamos no quadro de Tempo do Processador, porque a consulta foi executada; depois, caiu para zero.

Se voltarmos ao relat�rio de faturamento, verificamos que a consulta foi executada em 9 segundos. O monitor de atividade mostra esse pico e depois o retorno para o zero.

� assim, atrav�s do monitor de atividades (ou Active Monitor, em ingl�s), que podemos acompanhar as atividades do ambiente do servidor. � claro que, no ambiente real, as linhas de base n�o estar�o no zero, mas em algum n�vel no meio do gr�fico, j� que o banco de dados estar� processando coisas.

Ent�o, no pr�ximo v�deo, vamos processar uma s�rie de coisas nesse banco de dados para podermos mudar a nossa linha base inicial e verificar se isso vai afetar ou n�o a nossa consulta.

---------------------------------------------

Agora vamos "estressar" nosso servidor. Executaremos uma s�rie de processos que far�o com que o servidor saia de sua linha base e verificaremos se isso afetar� ou n�o o desempenho de nossa consulta.

Na se��o de documentos desta aula, voc�s poder�o acessar o seguinte arquivo para download: ACTIVE MONITOR.zip. Faremos seu download, copiaremos para o diret�rio de trabalho ("C: temp" para o instrutor) e o descompactaremos aqui.

Ao fazer isso notaremos uma s�rie de arquivos com extens�o .sql dentro deste diret�rio.

Vamos voltar ao Management Studio. Primeiro, vamos fixar para que as duas primeiras abas do Management Studio sempre exibam o Monitor de Atividades e o Relat�rio de Vendas. Para fazer isso, clicamos no �cone de alfinete de "Fixar" exibido no t�tulo da aba atual, no menu superior da tela. Fazemos isso em ambas as abas.

Agora, clicamos em "Arquivo > Abrir > Arquivo" e selecionamos l� todos os arquivos de extens�o .sql do diret�rio "ACTIVE MONITOR". Ent�o, clicamos em "Abrir" no canto inferior direito da janela do explorador de arquivos. Com isso, conferiremos todos os arquivos abertos no Management Studio clicando na seta para baixo no canto direito barra de abas.

Vamos abrir o arquivo Processamento ambiente 01.sql. Ele � um arquivo que faz um looping onde, a cada um segundo, insere numa segunda tabela todas as quantidades vendidas; ou seja, todas as quantidades que constam na tabela "TB_ITEM". Comentaremos a primeira linha com o -- (h�fen-h�fen) para podermos executar esse script sem problemas:

Processamento ambiente 01.sql, a t�tulo de exemplo

USE [DB_VENDAS];

-- IF OBJECT_ID(' dbo.Nums2', 'U') IS NOT NULL DROP TABLE dbo.Nums2; 
CREATE TABLE dbo.Nums2( n float );

DECLARE @max AS INT, @rc AS INT; 
 SET @max = 3600; 
 SET @rc = 1; 
 WHILE @rc < = @max 
 BEGIN 
 DECLARE @X AS FLOAt
 SELECT @X = SUM(QUANTIDADE) FROM [dbo].[tb_item]
 INSERT INTO dbo.Nums2 (n) values (@X);
 SET @rc = @rc + 1;
 WAITFOR DELAY '00:00:01';  
 END Copiar c�digo
Executamos esse script. Enquanto ele � executado, vamos acompanhar o Monitor de Atividade. Note que ele mudou: come�aram a aparecer uns "dentes" no gr�fico do tempo de processador; a barra verde sobe e desce repetidas vezes. Isso � devido ao processo que est� sendo executado, pois ele est� consumindo recursos da m�quina.

Agora, se executarmos o relat�rio de faturamento para outro m�s, como o quatro, e para o estado de Minas Gerais (MG) por exemplo, pode ser que demore um pouco mais:

Relatorio Faturamento Classificacao.sql

DECLARE @ESTE_MES INT DECLARE @ESTADO VARCHAR(2)
SET @ESTE_MES = 4
SET @ESTADO = 'MG'
# c�digo omitidoCopiar c�digo
Ao executar, o relat�rio leva 14 segundos para ser gerado � sendo que, antes, levava apenas 10. Isso aconteceu porque estamos processando coisas na nossa m�quina.

Vamos processar mais coisas ainda abrindo o arquivo Processamento ambiente 02.sql, que vai consumir ainda mais recursos da m�quina. Comentaremos a sua primeira linha e o executar.

Se verificarmos o monitor de atividade, veremos que o consumo est� em quase 100%. Os "dentes" que desciam mais para baixo em seu estado normal, chegando at� a zero, passaram a n�o descer mais que at� os 40%. Tamb�m passamos a ter resultados no gr�fico de entrada e sa�da de banco de dados. O computador, inclusive, pode at� fazer um barulho maior nesse momento por estar consumindo mem�ria.

Isso impactou o nosso relat�rio de faturamento? Vamos verificar. Escolheremos outro m�s e outro estado para gerar o relat�rio novamente, por exemplo, m�s cinco e Esp�rito Santo (ES):

Relatorio Faturamento Classificacao.sql

DECLARE @ESTE_MES INT DECLARE @ESTADO VARCHAR(2)
SET @ESTE_MES = 5
SET @ESTADO = 'ES'
# c�digo omitidoCopiar c�digo
Vamos executar esse script para ver se haver� preju�zo no tempo de processamento a partir do momento em que o sistema saiu do conhecimento base.

Rodou em 15 segundos, ou seja, 50% mais do que o tempo original. O usu�rio que est� l� na outra ponta j� deve come�ar a ficar desconfort�vel.

Vamos piorar esse ambiente?

Os arquivos de Processamento vendas de 01 a 09 est�o abertos, ent�o vamos clicar para executar cada um deles, um seguido do outro, por meio do menu aberto pela seta na barra de abas. � poss�vel que voc�, se estiver repetindo esse exerc�cio, comece a notar que come�a a haver um consumo maior de recursos do servidor na sua m�quina.

No monitor de atividades, verificamos que o processamento est� quase em 100%, no topo da grade, e a solicita��o de lote aumentou um pouco.

Agora, vamos selecionar outro m�s e estado para gerar um novo relat�rio: m�s 6 e Rio Grande do Sul (RS):

Relatorio Faturamento Classificacao.sql

DECLARE @ESTE_MES INT DECLARE @ESTADO VARCHAR(2)
SET @ESTE_MES = 6
SET @ESTADO = 'RS'
# c�digo omitidoCopiar c�digo
Vamos executar para ver como ser� o resultado dessa consulta. Chegamos a 15 segundos novamente, mas podemos notar que a m�quina ficou um pouco mais pesada.

Conclus�o desse exerc�cio: � muito importante acompanhar o que est� acontecendo no monitor de atividades e conhecer o seu n�vel base antes de come�ar a gerenciar o seu ambiente do SQL Server. Ent�o, a partir do momento que houver problema de performance, a primeira coisa que voc� deve fazer � verificar se o ambiente fugiu do n�vel base.

Antes de terminar o exerc�cio, pe�o que voc� feche todas as janelas e pare o processamento para que a m�quina n�o fique consumindo recursos o tempo todo. Nos pr�ximos v�deos, continuaremos os exerc�cios pr�ticos.

-------------------------------------------

Um ponto de aten��o para o DBA � a verifica��o constante do espa�o em disco dispon�vel no servidor onde a base de dados est� armazenada. Isso porque a base de dados do SQL Server tende a crescer muito, principalmente os arquivos de log e transa��es, � medida que o banco vai sendo utilizado.

A diminui��o do espa�o livre em disco pode afetar a performance do sistema. Por isso, o DBA tamb�m deve verificar o crescimento da base.

Na se��o de atividade abaixo deste v�deo, h� um link para download do script Reduzindo Base.sql. Vamos copi�-lo para o nosso diret�rio de trabalho. Voltando ao Management Studio, vamos carregar esse novo script clicando em "Arquivo > Abrir > Arquivo > Reduzindo Base.sql > Abrir". O script que se abre � o seguinte:

USE DB_VENDAS
ALTER DATABASE DB_VENDAS SET RECOVERY SIMPLE
DBCC SHRINKDATABASE ('DB_VENDAS', NOTRUNCATE)
DBCC SHRINKDATABASE ('DB_VENDAS', TRUNCATEONLY)
ALTER DATABASE DB_VENDAS SET RECOVERY FULLCopiar c�digo
Note que ele est� executando quatro comandos � o comando USE no in�cio est� apenas reposicionando o script para ser executado na base DB VENDAS. Esses quatro comandos ir�o reduzir o tamanho da base de dados do banco de dados porque, � medida que o banco vai sendo utilizado, muita coisa desnecess�ria ser� gravada nele.

Basicamente, o primeiro comando, ALTER DATABASE com o SET RECOVERY SIMPLE, � usado para modificar as configura��es do banco de dados. Quando usamos a fun��o de recupera��o definindo a op��o SIMPLE, o SQL Server n�o mant�m nenhum log de transa��o completo.

Isso significa que, ao recuperar os dados da base de dados, eliminar� os dados de transa��es de log. Isso pode ser perigoso se voc� tem a necessidade de um rollback dos dados. Por isso, ao rodar os comandos de redu��o da base de dados, � importante ter certeza de que voc� realizou um backup do banco e que seus usu�rios n�o est�o utilizando esse banco.

O segundo comando se chama DBCC SHRINKDATABASE. Com ele, reduzimos o tamanho do banco de dados removendo todo o espa�o n�o utilizado. O par�metro NOTRUNCATE significa que o arquivo do banco de dados n�o ser� encurtado al�m do tamanho atual, mesmo que haja espa�o inutilizado.

O terceiro comando tamb�m � o DBCC SHRINKDATABASE, mas com o par�metro TRUNCATEONLY. Ele remover� apenas o espa�o n�o utilizado no final do arquivo do banco de dados. Isso significa que o tamanho do arquivo ser� reduzido sem mover dados.

O �ltimo comando � o ALTER DATABASE novamente, dessa vez com o par�metro SET RECOVERY FULL. Com essa op��o definida, o SQL Server mant�m o log de transa��o completo � ent�o, permite que voc� volte a gravar as transa��es do banco. Ou seja, se voc� n�o passar o seu banco novamente para RECOVERY FULL, estar� limitando a capacidade de salvar os logs de transa��o.

No entanto, para reduzir o tamanho, voc� precisa passar o banco para RECOVERY SIMPLE, ou seja, eliminar a necessidade de salvar o log de transa��o, para ent�o reduzir a base e, finalmente, voltar ao status original.

Ent�o, vamos verificar o tamanho da base nesse momento. Para isso, clicamos no nome da base "DB_VENDAS" no menu lateral esquerdo com o bot�o direito do mouse e, em seguida, clicamos em "Propriedades". Na janela de propriedades, clicamos em "Arquivos" no menu lateral esquerdo. Nessa tela, veremos todas as propriedades do nosso banco de dados. Na tabela, temos um campo chamado "Tamanho (MB)" em que podemos ver o tamanho do banco:

3105 MB do banco de dados "DB_VENDAS"
4104 MB de log de transa��o
Podemos clicar em "Cancelar" para fechar essa janela de propriedades do banco de dados.

Agora, vamos executar os comandos do script Reduzindo Base.sql. Ele roda rapidamente e, se acessarmos novamente a janela de Propriedades do Banco, veremos que seu tamanho foi reduzido:

3068 MB do banco de dados "DB_VENDAS"
8 MB de log de transa��o
O tamanho do banco diminuiu pouco, mas o do log de transa��o reduziu bastante. Economizamos 4GB de espa�o! Claro que, se quisermos dar um rollback numa transa��o que estava parada no meio, n�o conseguiremos porque apagamos todo o log de transa��o. Mas, houve uma economia muito grande de espa�o.

� importante que n�s, como DBAs, tenhamos este script em m�os para reduzir periodicamente o tamanho da base de dados, economizando espa�o em disco e evitando que ele se esgote. Isso pode acontecer com a m�quina onde o banco de dados SQL Server est� salvo. Portanto, � fundamental manter um controle constante do espa�o livre em disco dispon�vel.

------------------------------------------------------

Ao monitorar e ajustar o desempenho de um ambiente do SQL Server, n�s n�o devemos apenas medir o tempo de resposta da consulta, mas tamb�m precisamos monitorar muitos outros fatores que possam afetar o desempenho. O que vimos em todos os v�deos desta aula foi isso: como conhecer a linha base de trabalho e monitorar o ambiente de disco. Vamos, ent�o, falar sobre os pontos de aten��o no monitoramento ao verificar performance.

Pontos de aten��o: Performance
1. Quantidade de solicita��es
Saber a quantidade de solicita��es simult�neas que ocorrem no servidor � muito importante. Al�m disso, precisamos verificar o uso do processamento de CPU para cada uma dessas solicita��es � o que fizemos com o Active Monitor. Isso porque a quantidade de solicita��es � um dos principais indicativos de desempenho de um banco de dados no SQL Server.

A quantidade de solicita��es inclui tamb�m o n�mero de consultas e transa��es por segundo, bem como o n�mero de usu�rios simult�neos que acessam o banco de dados. Ao monitorar a quantidade de solicita��es, podemos, por exemplo, identificar aqueles padr�es de uso; ou seja, a linha base. Podemos, inclusive, tra�ar linhas-base conforme os hor�rios de pico ou consultas mais frequentes, entendendo o banco quando estamos executando transa��es com alta carga de dados.

Isso porque pode ser que a linha base n�o seja a mesma em intervalos de tempo iguais. Podemos ter uma linha base durante o dia, por exemplo, e durante a noite, em que h� processamento de processos agendados, a linha base pode mudar.

Sabendo disso, conhecendo bem e ajustando a sua linha base ao longo do tempo, voc� consegue identificar pontos de gargalo no sistema e, tamb�m, identificar oportunidades para otimizar as consultas e transa��es para melhorar a performance.

Al�m disso, monitorar a quantidade de solicita��es permite que voc� identifique problemas de seguran�a, como ataques de SQL Injection ou outras amea�as que podem ocorrer no seu banco de dados.

2. Espa�o afetado pelas solicita��es
Outro ponto importante, sobre o qual falamos no v�deo anterior, � o espa�o em disco � mais um fator cr�tico que deve ser considerado ao monitorar o desempenho de um banco de dados SQL Server. A falta de espa�o em disco pode resultar em v�rios problemas, incluindo lentid�o do sistema, interrup��o de opera��es e at� perda de dados.

Por isso, � importante sempre monitorar o espa�o em disco do banco de dados, incluindo o tamanho total do banco, o tamanho das tabelas, dos �ndices e o tamanho dos arquivos de log. Isso vai permitir que voc� identifique se o banco de dados est� atingindo os seus limites de espa�o em disco e se � necess�rio adicionar mais espa�o � disposi��o ou otimizar o banco de dados para liberar espa�o, como fizemos anteriormente.

Al�m disso, tamb�m vale a pena frisar a import�ncia de monitorar a utiliza��o do espa�o em disco ao longo do tempo, identificando como o banco cresce ao longo do tempo, para identificar tend�ncias e planejar a futura manuten��o desses dados. Por exemplo: se o banco estiver crescendo muito r�pido, voc� pode planejar e adicionar mais espa�o em disco ou otimizar o banco, para liberar espa�o desnecess�rio.

3. Tipos de solicita��es
Reconhecer os diferentes tipos de solicita��es feitas no SQL Server � tamb�m um elemento importante, pois cada tipo de opera��o possui um impacto diferente na performance do sistema.

Por exemplo, as opera��es de inser��o, atualiza��o e exclus�o, conhecidas como inserts, updates e deletes, geralmente demandam maior utiliza��o de entrada e sa�da (I/O) e recursos de disco em compara��o �s consultas. Por outro lado, as consultas que n�o consomem tanto I/O, mas que possuem soma e agrega��es, podem ser mais intensivas em CPU e em uso de mem�ria. Isso pode, claro, afetar a performance.

Quando voc� monitora esses tipos de solicita��es, � poss�vel identificar o impacto de cada tipo de opera��o dentro da performance do sistema. Se necess�rio, voc� pode utilizar essas transa��es para melhorar a performance. Al�m disso, monitorar os tipos de solicita��es permite identificar oportunidades para melhorar a arquitetura do banco, como, por exemplo, uso de �ndices ou otimiza��o de consultas.

4. Dificuldade das solicita��es
Conhecer a complexidade das solicita��es � muito importante para voc� entender o seu ambiente e garantir desempenho no SQL Server.

Por exemplo: solicita��es simples, como leitura de dados de uma tabela, geralmente t�m impacto menor na performance do sistema do que requisitar solicita��es mais complexas, como as que t�m JOIN entre tabelas. Esse tipo de solicita��o pode gerar uso intensivo de CPU e mem�ria.

Por isso, � importante entender como s�o essas solicita��es. Conhecendo a complexidade delas, � poss�vel identificar oportunidades de melhorar a arquitetura do banco, como, por exemplo, uso de �ndices para otimizar a velocidade dessas consultas.

� fundamental incluir na sua an�lise do ambiente a complexidade das solicita��es no seu plano de gerenciamento e desempenho do SQL Server.

Conclus�es
Alguns pontos mencionados neste v�deo n�s j� conhecemos nessa aula, atrav�s do Active Monitor e do script de redu��o de tamanho de base.

Mas, vamos entender melhor as solicita��es que chegam ao banco, entender se elas s�o complexas ou n�o, o tempo que elas levam e se � poss�vel melhorar o tempo de uma solicita��o espec�fica, como uma consulta, por meio de reestrutura��o de elementos internos do banco.

S�o esses outros pontos muito importantes sobre performance que trataremos nas pr�ximas aulas.

----------------------------------------------

Neste ponto, j� aprendemos como DBA, a identificar se o nosso servidor est� se comportando de acordo com sua linha base. Se come�armos a observar que ele est� fugindo da linha base, podemos fazer uma investiga��o mais detalhada para tentar entender que tipo de consulta ou comando, enviada ao servidor pelo cliente, est� afetando e modificando a linha base. Para isso, faremos o que chamamos de trace.

O trace funciona como uma observa��o da comunica��o entre o cliente e o servidor a fim de entender o que est� prejudicando o ambiente do SQL Server. Para isso, utilizaremos uma ferramenta chamada SQL Server Profiler, que ajuda a identificar as comunica��es entre o cliente e o servidor.

Fecharemos o monitor de atividades acessaremos o seguinte link para fazer download do arquivo "Tracesql.sql". Ap�s baixar este arquivo, devemos copi�-lo para a pasta do diret�rio de trabalho.

De volta ao Management Studio, vamos em "Arquivo", no menu superior, e em Abrir > Arquivo. Uma janela abrir� e devemos navegar at� a pasta do diret�rio para selecionar o arquivo que acabamos de baixar. Neste ponto, devemos lembrar de nos certificar que estamos na base DB_Vendas.

Temos tr�s consultas, mas, na pr�tica, o usu�rio est� olhando uma aplica��o que, normalmente, � um dashboard. Um dashboard seria um relat�rio, no formato de painel, com diversas representa��es visuais, como, por exemplo, gr�ficos de pizza e linha, tabelas e caixas de sele��o para escolhermos filtros. Quando o usu�rio clica em um bot�o da aplica��o para atualizar todos esses componentes, o programa executa uma s�rie de consultas no SQL Server.

Nem sempre um relat�rio � composto por apenas uma consulta, pois �s vezes s�o necess�rias v�rias. O que estamos simulando s�o tr�s consultas ao banco de dados, supondo que elas s�o executadas pelo relat�rio do usu�rio quando este deseja fazer algo.

Sabemos que existe um problema no servidor e precisamos identificar se uma dessas tr�s consultas � a causa deste problema. Faremos isso usando o SQL Server Profiler.

Para abrir esta ferramenta, vamos em "Ferramentas", no menu superior, e clicamos em "SQL Server Profiler". Em seguida, nos autenticamos na base. Feito isso, temos acesso a uma janela que corresponde � caixa principal para parametrizar o SQL Server Profiler.

A primeira coisa que faremos nomear o rastreamento como "TESTE". Normalmente, esta ferramenta j� disponibiliza para uma s�rie de templates prontos chamados de modelo. Em "Usar o modelo", temos a op��o "Em branco", mas �s vezes s�o apresentados alguns modelos em funcionamento.

Ao selecionar o modelo "Em branco", � poss�vel que surja uma mensagem informando que o modelo tem um formato incorreto, ent�o basta ignor�-la. No ambiente, provavelmente voc� ter� uma lista de modelos dispon�veis.

Feito isso, vamos na guia "Sele��o de Eventos", no topo da janela, onde podemos escolher, entre v�rios eventos existentes, aquele que far� o acompanhamento. Note que temos diversos tipos que nos permitem fazer o acompanhamento pelo SQL Server Profiler.

Aqui, nos interessa acompanhar os comandos de TSQL. Ent�o selecionaremos esta op��o e uma lista se abrir� com os eventos correspondentes ao comando de TSQL, entre os quais selecionaremos SQL:BatchStarting e SQL:BatchCompleted. Do lado direito, temos as colunas em que ser�o exibidos valores quando fizermos o trace desses eventos.

O SQL:BatchStarting far� o trace quando um comando SQL for enviado ao servidor. J� o SQL:BatchCompleted acontecer� dentro do trace quando o mesmo comando SQL Server for retornado do servidor para o cliente. Ent�o ele escrever� alguns indicadores que constam nas colunas seguintes como, por exemplo, quantidade de CPU, ID do cliente, ID do processo do cliente que executou a consulta, entre outros.

Podemos, tamb�m, executar filtros sobre os eventos trace que acontecer�o. Para configurar esses filtros, basta irmos no bot�o "Filtros de Coluna", localizado no canto inferior direito da janela. Clicando nele, temos acesso aos filtros que podemos aplicar. Se clicarmos, por exemplo, em "CPU" e colocarmos o n�mero 50 em "Maior ou igual a", significa que s� faremos o trace quando o n�vel de CPU ultrapassar 50%.

Anteriormente, vimos que o DBA pode acompanhar o consumo de CPU no seu n�vel de linha base. Mas, al�m disso, ele pode especificar, por exemplo, que a linha base deve estar trabalhando em 50%. Dessa forma, o trace avisar� quando consultas ou processamentos que consumiram mais do que 50% forem executados, porque passam a ser suspeitos de prejudicar a performance do banco.

N�o usaremos o filtro "CPU", mas sim o "LoginName", passando "sa" para "Como". Ou seja, s� exibiremos o trace quando o usu�rio "sa" executar algum comando de TSL. Feito isso, basta clicar em "OK" e, depois, em "Executar". O trace j� est� pronto para acompanharmos o que acontecer� no ambiente.

--------------------------------------------------------

Estamos com o SQL Server Profiler ligado, mas, por enquanto, ele n�o escreveu nada. Isso, porque, n�s colocamos um filtro para que uma consulta seja acompanhada apenas quando o usu�rio SA a enviasse para o servidor.

Voltando para o Management Studio, vamos executar a primeira consulta, que pega o c�digo e o nome do produto e lista todos os resultados.

select codigo_produto as PRODUTO, produto as NOME_PRODUTO
from [dbo].[tb_produto]
Copiar c�digo
Ao faz�-lo, note que, em termos de performance, a execu��o foi r�pida. Vejamos o que aconteceu no SQL Server Profiler.

Clicando na guia do Profiler, note que foram escritas quatro linhas. A primeira linha corresponde � execu��o da consulta "SELECT @@SPID;", algo interno ao SQL Server. Na terceira linha, temos "SQL: BatchStarting", onde conseguimos ver, na janela abaixo, a consulta executada.

Acompanhando os valores das colunas de cada linha, conseguimos ver a aplica��o que executou isso, no caso, o Management Studio. Se tiv�ssemos executado essa consulta por uma aplica��o, provavelmente ver�amos o nome do DriverDBC ou OLDB, que fazem a comunica��o entre o cliente e o servidor atrav�s dela. Temos, ainda, o n�mero do processamento no servidor, a database no qual a consulta foi efetuada, o nome do cliente, entre outros dados.

Sendo assim, conseguimos monitorar uma s�rie de par�metros e descobrir, por exemplo, qual usu�rio ou m�quina realizou a consulta. Em "StartTime", temos a hora que o banco de dados recebeu a consulta e, embaixo, a hora que ele a retornou para o cliente. Note que foi praticamente instant�neo.

Em "TextData", temos o texto que corresponde � consulta. Mas nos importa, principalmente, a informa��o de "CPU", que praticamente n�o foi gasta, o que nos permite fazer um link com o monitor de atividade para saber se a CPU estourou muito ou n�o essa consulta. Al�m disso, em "Duration", temos a dura��o em milissegundos, que foi 3. Por fim, mas igualmente importante, temos "Reads" e "RowCounts", onde conseguimos ver as entradas e sa�das que o servidor fez, respectivamente. Note que foram feitas 217 consultas e retornadas 401 para o cliente.

Nas entradas e sa�das, observamos em termos de I.O. de disco; enquanto na CPU, vemos em termos de mem�ria e processamento.

Vamos executar a segunda consulta, respons�vel por listar os estados.

select sigla_estado as ESTADO, nome_estado as NOME_ESTADO from tb_estado
Copiar c�digo
Ao execut�-la, voltamos ao SQL Server Profiler para acompanhar. Note que teve uma dura��o menor que a anterior, al�m de retornar menos linhas, pois foram apenas 24.

Sabemos que a tabela de clientes tem cerca de 1 milh�o de clientes. Fa�amos, ent�o, uma sele��o nesta tabela para observarmos se haver� diferen�a em seu acompanhamento, uma vez que ela � maior que as tabelas de produtos e estados.

select * from [dbo].[tb_cliente]
Copiar c�digo
Ao executar, perceba que, embora o resultado seja retornado, temos a informa��o de que a consulta ainda est� sendo executada. Quando ela � finalizada, essa mensagem � alterada informando que a consulta foi conclu�da e em quanto tempo. No caso, em 7 segundos. Isso ocorre porque pegar os dados de clientes da tabela � r�pido; a demora se encontra em escrever essa sa�da de 1 milh�o de clientes.

Se olharmos o SQL Server Profiler, notamos que tivemos um tempo maior, cerca de 7.612 segundos. O n�mero de leituras se encontra em 12.648 e as linhas retornadas est�o em 1 milh�o. Ou seja, o n�mero de linhas retornadas influencia no tempo de processamento de entradas e sa�das.

Vamos observar, agora, a consulta que faz um processamento mais pesado.

SELECT dbo.tb_estado.nome_estado AS ESTADO, dbo.tb_produto.produto AS PRODUTO, YEAR([data]) AS ANO, 
         SUM(CONVERT(FLOAT, (dbo.tb_item.quantidade))) as QUANTIDADE
FROM dbo.tb_item INNER JOIN
         dbo.tb_produto ON dbo.tb_item.codigo_produto = dbo.tb_produto.codigo_produto INNER JOIN 
         dbo.tb_nota ON dbo.tb_item numero = dbo.tb_nota.numero CROSS JOIN 
         dbo.tb_cliente INNER JOIN
         dbo.tb_cidade ON dbo.tb_cliente.cidade = dbo.tb_cidade.cidade INNER JOIN 
         dbo.tb_estado ON dbo.tb_cidade.sigla_estado = dbo.tb_estado.sigla_estado 
         WHERE dbo.tb_produto.codigo_produto = 2 AND dbo.tb_estado.sigla estado = 'RJ'
         AND YEAR([data]) = 2020
         GROUP BY
         dbo.tb_estado.nome_estado, dbo.tb_produto.produto, YEAR ([data])
Copiar c�digo
Ao executar, n�o temos um retorno imediato. Perceba que o processamento demora cerca de 7 segundos.

No SQL Server Profiler, notamos que demorou praticamente os mesmos 7 segundos que a consulta anterior. Mas, enquanto na anterior o tempo foi gasto para escrever a resposta, nesta o tempo maior foi gasto no processamento, pois teve que trabalhar internamente 344.170 linhas e s� escreveu 3 linhas de resultado.

Esses s�o dois exemplos de consultas que demoraram praticamente o mesmo tempo, mas enquanto uma gastou muito na entrada e sa�da, a outra gastou mais no processamento interno.

Vamos simular uma s�rie de consultas chegando no banco. Para isso, clicaremos com o bot�o direito do mouse sobre "DESKTOP", no menu lateral, depois em "Monitor de Atividades", assim estaremos ligando-o.

Ao ligar o monitor de atividades, ele internamente faz uma s�rie de consultas no ambiente do SQL Server. Se olharmos o SQL Server Profiler, veremos que ele est� escrevendo uma s�rie de resultados de acompanhamento das consultas, pois abrimos o monitor com o usu�rio SA.

Vamos parar o monitor de atividades fechando a aba que foi aberta ao lig�-lo. A seguir, veremos como analisar melhor a sa�da dessas linhas que foram escritas pelo Trace do SQL Server.

----------------------------------------------------------

No SQL Server Profiler, temos o resultado do trace, embora ele ainda esteja sendo executado. Paramos o monitor de atividades para evitar que mais acompanhamentos fossem escritos. Mas, se voltarmos ao Management Studio e executarmos a consulta mais pesada, veremos que o trace permanece em processamento.

SELECT dbo.tb_estado.nome_estado AS ESTADO, dbo.tb_produto.produto AS PRODUTO, YEAR([data]) AS ANO, 
         SUM(CONVERT(FLOAT, (dbo.tb_item.quantidade))) as QUANTIDADE
FROM dbo.tb_item INNER JOIN
         dbo.tb_produto ON dbo.tb_item.codigo_produto = dbo.tb_produto.codigo_produto INNER JOIN 
         dbo.tb_nota ON dbo.tb_item numero = dbo.tb_nota.numero CROSS JOIN 
         dbo.tb_cliente INNER JOIN
         dbo.tb_cidade ON dbo.tb_cliente.cidade = dbo.tb_cidade.cidade INNER JOIN 
         dbo.tb_estado ON dbo.tb_cidade.sigla_estado = dbo.tb_estado.sigla_estado 
         WHERE dbo.tb_produto.codigo_produto = 2 AND dbo.tb_estado.sigla estado = 'RJ'
         AND YEAR([data]) = 2020
         GROUP BY
         dbo.tb_estado.nome_estado, dbo.tb_produto.produto, YEAR ([data])
Copiar c�digo
� poss�vel pausar o trace no bot�o de pausa que aparece na barra superior. Se, ao paus�-lo, executarmos novamente a consulta, o trace n�o escrever� nada porque est� pausado.

O DBA n�o precisa ficar com o trace ligado o tempo todo, pois gasta processamento fazendo com que o SQL Server se preocupe em escrever tudo que faz.

O trace � uma ferramenta importante para que, quando o DBA note que o processamento do ambiente est� fugindo da linha base do SQL Server, isso chame aten��o e ele fa�a uma investiga��o mais detalhada. Ent�o, somente neste momento, o trace ser� ligado para apontar, dentre os diversos comandos que est�o trafegando entre cliente e servidor, aquele que est� gerando o problema.

Sendo assim, deixamos o trace ligado somente durante o tempo em que o monitor de atividade indica que h� uma s�rie de informa��es fugindo � linha base. Depois, analisamos esses resultados.

Por�m, analisar esses resultados a partir de uma lista com a dimens�o da que temos agora, torna-se muito dif�cil, o que dificulta, tamb�m, que identifiquemos quem est� causando problema. Pensando nisso, podemos salvar o resultado do trace em uma tabela do banco de dados, na qual podemos fazer consultas para verificar o que aconteceu no SQL Server durante o per�odo que deixamos o Profile rodando.

Para salvar o conte�do do trace, vamos em Arquivo > Salvar Como > Tabela de Rastreamento. Uma janela se abrir� e, nela, faremos a conex�o no SQL Server. Depois, clicamos em "Conectar" e escolhemos uma base de dados. Aqui, optaremos pela pr�pria base de dados com a qual estamos trabalhando, "DB_VENDAS". Em seguida, damos um nome para a tabela, como "RASTREAMENTO_TRACE". Feito isso, basta clicar em "OK" e o conte�do � salvo nesta tabela. Vamos verificar sua escritura.

No SQL Server, clicamos com o bot�o direito do mouse sobre "DB_VENDAS" e atualizamos. Ao faz�-lo, tabela "RASTREAMENTO_TRACE" deve aparecer. Ao expandir as colunas dessa tabela, vemos v�rios campos que correspondem �s colunas do trace.

Vamos criar uma nova consulta e executar o seguinte:

SELECT * FROM [dbo].[RASTREAMENTO_TRACE]
Copiar c�digo
Feito isso, podemos verificar todo o processamento.

Outra possibilidade � selecionar as dura��es maiores que 6.500 milissegundos, por exemplo:

SELECT * FROM [dbo].[RASTREAMENTO_TRACE] WHERE Duration >= 6500
Copiar c�digo
Ao rodarmos essa consulta, nos s�o retornadas somente as consultas que demoraram mais. Note, inclusive, que temos consultas que demoraram mais do que 6.500 milissegundos vindas, tamb�m, da base "tempdb", que � a base interna do SQL Server. Quem fez essas consultas foi o monitor, mas supondo que n�o queremos elas, podemos acrescentar o comando and DatabaseName <> 'tempdb':

SELECT * FROM [dbo].[RASTREAMENTO_TRACE] WHERE Duration >= 6500 and DatabaseName <> 'tempdb'
Copiar c�digo
Agora temos acesso � 3 consultas que demoraram mais que 6500 milissegundos. Uma delas foi a consulta � tabela de clientes; enquanto as outras duas correspondem �s duas execu��es da consulta que fazia o join entre v�rias tabelas.

Dessa forma, tentamos descobrir qual � a consulta que gerou problema no ambiente. Ao identific�-la, podemos a analis�-la com cuidado para entender como ela foi constru�da e como est� sendo processada pelo SQL Server, a fim de ver o que podemos fazer para que ela n�o prejudique mais o cliente. Faremos isso nas pr�ximas aulas!

-----------------------------------------------------

Vimos na pr�tica como funciona o SQL Server Profile, ent�o vamos nos aprofundar um pouco mais sobre o que ele pode fazer.

O SQL Server Profile � uma ferramenta integrada ao SQL Server Management Studio que permite monitorar e rastrear eventos no banco de dados do SQL Server. � muito �til para fins de diagn�stico de desempenho, an�lise de consultas, auditoria de seguran�a e outras atividades semelhantes a essas.

O SQL Server Profile permite que o usu�rio crie se��es personalizadas de rastreamento, defina filtros e classifique os eventos capturados. Tamb�m � poss�vel executar essas personaliza��es v�rias vezes para fins de compara��o. Ou seja, para saber se nossas a��es melhoraram ou n�o os problemas de performance do ambiente.

Podemos afirmar que o SQL Server Profile � uma ferramenta de rastreamento do SQL Server. Esse rastreamento possibilita identificar gargalos de desempenho e solucionar os problemas que afetam o desempenho geral do sistema. Sendo assim, � poss�vel capturar e analisar informa��es sobre solicita��es enviadas ao banco de dados, incluindo informa��es sobre comandos de SQL, opera��es do sistema e chamadas do sistema. Al�m disso, podemos visualizar informa��es sobre o uso de recursos do sistema, como CPU, mem�ria, entrada e sa�da de disco, e outros recursos que permitem identificar os pontos de melhoria para melhorar o desempenho.

Ele tamb�m oferece modelos pr�-definidos que podem ser usados para identificar os problemas de performance. Cada modelo pr�-definido � desenhado e projetado para rastrear e identificar um determinado problema. Ent�o, podemos ter modelos que s� monitorem a entrada e sa�da de dados; a aloca��o de mem�ria ou recursos de CPU, sendo poss�vel salvar esses modelos e execut�-los sempre que necess�rio. Assim, � poss�vel comparar os resultados e ver se a efici�ncia do SQL Server est� melhorando com as a��es realizadas no banco de dados.

Al�m disso, tamb�m � poss�vel efetuar o trace atrav�s de comandos de TSQL, que � a linguagem de programa��o do SQL Server.

Vamos, agora, conhecer quais s�o os principais m�dulos do SQL Server Profiler:

Eventos: permite que voc� defina quais eventos do SQL Server quer monitorar, como inser��es, atualiza��es, consultas e muito mais;
Colunas: neste m�dulo � poss�vel especificar o que se quer visualizar. Podemos, por exemplo, adicionar colunas como tempo de execu��o, quantidade de leituras, quantidade de escritas, entre outros;
Templates: permitem salvar a configura��o para uso futuro, facilitando a gera��o de relat�rios;
Filtros: permitem que voc� filtre o resultado dos relat�rios, por exemplo, por data, usu�rio ou eventos. Neste caso, o trace s� � realizado quando esses filtros ocorrem;
Gr�ficos e relat�rios: � poss�vel salvar o conte�do do trace em uma tabela e construir relat�rios mais elaborados usando outras ferramentas contidas no SQL Server;
Armazenamento de se��es: aqui, � poss�vel salvar as informa��es coletadas no profile temporariamente e, depois, analis�-las para identificar o que aconteceu dentro do ambiente do SQL Server em um determinado per�odo.
Alguns comandos de TSQL para executar o profile s�o:

sp_trace_create: cria uma nova se��o de rastreamento;
sp_trace_setevent: configura os eventos a serem capturados durante a se��o de rastreamento;
sp_trace_setfilter: configura os filtros que ser�o aplicados durante a se��o de rastreamento;
sp_trace_start: inicia a se��o de rastreamento;
sp_trace_stop: interrompe ou para a se��o de rastreamento;
sp_trace_delete: exclui uma se��o de rastreamento;
sptracegetdata: recupera dados que foram capturados durante uma sess�o de rastreamento.
Todos esses comandos permitem que voc� possa, por exemplo, criar um programa em TSQL para que, em determinados per�odos, de forma automatizada, ele fa�a a coleta do trace.

Exemplo de c�digo em TSQL que efetua o trace:

-- Cria o Trace
DECLARE @trace_id INT
EXEC sp_trace_create @traceid = @trace_id OUTPUT

-- Inicializa os eventos de Trace
EXEC sp_trace_setevent @traceid = @trace_id, @eventid = 10, @columnid =1, @on = 1
EXEC sp_trace_setevent @traceid = @trace_id, @eventid = 12, @columnid = 1, @on 1

-- Inicializa os filtros do Trace
EXEC sp_trace_setfilter @traceid = @trace_id, @columnid = 1, @logical_operator = 0, @comparison_operator = 0, @value = N'example_user'

-- Inicia o Trace
EXEC sp_trace_start @traceid = @trace_id

-- Espera alguns segundos
WAITFOR DELAY '00:00:05'

-- Para o Trace
EXEC sp_trace_stop @traceid = @trace_id

-- Limpa o Trace
EXEC sp_trace_delete @traceid = @trace_idCopiar c�digo
No primeiro passo, usamos sp_trace_create e armazenamos o ID do trace em uma vari�vel. Depois, iniciamos os eventos de trace, passando alguns par�metros como eventid, columnid e on.

Em seguida, em sp_trace_setfilter, definimos os filtros que ser�o aplicados. Depois que declaramos e definimos como ser� o nosso trace, iniciamos o trace com sp_trace_start e fazemos a espera de alguns segundos. Ou seja, ao iniciar o trace, ele ser� feito durante esse tempo estabelecido. Por fim, depois desse tempo, podemos parar o trace com sp_trace_stop e limp�-lo com sp_trace_delete.

----------------------------------------------------

Quais foram os passos que percorremos at� essa aula? Bem, como DBA desse ambiente da SQL Server, come�amos pela an�lise do ambiente no seu n�vel base.

Monitoramos o funcionamento do sistema atrav�s do monitor de atividades e tra�amos qual � o n�vel base de funcionamento dele. Se o sistema estiver funcionando dentro desse n�vel base, ainda podemos ter um cen�rio com problemas de performance, mas n�o ser�o devido ao ambiente.

Mas, se identificamos que os processos est�o fugindo do n�vel base, passamos para o passo dois: monitorar toda a comunica��o entre cliente e servidor do banco.

Para isso, usamos o SQL Server Profile. Nessa ferramenta, identificamos os comandos que s�o problem�ticos.

� hora de analisar esses comandos e verificar o que podemos fazer para melhorar a performance deles.

Normalmente, os comandos problem�ticos que vamos analisar nessa fase est�o associados a consultas (queries). Ou seja, consultas atrav�s de comandos SELECT.

Afinal, essas consultas s�o utilizadas para a emiss�o dos relat�rios usados pelas pessoas usu�rias que acessam os dados do banco.

A an�lise desses comandos SELECT � feita atrav�s do plano de execu��o. Nesse v�deo, vamos entender como funciona o plano de execu��o de uma consulta.

Plano de execu��o
No SQL Server Management Studio, vamos criar uma nova consulta ao clicar no bot�o "Nova Consulta" na barra de ferramentas (ou atalho "Ctrl + N") para fazer um exerc�cio.

No banco de dados, temos uma tabela criada em v�deos anteriores chamada "Nums". Vamos pegar o conte�do dessa tabela e transferir para uma segunda tabela por meio do seguinte comando:

SELECT * INTO NumsLinha FROM Nums;Copiar c�digo
Ao selecionar e executar esse c�digo com o bot�o "Executar" na barra de ferramentas (ou "F5"), transportamos todo o conte�do da tabela "Nums" para essa nova tabela chamada "NumsLinha".

No painel "Pesquisador de Objetos" � esquerda, clicamos com bot�o direito do mouse na pasta "Tabelas" e selecionamos "Atualizar". Agora temos essa nova tabela listada dentro de "Tabelas".

As tabelas "Nums" e "NumsLinha" n�o s�o iguais. Ambas s�o iguais no conte�do, mas n�o na estrutura interna. Voc�s v�o entender mais � frente o porqu�.

Por�m, digamos que nosso objetivo seja analisar a consulta onde selecionamos todos os registros da tabela "NumsLinha" que tenham o campo N igual � 10001.

SELECT * FROM NumsLinha WHERE N = '10001';Copiar c�digo
Ap�s selecionar e executar essa consulta, temos o resultado esperado.

Resultados:

#	n
1	10001
Por�m, agora queremos verificar o plano de execu��o dessa consulta para entender o que o SQL Server fez para nos trazer esse resultado.

Antes de analisar o plano de execu��o, vamos refletir: o SQL Server deve ter ido na tabela, percorrido todas as linhas da tabela at� achar a linha cujo N era igual a 10001, pegou essa linha e a exibiu. � isso que supomos que a ferramenta deve ter feito.

Vamos tentar entender se foi isso mesmo que aconteceu?

Se selecionamos novamente a segunda consulta e clicamos no bot�o "Incluir Plano de Execu��o Real" da barra de ferramentas (ou atalho "Ctrl + M"), vamos justamente ativar o plano de execu��o. Ap�s ativ�-lo, executamos a sele��o novamente.

Com isso, al�m do resultado da consulta, foi criada uma nova aba chamada "Plano de execu��o" na parte inferior do SQL Server Management Studio.

Clicamos nessa aba, temos todos os passos executados pelo SQL Server at� chegar ao resultado final.

Plano de execu��o:

Consulta 1: Custo da consulta (relativo ao lote): 100%

�ndice Ausente (Impacto 99.932): CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>] ON [dbo].[NumsLinha] ([n])

Captura de tela da aba "Plano de execu��o" do SQL Server Management Studio. Diagrama de tr�s passos: "SELECT", "Paralelismo (Gather Streams)" e "Table Scan (NumsLinha)", cada um possui um �cone ilustrativo acima e informa��es abaixo. S�o ligados por setas que apontam da direita para a esquerda. A �nica informa��o abaixo do passo "SELECT" �: custo de 0%. As informa��es abaixo do passo "Paralelismo (Gather Streams)" s�o: custo 8%, 0.523 segundos e 1 de 1(100%). As informa��es abaixo do passo "Table Scan (NumsLinha)" s�o: custo 92%, 0.523 segundos e 1 de 1(100%).

Foram executados tr�s passos. Chamamos cada passo de operador. Fazemos a leitura da direita para a esquerda, seguindo as setas. Assim, sabemos que o SQL Server usou um operador chamado "Table Scan", depois um operador chamado "Paralelismo" e, finalmente, exibiu o resultado final do comando "SELECT".

Em todos os operadores, existe um indicador chamado custo. Ao somar os custos dos operados temos o custo do SQL Server para nos devolver esse resultado. Foram gastos 92% do custo para fazer o "Table Scan", enquanto 8% desse custo foi para fazer o "Paralelismo".

Mas, podemos obter mais informa��es a respeito de cada operador executado pelo plano de execu��o.

Se passamos o cursor do mouse sobre o passo, aparece uma estat�stica sobre aquele operador espec�fico.

Table Scan

-	-
Opera��o F�sica	Table Scan
Opera��o L�gica	Table Scan
Modo de Execu��o Estimado	Row
Armazenamento	Row
N�mero de Linhas Lidas	30000000
N�mero Real de Linhas de Todas as Execu��es	1
N�mero Real de Lotes	0
Custo Estimado de E/S	35,7321
Custo Estimado do Operador	43,9821 (92%)
Custo Estimado da Sub�rvore	43,9821
Custo Estimado de CPU	8,25002
�	�
Para o "Table Scan", nos mostra o nome do operador como Table Scan, o n�mero de linhas que o programa teve que interagir para fazer esse Table Scan. O Table Scan teve que percorrer 30000000 linhas, isto �, a tabela toda. Tamb�m temos o custo estimado de entrada e sa�da (E/S) com o valor 35,7321. Ou seja, quanto foi gasto de I/O de disco.

Depois, temos o custo estimado desse operador: 92% do custo foi nesse passo e o custo foi de 43,9821. Mas, em que unidades esse custo � expresso? Unidade nenhuma, pois � uma unidade interna do SQL Server. Esse custo s� vai ter sentido quando o comparamos com outro plano de execu��o. Dessa forma, vamos saber se 43 � muito ou pouco.

Al�m disso, � listado o custo estimado de CPU como 8,25002. Note que o valor total do custo estimado do operador � a soma do gasto de entrada e sa�da com o que foi gasto de CPU.

O custo estimado da sub-�rvore � o acumulado do custo at� chegar ao resultado final. Ent�o, o SQL Server gastou 43,9821 at� esse primeiro passo.

Paralelismo

-	-
Opera��o F�sica	Paralelismo
Opera��o L�gica	Gather Streams
Modo de Execu��o Estimado	Row
Armazenamento	Row
N�mero Real de Linhas de Todas as Execu��es	1
N�mero Real de Lotes	0
Custo Estimado de E/S	0
Custo Estimado do Operador	3,6285 (8%)
Custo Estimado da Sub�rvore	47,6106
Custo Estimado de CPU	0,0285019
�	�
Depois, passamos o cursor sobre "Paralelismo". Nesse segundo passo, teve um custo estimado de 3,6285 somente para esse operador, ou seja, 8%. Com isso, o acumulado passou a ser 47,6106 como podemos observar no custo estimado da sub�rvore. Apesar desse passo n�o gastar nada de disco, s� de CPU.

SELECT

-	-
Tamanho do plano em cache	24 KB
Custo Estimado do Operador	0 (0%)
Grau de Paralelismo	8
Custo Estimado da Sub�rvore	47,6106
Concess�o de Mem�ria	136 KB
N�mero Estimado de Linhas de Todas as Execu��es	0
N�mero Estimado de Linhas por Execu��o	1,0829
Depois, passamos o cursor pelo operador "SELECT", onde temos o valor final, 47,6106. Ent�o, esse foi o custo estimado. Vamos comentar esse valor em uma nova linha.

-- 47,6106Copiar c�digo
O nosso objetivo ao tentar melhorar uma consulta � fazer com que o plano de execu��o do SQL Server percorra caminhos mais perform�ticos para resolv�-la.

Por qu�? Porque dependendo da estrutura do banco, da estrutura das tabelas e a forma como as tabelas forem criadas, o plano de execu��o vai escolher caminhos mais eficientes. Por isso, nosso objetivo � tentar entender como est� montada essa consulta e determinar novos caminhos para melhorar o plano de execu��o.

No pr�ximo v�deo, vamos aprender como executar esse mesmo plano de execu��o de uma maneira mais eficiente. Um abra�o e at� o pr�ximo v�deo.

-------------------------------------------------------------

A consulta para selecionar da tabela NumsLinha aquela cujo N � 10001, gastou 47,6106 unidades internas do SQL Server e executou o plano de execu��o com tr�s operadores: "Table Scan", "Paralelismo" e "SELECT".

Em uma nova consulta, vamos repetir esse comando utilizando a tabela "Nums". Relembramos que a tabela "Nums" e a tabela "NumsLinha" t�m o mesmo conte�do, por�m internamente elas t�m uma diferen�a. Vamos descobrir se essa diferen�a vai realmente acarretar alguma melhoria do plano de execu��o.

Para isso, vamos voltar � consulta original, copiar o comando e col�-lo na nova consulta. S� que em vez de consultar na tabela "NumsLinha", vamos usar a tabela "Nums".

SELECT * FROM Nums WHERE N = '10001';Copiar c�digo
Vamos executar essa consulta com o plano de execu��o ativado.

Resultados:

#	n
1	10001
Note que tivemos um plano de execu��o diferente.

Plano de execu��o:

Consulta 1: Custo da consulta (relativo ao lote): 100%

Captura de tela da aba "Plano de execu��o" do SQL Server Management Studio. Diagrama de dois passos: "SELECT" e "Busca de �ndice Clusterizado (Clustered)", cada um possui um �cone ilustrativo acima e informa��es abaixo. S�o ligados por setas que apontam da direita para a esquerda. A �nica informa��o abaixo do passo "SELECT" �: custo de 0%. As informa��es abaixo do passo "Busca de �ndice Clusterizado (Clustered)" s�o: PK_Nums_3BD01993BEE0CC12, custo 100%, 0.000 segundos e 1 de 1(100%)

Vamos compar�-lo com o anterior: o primeiro fez tr�s operadores e o segundo apenas dois.

Colocamos o cursor do mouse sobre o operador "Busca de �ndice Clusterizado" do segundo plano de execu��o para verificar o custo da opera��o. Note que 100% do custo ficou nesse passo, mas o valor desse custo � de apenas 0,0032831. Convenhamos que foi uma grande melhoria.

Anotamos o valor do custo estimado da opera��o para refer�ncia futura.

-- 0,0032831Copiar c�digo
Comparar planos de execu��o
Podemos comparar os planos de execu��o.

No plano de execu��o da tabela "NumsLinha", vamos clicar com o bot�o direito do mouse na aba "Plano de execu��o" e escolher a op��o "Salvar o Plano de Execu��o como�". Na janela que se abre, selecionamos o diret�rio de trabalho e salvamos o arquivo PLANO DE CONSULTA 01.sqlplan externamente.

No plano de execu��o da tabela "Nums", vamos clicar com o bot�o direito do mouse sobre uma �rea vazia da aba "Plano de execu��o" e escolher a op��o "Comparar Plano de Execu��o". Na janela que se abre, escolhemos o plano que salvamos anteriormente.

Ao clicar em abrir, conseguimos visualizar os dois planos de execu��o na aba "Compara��o de Plano de Execu��o". No plano superior temos o plano de execu��o da tabela "Nums" e no plano inferior temos o plano de execu��o de "NumsLinha".

No painel "Propriedades" � direita, conseguimos analisar as compara��es: o plano superior gastou 0,0032831 e o plano inferior gastou 47,6106. Houve bastante diferen�a no custo estimado.

Os indicadores que est�o diferentes entre cada plano s�o sinalizados com um sinal de diferen�a. Por exemplo, teve uma diferen�a entre os valores da propriedade "Compile Memory". Dessa forma, conseguimos analisar os pontos mais importantes de diferen�a entre esses planos de execu��o.

Agora, o que quer�amos destacar para voc�s a respeito de diferen�a entre esses dois planos est� escrito nos planos de execu��o. No plano de "NumsLinha", foi usado um "Table Scan" e um "Paralelismo". J� no outro plano, foi usado outro operador chamado "Busca de �ndice Clusterizado".

Isso significa que foram utilizados caminhos diferentes para chegar no mesmo resultado. Al�m disso, o operador "Busca de �ndice Clusterizado" foi bem mais eficiente do que fazer o "Table Scan".

Esses passos utilizaram o que chamamos de "Busca por Table Scan" e por "Busca por Seek". O termo em ingl�s "seek" se refere a busca de �ndice. O termo "clusterizado" � adicionado, pois podemos ter diferentes buscas de �ndice - como aprenderemos futuramente.

Existe uma grande diferen�a em termos de custo entre as consultas para buscar a linha do filtro N = '10001'. Afinal, tivemos que percorrer a tabela toda para achar a linha cujo N � igual � 10001. Ao usar um "Table Scan", vamos gastar mais tempo do que se usamos um "Seek".

O que faz o SQL Server optar pelo "seek" em vez do "scan"?

Quando fizemos as consultas, n�o especificamos nada para o SQL Server. Mas, ele sozinho decidiu usar um "Table Scan" para a consulta na tabela "NumsLinha". Quando fizemos o SELECT na tabela "Nums", ele usou o "seek". A diferen�a est� no �ndice clusterizado.

No pr�ximo v�deo, vamos entender como funciona um �ndice e como ele influencia na melhoria da performance do plano de execu��o.

Afinal, se expandimos a pasta "�ndices" da tabela "NumsLinha" no painel "Pesquisador de Objetos" � esquerda, n�o temos nenhum �ndice. Por�m, se verificamos na tabela "Nums", temos um �ndice: PK_Nums_3BD01993BEE0CC12 (Clusterizado). Logo, o fato desse �ndice existir fez com que o plano de execu��o da busca daquela linha, atrav�s da tabela "Nums", fosse muito mais eficiente do que na tabela "NumsLinha".

Entender a import�ncia do �ndice � fundamental. Por�m, precisamos saber os tipos de �ndices existentes e como criar o �ndice correto. Vamos discutir esses pontos nos pr�ximos v�deos. Um abra�o e at� daqui a pouco.

--------------------------------------------------

No v�deo anterior, descobrimos que o �ndice melhora o resultado do plano de execu��o. Vamos entender como isso funciona.

�ndices
Vamos criar aqui uma nova consulta para trabalhar com a tabela "TB_cliente" do supermercado BitByte. Em uma nova linha, vamos escrever a seguinte consulta:

SELECT * FROM tb_cliente WHERE cidade = 'Salvador';Copiar c�digo
Vamos selecionar e executar essa consulta.

Resultados:

#	cpf	nome	sobrenome	email	telefone	cidade	numero	rua	complemento
1	56921331639	Gustavo	Ribeiro	gmail.com	22988107	Salvador	2635	Rua 119	Apto. 87
2	724631570	Solange	Castro	yahoo.com	40843852	Salvador	613	Rua 24	Apto. 69
3	5064441074	Cristina	Nascimento	uol.com.br	88522388	Salvador	1511	Rua 974	Apto. 29
�	�	�	�	�	�	�	�	�	�
O resultado s�o todos os clientes que est�o em Salvador.

Agora, vamos ativar o plano de execu��o desta consulta no bot�o "Incluir Plano de Execu��o Real". Na aba "Plano de execu��o", verificamos que o plano de execu��o dessa consulta usa o "Table Scan", al�m do "Paralelismo" para chegar ao "SELECT". Em outras palavras, o SQL Server percorre toda a tabela, analisa linha a linha em busca de quem � cliente da cidade de Salvador.

Plano de execu��o:

Consulta 1: Custo da consulta (relativo ao lote): 100%

�ndice Ausente (Impacto 99.932): CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>] ON [dbo].[tb_cliente] ([cidade]) INCLUDE ([cpf], [nome], [sobrenome], [email], [telefone], [numero], [rua], [complemento])

Captura de tela da aba "Plano de execu��o" do SQL Server Management Studio. Diagrama de tr�s passos: "SELECT", "Paralelismo (Gather Streams)" e "Table Scan (tb_cliente)", cada um possui um �cone ilustrativo acima e informa��es abaixo. S�o ligados por setas que apontam da direita para a esquerda. A �nica informa��o abaixo do passo "SELECT" �: custo de 0%. As informa��es abaixo do passo "Paralelismo (Gather Streams)" s�o: custo 2%, 0.006 segundos e 8306 de 8058 (103%). As informa��es abaixo do passo "Table Scan (tb_cliente)" s�o: custo 98%, 0.034 segundos e 8306 de 8058 (103%).

Vamos observar o resultado desse plano de execu��o ao passar o cursor do mouse sobre o operador "SELECT". Em "custo estimado da sub�rvore" temos um valor de 9,66822, vamos anot�-lo.

-- 9,66822Copiar c�digo
Agora, observe que o pr�prio plano de execu��o nos escreve uma mensagem em verde: "�ndice ausente". Em seguida, nos mostra um comando para criar o �ndice. Ou seja, apesar de resolver o plano de execu��o dessa consulta com "Table Scan", o pr�prio SQL Server d� uma dica para quem est� analisando o plano de execu��o: "para melhorar o resultado, � preciso criar um �ndice".

Qual �ndice devemos criar? O especificado no comando CREATE NONCLUSTERED INDEX. Ent�o, vamos cri�-lo.

Cria��o de �ndice
Em uma nova linha, digitamos CREATE NONCLUSTERED INDEX seguido do nome do �ndice. Nosso �ndice vai se chamar idx_tb_cliente_cidade, ou seja, identificamos em seu nome a tabela e o campo que faz parte do �ndice. Em seguida, escrevemos ON seguido do nome da tabela tb_cliente e o campo cidade entre par�nteses.

Tamb�m pede para incluir a cl�usula INCLUDE e todos os campos da tabela entre par�nteses, exceto o campo que faz parte do �ndice.

CREATE NONCLUSTERED INDEX idx_tb_cliente_cidade ON tb_cliente (cidade) 
INCLUDE (cpf, nome, sobrenome, email, telefone, numero, rua, complemento);Copiar c�digo
Selecionamos e executamos o comando para criar o �ndice.

Mensagens:

Comandos conclu�dos com �xito

Executamos de novo a mesma consulta SELECT com o plano de execu��o ativado. Note que agora temos um plano de execu��o diferente usando o �ndice.

Plano de execu��o:

Consulta 1: Custo da consulta (relativo ao lote): 100%

Captura de tela da aba "Plano de execu��o" do SQL Server Management Studio. Diagrama de dois passos: "SELECT" e "Index Seek (NonClustered)", cada um possui um �cone ilustrativo acima e informa��es abaixo. S�o ligados por setas que apontam da direita para a esquerda. A �nica informa��o abaixo do passo "SELECT" �: custo de 0%. As informa��es abaixo do passo "Index Seek (NonClustered)" s�o: idx_tb_cliente_cidade, custo 100%, 0.004 segundos e 8306 de 8306(100%)

Conseguimos verificar que o �ndice usado foi o �ndice que acabamos de criar. Passando o cursor do mouse sobre "SELECT", descobrimos que custo desse plano foi de 0,09184. Um ganho excelente, comparando o custo das duas consultas.

-- 9,66822
-- 0,09184Copiar c�digo
Para criar o �ndice, a estrutura do comando �:

CREATE + tipo do �ndice. Criamos um �ndice do tipo NON_CLUSTERED (n�o clusterizado em tradu��o livre);
INDEX + nome do �ndice. Normalmente, esse nome seguir� a nomenclatura que a empresa usa;
ON + nome da tabela onde vai ter o �ndice + nome do campo que faz parte do �ndice entre par�nteses;
INCLUDE + outros campos que n�o fazem parte do �ndice entre par�nteses.
Dependendo do tipo do �ndice e a forma como voc� o cria, o plano de execu��o vai ou n�o usar o �ndice.

Antes de discutir esse assunto e explicar como o plano de execu��o escolhe o �ndice correto, vamos entender como a estrutura do �ndice realmente melhora o plano de execu��o.

Estrutura do �ndice
Vamos exemplificar com uma pequena tabela, onde temos clientes armazenados fora de ordem.

Tabela fict�cia:

CLIENTE	NOME
002	Cliente 002
001	Cliente 001
003	Cliente 003
Na primeira linha, temos o 002. Na segunda linha, o 001. E na terceira linha, o 003. Digamos que queremos achar o elemento cujo c�digo do cliente seja 003.

Em um "Table Scan", temos que percorrer a tabela toda e verificar linha a linha at� descobrir onde est� o 003 que � o filtro. Percorrer a tabela toda do in�cio ao fim tem um custo.

Agora, o �ndice � uma tabela auxiliar onde temos os c�digos ordenados do menor para o maior, ou seja, o campo que faz parte do crit�rio do �ndice. Tamb�m temos a posi��o de onde est� armazenado cada linha da tabela.

�ndice:

CLIENTE	LINHA
001	2
002	1
003	3
Dessa maneira, se queremos achar o 003, conseguimos rapidamente localizar a linha do �ndice onde est� o 003 atrav�s de um algoritmo de busca. Ent�o, verificamos a posi��o de mem�ria onde o 003 est� armazenado para ir at� a tabela buscar o dado desejado.

Em suma, o "Table Scan" realiza a busca diretamente na tabela, percorrendo linha a linha at� o final.

No �ndice, existe uma tabela auxiliar organizada de forma alfab�tica, e atrav�s do algoritmo de busca, � poss�vel descobrir a posi��o desejada mais rapidamente. A partir da�, j� se sabe a posi��o de mem�ria onde o dado que queremos buscar est� armazenado.

� nesse contexto de posi��o de mem�ria que surgem os conceitos de �ndice n�o clusterizado e clusterizado. Eles se baseiam na estrutura de como os dados est�o armazenados na mem�ria.

Suponha que se tenha uma �rea de disco representado por um ret�ngulo cinza. Nele, temos ret�ngulos coloridos menores, onde cada cor diferente representa um segmento de dados gravados e armazenados no disco.

Os �ndices n�o clusterizados funcionam da seguinte maneira: existe uma estrutura auxiliar na qual os dados est�o armazenados em ordem alfab�tica, de acordo com o crit�rio do �ndice.

Por exemplo, guardamos nomes de pessoas no disco: Jo�o, Pedro, Carlos, Ana e J�lia. Esses dados v�o estar guardados de forma ordenada na estrutura auxiliar: Ana, Carlos, Jo�o, J�lia e Pedro. Se quisermos encontrar o funcion�rio Jo�o, basta buscar o nome "Jo�o" dentro da lista ordenada. O algoritmo para fazer isso � r�pido. Ap�s achar o "Jo�o", verificamos a posi��o de mem�ria do registro na tabela e buscamos o dado.

J� o �ndice clusterizado � diferente. Esse �ndice faz com que os segmentos de mem�ria da tabela no disco j� estejam gravados ordenadamente pelo crit�rio do �ndice. Dessa maneira, quando queremos buscar um determinado nome de funcion�rio, a busca � feita diretamente dentro dos segmentos de mem�ria.

A conclus�o � que o �ndice clusterizado � mais eficiente que o n�o clusterizado. Por�m, n�o basta criar todos os �ndices clusterizados para resolver o problema de perfomance.

No pr�ximo v�deo, vamos criar v�rios exemplos de �ndices clusterizados e n�o clusterizados para entender qual � o �ndice correto a ser utilizado em cada caso.

-------------------------------------------------------------

Agora, vamos discutir como sabemos qual � o �ndice correto a ser usado, dependendo de cada consulta.

Para isso, voc�s v�o baixar o arquivo ConsultasIndices.sql cujo link est� disponibilizado na atividade "Preparando o ambiente".

Ap�s baix�-lo, vamos acessar o SQL Server Management Studio. No menu superior, vamos em "Arquivo > Abrir > Arquivo" (ou atalho "Ctrl + O"), selecionamos o arquivo ConsultasIndices.sql no diret�rio que o baixamos e apertamos "Abrir".

Nesse arquivo, temos uma s�rie de comandos que vamos analisar um a um.

Cria��o da tabela e inser��o de registros
Primeiro, vamos criar uma tabela chamada "T_heap", que vai ter seis campos todos do tipo inteiro. O nome dos campos �: a, b, c, d, e e f. Para criar essa tabela, selecionamos e executamos a segunda linha. Caso voc� j� tenha essa tabela criada ou est� repetindo a experi�ncia de novo, d� um DROP na tabela primeiro.

drop table T_heap;
CREATE TABLE T_heap (a int NOT NULL, b int NOT NULL, c int NOT NULL, d int NOT NULL, e int NOT NULL, f int NOT NULL);Copiar c�digo
Mensagens:

Comandos conclu�dos com �xito.

Pronto, criamos a tabela.

Depois, vamos selecionar desde declare at� end para executar outro comando.

declare @contador int
declare @max int
SET @contador = 1
SET @max = 50
WHILE @contador <= @max
BEGIN
   insert into T_heap (a,b,c,d,e,f) values ([dbo].[NumeroAleatorio](1,100), [dbo].[NumeroAleatorio](1,100),[dbo].[NumeroAleatorio](1,100),[dbo].[NumeroAleatorio](1,100),[dbo].[NumeroAleatorio](1,100),@contador)
   set @contador = @contador + 1
ENDCopiar c�digo
Ele vai fazer um loop e inserir 50 linhas na tabela "T_heap", sendo que todos os campos de a at� e ser�o n�meros aleat�rios entre 1 e 100 e apenas o campo f vai ser o contador. Desse modo, como teremos 50 linhas, o campo f vai ter desde o n�mero 1 at� 50.

Mensagens:

(1 linha afetada) x 50

Pronto, coloquei 50 linhas dentro da tabela "T_heap".

Vamos selecionar um comando que n�o est� escrito previamente no arquivo baixado, s� para saber o conte�do da tabela.

SELECT * FROM T_heap;Copiar c�digo
Resultados:

#	a	b	c	d	e	f
1	38	13	26	39	21	1
2	30	23	43	59	86	2
3	22	22	13	3	5	3
�	�	�	�	�	�	�
O resultado s�o os dados da tabela.

Consulta com �ndice n�o clusterizado
Em seguida, vamos selecionar somente os campos b e c, usando como filtro b igual � 68 e c igual � 55.

SELECT b, c FROM t_heap where b = 68 and c= 55;Copiar c�digo
Vamos selecionar essa linha, ativar o plano de execu��o e executar o comando.

Ap�s executar esse comando, acessamos a aba "Plano de execu��o" e notamos que foi feito um "Table Scan (T_heap)" de custo 100% e um "SELECT" de custo 0%. Como n�o tem �ndice na tabela, o SQL Server percorreu todas as linhas e fez um "Table Scan".

Agora, vamos criar um �ndice n�o clusterizado usando o pr�ximo comando do arquivo:

CREATE NONCLUSTERED INDEX T_heap_a ON T_heap (a);Copiar c�digo
O nome do �ndice � T_heap_a e vai ser criado na tabela T_heap apenas para o campo a. O campo a vai ser o crit�rio do �ndice. Selecionamos e executamos para criar o �ndice.

Mensagens:

Comandos conclu�dos com �xito.

Agora a pr�xima sele��o vai usar b igual � 1 como filtro e selecionar o campo b da tabela t_heap.

SELECT b FROM t_heap WHERE b = 1Copiar c�digo
Lembre-se que temos um �ndice criado para essa tabela, por�m o �ndice considera o campo a. O que vai acontecer?

Ap�s executar, verificamos o plano de execu��o. Note que o SQL Server continua fazendo o "Table scan". Por qu�? Porque o �ndice que temos na tabela considera o campo a, mas fizemos um SELECT no campo b. Logo, esse �ndice que considera o campo a n�o fez nenhuma diferen�a para melhorar a consulta que seleciona o campo b.

Mas, e se a consulta selecionar e tamb�m fizer um filtro no campo a?

SELECT a FROM t_heap WHERE a = 1Copiar c�digo
Se selecionamos e executamos essa outra consulta, a� sim ele vai usar o "Index Seek (NonClustered)" no plano de execu��o, usando justamente o �ndice que criamos T_heap_a. Por qu�? Porque o �ndice considera somente o campo a. Como fizemos o crit�rio de sele��o pelo campo a, funcionou.

Agora, vamos criar outro �ndice, usando como crit�rio o campo b e o campo c.

CREATE INDEX T_heap_bc ON T_heap (b, c);Copiar c�digo
Mensagens:

Comandos conclu�dos com �xito.

Em seguida, fazemos uma sele��o do campo b e do campo c, usando como crit�rio tamb�m b e c.

SELECT b, c FROM t_heap WHERE b = 1 and c = 1;Copiar c�digo
Com isso, o plano de execu��o usa o "Index Seek (NonClustered)" e justamente usa o �ndice que acabamos de criar, T_heap_bc.

O que acontece se selecionamos s� o campo b? O crit�rio de sele��o ainda � b e c igual � 1, mas na sele��o s� escolhemos b.

SELECT b FROM t_heap WHERE b = 1 and c = 1;Copiar c�digo
No plano de execu��o, continuamos usando o �ndice T_heap_bc.

Agora, o que acontece se selecionamos a, usando como crit�rio de filtro b e c?

SELECT a FROM t_heap WHERE b = 1 and c = 1;Copiar c�digo
Perceba a diferen�a. O campo a tem um �ndice pr�prio, T_heap_a. Tamb�m temos outro �ndice, que � o T_heap_bc. Mas, estamos selecionando o a, usando como crit�rio b e c. O que vai acontecer?

Ap�s executar, foi feito um "Table Scan" no plano de execu��o. Mas, temos um �ndice para a e um �ndice para b e c. Por que o SQL Server fez o "Table Scan"?

Ele fez o "Table Scan" justamente porque n�o existe um �ndice que tenha a, b e c juntos. Se existisse, o �ndice seria usado.

Cl�usula INCLUDE
Mas, existe uma cl�usula chamada INCLUDE que at� usamos no v�deo anterior. O que significa o INCLUDE?

Vamos fazer o teste com o campo d, criando o �ndice T_heap_d.

CREATE INDEX T_heap_d ON T_heap (d) INCLUDE (e);Copiar c�digo
Note que o �ndice � do campo D, mas est� usando o INCLUDE do campo e. Vamos executamos a cria��o desse �ndice.

Mensagens:

Comandos conclu�dos com �xito.

Agora, vamos visualizar o plano de execu��o para uma consulta que inclua e selecione d e e.

SELECT d, e FROM t_heap WHERE d = 1 and e = 1;Copiar c�digo
Ser� que o �ndice T_heap_d ser� usado? Ele s� foi criado para d, por�m tem um INCLUDE de e. Vamos conferir.

O SQL Server usa o �ndice no plano de execu��o. Ou seja, o INCLUDE inclui novos campos para que o �ndice usado para este campo �nico possa ser reaproveitado quando outros campos estiverem selecionados.

Por isso que quando criamos o �ndice idx_tb_cliente_cidade, que era s� por cidade, demos o INCLUDE em todos os outros campos da tabela. Assim, quando fizemos SELECT * da cidade de Salvador, o �ndice foi usado. Se tiv�ssemos criado o �ndice sem o INCLUDE, o plano de execu��o n�o usaria o �ndice na execu��o do SELECT *, apesar do ter crit�rio de filtro por cidade. Afinal, hav�amos selecionando outros campos que n�o faziam parte do campo do �ndice.

� muito importante que ao criar um �ndice, voc� tenha certeza que todos os campos que estejam na sele��o e no crit�rio de busca, fa�am parte do �ndice e do INCLUDE.

Se selecionamos os campos e e d usando como crit�rio d e e igual � 1, o plano de execu��o tamb�m vai usar o �ndice T_heap_d. O mesmo acontece se selecionamos apenas o campoe`.

SELECT e, d FROM t_heap WHERE d = 1 and e = 1;
SELECT e FROM t_heap WHERE d = 1 and e = 1;Copiar c�digo
Por�m, se selecionamos o campo a usando o crit�rio d e d, passa a usar o "Table Scan".

SELECT a FROM t_heap WHERE d = 1 and e = 1;Copiar c�digo
Se quis�ssemos que esta consulta utilizasse o �ndice correto, bastaria incluir o campo a em T_heap_d.

Para isso, primeiro damos um DROP INDEX para apagar o �ndice T_heap_d.

drop INDEX T_heap_d ON T_heap;Copiar c�digo
Mensagens:

Comandos conclu�dos com �xito.

Agora, vamos cri�-lo de novo, por�m, tamb�m vamos colocar o campo a no INCLUDE.

CREATE INDEX T_heap_d ON T_heap (d) INCLUDE (e, a); Copiar c�digo
Com isso, vamos criar um �ndice para o campo d, com INCLUDE nos campos e e a.

Mensagens:

Comandos conclu�dos com �xito.

�ndice criado.

SELECT a FROM t_heap WHERE d = 1 and e = 1;Copiar c�digo
Agora essa consulta que envolve d, e e a, vai usar o �ndice.

--------------------------------------------------------------------

No v�deo passado, aprendemos que quando utilizamos um �ndice n�o clusterizado, precisamos sempre incluir no crit�rio do �ndice ou no INCLUDE todos os campos que far�o parte do filtro e tamb�m da sele��o. Se faltar algum campo, o plano de execu��o n�o utilizar� o �ndice.

No entanto, podemos criar o que chamamos de UNIQUE INDEX ou �ndice �nico.

Cria��o de �ndice �nico
Vamos criar um �ndice �nico chamada T_heap_f usando o campo f da tabela "T_heap".

CREATE UNIQUE INDEX T_heap_f ON T_heap (f); Copiar c�digo
Por que vamos usar o campo f? Porque esse campo foi onde inclu�mos o contador do loop. Com isso, garantimos que o campo f � �nico.

Para colocar um campo como crit�rio de UNIQUE INDEX, ele n�o pode ter valores repetidos dentro da tabela. Ou seja, funciona como chave prim�ria, como j� aprendemos nos cursos introdut�rios sobre banco de dados e estruturas de tabela do SQL Server.

Mas qual ser� o impacto quando a tabela tiver um �ndice �nico?

Vamos verific�-lo ao selecionar e executar a cria��o do �ndice �nico T_heap_f.

Mensagens:

Comandos conclu�dos com �xito.

Em seguida, vamos selecionar o campo f, usando como filtro o pr�prio f igual � 1.

SELECT f FROM t_heap WHERE f = 1;Copiar c�digo
J� sabemos que um �ndice ser� utilizado, pois apenas o campo f est� sendo usado tanto na sele��o quanto no filtro. Ap�s executar o comando com o plano de execu��o ativo, verificamos que o �ndice �nico � usado no "Index Seek (NonClustered)" de custo 100% para chegar ao "SELECT".

Agora, qual ser� o resultado desta sele��o?

SELECT a FROM t_heap WHERE f = 1;Copiar c�digo
Selecionamos o campo a, usando como crit�rio o f igual � 1. Pelo que verificamos no v�deo passado, se us�ssemos �ndices n�o clusterizados, o plano de execu��o n�o usaria nenhum �ndice. Mas, vamos conferir o que vai acontecer agora que usamos �ndice �nico.

O SQL Server faz um plano de execu��o diferente, onde foram usados "Index Seek (NonClustered)" com custo de 50% e "RID Loopkup (Heap)" com custo de 50% para chegar ao operador "Loops Aninhados (Jun��o Interna)" com custo de 0% que, por sua vez, chega ao "SELECT" com custo de 0%.

Mas, note que ainda usa o �ndice T_heap_f no "Index Seek". Isso significa que o �ndice �nico possibilita o uso de �ndice em qualquer tipo de sele��o.

Sempre crie uma chave prim�ria em suas tabelas criadas no SQL Server. Assim, voc� pode criar o �ndice �nico para essa coluna que n�o ter� repeti��es de registros.

Muitas vezes, falamos �ndice �nico e chave prim�ria como sin�nimo. Mas, s�o conceitos diferentes.

A chave prim�ria � a defini��o colocada quando se cria a tabela para garantir que um determinado campo n�o pode se repetir. Com isso, � criada uma restri��o, como uma regra de neg�cio. Por exemplo, o c�digo de cliente ou o c�digo do produto. J� o �ndice �nico � um �ndice para o campo que n�o se repete.

O que acontece � que quando criamos uma chave prim�ria, automaticamente criamos um �ndice �nico. Assim, o �ndice faz parte de qualquer tipo de sele��o que seja feito na tabela.

---------------------------------------------------------

Agora vamos falar dos �ndices clusterizados.

Mas antes, vamos executar novamente a consulta SELECT a FROM t_heap WHERE f = 1 que fizemos no v�deo anterior para verificar seu plano de execu��o que usa o �ndice �nico T_heap_f. Repare que �ndice �nico � tamb�m um �ndice n�o clusterizado, ou seja, "NonClustered". Mas, � preciso necessariamente que a coluna que faz parte desse �ndice seja uma coluna �nica.

Cria��o da tabela e inser��o de registros
Agora, vamos criar outra tabela que vai se chamar "T_clu", que servir� para treinamos os �ndices clusterizados. Vamos criar a tabela atrav�s da seguinte linha presente no arquivo que baixamos:

CREATE TABLE T_clu (a int NOT NULL, b int NOT NULL, c int NOT NULL, d int NOT NULL, e int NOT NULL, f int NOT NULL); Copiar c�digo
Mensagens:

Comandos conclu�dos com �xito.

Ap�s criar a tabela, vamos fazer outro loop para colocar dados dentro dessa nova tabela. A diferen�a � que agora o contador, que define qual � o campo �nico, vai estar tanto no campo f quanto no campo a. Desse modo, tanto o campo a como o campo f ser�o campos �nicos. Vamos ter n�meros aleat�rios apenas nos campos b, c, d e e.

declare @contador int
declare @max int
SET @contador = 1
SET @max = 50
WHILE @contador <= @max
BEGIN
   insert into T_clu (a,b,c,d,e,f) values (@contador, [dbo].[NumeroAleatorio](1,100), [dbo].[NumeroAleatorio](1,100),[dbo].[NumeroAleatorio](1,100),[dbo].[NumeroAleatorio](1,100), @contador)
   set @contador = @contador + 1
END;Copiar c�digo
Selecionamos e executamos o comando para criar 50 linhas dentro da tabela "T_clu".

Consulta com �ndice clusterizado
Com o pr�ximo comando, vamos criar um campo �nico clusterizado chamado T_clu_a, usando como crit�rio o campo a.

CREATE UNIQUE CLUSTERED INDEX T_clu_a ON T_clu (a);Copiar c�digo
Mensagens:

Comandos conclu�dos com �xito.

Acabamos de criar um campo �nico clusterizado. Note que anteriormente usamos CREATE UNIQUE INDEX e n�o especificamos o tipo do �ndice, portanto, automaticamente ele foi "NonClustered". Logo, o campo �nico que criamos no v�deo passado era n�o clusterizado e agora criamos um clusterizado.

Campos �nicos podem ser dos dois tipos. A �nica diferen�a � que o n�o clusterizado guarda na sua estrutura apenas as posi��es de mem�ria. Com isso, voc� busca o dado desejado, acha a posi��o de mem�ria e vai nessa posi��o de mem�ria. Enquanto os clusterizados v�o direto nas posi��es de mem�ria do disco, porque j� foram armazenadas no disco de forma ordenada.

Ent�o, se T_clu_a � um campo �nico e dermos um SELECT *, ou seja, selecionar todos os campos, vamos ter o uso do �ndice no plano de execu��o.

SELECT * FROM T_clu where b = 68 and c= 55;Copiar c�digo
Conferimos que operador usado foi um "Clustered Index Scan (Clustered)" com custo de 100% que usa T_clu_a para chegar ao "SELECT" com custo de 0%.

Se colocamos como crit�rio da sele��o o pr�prio campo a presente no �ndice �nico, o �ndice tamb�m vai ser usado.

SELECT * FROM T_clu where a = 50;Copiar c�digo
No plano de execu��o, foi usado o operador "Busca de �ndice Clusterizado (Clustered)", usando o �ndice �nico T_clu_a.

Agora, vamos criar um �ndice usando b e c chamado T_clu_b.

CREATE INDEX T_clu_b ON T_clu (b, c); Copiar c�digo
Em seguida, usamos o crit�rio da sele��o do campo b e c.

SELECT b, c FROM T_clu where b = 50 and c = 50;Copiar c�digo
No plano de execu��o, ele escolheu fazer um "Index Seek (NonClustered)" com o �ndice T_clu_b, porque � o �ndice mais adequado.

Em outro comando, colocamos o mesmo filtro, mas selecionamos o campo e, o qual n�o faz parte do �ndice T_clu_b. Como a tabela "T_clu" tem um �ndice clusterizado �nico chamado T_clu_a, talvez o SQL Server passe a usar esse �ndice.

SELECT e FROM T_clu where b = 50 and c = 50;Copiar c�digo
Vamos verificar o que vai acontecer. Ap�s executar e conferir o plano de execu��o, notamos que foi usado o �ndice T_clu_a, que � o �ndice �nico. Por qu�?

Porque primeiro o SQL Server vai buscar o �ndice que encaixe perfeitamente na consulta. Ele sabe que tem um �ndice de b e c. Como temos o filtro b e c na consulta, esse �ndice T_clu_b � candidato. Por�m, como selecionamos o campo e, n�o � poss�vel usar o �ndice T_clu_b. Mas, antes de desistir, o SQL Server lembra que a tabela tem um �ndice �nico, portanto, ele pode usar esse �ndice �nico no lugar do �ndice espec�fico para b e c.

Agora, vamos criar um �ndice para o campo d chamado T_clu_d, mas usando o INCLUDE para incluir o campo e.

CREATE INDEX T_clu_d ON T_clu (d) INCLUDE (e);Copiar c�digo
Mensagens:

Comandos conclu�dos com �xito.

Quando fizermos a sele��o de d e e, o SQL Server vai usar o �ndice que mais se adapta, que � o �ndice T_clu_d.

SELECT d, e FROM T_clu where d = 2 and e = 2;Copiar c�digo
No plano de execu��o, conferimos que o operador usado foi um "Index Seek (NonClustered)" usando o T_clu_d.

Vamos criar um segundo �ndice �nico na tabela "T_clu" chamado T_clu_f, porque usa o campo f.

CREATE UNIQUE INDEX T_clu_f ON T_clu (f);Copiar c�digo
Mensagens:

Comandos conclu�dos com �xito.

Agora, vamos fazer uma sele��o de todos os campos da tabela, mas usando como crit�rio o campo f igual � 1.

SELECT * FROM T_clu where f = 1;Copiar c�digo
O SQL Server vai usar os dois �ndices para buscar as melhores informa��es para poder nos dar o resultado. No plano de execu��o, foram usados os operadores "Index Seek (NonClustered)" com o �ndice T_clu_f com custo de 50% e "Pesquisa de Chave (Clustered)" com o �ndice T_clu_a tamb�m com custo de 50%. Depois, � usado o operador "Loops Aninhados (Jun��o Interna)" com custo de 0% que, por sua vez, chega ao "SELECT" com custo de 0%.

Enfim, � importante que voc� entenda qual � o tipo de sele��o que voc� vai fazer e qual � o melhor �ndice que voc� deve utilizar.

Agora que n�s j� entendemos a mec�nica, o que vamos fazer no pr�ximo v�deo? No in�cio do curso mostramos para voc�s a consulta para cria��o do nosso relat�rio de faturamento que est� um pouco lenta. O cliente n�o gosta do relat�rio, porque demora muito. Vamos verificar se ao criar �ndices podemos melhor a consulta desse relat�rio.

Agora vamos retomar nosso problema original: otimizar o relat�rio de vendas de produtos por classifica��o. Quando nosso usu�rio reclamou sobre a performance do ambiente do SQL Server, ele estava se referindo a esse relat�rio.

Revisando nossa trajet�ria no curso
O que fizemos at� agora?

1- Verificamos a linha base do funcionamento do nosso ambiente. A partir dessa an�lise, notamos que em algumas situa��es, o processamento do servidor do SQL Server foge a essa linha base original.

2 - Usamos o SQL Profiler para fazer um Trace e verificar todas as comunica��es efetuadas entre clientes e o servidor. Depois, identificamos as consultas mais pesadas.

3 - Analisamos os planos de execu��o das consultas. Com esta an�lise, refletimos sobre as iniciativas poss�veis para reduzir o custo de resolu��o dessas consultas.

� isso que faremos agora:

Analisar o relat�rio de vendas;

Observar o seu plano de execu��o;

Pensar iniciativas para melhorar a performance.

Nossa base original j� foi bastante manipulada durante o curso, ent�o, antes de analisarmos a consulta que gera o relat�rio, vamos:

Apagar a nossa base e recuperar o mesmo backup que recuperamos na primeira aula do nosso curso. Assim, teremos uma base de dados apenas com as tabelas do supermercado BitByte, sem nenhum �ndice que possa prejudicar nossa an�lise.
Este processo � bem r�pido: basta clicar com o bot�o direito do mouse sobre a base DB Vendas que j� instalada na m�quina, e selecionar a op��o "Excluir". Na pr�xima tela, vamos marcar a caixa de sele��o "Fechar conex�es existentes" e apertar "Ok".

Nosso pr�ximo passo �, localizar na m�quina onde est� salvo o arquivo de backup. Se voc� n�o sabe onde salvou o arquivo, basta voltar � primeira aula do nosso treinamento e realizar novamente o download.

No meu caso, o arquivo est� localizado no diret�rio "C:> Temp > Vendas".

De volta ao ambiente (Microsoft SQL Server Management Studio), vamos selecionar o "Banco de Dados" com o bot�o direito do mouse e escolher a op��o "Restaurar banco de dados".

Na pr�xima tela, vamos marcar "Dispositivo". � frente, selecionaremos o bot�o de "tr�s pontinhos". Uma janela ser� aberta e, nela, apertaremos "Adicionar". Na pr�xima tela, buscaremos o diret�rio onde o arquivo de backup est� salvo: "temp > DBP_VENDAS".

Localizado o arquivo "BD_VENDAS.BAK", basta selecion�-lo e apertar "OK". Na outra janela, selecionamos o nome do arquivo, "C:\temp\DB_VENDAS\DB_VENDAS.BAK" e novamente apertamos "OK".

Em seguida, acessaremos "Op��es" no menu lateral esquerdo, "Selecionar uma p�gina". Em "Op��es", vamos marcar "Substituir o banco de dados existente", apertar "Ok" e aguardar o backup ser recuperado.

Agora temos a base de dados est� pronta e podemos come�ar a an�lise do relat�rio de vendas por classifica��o.

---------------------------------------------------------------

Estamos com o relat�rio de vendas por classifica��o aberto:

DECLARE @ESTE_MES INT DECLARE @ESTADP VARCHAR(2)
SET @ESTE_MES =
SET @ESTADO = 'SP'
SELECT VENDAS.classificacao AS CLASSIFICACAO,
       ROUND(VENDAS.VALOR_MES, 2) AS VALOR,
             ROUND(VENDAS.VALOR_MES/ TOTAL.VALOR_TOTAL) * 100, 2) AS PERCENTUAL

// c�digo omitido 
Copiar c�digo
Vamos escolher, aleatoriamente:

Um m�s. Por exemplo, "3" mar�o.
DECLARE @ESTE_MES INT DECLARE @ESTADP VARCHAR(2)
SET @ESTE_MES = 3
SET @ESTADO = 'SP'
SELECT VENDAS.classificacao AS CLASSIFICACAO,
       ROUND(VENDAS.VALOR_MES, 2) AS VALOR,
             ROUND(VENDAS.VALOR_MES/ TOTAL.VALOR_TOTAL) * 100, 2) AS PERCENTUAL

// c�digo omitido 
Copiar c�digo
Um estado da federa��o. Por exemplo, "RJ".
DECLARE @ESTE_MES INT DECLARE @ESTADP VARCHAR(2)
SET @ESTE_MES = 3
SET @ESTADO = 'RJ'
SELECT VENDAS.classificacao AS CLASSIFICACAO,
       ROUND(VENDAS.VALOR_MES, 2) AS VALOR,
             ROUND(VENDAS.VALOR_MES/ TOTAL.VALOR_TOTAL) * 100, 2) AS PERCENTUAL

// c�digo omitido 
Copiar c�digo
No menu superior da tela, vamos selecionar "Incluir Plano de Execu��o Real (Ctrl + M)" e apertar "Executar" para executarmos o relat�rio.

Estamos "resolvendo" o relat�rio no tempo original do usu�rio do supermercado BitByte. Na minha m�quina, executei em 17 segundos.

CLASSIFICACAO	VALOR	PERCENTUAL
Frutas	321540	7.66
Legumes	178029	4.24
Doces	158522	3.78
...	...	...
Podemos observar o "Plano de execu��o". Ele � extremamente complexo, utiliza v�rios tables scans e faz joins porque, o comando SQL que est� sendo resolvido � bastante complexo tamb�m.

O pr�prio plano de execu��o apresenta uma sugest�o de �ndice:

Consulta 1: Custo da consulta (relativo ao lote: 100%
SELECT VENDAS.classificacao AS CLASSIFICACAO, ROUND(VENDAS.VALOR_MES, 2) AS VALOR, ROUND(VENDAS.VALOR_MES/ TOTAL.VALOR_TOTAL) * 
�ndice Ausente (Impacto 46.4102): CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>] ON [dbo].[tb_item] ([codigo_prod...
Copiar c�digo
A sugest�o � criar um �ndice n�o clusterizado por c�digo do produto e passar um include no campo n�mero, quantidade e pre�o. Vamos criar esse �ndice.

Antes, n�o se esque�a de anotar o tempo de resolu��o do relat�rio. No meu caso, foi 17 segundos, com custo no plano de execu��o de 512.844 (Para visualizar esse valor, basta selecionar "SELEC Custo".

Ent�o, vamos criar o �ndice n�o clusterizado na tabela tb_item por c�digo do produto. Vamos escrever CREATE NONCLUSTERED INDEX seguido do nome do �ndice que ser� idx_tb_item_codigo_produto, sendo codigo_produto o campo em que criaremos o �ndice.

Depois, passaremos ON e o nome da tabela, tb_item. Entre par�nteses, passaremos o campo que ser� crit�rio do �ndice codigo_produto.

CREATE NONCLUSTERED INDEX idx_tb_item_codigo_produto ON tb_item (codigo_produto)
Copiar c�digo
Vamos aplicar o INLCUDE nos campos numero, quantidade e preco.

CREATE NONCLUSTERED INDEX idx_tb_item_codigo_produto ON tb_item (codigo_produto)
INCLUDE (numero, quantidade, preco);
Copiar c�digo
Agora, vamos executar o comando!

O �ndice foi criado. Na minha m�quina, o processo demorou 3 minutos e 43. N�o importa tanto o tempo de processamento, mas se o comando fez a base de dados crescer muito, principalmente porque temos um espa�o limitado na nossa m�quina. Podemos ter problemas se continuarmos a criar novos �ndices sem observar o crescimento da base.

Por exemplo, vamos selecionar a base DB_VENDAS com o bot�o direito do mouse. Acessaremos "Propriedades" e, na pr�xima tela, selecionaremos "Arquivos" e buscaremos a localiza��o da base de dados.

Na minha m�quina, a base de dados est� no diret�rio: "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER2\MSSQL\DATA". Vamos copiar esse diret�rio, abrir um explorador de arquivos do Windows, colar esse caminho no campo de "Acesso r�pido" e analisar a base de dados. A seguir, � poss�vel conferir um trecho:

Nome	Data de modifica��o	Tipo	Tamanho
DB_VENDAS.mdf	22/03/2023 23:53	SQL Server Database	5.371.904 KB
DB_VENDAS_log.Idf	22/03/2023 23:56	SQL Server Database	2.891.776 KB
...	...	...	...
A base aumentou o arquivo de log. O motivo � que os arquivos de log s�o utilizados na cria��o de �ndices, principalmente porque a base de dados j� tem muitos dados. Antes de seguirmos com as melhorias da nossa consulta, vamos fazer uma limpeza nessa base para n�o sermos surpreendidos por falta de espa�o.

Lembrando que, na aula 2, passamos por um v�deo espec�fico sobre o tamanho da base, onde fizemos download do script SQLQUERY16.sql-D...B_VENDAS (sa 53))*, respons�vel pela limpeza da base.

USE DB_VENDAS
ALTER DATABASE DB_VENDAS SET RECOVERY SIMPLE
DBBC SHRINKDATABASE ('DB_VENDAS', NOTRUNCATE)
DBCC SHRINKDATABASE ('DB_VENDAS', TRUNCATEONLY)
ALTER DA DATABASE DB_VENDAS SET RECOVERY FULL
Copiar c�digo
Retornando � p�gina da base dados, � poss�vel conferir que esta base est� com um arquivo de log de 2.8 GB. Se executarmos o comando anterior, ele vai limpar o arquivo de log. Execut�-lo n�o melhora ou piora a performance, mas deixa a base mais enxuta.

Terminada a execu��o, notaremos que o arquivo de log caiu de 2.8 GB para 8 MB.

Nome	Data de modifica��o	Tipo	Tamanho
DB_VENDAS.mdf	22/03/2023 23:53	SQL Server Database	5.270,976 KB
DB_VENDAS_log.Idf	22/03/2023 23:56	SQL Server Database	8.192 KB
...	...	...	...
Vamos seguir! Ser� que o �ndice abaixo melhorou a nossa consulta?

CREATE NONCLUSTERED INDEX idx_tb_item_codigo_produto ON tb_item (codigo_produto)
INCLUDE (numero, quantidade, preco);
Copiar c�digo
Vamos executar uma nova consulta, com m�s de abril, "4" e estado de Minas Gerais, "MG".

DECLARE @ESTE_MES INT DECLARE @ESTADP VARCHAR(2)
SET @ESTE_MES = 4
SET @ESTADO = 'MG'
SELECT VENDAS.classificacao AS CLASSIFICACAO,
       ROUND(VENDAS.VALOR_MES, 2) AS VALOR,
             ROUND(VENDAS.VALOR_MES/ TOTAL.VALOR_TOTAL) * 100, 2) AS PERCENTUAL

// c�digo omitido 
Copiar c�digo
Verificaremos o tempo e o custo da consulta.

     AND MONTH(tb_nota.data) * @ESTE_MES
       AND tb_estado.sigla_estado * @ESTADO
   GROUP BY tb_classificacao.classificacao) VENDAS
ORDER BY (VENDAS.VALOR_MES/TOTAL.VALOR_TOTAL) * 100 DESC

-- 17 segundos (512,844)

CREATE NONCLUSTERED INDEX idx_tb_item_codigo_produto ON tb_item (codigo_produto)
INCLUDE (numero, quantidade, preco);
Copiar c�digo
O tempo da consulta caiu para 6 segundos. Isso n�o quer dizer que a consulta j� est� com uma boa execu��o, porque se executarmos v�rias vezes o processamento, podemos obter resultado de tempo diferente. O importante � observarmos o tamanho do custo de resolu��o da consulta.

Voltando ao plano de execu��o e selecionado "SELECT Custo: 0", perceberemos que o custo da sub�rvore ficou em 512,884. Na verdade, n�o teve ganho nenhum. O tempo caiu para 6 segundos, mas o custo continua em 512,844.

     AND MONTH(tb_nota.data) * @ESTE_MES
       AND tb_estado.sigla_estado * @ESTADO
   GROUP BY tb_classificacao.classificacao) VENDAS
ORDER BY (VENDAS.VALOR_MES/TOTAL.VALOR_TOTAL) * 100 DESC

-- 17 segundos (512,844)

CREATE NONCLUSTERED INDEX idx_tb_item_codigo_produto ON tb_item (codigo_produto)
INCLUDE (numero, quantidade, preco);

-- 6 segundos
Copiar c�digo
Parece que esse �ndice n�o melhorou muito a resolu��o da nossa consulta, mas o plano de execu��o est� sugerindo a cria��o de outro �ndice (mesmo com um �ndice criado), agora pelo campo n�mero, incluindo a quantidade e pre�o do campo.

CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]

ON [dbo].[tb item]([numero])

INCLUDE([quantidade],[preco])

Vamos criar esse segundo �ndice. Vou aproveitar o comando constru�do anteriormente. Ao inv�s de gerar o �ndice pelo c�digo do produto, usaremos o campo n�mero.

CREATE NONCLUSTERED INDEX idx_tb_item_numero ON tb_item (numero)
INCLUDE (quantidade, preco);
Copiar c�digo
Executaremos o �ndice, a limpeza da base e conferiremos o resultado logo mais.

USE DB_VENDAS
ALTER DATABASE DB_VENDAS SET RECOVERY SIMPLE
DBBC SHRINKDATABASE ('DB_VENDAS', NOTRUNCATE)
DBCC SHRINKDATABASE ('DB_VENDAS', TRUNCATEONLY)
ALTER DA DATABASE DB_VENDAS SET RECOVERY FULL
Copiar c�digo
O segundo �ndice foi criado! No meu caso, o processo levou 3 minutos e 40 segundos. Um detalhe importante � a base aumentou.

Nome	Data de modifica��o	Tipo	Tamanho
DB_VENDAS.mdf	22/03/2023 00:18	SQL Server Database	7.678.144 KB
DB_VENDAS_log.Idf	22/03/2023 00:18	SQL Server Database	8.192 KB
...	...	...	...
Agora ela est� em 7.6 GB. O arquivo de log est� pequeno, porque rodamos o script de limpeza de log, mas para a base, n�o podemos fazer nada.

Lembrando que, na aula passada, aprendemos que o �ndice � uma tabela auxiliar, composta pelos campos "crit�rio do �ndice" ordenado de forma crescente, para facilitar a busca e "endere�o do segmento de mem�ria", onde a linha do campo est� situada no disco. � como se estiv�ssemos criando outra tabela com dados na base, por isso ela cresce.

Mas vamos entender o impacto disso na consulta. Podemos selecionar outro m�s, outro estado e rodar a consulta com o plano de execu��o selecionado.

DECLARE @ESTE_MES INT DECLARE @ESTADP VARCHAR(2)
SET @ESTE_MES = 7
SET @ESTADO = 'RS'
SELECT VENDAS.classificacao AS CLASSIFICACAO,
       ROUND(VENDAS.VALOR_MES, 2) AS VALOR,
             ROUND(VENDAS.VALOR_MES/ TOTAL.VALOR_TOTAL) * 100, 2) AS PERCENTUAL

// c�digo omitido 
Copiar c�digo
Nosso interesse � no custo e n�o no tempo. Mesmo assim, � interessante observar que agora ele rodou em 4 segundos. O custo do plano de execu��o caiu para 297,004.

Obtivemos um ganho no custo, que foi de 512.884 para 297.004. Mas, ainda podemos melhorar essa consulta. No pr�ximo v�deo vamos discutir o que podemos fazer para que a consulta fique ainda mais r�pida.

----------------------------------------------------

Analisando o Plano de execu��o ap�s a cria��o dos dois �ndices sugeridos pelo pr�prio plano, perceberemos, primeiro, que n�o h� mais nenhuma indica��o de cria��o de �ndices.

Al�m disso, nota-se que, ao inv�s de utilizar a Table Scan, ele preferiu usar a busca do dado pelo �ndice, Index Seek.

Index Seek (NonClustered)
[tb_itew].[idx th_item_numero]
Custo: 8 %
0.043s [
485400 de
263324 (184%)
Copiar c�digo
No entanto, ele ainda usa bastante o Table Scan. Podemos melhorar a resolu��o dessas consultas.

Analisando as tabelas da base de DB_VENDAS, percebemos que nenhuma tabela possui chave prim�ria.

Colunas
cidade
sigla_estado
Chaves prim�rias s�o campos que n�o podem se repetir. Elas s�o importantes para a manuten��o da integridade da base.

� comum encontrarmos bases de dados, mesmo nos bancos relacionais, que n�o possuem chaves prim�rias nem estrangeiras, pois a integridade � garantida pela aplica��o e n�o pela base. Por�m, isso pode gerar problemas de performance.

A cria��o da chave prim�ria favorece a performance, porque gera uma restri��o que impede a repeti��o de determinado valor da tabela. Al�m disso, internamente, o SQL cria um �ndice �nico (unique index) para o campo.

Na aula passada, aprendemos que quando temos um �ndice �nico, o plano de execu��o preferencialmente usa esse �ndice, independentemente dos campos selecionados na cl�usula select.

Sendo assim, vamos criar chaves prim�rias para todas as tabelas da base, comparar o tempo e conferir se isso trar� algum ganho. Come�ando pela tabela de cidades.

Tendo em vista os dois campos presentes, podemos considerar a cidade como candidata a chave prim�ria, j� que n�o podemos ter duas linhas na tabela com a mesma cidade.

Para criar essa chave prim�ria, � necess�rio alterar a tabela. Utilizaremos o comando ALTER TABLE na tabela de cidades, seguido de ADD CONSTRAINT (adicionar uma restri��o). A restri��o ser� nomeada como pk_cidades, isto �, "PK" seguido do nome da tabela, pois a chave prim�ria deve ser �nica.

O tipo de restri��o ser� PRIMARY KEY. Entre par�nteses, passaremos o campo que far� parte do crit�rio da chave prim�ria: cidade.

ALTER TABLE tb_cidade ADD CONSTRAINT pk_tb_cidade PRIMARY KEY (cidade);
Copiar c�digo
Comando conclu�do com �xito.

O comando foi executado. Vamos selecionar a tabela de cidade, dbo.tb_cidade, com o bot�o direito do mouse e apertar "Atualizar". Agora a tabela de cidades possui uma chave prim�ria.

Vamos para a tabela classifica��o. O campo que seria candidato a chave prim�ria para essa tabela � codigo_classificacao. O nome da tabela ser� classificacao. A CONSTRAINT ser� tb_classificacao e como campo de crit�rio teremos codigo_classificacao.

ALTER TABLE tb_cidade ADD CONSTRAINT pk_tb_cidade PRIMARY KEY (cidade);
ALTER TABLE tb_classificacao ADD CONSTRAINT pk_tb_classificacao PRIMARY KEY (codigo_classificacao);
Copiar c�digo
Comandos concluidos com �xito

J� criamos duas chaves prim�rias em duas tabelas diferentes. Atualizando as tabelas, poderemos conferir as chaves prim�rias. A base de dados ainda n�o aumentou significativamente, mas isso pode ocorrer quando criarmos chaves prim�rias nas tabelas maiores. Nestes casos, � sempre recomend�vel executar o script para limpar o arquivo de log.

Vamos ent�o para a tabela de clientes, cujo candidato a chave prim�ria � o CPF, j� que n�o podemos ter dois clientes com o mesmo CPF.

ALTER TABLE tb_cidade ADD CONSTRAINT pk_tb_cidade PRIMARY KEY (cidade);
ALTER TABLE tb_classificacao ADD CONSTRAINT pk_tb_classificacao PRIMARY KEY (codigo_classificacao);
ALTER TABLE tb_cliente ADD CONSTRAINT pk_tb_cliente PRIMARY KEY (cpf);
Copiar c�digo
Comandos concluidos com �xito.

A tabela de clientes � grande, composta por muitas linhas, mesmo assim, foi gerada em quatro segundos. O tamanho da base subiu um pouco, mas ainda n�o � necess�rio executar o script para limpar o arquivo de log.

Por fim, vamos criar a chave prim�ria para a tabela de estados. O campo candidato � sigla_estado, que � o que identifica um estado geogr�fico.

ALTER TABLE tb_cidade ADD CONSTRAINT pk_tb_cidade PRIMARY KEY (cidade);
ALTER TABLE tb_classificacao ADD CONSTRAINT pk_tb_classificacao PRIMARY KEY (codigo_classificacao);
ALTER TABLE tb_estado ADD CONSTRAINT pk_tb_estado PRIMARY KEY (sigla_estado);
Copiar c�digo
Comandos concluidos com �xito.

N�s pularemos a tabela de itens e vamos para a tabela loja, cuja identifica��o � o c�digo da loja, codigo_loja.

ALTER TABLE tb_cidade ADD CONSTRAINT pk_tb_cidade PRIMARY KEY (cidade);
ALTER TABLE tb_classificacao ADD CONSTRAINT pk_tb_classificacao PRIMARY KEY (codigo_classificacao);
ALTER TABLE tb_loja ADD CONSTRAINT pk_tb_loja PRIMARY KEY (codigo_loja);
Copiar c�digo
Tamb�m vamos pular a tabela de notas e vamos para tb_produto. O campo candidato, neste caso, � codigo_produto.

ALTER TABLE tb_cidade ADD CONSTRAINT pk_tb_cidade PRIMARY KEY (cidade);
ALTER TABLE tb_classificacao ADD CONSTRAINT pk_tb_classificacao PRIMARY KEY (codigo_classificacao);
ALTER TABLE tb_loja ADD CONSTRAINT pk_tb_loja PRIMARY KEY (codigo_loja);
ALTER TABLE tb_produto ADD CONSTRAINT pk_tb_produto PRIMARY KEY (codigo_produto);Copiar c�digo
Comandos concluidos com �xito.

Temos a chave prim�ria para todas as tabelas.

Pulamos as tabelas de nota e item e o motivo � que teremos uma atividade de desafio ap�s este v�deo.

Desafio: criar a chave prim�ria para as tabelas de nota e de item. N�o se esque�am de observar os campos e sugerir os campos candidatos a chave prim�ria, considerando que a tabela tb_nota tem o cabe�alho da nota e, na tabela de itens, cada nota pode ter v�rios itens/produtos vendidos.

Com essas informa��es, voc� est� pronto para o desafio. Lembre-se de criar as chaves prim�rias para as duas tabelas. No pr�ximo v�deo, vamos conferir o resultado e poss�veis ganhos.

-------------------------------------------------

No v�deo anterior, criamos as chaves prim�rias para cada uma das tabelas cadastrais do supermercado BitByte. Essa etapa � importante porque a cria��o da chave prim�ria gera automaticamente a constru��o de um �ndice �nico. Esse �ndice pode ser utilizado pelos planos de execu��o para fazer buscas de forma mais eficiente, evitando o uso do SCAN e dando prefer�ncia ao SEEK. Isso significa que as consultas ser�o executadas de forma mais r�pida e com menor consumo de recursos do sistema. Por isso, � fundamental definir as chaves prim�rias corretamente e entender como elas impactam no desempenho das consultas.

Agora, � necess�rio que voc� crie as chaves prim�rias para as tabelas de notas fiscais e itens de notas fiscais. � importante identificar quais consultas ser�o candidatas a chaves prim�rias, e em seguida, cri�-las utilizando os mesmos comandos apresentados no v�deo. Assim, ser� poss�vel otimizar as consultas e evitar a busca por toda a tabela, dando prefer�ncia ao uso do �ndice.

----------------------------------------------------

Pronto! Executamos a cria��o de mais duas chaves prim�rias, uma para a tabela tb_nota e outra para a tabela tb_item.

ALTER TABLE tb_classificacao ADD CONSTRAINT pk_tb_classificacao PRIMARY KEY (codigo_classificaco);
ALTER TABLE tb_cliente ADD CONSTRAINT pk_tb_cliente PRIMARY KEY (cpf);
ALTER TABLE tb_estado ADD CONSTRAINT pk_tb_estado PRIMARY KEY (sigla estado);
ALTER TABLE tb_loja ADD CONSTRAINT pk_tb_loja PRIMARY KEY (codigo_loja);
ALTER TABLE tb_produto ADD CONSTRAINT pk_tb_produto PRIMARY KEY (codige_produto);

ALTER TABLE tb_nota ADD CONSTRAINT pk_tb_nota PRIMARY KEY (numero);
ALTER TABLE tb_item ADD CONSTRAINT pk_tb_item PRIMARY KEY (numero, codigo_produto);
Copiar c�digo
O campo candidato para a chave prim�ria da tabela tb_nota foi o campo numero, afinal, n�o podemos ter mais de uma nota fiscal com o mesmo n�mero.

ALTER TABLE tb_nota ADD CONSTRAINT pk_tb_nota PRIMARY KEY (numero);
Copiar c�digo
No caso da tabela tb_item, o candidato foi uma chave composta, afinal, n�o podemos ter mais de um item com o mesmo n�mero e mesmo c�digo do produto em notas fiscais. Por isso, neste caso a chave prim�ria � composta.

ALTER TABLE tb_item ADD CONSTRAINT pk_tb_item PRIMARY KEY (numero, codigo_produto);
Copiar c�digo
Vamos avaliar o ganho da nossa consulta ap�s termos criado todas as chaves prim�rias. Novamente, vamos selecionar a consulta e executar.

Lembre-se de verificar a base de dados, DB_VENDAS, e selecionar o plano de execu��o.

Minha execu��o durou um segundo. Podemos anotar esse valor da dura��o.

 ALTER TABLE tb_classificacao ADD CONSTRAINT pk_tb_classificacao PRIMARY KEY (codigo_classificaco);
ALTER TABLE tb_cliente ADD CONSTRAINT pk_tb_cliente PRIMARY KEY (cpf);
ALTER TABLE tb_estado ADD CONSTRAINT pk_tb_estado PRIMARY KEY (sigla estado);
ALTER TABLE tb_loja ADD CONSTRAINT pk_tb_loja PRIMARY KEY (codigo_loja);
ALTER TABLE tb_produto ADD CONSTRAINT pk_tb_produto PRIMARY KEY (codige_produto);

ALTER TABLE tb_nota ADD CONSTRAINT pk_tb_nota PRIMARY KEY (numero);
ALTER TABLE tb_item ADD CONSTRAINT pk_tb_item PRIMARY KEY (numero, codigo_produto);

-- 1 segundo
Copiar c�digo
Qual foi o custo da consulta? Acessando o "Plano de execu��o" e selecionando "SELECT Custo: 0", � poss�vel conferir que o custo estimado da sub�rvore caiu para 74,21.

Analisando o plano de execu��o, � poss�vel notar que em grande parte das tabelas, no momento das buscas, ele utilizou �ndice ao inv�s do scan. Por exemplo, na tabela de cidade, tb_cidade, ele usou um �ndice clusterizado, o sacn e o �ndice relacionado com a PK da tabela de cidade, pk_tb_cidade.

Clustered Index Scan (Clustered)
   [tb_cidade].[pk_tb_cidade]
            Custo: 0 %
                      0.00s
                      33 de
                        5 (660%)
Copiar c�digo
Se observarmos outras tabelas, por exemplo, a tabela de estado, notaremos que ele tamb�m usou o SeeK com o �ndice clusterizado e a chave prim�ria da tabela de estado.

Busca de Indice Clusterizado (Clust...
     [tb_estado].[pk_tb_estado]
                Custo: 0 %
                          0.000s
                           1 de
                        1 (100%)
Copiar c�digo
H� outro caso tamb�m com a chave prim�ria da tabela de nota.

Clustered Index Scan (Clustered)
     [tb_nota].[pk_tb_nota]
               Custo: 9 %
                      0.118s
                     183779 de 
                     153624 (119%)
Copiar c�digo
Por isso ficou mais r�pido.

E qual foi o nosso ganho total? Considerando as anota��es do antes e depois da cria��o dos �ndices, fomos de 17 segundos com um custo de 512,84 para 1 segundo com um custo de 74,21.

-- 1 segundo (74,21)
-- 17 segundos (512,844)
Copiar c�digo
Ou seja, obtivemos um grande ganho na performance da consulta. O plano de execu��o at� sugere criamos novos �ndices ap�s a cria��o das chaves prim�rias. Por�m, n�o faremos isso, porque j� chegamos a 1 segundo. � pouco produtivo come�ar a criar mais �ndices para ter ganhos irris�rios.

---------------------------------------------

No v�deo anterior, pudemos observar que a cria��o de chaves prim�rias no banco de dados relacional gerou �ndices que foram capazes de melhorar significativamente a performance das consultas realizadas. No entanto, vale ressaltar que os bancos de dados relacionais tamb�m possuem chaves estrangeiras que estabelecem rela��es entre as tabelas. Quando essas chaves estrangeiras s�o criadas, elas tamb�m geram �ndices que podem ajudar a aprimorar a performance do banco de dados. Isso ocorre porque as chaves estrangeiras permitem que as tabelas sejam relacionadas de forma mais eficiente, tornando as consultas mais r�pidas e precisas. Assim, a cria��o de chaves estrangeiras � uma pr�tica importante a ser considerada para otimizar o desempenho do banco de dados relacional.

-----------------------------------------------

===========RESUMO DO CURSO===============

Performance
Estudo de caso - Supermercados Bitbyte.
Come�amos recuperando a nossa base de dados, a que foi usada nos exerc�cios pr�ticos do curso. Para us�-la, tivemos que entender o funcionamento do nosso estudo de caso: o supermercado BitByte.

Notamos que as tabelas das bases de dados eram muito grandes. Al�m disso, havia um relat�rio de determinado usu�rio que estava demorando muito para ser gerado. Portanto, nossa fun��o inicial foi melhorar o desempenho desse relat�rio.

Aspectos sobre performance.
Antes de atuar sobre esse relat�rio, foi necess�rio entender melhor o que � performance. Isto �, o que pode prejudicar a performance de um ambiente de um banco de dados.

Muitas das raz�es que prejudicam a performance n�o s�o de influ�ncia do DBA. Ou seja, o DBA n�o pode resolv�-las. Por exemplo: um hardware mal dimensionado, por estar processando muito a CPU; pouca mem�ria RAM; o espa�o em disco n�o � suficiente para que o banco possa crescer.

Tudo isso prejudica a performance. E o DBA, nesses casos, n�o tem muito o que fazer, al�m de informar esse mau dimensionamento para os departamentos respons�veis pela infraestrutura da empresa.

Em alguns outros aspectos, por exemplo, parametriza��o do servidor, gerenciamento do crescimento da base de dados e cuidado com a estrutura das consultas, o DBA pode atuar.

Active monitor.
Independentemente da raz�o pela qual o ambiente do banco de dados est� com a sua performance comprometida, � necess�rio que o DBA tenha instrumentos para monitorar o ambiente. Para isso est� � disposi��o o Active Monitor.

Durante o curso, aprendemos a acessar essa ferramenta, a acompanhar o desempenho dos principais indicadores que medem a performance do ambiente, como o consumo de CPU, tempo de espera, entrada e sa�da, dentre outros indicadores importantes.

Quando abordamos o Active Monitor, simulamos cen�rios de alto processamento que acabavam repercutindo numa maior utiliza��o dos recursos, prejudicando o ambiente do banco de dados.

Tudo isso permite determinarmos um n�vel de consumo padr�o do servidor. Isso porque conhecer como esses recursos s�o consumidos e qual � a sua sazonalidade de consumo ao longo do tempo � fundamental para que o DBA detecte anomalias e possa se antecipar aos problemas de performance que podem ocorrer.

SQL Profiler
No processo de identifica��o das anomalias, conhecemos outra ferramenta: o SQL Server Profiler. Nele, � poss�vel verificar tudo que chega ao servidor, todos os comandos de SQL que s�o executados. Tamb�m conseguimos coletar algumas estat�sticas referentes a esses processamentos.

Por exemplo: tempo de resposta; entrada e sa�da; linhas manipuladas; dentre outros indicadores. Diferentemente do Active Monitor, aqui pensamos nos indicadores espec�ficos para cada comando. Chamamos isso de traces.

Os traces gerados no SQL Profiler podem ser salvos em arquivos para an�lises e compara��es com traces coletados em dias diferentes. Inclusive, aprendemos que tamb�m � poss�vel executar traces via comandos de TSQL. Logo, podemos fazer um script e agendar execu��es peri�dicas.

Planos de execu��o.
Quando o profile apresenta as consultas problem�ticas, podemos estudar o plano de execu��o de cada uma dessas consultas. Ele � o caminho que o SQL Server faz para apresentar o resultado final de uma consulta.

O SQL Server resolve a consulta atrav�s da execu��o que chamamos de operadores. Esses operadores possuem estat�sticas em cada passo do plano. Cada operador executado tem estat�sticas, por exemplo: linhas processadas; o custo da execu��o do passo; dentre outros.

Aprendemos a visualizar o plano de execu��o de uma consulta e as estat�sticas de cada operador.

�ndices.
Dois dos operadores mais utilizados nos planos de execu��o s�o o Seek e o Scan.

O Scan � mais lento, porque, quando � usado para encontrar algo em uma tabela, procura esse elemento percorrendo toda a tabela do in�cio ao fim at� encontrar as linhas que satisfa�am a condi��o de busca.

J� o Seek, n�o. Ele utiliza uma estrutura auxiliar chamada �ndice para realizar buscas mais eficientes que o Scan. Para transformar um plano de execu��o de Scan para Seek, temos que criar �ndices.

Existem muitos tipos de �ndices. Neste curso, estudamos os clusterizados, os n�o clusterizados e os �ndices �nicos. A depender do tipo de �ndice usado e como est� sendo constru�da a consulta � ou seja, quem est� no filtro e quem est� no Select � o plano de execu��o escolher� o Scan ou encontrar� um �ndice espec�fico para usar o Seek.

Utilizar uma consulta � fazer com que os planos de execu��o executem mais Seeks em detrimento aos Scans.

Tamb�m conhecemos mais a fundo como funciona o algoritmo de busca do �ndice, o B-tree, e por que ele � muito mais eficiente do que realizar uma busca procurando determinado filtro na tabela completa.

Caso pr�tico.
Finalmente, voltamos ao relat�rio apresentado no in�cio do curso. Efetuamos o plano de execu��o do relat�rio. O pr�prio plano sugeriu a cria��o de alguns �ndices. Criamos esses �ndices e percebemos uma melhora significativa no resultado do plano de execu��o, mas ainda n�o era o ideal.

Ent�o, geramos as chaves prim�rias e as chaves estrangeiras da base de dados. Isso porque sempre que criamos uma chave prim�ria ou uma chave estrangeira, por detr�s dessas estruturas tamb�m s�o criados os �ndices.

Ao criar os �ndices sugeridos das chaves prim�rias e das chaves estrangeiras, notamos um ganho significativo na consulta do usu�rio com problemas de performance.

*/


ALTER TABLE [dbo].[tb_cidade] ADD CONSTRAINT [fk_tb_cidade_sigla_estado] FOREIGN KEY([sigla_estado])
REFERENCES [dbo].[tb_estado] ([sigla_estado])

ALTER TABLE [dbo].[tb_cliente] ADD CONSTRAINT [fk_tb_cliente_cidade] FOREIGN KEY([cidade])
REFERENCES [dbo].[tb_cidade] ([cidade])

ALTER TABLE [dbo].[tb_item] ADD CONSTRAINT [fk_tb_item_codigo_produto] FOREIGN KEY([codigo_produto])
REFERENCES [dbo].[tb_produto] ([codigo_produto])

ALTER TABLE [dbo].[tb_item] ADD CONSTRAINT [fk_tb_item_numero] FOREIGN KEY([numero])
REFERENCES [dbo].[tb_nota] ([numero])

ALTER TABLE [dbo].[tb_loja] ADD CONSTRAINT [fk_tb_loja_cidade] FOREIGN KEY([cidade])
REFERENCES [dbo].[tb_cidade] ([cidade])

ALTER TABLE [dbo].[tb_nota] ADD CONSTRAINT [fk_tb_nota_cliente] FOREIGN KEY([cpf])
REFERENCES [dbo].[tb_cliente] ([cpf])

ALTER TABLE [dbo].[tb_nota] ADD CONSTRAINT [fk_tb_nota_loja] FOREIGN KEY([codigo_loja])
REFERENCES [dbo].[tb_loja] ([codigo_loja])

ALTER TABLE [dbo].[tb_produto] ADD CONSTRAINT [fk_tb_produto_codigo_classificacao] FOREIGN KEY([codigo_classificacao])
REFERENCES [dbo].[tb_classificacao] ([codigo_classificacao])