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
Estamos no Management Studio e, antes de continuar, abaixo do vídeo atual há uma atividade com o link para fazer o download do arquivo Relatorio Faturamento Classificacao.sql. Faça o download, copie e cole o arquivo no diretório "C: temp". Nós estamos usando este diretório como área de trabalho, mas você pode utilizar qualquer outro.

Voltando ao Management Studio, clicamos em "Arquivo > Abrir Arquivo" no canto superior esquerdo da tela e selecionamos o arquivo no diretório "C: temp" com a extensão .sql que acabamos de baixar. Esse arquivo é um relatório. Vamos executar essa consulta para gerar esse relatório, clicando em "Executar" na barra de ações superior da tela.

Enquanto aguardamos a consulta ser executada, vamos entender o que é essa consulta: ela representa as vendas por classificação de produtos em um determinado período em uma loja. Obviamente, a pessoa usuária não acessa o Management Studio para observar os dados gerados nessa consulta. Ela utiliza uma aplicação da empresa que, por meio de uma interface amigável, envia a consulta para o banco de dados e retorna o resultado com tabelas e gráficos.

Ao executar a consulta, notamos no canto inferior direito do MS que ela levou 10 segundos para obter o resultado. Isso é muito ou pouco?

Devemos lembrar que a pessoa usuária não está executando essa consulta diretamente no MS, mas num software cliente. Pelo clique de Execução nessa tela, é enviado para o servidor, via tráfego de rede, a ordem para executar o relatório. O relatório é executado e os dados resultantes voltam para o cliente, que os organiza e apresenta de forma visual para a pessoa usuária. Então, com certeza, serão mais de 10 segundos até que o resultado chegue até essa pessoa.

Embora esse tempo seja aceitável, precisamos entender que, para o usuário que aguarda o resultado na tela da aplicação, com aquela tela de carregamento, esse tempo pode parecer uma eternidade. Portanto, quem vai dizer se o ambiente tem ou não problema de performance será a experiência do usuário com a aplicação.

Como DBA responsável pelo ambiente, quando recebo um chamado do usuário para rever o tempo de execução, preciso identificar a origem do problema e entender por que esse tempo está causando desconforto. Mas, antes de começar a investigar, precisamos conhecer como o ambiente funciona em uma situação normal, sem problemas de performance.

É como comparar o barulho do motor de um carro zero quilômetro com o mesmo carro após alguns meses de uso — um barulho diferente no motor nos indica um problema, porque conhecemos o barulho do carro em seu estado normal. O mesmo vale para o SQL Server: antes de investigar o motivo da lentidão de uma consulta, precisamos conhecer como funciona nosso ambiente de SQL Server, ou seja, como funciona o banco de dados no estado normal, sem problemas.

O primeiro passo para identificar o que está causando lentidão é verificar se o nosso banco de dados está apresentando algum comportamento estranho. Vamos aprender a fazer isso no próximo vídeo: como conhecer o ambiente do nosso SQL Server num estado normal, que é como um motor de carro novo, funcionando de forma limpa e silenciosa? Com isso, podemos identificar possíveis problemas.

------------------------------------

Neste vídeo, vamos falar sobre o Active Monitor. No vídeo anterior, aprendemos que é importante conhecer o comportamento normal do sistema operacional e do SQL Server para identificar possíveis anomalias no nosso ambiente e tentar resolver problemas de desempenho de forma eficiente.

Definir uma linha base é uma boa prática para identificar problemas de desempenho rapidamente, quando o ambiente do banco estiver se comportando de maneira diferente do esperado. Isso permite que o DBA tente resolvê-los antes que realmente aconteçam.

A primeira abordagem é ter um monitoramento e estabelecer a linha base de desempenho do servidor SQL Server que estamos administrando. Quando houver algum pico repentino, por exemplo, de gasto de CPU ou de memória, a linha base nos ajudará a saber quando esse problema aconteceu e o motivo, para resolvê-lo rapidamente.

O Active Monitor é a ferramenta que o DBA tem à disposição para analisar essa linha base no ambiente do SQL Server. Ele serve para monitorar e diagnosticar o servidor do Microsoft SQL Server. Essa é uma ferramenta projetada para fornecer ao DBA informações detalhadas sobre a saúde e o desempenho do banco de dados, a fim de ajudar a identificar rapidamente quaisquer problemas que possam estar afetando o desempenho do banco de dados.

O Active Monitor é composto de várias componentes, incluindo:

Coletor de dados;
Serviço de gerenciamento;
Interface de usuário.
O coletor de dados do Active Monitor coleta informações sobre o desempenho do SQL Server, incluindo informações sobre entrada e saída (I/O), a utilização de CPU, a utilização de memória e várias outras métricas de desempenho.

Como o Active Monitor funciona?
Para entender como o SQL Server se comporta na linha base, é necessário conhecer o comportamento normal do servidor em seu estado de cruzeiro, considerando a quantidade de usuários conectados todo dia e o hardware disponível para executar o SQL Server.

Quando há uma necessidade de verificação (quando determinadas consultas estão com uma performance muito baixa), a primeira coisa a ser analisada é se a linha base mudou no momento em que o usuário executou a consulta. Nesse caso, o problema pode não estar na consulta ou no SQL Server, mas no ambiente.

Vamos abrir a nossa consulta no SQL Server. Para demonstrar o funcionamento do Active Monitor, clicamos com o botão direito do mouse sobre o nome do servidor ("W10-VILA22", no caso do instrutor) e selecionamos o "Monitor de Atividade".

Ao fazer isso, abre-se uma aba que exibe quatro janelas diferentes, uma ao lado da outra. Elas são pretas e gradeadas, exibindo uma escala de números à direita A primeira exibe as informações sobre o Tempo do Processador, a segunda sobre Tarefas de Espera, a terceira sobre Entrada e Saída do Banco de Dados e a quarta sobre Solicitações em Lotes.

Para visualizar a evolução do gráfico mais rapidamente, clicamos em qualquer área vazia entre esses quatro quadros escuros com o botão direito do mouse e selecionamos a opção "Intervalo de atualização > 1 segundo".

Ao fazer isso, começamos a verificar uma evolução nas solicitações em lotes: uma barra verde sobe da base até o número quatro, estabilizando ali. Já o tempo de processamento, tarefas em espera e E/S do banco ficam praticamente zerados. Isso ocorre porque o servidor está no seu estado quase "adormecido" e nada está executando, exceto os seus processos internos.

Para mostrar isso claramente, enquanto o monitor exibe os resultados, vamos clicar na aba do relatório de vendas e mudar os parâmetros de consulta. Em vez de mês 2, vamos colocar o mês 3 em @ESTE_MES; em vez de São Paulo em @ESTADO, vamos colocar 'RJ' de Rio de Janeiro e executar o relatório:

Relatorio Faturamento Classificacao.sql

DECLARE @ESTE_MES INT DECLARE @ESTADO VARCHAR(2)
SET @ESTE_MES = 3
SET @ESTADO = 'RJ'
# código omitidoCopiar código
Ao executar, note o que aconteceu no monitor de atividade: houve um pico de quase 99% do uso de CPU, como verificamos no quadro de Tempo do Processador, porque a consulta foi executada; depois, caiu para zero.

Se voltarmos ao relatório de faturamento, verificamos que a consulta foi executada em 9 segundos. O monitor de atividade mostra esse pico e depois o retorno para o zero.

É assim, através do monitor de atividades (ou Active Monitor, em inglês), que podemos acompanhar as atividades do ambiente do servidor. É claro que, no ambiente real, as linhas de base não estarão no zero, mas em algum nível no meio do gráfico, já que o banco de dados estará processando coisas.

Então, no próximo vídeo, vamos processar uma série de coisas nesse banco de dados para podermos mudar a nossa linha base inicial e verificar se isso vai afetar ou não a nossa consulta.

---------------------------------------------

Agora vamos "estressar" nosso servidor. Executaremos uma série de processos que farão com que o servidor saia de sua linha base e verificaremos se isso afetará ou não o desempenho de nossa consulta.

Na seção de documentos desta aula, vocês poderão acessar o seguinte arquivo para download: ACTIVE MONITOR.zip. Faremos seu download, copiaremos para o diretório de trabalho ("C: temp" para o instrutor) e o descompactaremos aqui.

Ao fazer isso notaremos uma série de arquivos com extensão .sql dentro deste diretório.

Vamos voltar ao Management Studio. Primeiro, vamos fixar para que as duas primeiras abas do Management Studio sempre exibam o Monitor de Atividades e o Relatório de Vendas. Para fazer isso, clicamos no ícone de alfinete de "Fixar" exibido no título da aba atual, no menu superior da tela. Fazemos isso em ambas as abas.

Agora, clicamos em "Arquivo > Abrir > Arquivo" e selecionamos lá todos os arquivos de extensão .sql do diretório "ACTIVE MONITOR". Então, clicamos em "Abrir" no canto inferior direito da janela do explorador de arquivos. Com isso, conferiremos todos os arquivos abertos no Management Studio clicando na seta para baixo no canto direito barra de abas.

Vamos abrir o arquivo Processamento ambiente 01.sql. Ele é um arquivo que faz um looping onde, a cada um segundo, insere numa segunda tabela todas as quantidades vendidas; ou seja, todas as quantidades que constam na tabela "TB_ITEM". Comentaremos a primeira linha com o -- (hífen-hífen) para podermos executar esse script sem problemas:

Processamento ambiente 01.sql, a título de exemplo

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
 END Copiar código
Executamos esse script. Enquanto ele é executado, vamos acompanhar o Monitor de Atividade. Note que ele mudou: começaram a aparecer uns "dentes" no gráfico do tempo de processador; a barra verde sobe e desce repetidas vezes. Isso é devido ao processo que está sendo executado, pois ele está consumindo recursos da máquina.

Agora, se executarmos o relatório de faturamento para outro mês, como o quatro, e para o estado de Minas Gerais (MG) por exemplo, pode ser que demore um pouco mais:

Relatorio Faturamento Classificacao.sql

DECLARE @ESTE_MES INT DECLARE @ESTADO VARCHAR(2)
SET @ESTE_MES = 4
SET @ESTADO = 'MG'
# código omitidoCopiar código
Ao executar, o relatório leva 14 segundos para ser gerado — sendo que, antes, levava apenas 10. Isso aconteceu porque estamos processando coisas na nossa máquina.

Vamos processar mais coisas ainda abrindo o arquivo Processamento ambiente 02.sql, que vai consumir ainda mais recursos da máquina. Comentaremos a sua primeira linha e o executar.

Se verificarmos o monitor de atividade, veremos que o consumo está em quase 100%. Os "dentes" que desciam mais para baixo em seu estado normal, chegando até a zero, passaram a não descer mais que até os 40%. Também passamos a ter resultados no gráfico de entrada e saída de banco de dados. O computador, inclusive, pode até fazer um barulho maior nesse momento por estar consumindo memória.

Isso impactou o nosso relatório de faturamento? Vamos verificar. Escolheremos outro mês e outro estado para gerar o relatório novamente, por exemplo, mês cinco e Espírito Santo (ES):

Relatorio Faturamento Classificacao.sql

DECLARE @ESTE_MES INT DECLARE @ESTADO VARCHAR(2)
SET @ESTE_MES = 5
SET @ESTADO = 'ES'
# código omitidoCopiar código
Vamos executar esse script para ver se haverá prejuízo no tempo de processamento a partir do momento em que o sistema saiu do conhecimento base.

Rodou em 15 segundos, ou seja, 50% mais do que o tempo original. O usuário que está lá na outra ponta já deve começar a ficar desconfortável.

Vamos piorar esse ambiente?

Os arquivos de Processamento vendas de 01 a 09 estão abertos, então vamos clicar para executar cada um deles, um seguido do outro, por meio do menu aberto pela seta na barra de abas. É possível que você, se estiver repetindo esse exercício, comece a notar que começa a haver um consumo maior de recursos do servidor na sua máquina.

No monitor de atividades, verificamos que o processamento está quase em 100%, no topo da grade, e a solicitação de lote aumentou um pouco.

Agora, vamos selecionar outro mês e estado para gerar um novo relatório: mês 6 e Rio Grande do Sul (RS):

Relatorio Faturamento Classificacao.sql

DECLARE @ESTE_MES INT DECLARE @ESTADO VARCHAR(2)
SET @ESTE_MES = 6
SET @ESTADO = 'RS'
# código omitidoCopiar código
Vamos executar para ver como será o resultado dessa consulta. Chegamos a 15 segundos novamente, mas podemos notar que a máquina ficou um pouco mais pesada.

Conclusão desse exercício: é muito importante acompanhar o que está acontecendo no monitor de atividades e conhecer o seu nível base antes de começar a gerenciar o seu ambiente do SQL Server. Então, a partir do momento que houver problema de performance, a primeira coisa que você deve fazer é verificar se o ambiente fugiu do nível base.

Antes de terminar o exercício, peço que você feche todas as janelas e pare o processamento para que a máquina não fique consumindo recursos o tempo todo. Nos próximos vídeos, continuaremos os exercícios práticos.

-------------------------------------------

Um ponto de atenção para o DBA é a verificação constante do espaço em disco disponível no servidor onde a base de dados está armazenada. Isso porque a base de dados do SQL Server tende a crescer muito, principalmente os arquivos de log e transações, à medida que o banco vai sendo utilizado.

A diminuição do espaço livre em disco pode afetar a performance do sistema. Por isso, o DBA também deve verificar o crescimento da base.

Na seção de atividade abaixo deste vídeo, há um link para download do script Reduzindo Base.sql. Vamos copiá-lo para o nosso diretório de trabalho. Voltando ao Management Studio, vamos carregar esse novo script clicando em "Arquivo > Abrir > Arquivo > Reduzindo Base.sql > Abrir". O script que se abre é o seguinte:

USE DB_VENDAS
ALTER DATABASE DB_VENDAS SET RECOVERY SIMPLE
DBCC SHRINKDATABASE ('DB_VENDAS', NOTRUNCATE)
DBCC SHRINKDATABASE ('DB_VENDAS', TRUNCATEONLY)
ALTER DATABASE DB_VENDAS SET RECOVERY FULLCopiar código
Note que ele está executando quatro comandos — o comando USE no início está apenas reposicionando o script para ser executado na base DB VENDAS. Esses quatro comandos irão reduzir o tamanho da base de dados do banco de dados porque, à medida que o banco vai sendo utilizado, muita coisa desnecessária será gravada nele.

Basicamente, o primeiro comando, ALTER DATABASE com o SET RECOVERY SIMPLE, é usado para modificar as configurações do banco de dados. Quando usamos a função de recuperação definindo a opção SIMPLE, o SQL Server não mantém nenhum log de transação completo.

Isso significa que, ao recuperar os dados da base de dados, eliminará os dados de transações de log. Isso pode ser perigoso se você tem a necessidade de um rollback dos dados. Por isso, ao rodar os comandos de redução da base de dados, é importante ter certeza de que você realizou um backup do banco e que seus usuários não estão utilizando esse banco.

O segundo comando se chama DBCC SHRINKDATABASE. Com ele, reduzimos o tamanho do banco de dados removendo todo o espaço não utilizado. O parâmetro NOTRUNCATE significa que o arquivo do banco de dados não será encurtado além do tamanho atual, mesmo que haja espaço inutilizado.

O terceiro comando também é o DBCC SHRINKDATABASE, mas com o parâmetro TRUNCATEONLY. Ele removerá apenas o espaço não utilizado no final do arquivo do banco de dados. Isso significa que o tamanho do arquivo será reduzido sem mover dados.

O último comando é o ALTER DATABASE novamente, dessa vez com o parâmetro SET RECOVERY FULL. Com essa opção definida, o SQL Server mantém o log de transação completo — então, permite que você volte a gravar as transações do banco. Ou seja, se você não passar o seu banco novamente para RECOVERY FULL, estará limitando a capacidade de salvar os logs de transação.

No entanto, para reduzir o tamanho, você precisa passar o banco para RECOVERY SIMPLE, ou seja, eliminar a necessidade de salvar o log de transação, para então reduzir a base e, finalmente, voltar ao status original.

Então, vamos verificar o tamanho da base nesse momento. Para isso, clicamos no nome da base "DB_VENDAS" no menu lateral esquerdo com o botão direito do mouse e, em seguida, clicamos em "Propriedades". Na janela de propriedades, clicamos em "Arquivos" no menu lateral esquerdo. Nessa tela, veremos todas as propriedades do nosso banco de dados. Na tabela, temos um campo chamado "Tamanho (MB)" em que podemos ver o tamanho do banco:

3105 MB do banco de dados "DB_VENDAS"
4104 MB de log de transação
Podemos clicar em "Cancelar" para fechar essa janela de propriedades do banco de dados.

Agora, vamos executar os comandos do script Reduzindo Base.sql. Ele roda rapidamente e, se acessarmos novamente a janela de Propriedades do Banco, veremos que seu tamanho foi reduzido:

3068 MB do banco de dados "DB_VENDAS"
8 MB de log de transação
O tamanho do banco diminuiu pouco, mas o do log de transação reduziu bastante. Economizamos 4GB de espaço! Claro que, se quisermos dar um rollback numa transação que estava parada no meio, não conseguiremos porque apagamos todo o log de transação. Mas, houve uma economia muito grande de espaço.

É importante que nós, como DBAs, tenhamos este script em mãos para reduzir periodicamente o tamanho da base de dados, economizando espaço em disco e evitando que ele se esgote. Isso pode acontecer com a máquina onde o banco de dados SQL Server está salvo. Portanto, é fundamental manter um controle constante do espaço livre em disco disponível.

------------------------------------------------------

Ao monitorar e ajustar o desempenho de um ambiente do SQL Server, nós não devemos apenas medir o tempo de resposta da consulta, mas também precisamos monitorar muitos outros fatores que possam afetar o desempenho. O que vimos em todos os vídeos desta aula foi isso: como conhecer a linha base de trabalho e monitorar o ambiente de disco. Vamos, então, falar sobre os pontos de atenção no monitoramento ao verificar performance.

Pontos de atenção: Performance
1. Quantidade de solicitações
Saber a quantidade de solicitações simultâneas que ocorrem no servidor é muito importante. Além disso, precisamos verificar o uso do processamento de CPU para cada uma dessas solicitações — o que fizemos com o Active Monitor. Isso porque a quantidade de solicitações é um dos principais indicativos de desempenho de um banco de dados no SQL Server.

A quantidade de solicitações inclui também o número de consultas e transações por segundo, bem como o número de usuários simultâneos que acessam o banco de dados. Ao monitorar a quantidade de solicitações, podemos, por exemplo, identificar aqueles padrões de uso; ou seja, a linha base. Podemos, inclusive, traçar linhas-base conforme os horários de pico ou consultas mais frequentes, entendendo o banco quando estamos executando transações com alta carga de dados.

Isso porque pode ser que a linha base não seja a mesma em intervalos de tempo iguais. Podemos ter uma linha base durante o dia, por exemplo, e durante a noite, em que há processamento de processos agendados, a linha base pode mudar.

Sabendo disso, conhecendo bem e ajustando a sua linha base ao longo do tempo, você consegue identificar pontos de gargalo no sistema e, também, identificar oportunidades para otimizar as consultas e transações para melhorar a performance.

Além disso, monitorar a quantidade de solicitações permite que você identifique problemas de segurança, como ataques de SQL Injection ou outras ameaças que podem ocorrer no seu banco de dados.

2. Espaço afetado pelas solicitações
Outro ponto importante, sobre o qual falamos no vídeo anterior, é o espaço em disco — mais um fator crítico que deve ser considerado ao monitorar o desempenho de um banco de dados SQL Server. A falta de espaço em disco pode resultar em vários problemas, incluindo lentidão do sistema, interrupção de operações e até perda de dados.

Por isso, é importante sempre monitorar o espaço em disco do banco de dados, incluindo o tamanho total do banco, o tamanho das tabelas, dos índices e o tamanho dos arquivos de log. Isso vai permitir que você identifique se o banco de dados está atingindo os seus limites de espaço em disco e se é necessário adicionar mais espaço à disposição ou otimizar o banco de dados para liberar espaço, como fizemos anteriormente.

Além disso, também vale a pena frisar a importância de monitorar a utilização do espaço em disco ao longo do tempo, identificando como o banco cresce ao longo do tempo, para identificar tendências e planejar a futura manutenção desses dados. Por exemplo: se o banco estiver crescendo muito rápido, você pode planejar e adicionar mais espaço em disco ou otimizar o banco, para liberar espaço desnecessário.

3. Tipos de solicitações
Reconhecer os diferentes tipos de solicitações feitas no SQL Server é também um elemento importante, pois cada tipo de operação possui um impacto diferente na performance do sistema.

Por exemplo, as operações de inserção, atualização e exclusão, conhecidas como inserts, updates e deletes, geralmente demandam maior utilização de entrada e saída (I/O) e recursos de disco em comparação às consultas. Por outro lado, as consultas que não consomem tanto I/O, mas que possuem soma e agregações, podem ser mais intensivas em CPU e em uso de memória. Isso pode, claro, afetar a performance.

Quando você monitora esses tipos de solicitações, é possível identificar o impacto de cada tipo de operação dentro da performance do sistema. Se necessário, você pode utilizar essas transações para melhorar a performance. Além disso, monitorar os tipos de solicitações permite identificar oportunidades para melhorar a arquitetura do banco, como, por exemplo, uso de índices ou otimização de consultas.

4. Dificuldade das solicitações
Conhecer a complexidade das solicitações é muito importante para você entender o seu ambiente e garantir desempenho no SQL Server.

Por exemplo: solicitações simples, como leitura de dados de uma tabela, geralmente têm impacto menor na performance do sistema do que requisitar solicitações mais complexas, como as que têm JOIN entre tabelas. Esse tipo de solicitação pode gerar uso intensivo de CPU e memória.

Por isso, é importante entender como são essas solicitações. Conhecendo a complexidade delas, é possível identificar oportunidades de melhorar a arquitetura do banco, como, por exemplo, uso de índices para otimizar a velocidade dessas consultas.

É fundamental incluir na sua análise do ambiente a complexidade das solicitações no seu plano de gerenciamento e desempenho do SQL Server.

Conclusões
Alguns pontos mencionados neste vídeo nós já conhecemos nessa aula, através do Active Monitor e do script de redução de tamanho de base.

Mas, vamos entender melhor as solicitações que chegam ao banco, entender se elas são complexas ou não, o tempo que elas levam e se é possível melhorar o tempo de uma solicitação específica, como uma consulta, por meio de reestruturação de elementos internos do banco.

São esses outros pontos muito importantes sobre performance que trataremos nas próximas aulas.

----------------------------------------------

Neste ponto, já aprendemos como DBA, a identificar se o nosso servidor está se comportando de acordo com sua linha base. Se começarmos a observar que ele está fugindo da linha base, podemos fazer uma investigação mais detalhada para tentar entender que tipo de consulta ou comando, enviada ao servidor pelo cliente, está afetando e modificando a linha base. Para isso, faremos o que chamamos de trace.

O trace funciona como uma observação da comunicação entre o cliente e o servidor a fim de entender o que está prejudicando o ambiente do SQL Server. Para isso, utilizaremos uma ferramenta chamada SQL Server Profiler, que ajuda a identificar as comunicações entre o cliente e o servidor.

Fecharemos o monitor de atividades acessaremos o seguinte link para fazer download do arquivo "Tracesql.sql". Após baixar este arquivo, devemos copiá-lo para a pasta do diretório de trabalho.

De volta ao Management Studio, vamos em "Arquivo", no menu superior, e em Abrir > Arquivo. Uma janela abrirá e devemos navegar até a pasta do diretório para selecionar o arquivo que acabamos de baixar. Neste ponto, devemos lembrar de nos certificar que estamos na base DB_Vendas.

Temos três consultas, mas, na prática, o usuário está olhando uma aplicação que, normalmente, é um dashboard. Um dashboard seria um relatório, no formato de painel, com diversas representações visuais, como, por exemplo, gráficos de pizza e linha, tabelas e caixas de seleção para escolhermos filtros. Quando o usuário clica em um botão da aplicação para atualizar todos esses componentes, o programa executa uma série de consultas no SQL Server.

Nem sempre um relatório é composto por apenas uma consulta, pois às vezes são necessárias várias. O que estamos simulando são três consultas ao banco de dados, supondo que elas são executadas pelo relatório do usuário quando este deseja fazer algo.

Sabemos que existe um problema no servidor e precisamos identificar se uma dessas três consultas é a causa deste problema. Faremos isso usando o SQL Server Profiler.

Para abrir esta ferramenta, vamos em "Ferramentas", no menu superior, e clicamos em "SQL Server Profiler". Em seguida, nos autenticamos na base. Feito isso, temos acesso a uma janela que corresponde à caixa principal para parametrizar o SQL Server Profiler.

A primeira coisa que faremos nomear o rastreamento como "TESTE". Normalmente, esta ferramenta já disponibiliza para uma série de templates prontos chamados de modelo. Em "Usar o modelo", temos a opção "Em branco", mas às vezes são apresentados alguns modelos em funcionamento.

Ao selecionar o modelo "Em branco", é possível que surja uma mensagem informando que o modelo tem um formato incorreto, então basta ignorá-la. No ambiente, provavelmente você terá uma lista de modelos disponíveis.

Feito isso, vamos na guia "Seleção de Eventos", no topo da janela, onde podemos escolher, entre vários eventos existentes, aquele que fará o acompanhamento. Note que temos diversos tipos que nos permitem fazer o acompanhamento pelo SQL Server Profiler.

Aqui, nos interessa acompanhar os comandos de TSQL. Então selecionaremos esta opção e uma lista se abrirá com os eventos correspondentes ao comando de TSQL, entre os quais selecionaremos SQL:BatchStarting e SQL:BatchCompleted. Do lado direito, temos as colunas em que serão exibidos valores quando fizermos o trace desses eventos.

O SQL:BatchStarting fará o trace quando um comando SQL for enviado ao servidor. Já o SQL:BatchCompleted acontecerá dentro do trace quando o mesmo comando SQL Server for retornado do servidor para o cliente. Então ele escreverá alguns indicadores que constam nas colunas seguintes como, por exemplo, quantidade de CPU, ID do cliente, ID do processo do cliente que executou a consulta, entre outros.

Podemos, também, executar filtros sobre os eventos trace que acontecerão. Para configurar esses filtros, basta irmos no botão "Filtros de Coluna", localizado no canto inferior direito da janela. Clicando nele, temos acesso aos filtros que podemos aplicar. Se clicarmos, por exemplo, em "CPU" e colocarmos o número 50 em "Maior ou igual a", significa que só faremos o trace quando o nível de CPU ultrapassar 50%.

Anteriormente, vimos que o DBA pode acompanhar o consumo de CPU no seu nível de linha base. Mas, além disso, ele pode especificar, por exemplo, que a linha base deve estar trabalhando em 50%. Dessa forma, o trace avisará quando consultas ou processamentos que consumiram mais do que 50% forem executados, porque passam a ser suspeitos de prejudicar a performance do banco.

Não usaremos o filtro "CPU", mas sim o "LoginName", passando "sa" para "Como". Ou seja, só exibiremos o trace quando o usuário "sa" executar algum comando de TSL. Feito isso, basta clicar em "OK" e, depois, em "Executar". O trace já está pronto para acompanharmos o que acontecerá no ambiente.

--------------------------------------------------------

Estamos com o SQL Server Profiler ligado, mas, por enquanto, ele não escreveu nada. Isso, porque, nós colocamos um filtro para que uma consulta seja acompanhada apenas quando o usuário SA a enviasse para o servidor.

Voltando para o Management Studio, vamos executar a primeira consulta, que pega o código e o nome do produto e lista todos os resultados.

select codigo_produto as PRODUTO, produto as NOME_PRODUTO
from [dbo].[tb_produto]
Copiar código
Ao fazê-lo, note que, em termos de performance, a execução foi rápida. Vejamos o que aconteceu no SQL Server Profiler.

Clicando na guia do Profiler, note que foram escritas quatro linhas. A primeira linha corresponde à execução da consulta "SELECT @@SPID;", algo interno ao SQL Server. Na terceira linha, temos "SQL: BatchStarting", onde conseguimos ver, na janela abaixo, a consulta executada.

Acompanhando os valores das colunas de cada linha, conseguimos ver a aplicação que executou isso, no caso, o Management Studio. Se tivéssemos executado essa consulta por uma aplicação, provavelmente veríamos o nome do DriverDBC ou OLDB, que fazem a comunicação entre o cliente e o servidor através dela. Temos, ainda, o número do processamento no servidor, a database no qual a consulta foi efetuada, o nome do cliente, entre outros dados.

Sendo assim, conseguimos monitorar uma série de parâmetros e descobrir, por exemplo, qual usuário ou máquina realizou a consulta. Em "StartTime", temos a hora que o banco de dados recebeu a consulta e, embaixo, a hora que ele a retornou para o cliente. Note que foi praticamente instantâneo.

Em "TextData", temos o texto que corresponde à consulta. Mas nos importa, principalmente, a informação de "CPU", que praticamente não foi gasta, o que nos permite fazer um link com o monitor de atividade para saber se a CPU estourou muito ou não essa consulta. Além disso, em "Duration", temos a duração em milissegundos, que foi 3. Por fim, mas igualmente importante, temos "Reads" e "RowCounts", onde conseguimos ver as entradas e saídas que o servidor fez, respectivamente. Note que foram feitas 217 consultas e retornadas 401 para o cliente.

Nas entradas e saídas, observamos em termos de I.O. de disco; enquanto na CPU, vemos em termos de memória e processamento.

Vamos executar a segunda consulta, responsável por listar os estados.

select sigla_estado as ESTADO, nome_estado as NOME_ESTADO from tb_estado
Copiar código
Ao executá-la, voltamos ao SQL Server Profiler para acompanhar. Note que teve uma duração menor que a anterior, além de retornar menos linhas, pois foram apenas 24.

Sabemos que a tabela de clientes tem cerca de 1 milhão de clientes. Façamos, então, uma seleção nesta tabela para observarmos se haverá diferença em seu acompanhamento, uma vez que ela é maior que as tabelas de produtos e estados.

select * from [dbo].[tb_cliente]
Copiar código
Ao executar, perceba que, embora o resultado seja retornado, temos a informação de que a consulta ainda está sendo executada. Quando ela é finalizada, essa mensagem é alterada informando que a consulta foi concluída e em quanto tempo. No caso, em 7 segundos. Isso ocorre porque pegar os dados de clientes da tabela é rápido; a demora se encontra em escrever essa saída de 1 milhão de clientes.

Se olharmos o SQL Server Profiler, notamos que tivemos um tempo maior, cerca de 7.612 segundos. O número de leituras se encontra em 12.648 e as linhas retornadas estão em 1 milhão. Ou seja, o número de linhas retornadas influencia no tempo de processamento de entradas e saídas.

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
Copiar código
Ao executar, não temos um retorno imediato. Perceba que o processamento demora cerca de 7 segundos.

No SQL Server Profiler, notamos que demorou praticamente os mesmos 7 segundos que a consulta anterior. Mas, enquanto na anterior o tempo foi gasto para escrever a resposta, nesta o tempo maior foi gasto no processamento, pois teve que trabalhar internamente 344.170 linhas e só escreveu 3 linhas de resultado.

Esses são dois exemplos de consultas que demoraram praticamente o mesmo tempo, mas enquanto uma gastou muito na entrada e saída, a outra gastou mais no processamento interno.

Vamos simular uma série de consultas chegando no banco. Para isso, clicaremos com o botão direito do mouse sobre "DESKTOP", no menu lateral, depois em "Monitor de Atividades", assim estaremos ligando-o.

Ao ligar o monitor de atividades, ele internamente faz uma série de consultas no ambiente do SQL Server. Se olharmos o SQL Server Profiler, veremos que ele está escrevendo uma série de resultados de acompanhamento das consultas, pois abrimos o monitor com o usuário SA.

Vamos parar o monitor de atividades fechando a aba que foi aberta ao ligá-lo. A seguir, veremos como analisar melhor a saída dessas linhas que foram escritas pelo Trace do SQL Server.

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
Copiar código
É possível pausar o trace no botão de pausa que aparece na barra superior. Se, ao pausá-lo, executarmos novamente a consulta, o trace não escreverá nada porque está pausado.

O DBA não precisa ficar com o trace ligado o tempo todo, pois gasta processamento fazendo com que o SQL Server se preocupe em escrever tudo que faz.

O trace é uma ferramenta importante para que, quando o DBA note que o processamento do ambiente está fugindo da linha base do SQL Server, isso chame atenção e ele faça uma investigação mais detalhada. Então, somente neste momento, o trace será ligado para apontar, dentre os diversos comandos que estão trafegando entre cliente e servidor, aquele que está gerando o problema.

Sendo assim, deixamos o trace ligado somente durante o tempo em que o monitor de atividade indica que há uma série de informações fugindo à linha base. Depois, analisamos esses resultados.

Porém, analisar esses resultados a partir de uma lista com a dimensão da que temos agora, torna-se muito difícil, o que dificulta, também, que identifiquemos quem está causando problema. Pensando nisso, podemos salvar o resultado do trace em uma tabela do banco de dados, na qual podemos fazer consultas para verificar o que aconteceu no SQL Server durante o período que deixamos o Profile rodando.

Para salvar o conteúdo do trace, vamos em Arquivo > Salvar Como > Tabela de Rastreamento. Uma janela se abrirá e, nela, faremos a conexão no SQL Server. Depois, clicamos em "Conectar" e escolhemos uma base de dados. Aqui, optaremos pela própria base de dados com a qual estamos trabalhando, "DB_VENDAS". Em seguida, damos um nome para a tabela, como "RASTREAMENTO_TRACE". Feito isso, basta clicar em "OK" e o conteúdo é salvo nesta tabela. Vamos verificar sua escritura.

No SQL Server, clicamos com o botão direito do mouse sobre "DB_VENDAS" e atualizamos. Ao fazê-lo, tabela "RASTREAMENTO_TRACE" deve aparecer. Ao expandir as colunas dessa tabela, vemos vários campos que correspondem às colunas do trace.

Vamos criar uma nova consulta e executar o seguinte:

SELECT * FROM [dbo].[RASTREAMENTO_TRACE]
Copiar código
Feito isso, podemos verificar todo o processamento.

Outra possibilidade é selecionar as durações maiores que 6.500 milissegundos, por exemplo:

SELECT * FROM [dbo].[RASTREAMENTO_TRACE] WHERE Duration >= 6500
Copiar código
Ao rodarmos essa consulta, nos são retornadas somente as consultas que demoraram mais. Note, inclusive, que temos consultas que demoraram mais do que 6.500 milissegundos vindas, também, da base "tempdb", que é a base interna do SQL Server. Quem fez essas consultas foi o monitor, mas supondo que não queremos elas, podemos acrescentar o comando and DatabaseName <> 'tempdb':

SELECT * FROM [dbo].[RASTREAMENTO_TRACE] WHERE Duration >= 6500 and DatabaseName <> 'tempdb'
Copiar código
Agora temos acesso à 3 consultas que demoraram mais que 6500 milissegundos. Uma delas foi a consulta à tabela de clientes; enquanto as outras duas correspondem às duas execuções da consulta que fazia o join entre várias tabelas.

Dessa forma, tentamos descobrir qual é a consulta que gerou problema no ambiente. Ao identificá-la, podemos a analisá-la com cuidado para entender como ela foi construída e como está sendo processada pelo SQL Server, a fim de ver o que podemos fazer para que ela não prejudique mais o cliente. Faremos isso nas próximas aulas!

-----------------------------------------------------

Vimos na prática como funciona o SQL Server Profile, então vamos nos aprofundar um pouco mais sobre o que ele pode fazer.

O SQL Server Profile é uma ferramenta integrada ao SQL Server Management Studio que permite monitorar e rastrear eventos no banco de dados do SQL Server. É muito útil para fins de diagnóstico de desempenho, análise de consultas, auditoria de segurança e outras atividades semelhantes a essas.

O SQL Server Profile permite que o usuário crie seções personalizadas de rastreamento, defina filtros e classifique os eventos capturados. Também é possível executar essas personalizações várias vezes para fins de comparação. Ou seja, para saber se nossas ações melhoraram ou não os problemas de performance do ambiente.

Podemos afirmar que o SQL Server Profile é uma ferramenta de rastreamento do SQL Server. Esse rastreamento possibilita identificar gargalos de desempenho e solucionar os problemas que afetam o desempenho geral do sistema. Sendo assim, é possível capturar e analisar informações sobre solicitações enviadas ao banco de dados, incluindo informações sobre comandos de SQL, operações do sistema e chamadas do sistema. Além disso, podemos visualizar informações sobre o uso de recursos do sistema, como CPU, memória, entrada e saída de disco, e outros recursos que permitem identificar os pontos de melhoria para melhorar o desempenho.

Ele também oferece modelos pré-definidos que podem ser usados para identificar os problemas de performance. Cada modelo pré-definido é desenhado e projetado para rastrear e identificar um determinado problema. Então, podemos ter modelos que só monitorem a entrada e saída de dados; a alocação de memória ou recursos de CPU, sendo possível salvar esses modelos e executá-los sempre que necessário. Assim, é possível comparar os resultados e ver se a eficiência do SQL Server está melhorando com as ações realizadas no banco de dados.

Além disso, também é possível efetuar o trace através de comandos de TSQL, que é a linguagem de programação do SQL Server.

Vamos, agora, conhecer quais são os principais módulos do SQL Server Profiler:

Eventos: permite que você defina quais eventos do SQL Server quer monitorar, como inserções, atualizações, consultas e muito mais;
Colunas: neste módulo é possível especificar o que se quer visualizar. Podemos, por exemplo, adicionar colunas como tempo de execução, quantidade de leituras, quantidade de escritas, entre outros;
Templates: permitem salvar a configuração para uso futuro, facilitando a geração de relatórios;
Filtros: permitem que você filtre o resultado dos relatórios, por exemplo, por data, usuário ou eventos. Neste caso, o trace só é realizado quando esses filtros ocorrem;
Gráficos e relatórios: é possível salvar o conteúdo do trace em uma tabela e construir relatórios mais elaborados usando outras ferramentas contidas no SQL Server;
Armazenamento de seções: aqui, é possível salvar as informações coletadas no profile temporariamente e, depois, analisá-las para identificar o que aconteceu dentro do ambiente do SQL Server em um determinado período.
Alguns comandos de TSQL para executar o profile são:

sp_trace_create: cria uma nova seção de rastreamento;
sp_trace_setevent: configura os eventos a serem capturados durante a seção de rastreamento;
sp_trace_setfilter: configura os filtros que serão aplicados durante a seção de rastreamento;
sp_trace_start: inicia a seção de rastreamento;
sp_trace_stop: interrompe ou para a seção de rastreamento;
sp_trace_delete: exclui uma seção de rastreamento;
sptracegetdata: recupera dados que foram capturados durante uma sessão de rastreamento.
Todos esses comandos permitem que você possa, por exemplo, criar um programa em TSQL para que, em determinados períodos, de forma automatizada, ele faça a coleta do trace.

Exemplo de código em TSQL que efetua o trace:

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
EXEC sp_trace_delete @traceid = @trace_idCopiar código
No primeiro passo, usamos sp_trace_create e armazenamos o ID do trace em uma variável. Depois, iniciamos os eventos de trace, passando alguns parâmetros como eventid, columnid e on.

Em seguida, em sp_trace_setfilter, definimos os filtros que serão aplicados. Depois que declaramos e definimos como será o nosso trace, iniciamos o trace com sp_trace_start e fazemos a espera de alguns segundos. Ou seja, ao iniciar o trace, ele será feito durante esse tempo estabelecido. Por fim, depois desse tempo, podemos parar o trace com sp_trace_stop e limpá-lo com sp_trace_delete.

----------------------------------------------------

Quais foram os passos que percorremos até essa aula? Bem, como DBA desse ambiente da SQL Server, começamos pela análise do ambiente no seu nível base.

Monitoramos o funcionamento do sistema através do monitor de atividades e traçamos qual é o nível base de funcionamento dele. Se o sistema estiver funcionando dentro desse nível base, ainda podemos ter um cenário com problemas de performance, mas não serão devido ao ambiente.

Mas, se identificamos que os processos estão fugindo do nível base, passamos para o passo dois: monitorar toda a comunicação entre cliente e servidor do banco.

Para isso, usamos o SQL Server Profile. Nessa ferramenta, identificamos os comandos que são problemáticos.

É hora de analisar esses comandos e verificar o que podemos fazer para melhorar a performance deles.

Normalmente, os comandos problemáticos que vamos analisar nessa fase estão associados a consultas (queries). Ou seja, consultas através de comandos SELECT.

Afinal, essas consultas são utilizadas para a emissão dos relatórios usados pelas pessoas usuárias que acessam os dados do banco.

A análise desses comandos SELECT é feita através do plano de execução. Nesse vídeo, vamos entender como funciona o plano de execução de uma consulta.

Plano de execução
No SQL Server Management Studio, vamos criar uma nova consulta ao clicar no botão "Nova Consulta" na barra de ferramentas (ou atalho "Ctrl + N") para fazer um exercício.

No banco de dados, temos uma tabela criada em vídeos anteriores chamada "Nums". Vamos pegar o conteúdo dessa tabela e transferir para uma segunda tabela por meio do seguinte comando:

SELECT * INTO NumsLinha FROM Nums;Copiar código
Ao selecionar e executar esse código com o botão "Executar" na barra de ferramentas (ou "F5"), transportamos todo o conteúdo da tabela "Nums" para essa nova tabela chamada "NumsLinha".

No painel "Pesquisador de Objetos" à esquerda, clicamos com botão direito do mouse na pasta "Tabelas" e selecionamos "Atualizar". Agora temos essa nova tabela listada dentro de "Tabelas".

As tabelas "Nums" e "NumsLinha" não são iguais. Ambas são iguais no conteúdo, mas não na estrutura interna. Vocês vão entender mais à frente o porquê.

Porém, digamos que nosso objetivo seja analisar a consulta onde selecionamos todos os registros da tabela "NumsLinha" que tenham o campo N igual à 10001.

SELECT * FROM NumsLinha WHERE N = '10001';Copiar código
Após selecionar e executar essa consulta, temos o resultado esperado.

Resultados:

#	n
1	10001
Porém, agora queremos verificar o plano de execução dessa consulta para entender o que o SQL Server fez para nos trazer esse resultado.

Antes de analisar o plano de execução, vamos refletir: o SQL Server deve ter ido na tabela, percorrido todas as linhas da tabela até achar a linha cujo N era igual a 10001, pegou essa linha e a exibiu. É isso que supomos que a ferramenta deve ter feito.

Vamos tentar entender se foi isso mesmo que aconteceu?

Se selecionamos novamente a segunda consulta e clicamos no botão "Incluir Plano de Execução Real" da barra de ferramentas (ou atalho "Ctrl + M"), vamos justamente ativar o plano de execução. Após ativá-lo, executamos a seleção novamente.

Com isso, além do resultado da consulta, foi criada uma nova aba chamada "Plano de execução" na parte inferior do SQL Server Management Studio.

Clicamos nessa aba, temos todos os passos executados pelo SQL Server até chegar ao resultado final.

Plano de execução:

Consulta 1: Custo da consulta (relativo ao lote): 100%

Índice Ausente (Impacto 99.932): CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>] ON [dbo].[NumsLinha] ([n])

Captura de tela da aba "Plano de execução" do SQL Server Management Studio. Diagrama de três passos: "SELECT", "Paralelismo (Gather Streams)" e "Table Scan (NumsLinha)", cada um possui um ícone ilustrativo acima e informações abaixo. São ligados por setas que apontam da direita para a esquerda. A única informação abaixo do passo "SELECT" é: custo de 0%. As informações abaixo do passo "Paralelismo (Gather Streams)" são: custo 8%, 0.523 segundos e 1 de 1(100%). As informações abaixo do passo "Table Scan (NumsLinha)" são: custo 92%, 0.523 segundos e 1 de 1(100%).

Foram executados três passos. Chamamos cada passo de operador. Fazemos a leitura da direita para a esquerda, seguindo as setas. Assim, sabemos que o SQL Server usou um operador chamado "Table Scan", depois um operador chamado "Paralelismo" e, finalmente, exibiu o resultado final do comando "SELECT".

Em todos os operadores, existe um indicador chamado custo. Ao somar os custos dos operados temos o custo do SQL Server para nos devolver esse resultado. Foram gastos 92% do custo para fazer o "Table Scan", enquanto 8% desse custo foi para fazer o "Paralelismo".

Mas, podemos obter mais informações a respeito de cada operador executado pelo plano de execução.

Se passamos o cursor do mouse sobre o passo, aparece uma estatística sobre aquele operador específico.

Table Scan

-	-
Operação Física	Table Scan
Operação Lógica	Table Scan
Modo de Execução Estimado	Row
Armazenamento	Row
Número de Linhas Lidas	30000000
Número Real de Linhas de Todas as Execuções	1
Número Real de Lotes	0
Custo Estimado de E/S	35,7321
Custo Estimado do Operador	43,9821 (92%)
Custo Estimado da Subárvore	43,9821
Custo Estimado de CPU	8,25002
…	…
Para o "Table Scan", nos mostra o nome do operador como Table Scan, o número de linhas que o programa teve que interagir para fazer esse Table Scan. O Table Scan teve que percorrer 30000000 linhas, isto é, a tabela toda. Também temos o custo estimado de entrada e saída (E/S) com o valor 35,7321. Ou seja, quanto foi gasto de I/O de disco.

Depois, temos o custo estimado desse operador: 92% do custo foi nesse passo e o custo foi de 43,9821. Mas, em que unidades esse custo é expresso? Unidade nenhuma, pois é uma unidade interna do SQL Server. Esse custo só vai ter sentido quando o comparamos com outro plano de execução. Dessa forma, vamos saber se 43 é muito ou pouco.

Além disso, é listado o custo estimado de CPU como 8,25002. Note que o valor total do custo estimado do operador é a soma do gasto de entrada e saída com o que foi gasto de CPU.

O custo estimado da sub-árvore é o acumulado do custo até chegar ao resultado final. Então, o SQL Server gastou 43,9821 até esse primeiro passo.

Paralelismo

-	-
Operação Física	Paralelismo
Operação Lógica	Gather Streams
Modo de Execução Estimado	Row
Armazenamento	Row
Número Real de Linhas de Todas as Execuções	1
Número Real de Lotes	0
Custo Estimado de E/S	0
Custo Estimado do Operador	3,6285 (8%)
Custo Estimado da Subárvore	47,6106
Custo Estimado de CPU	0,0285019
…	…
Depois, passamos o cursor sobre "Paralelismo". Nesse segundo passo, teve um custo estimado de 3,6285 somente para esse operador, ou seja, 8%. Com isso, o acumulado passou a ser 47,6106 como podemos observar no custo estimado da subárvore. Apesar desse passo não gastar nada de disco, só de CPU.

SELECT

-	-
Tamanho do plano em cache	24 KB
Custo Estimado do Operador	0 (0%)
Grau de Paralelismo	8
Custo Estimado da Subárvore	47,6106
Concessão de Memória	136 KB
Número Estimado de Linhas de Todas as Execuções	0
Número Estimado de Linhas por Execução	1,0829
Depois, passamos o cursor pelo operador "SELECT", onde temos o valor final, 47,6106. Então, esse foi o custo estimado. Vamos comentar esse valor em uma nova linha.

-- 47,6106Copiar código
O nosso objetivo ao tentar melhorar uma consulta é fazer com que o plano de execução do SQL Server percorra caminhos mais performáticos para resolvê-la.

Por quê? Porque dependendo da estrutura do banco, da estrutura das tabelas e a forma como as tabelas forem criadas, o plano de execução vai escolher caminhos mais eficientes. Por isso, nosso objetivo é tentar entender como está montada essa consulta e determinar novos caminhos para melhorar o plano de execução.

No próximo vídeo, vamos aprender como executar esse mesmo plano de execução de uma maneira mais eficiente. Um abraço e até o próximo vídeo.

-------------------------------------------------------------

A consulta para selecionar da tabela NumsLinha aquela cujo N é 10001, gastou 47,6106 unidades internas do SQL Server e executou o plano de execução com três operadores: "Table Scan", "Paralelismo" e "SELECT".

Em uma nova consulta, vamos repetir esse comando utilizando a tabela "Nums". Relembramos que a tabela "Nums" e a tabela "NumsLinha" têm o mesmo conteúdo, porém internamente elas têm uma diferença. Vamos descobrir se essa diferença vai realmente acarretar alguma melhoria do plano de execução.

Para isso, vamos voltar à consulta original, copiar o comando e colá-lo na nova consulta. Só que em vez de consultar na tabela "NumsLinha", vamos usar a tabela "Nums".

SELECT * FROM Nums WHERE N = '10001';Copiar código
Vamos executar essa consulta com o plano de execução ativado.

Resultados:

#	n
1	10001
Note que tivemos um plano de execução diferente.

Plano de execução:

Consulta 1: Custo da consulta (relativo ao lote): 100%

Captura de tela da aba "Plano de execução" do SQL Server Management Studio. Diagrama de dois passos: "SELECT" e "Busca de Índice Clusterizado (Clustered)", cada um possui um ícone ilustrativo acima e informações abaixo. São ligados por setas que apontam da direita para a esquerda. A única informação abaixo do passo "SELECT" é: custo de 0%. As informações abaixo do passo "Busca de Índice Clusterizado (Clustered)" são: PK_Nums_3BD01993BEE0CC12, custo 100%, 0.000 segundos e 1 de 1(100%)

Vamos compará-lo com o anterior: o primeiro fez três operadores e o segundo apenas dois.

Colocamos o cursor do mouse sobre o operador "Busca de Índice Clusterizado" do segundo plano de execução para verificar o custo da operação. Note que 100% do custo ficou nesse passo, mas o valor desse custo é de apenas 0,0032831. Convenhamos que foi uma grande melhoria.

Anotamos o valor do custo estimado da operação para referência futura.

-- 0,0032831Copiar código
Comparar planos de execução
Podemos comparar os planos de execução.

No plano de execução da tabela "NumsLinha", vamos clicar com o botão direito do mouse na aba "Plano de execução" e escolher a opção "Salvar o Plano de Execução como…". Na janela que se abre, selecionamos o diretório de trabalho e salvamos o arquivo PLANO DE CONSULTA 01.sqlplan externamente.

No plano de execução da tabela "Nums", vamos clicar com o botão direito do mouse sobre uma área vazia da aba "Plano de execução" e escolher a opção "Comparar Plano de Execução". Na janela que se abre, escolhemos o plano que salvamos anteriormente.

Ao clicar em abrir, conseguimos visualizar os dois planos de execução na aba "Comparação de Plano de Execução". No plano superior temos o plano de execução da tabela "Nums" e no plano inferior temos o plano de execução de "NumsLinha".

No painel "Propriedades" à direita, conseguimos analisar as comparações: o plano superior gastou 0,0032831 e o plano inferior gastou 47,6106. Houve bastante diferença no custo estimado.

Os indicadores que estão diferentes entre cada plano são sinalizados com um sinal de diferença. Por exemplo, teve uma diferença entre os valores da propriedade "Compile Memory". Dessa forma, conseguimos analisar os pontos mais importantes de diferença entre esses planos de execução.

Agora, o que queríamos destacar para vocês a respeito de diferença entre esses dois planos está escrito nos planos de execução. No plano de "NumsLinha", foi usado um "Table Scan" e um "Paralelismo". Já no outro plano, foi usado outro operador chamado "Busca de Índice Clusterizado".

Isso significa que foram utilizados caminhos diferentes para chegar no mesmo resultado. Além disso, o operador "Busca de Índice Clusterizado" foi bem mais eficiente do que fazer o "Table Scan".

Esses passos utilizaram o que chamamos de "Busca por Table Scan" e por "Busca por Seek". O termo em inglês "seek" se refere a busca de índice. O termo "clusterizado" é adicionado, pois podemos ter diferentes buscas de índice - como aprenderemos futuramente.

Existe uma grande diferença em termos de custo entre as consultas para buscar a linha do filtro N = '10001'. Afinal, tivemos que percorrer a tabela toda para achar a linha cujo N é igual à 10001. Ao usar um "Table Scan", vamos gastar mais tempo do que se usamos um "Seek".

O que faz o SQL Server optar pelo "seek" em vez do "scan"?

Quando fizemos as consultas, não especificamos nada para o SQL Server. Mas, ele sozinho decidiu usar um "Table Scan" para a consulta na tabela "NumsLinha". Quando fizemos o SELECT na tabela "Nums", ele usou o "seek". A diferença está no índice clusterizado.

No próximo vídeo, vamos entender como funciona um índice e como ele influencia na melhoria da performance do plano de execução.

Afinal, se expandimos a pasta "Índices" da tabela "NumsLinha" no painel "Pesquisador de Objetos" à esquerda, não temos nenhum índice. Porém, se verificamos na tabela "Nums", temos um índice: PK_Nums_3BD01993BEE0CC12 (Clusterizado). Logo, o fato desse índice existir fez com que o plano de execução da busca daquela linha, através da tabela "Nums", fosse muito mais eficiente do que na tabela "NumsLinha".

Entender a importância do índice é fundamental. Porém, precisamos saber os tipos de índices existentes e como criar o índice correto. Vamos discutir esses pontos nos próximos vídeos. Um abraço e até daqui a pouco.

--------------------------------------------------

No vídeo anterior, descobrimos que o índice melhora o resultado do plano de execução. Vamos entender como isso funciona.

Índices
Vamos criar aqui uma nova consulta para trabalhar com a tabela "TB_cliente" do supermercado BitByte. Em uma nova linha, vamos escrever a seguinte consulta:

SELECT * FROM tb_cliente WHERE cidade = 'Salvador';Copiar código
Vamos selecionar e executar essa consulta.

Resultados:

#	cpf	nome	sobrenome	email	telefone	cidade	numero	rua	complemento
1	56921331639	Gustavo	Ribeiro	gmail.com	22988107	Salvador	2635	Rua 119	Apto. 87
2	724631570	Solange	Castro	yahoo.com	40843852	Salvador	613	Rua 24	Apto. 69
3	5064441074	Cristina	Nascimento	uol.com.br	88522388	Salvador	1511	Rua 974	Apto. 29
…	…	…	…	…	…	…	…	…	…
O resultado são todos os clientes que estão em Salvador.

Agora, vamos ativar o plano de execução desta consulta no botão "Incluir Plano de Execução Real". Na aba "Plano de execução", verificamos que o plano de execução dessa consulta usa o "Table Scan", além do "Paralelismo" para chegar ao "SELECT". Em outras palavras, o SQL Server percorre toda a tabela, analisa linha a linha em busca de quem é cliente da cidade de Salvador.

Plano de execução:

Consulta 1: Custo da consulta (relativo ao lote): 100%

Índice Ausente (Impacto 99.932): CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>] ON [dbo].[tb_cliente] ([cidade]) INCLUDE ([cpf], [nome], [sobrenome], [email], [telefone], [numero], [rua], [complemento])

Captura de tela da aba "Plano de execução" do SQL Server Management Studio. Diagrama de três passos: "SELECT", "Paralelismo (Gather Streams)" e "Table Scan (tb_cliente)", cada um possui um ícone ilustrativo acima e informações abaixo. São ligados por setas que apontam da direita para a esquerda. A única informação abaixo do passo "SELECT" é: custo de 0%. As informações abaixo do passo "Paralelismo (Gather Streams)" são: custo 2%, 0.006 segundos e 8306 de 8058 (103%). As informações abaixo do passo "Table Scan (tb_cliente)" são: custo 98%, 0.034 segundos e 8306 de 8058 (103%).

Vamos observar o resultado desse plano de execução ao passar o cursor do mouse sobre o operador "SELECT". Em "custo estimado da subárvore" temos um valor de 9,66822, vamos anotá-lo.

-- 9,66822Copiar código
Agora, observe que o próprio plano de execução nos escreve uma mensagem em verde: "índice ausente". Em seguida, nos mostra um comando para criar o índice. Ou seja, apesar de resolver o plano de execução dessa consulta com "Table Scan", o próprio SQL Server dá uma dica para quem está analisando o plano de execução: "para melhorar o resultado, é preciso criar um índice".

Qual índice devemos criar? O especificado no comando CREATE NONCLUSTERED INDEX. Então, vamos criá-lo.

Criação de índice
Em uma nova linha, digitamos CREATE NONCLUSTERED INDEX seguido do nome do índice. Nosso índice vai se chamar idx_tb_cliente_cidade, ou seja, identificamos em seu nome a tabela e o campo que faz parte do índice. Em seguida, escrevemos ON seguido do nome da tabela tb_cliente e o campo cidade entre parênteses.

Também pede para incluir a cláusula INCLUDE e todos os campos da tabela entre parênteses, exceto o campo que faz parte do índice.

CREATE NONCLUSTERED INDEX idx_tb_cliente_cidade ON tb_cliente (cidade) 
INCLUDE (cpf, nome, sobrenome, email, telefone, numero, rua, complemento);Copiar código
Selecionamos e executamos o comando para criar o índice.

Mensagens:

Comandos concluídos com êxito

Executamos de novo a mesma consulta SELECT com o plano de execução ativado. Note que agora temos um plano de execução diferente usando o índice.

Plano de execução:

Consulta 1: Custo da consulta (relativo ao lote): 100%

Captura de tela da aba "Plano de execução" do SQL Server Management Studio. Diagrama de dois passos: "SELECT" e "Index Seek (NonClustered)", cada um possui um ícone ilustrativo acima e informações abaixo. São ligados por setas que apontam da direita para a esquerda. A única informação abaixo do passo "SELECT" é: custo de 0%. As informações abaixo do passo "Index Seek (NonClustered)" são: idx_tb_cliente_cidade, custo 100%, 0.004 segundos e 8306 de 8306(100%)

Conseguimos verificar que o índice usado foi o índice que acabamos de criar. Passando o cursor do mouse sobre "SELECT", descobrimos que custo desse plano foi de 0,09184. Um ganho excelente, comparando o custo das duas consultas.

-- 9,66822
-- 0,09184Copiar código
Para criar o índice, a estrutura do comando é:

CREATE + tipo do índice. Criamos um índice do tipo NON_CLUSTERED (não clusterizado em tradução livre);
INDEX + nome do índice. Normalmente, esse nome seguirá a nomenclatura que a empresa usa;
ON + nome da tabela onde vai ter o índice + nome do campo que faz parte do índice entre parênteses;
INCLUDE + outros campos que não fazem parte do índice entre parênteses.
Dependendo do tipo do índice e a forma como você o cria, o plano de execução vai ou não usar o índice.

Antes de discutir esse assunto e explicar como o plano de execução escolhe o índice correto, vamos entender como a estrutura do índice realmente melhora o plano de execução.

Estrutura do índice
Vamos exemplificar com uma pequena tabela, onde temos clientes armazenados fora de ordem.

Tabela fictícia:

CLIENTE	NOME
002	Cliente 002
001	Cliente 001
003	Cliente 003
Na primeira linha, temos o 002. Na segunda linha, o 001. E na terceira linha, o 003. Digamos que queremos achar o elemento cujo código do cliente seja 003.

Em um "Table Scan", temos que percorrer a tabela toda e verificar linha a linha até descobrir onde está o 003 que é o filtro. Percorrer a tabela toda do início ao fim tem um custo.

Agora, o índice é uma tabela auxiliar onde temos os códigos ordenados do menor para o maior, ou seja, o campo que faz parte do critério do índice. Também temos a posição de onde está armazenado cada linha da tabela.

Índice:

CLIENTE	LINHA
001	2
002	1
003	3
Dessa maneira, se queremos achar o 003, conseguimos rapidamente localizar a linha do índice onde está o 003 através de um algoritmo de busca. Então, verificamos a posição de memória onde o 003 está armazenado para ir até a tabela buscar o dado desejado.

Em suma, o "Table Scan" realiza a busca diretamente na tabela, percorrendo linha a linha até o final.

No índice, existe uma tabela auxiliar organizada de forma alfabética, e através do algoritmo de busca, é possível descobrir a posição desejada mais rapidamente. A partir daí, já se sabe a posição de memória onde o dado que queremos buscar está armazenado.

É nesse contexto de posição de memória que surgem os conceitos de índice não clusterizado e clusterizado. Eles se baseiam na estrutura de como os dados estão armazenados na memória.

Suponha que se tenha uma área de disco representado por um retângulo cinza. Nele, temos retângulos coloridos menores, onde cada cor diferente representa um segmento de dados gravados e armazenados no disco.

Os índices não clusterizados funcionam da seguinte maneira: existe uma estrutura auxiliar na qual os dados estão armazenados em ordem alfabética, de acordo com o critério do índice.

Por exemplo, guardamos nomes de pessoas no disco: João, Pedro, Carlos, Ana e Júlia. Esses dados vão estar guardados de forma ordenada na estrutura auxiliar: Ana, Carlos, João, Júlia e Pedro. Se quisermos encontrar o funcionário João, basta buscar o nome "João" dentro da lista ordenada. O algoritmo para fazer isso é rápido. Após achar o "João", verificamos a posição de memória do registro na tabela e buscamos o dado.

Já o índice clusterizado é diferente. Esse índice faz com que os segmentos de memória da tabela no disco já estejam gravados ordenadamente pelo critério do índice. Dessa maneira, quando queremos buscar um determinado nome de funcionário, a busca é feita diretamente dentro dos segmentos de memória.

A conclusão é que o índice clusterizado é mais eficiente que o não clusterizado. Porém, não basta criar todos os índices clusterizados para resolver o problema de perfomance.

No próximo vídeo, vamos criar vários exemplos de índices clusterizados e não clusterizados para entender qual é o índice correto a ser utilizado em cada caso.

-------------------------------------------------------------

Agora, vamos discutir como sabemos qual é o índice correto a ser usado, dependendo de cada consulta.

Para isso, vocês vão baixar o arquivo ConsultasIndices.sql cujo link está disponibilizado na atividade "Preparando o ambiente".

Após baixá-lo, vamos acessar o SQL Server Management Studio. No menu superior, vamos em "Arquivo > Abrir > Arquivo" (ou atalho "Ctrl + O"), selecionamos o arquivo ConsultasIndices.sql no diretório que o baixamos e apertamos "Abrir".

Nesse arquivo, temos uma série de comandos que vamos analisar um a um.

Criação da tabela e inserção de registros
Primeiro, vamos criar uma tabela chamada "T_heap", que vai ter seis campos todos do tipo inteiro. O nome dos campos é: a, b, c, d, e e f. Para criar essa tabela, selecionamos e executamos a segunda linha. Caso você já tenha essa tabela criada ou está repetindo a experiência de novo, dê um DROP na tabela primeiro.

drop table T_heap;
CREATE TABLE T_heap (a int NOT NULL, b int NOT NULL, c int NOT NULL, d int NOT NULL, e int NOT NULL, f int NOT NULL);Copiar código
Mensagens:

Comandos concluídos com êxito.

Pronto, criamos a tabela.

Depois, vamos selecionar desde declare até end para executar outro comando.

declare @contador int
declare @max int
SET @contador = 1
SET @max = 50
WHILE @contador <= @max
BEGIN
   insert into T_heap (a,b,c,d,e,f) values ([dbo].[NumeroAleatorio](1,100), [dbo].[NumeroAleatorio](1,100),[dbo].[NumeroAleatorio](1,100),[dbo].[NumeroAleatorio](1,100),[dbo].[NumeroAleatorio](1,100),@contador)
   set @contador = @contador + 1
ENDCopiar código
Ele vai fazer um loop e inserir 50 linhas na tabela "T_heap", sendo que todos os campos de a até e serão números aleatórios entre 1 e 100 e apenas o campo f vai ser o contador. Desse modo, como teremos 50 linhas, o campo f vai ter desde o número 1 até 50.

Mensagens:

(1 linha afetada) x 50

Pronto, coloquei 50 linhas dentro da tabela "T_heap".

Vamos selecionar um comando que não está escrito previamente no arquivo baixado, só para saber o conteúdo da tabela.

SELECT * FROM T_heap;Copiar código
Resultados:

#	a	b	c	d	e	f
1	38	13	26	39	21	1
2	30	23	43	59	86	2
3	22	22	13	3	5	3
…	…	…	…	…	…	…
O resultado são os dados da tabela.

Consulta com índice não clusterizado
Em seguida, vamos selecionar somente os campos b e c, usando como filtro b igual à 68 e c igual à 55.

SELECT b, c FROM t_heap where b = 68 and c= 55;Copiar código
Vamos selecionar essa linha, ativar o plano de execução e executar o comando.

Após executar esse comando, acessamos a aba "Plano de execução" e notamos que foi feito um "Table Scan (T_heap)" de custo 100% e um "SELECT" de custo 0%. Como não tem índice na tabela, o SQL Server percorreu todas as linhas e fez um "Table Scan".

Agora, vamos criar um índice não clusterizado usando o próximo comando do arquivo:

CREATE NONCLUSTERED INDEX T_heap_a ON T_heap (a);Copiar código
O nome do índice é T_heap_a e vai ser criado na tabela T_heap apenas para o campo a. O campo a vai ser o critério do índice. Selecionamos e executamos para criar o índice.

Mensagens:

Comandos concluídos com êxito.

Agora a próxima seleção vai usar b igual à 1 como filtro e selecionar o campo b da tabela t_heap.

SELECT b FROM t_heap WHERE b = 1Copiar código
Lembre-se que temos um índice criado para essa tabela, porém o índice considera o campo a. O que vai acontecer?

Após executar, verificamos o plano de execução. Note que o SQL Server continua fazendo o "Table scan". Por quê? Porque o índice que temos na tabela considera o campo a, mas fizemos um SELECT no campo b. Logo, esse índice que considera o campo a não fez nenhuma diferença para melhorar a consulta que seleciona o campo b.

Mas, e se a consulta selecionar e também fizer um filtro no campo a?

SELECT a FROM t_heap WHERE a = 1Copiar código
Se selecionamos e executamos essa outra consulta, aí sim ele vai usar o "Index Seek (NonClustered)" no plano de execução, usando justamente o índice que criamos T_heap_a. Por quê? Porque o índice considera somente o campo a. Como fizemos o critério de seleção pelo campo a, funcionou.

Agora, vamos criar outro índice, usando como critério o campo b e o campo c.

CREATE INDEX T_heap_bc ON T_heap (b, c);Copiar código
Mensagens:

Comandos concluídos com êxito.

Em seguida, fazemos uma seleção do campo b e do campo c, usando como critério também b e c.

SELECT b, c FROM t_heap WHERE b = 1 and c = 1;Copiar código
Com isso, o plano de execução usa o "Index Seek (NonClustered)" e justamente usa o índice que acabamos de criar, T_heap_bc.

O que acontece se selecionamos só o campo b? O critério de seleção ainda é b e c igual à 1, mas na seleção só escolhemos b.

SELECT b FROM t_heap WHERE b = 1 and c = 1;Copiar código
No plano de execução, continuamos usando o índice T_heap_bc.

Agora, o que acontece se selecionamos a, usando como critério de filtro b e c?

SELECT a FROM t_heap WHERE b = 1 and c = 1;Copiar código
Perceba a diferença. O campo a tem um índice próprio, T_heap_a. Também temos outro índice, que é o T_heap_bc. Mas, estamos selecionando o a, usando como critério b e c. O que vai acontecer?

Após executar, foi feito um "Table Scan" no plano de execução. Mas, temos um índice para a e um índice para b e c. Por que o SQL Server fez o "Table Scan"?

Ele fez o "Table Scan" justamente porque não existe um índice que tenha a, b e c juntos. Se existisse, o índice seria usado.

Cláusula INCLUDE
Mas, existe uma cláusula chamada INCLUDE que até usamos no vídeo anterior. O que significa o INCLUDE?

Vamos fazer o teste com o campo d, criando o índice T_heap_d.

CREATE INDEX T_heap_d ON T_heap (d) INCLUDE (e);Copiar código
Note que o índice é do campo D, mas está usando o INCLUDE do campo e. Vamos executamos a criação desse índice.

Mensagens:

Comandos concluídos com êxito.

Agora, vamos visualizar o plano de execução para uma consulta que inclua e selecione d e e.

SELECT d, e FROM t_heap WHERE d = 1 and e = 1;Copiar código
Será que o índice T_heap_d será usado? Ele só foi criado para d, porém tem um INCLUDE de e. Vamos conferir.

O SQL Server usa o índice no plano de execução. Ou seja, o INCLUDE inclui novos campos para que o índice usado para este campo único possa ser reaproveitado quando outros campos estiverem selecionados.

Por isso que quando criamos o índice idx_tb_cliente_cidade, que era só por cidade, demos o INCLUDE em todos os outros campos da tabela. Assim, quando fizemos SELECT * da cidade de Salvador, o índice foi usado. Se tivéssemos criado o índice sem o INCLUDE, o plano de execução não usaria o índice na execução do SELECT *, apesar do ter critério de filtro por cidade. Afinal, havíamos selecionando outros campos que não faziam parte do campo do índice.

É muito importante que ao criar um índice, você tenha certeza que todos os campos que estejam na seleção e no critério de busca, façam parte do índice e do INCLUDE.

Se selecionamos os campos e e d usando como critério d e e igual à 1, o plano de execução também vai usar o índice T_heap_d. O mesmo acontece se selecionamos apenas o campoe`.

SELECT e, d FROM t_heap WHERE d = 1 and e = 1;
SELECT e FROM t_heap WHERE d = 1 and e = 1;Copiar código
Porém, se selecionamos o campo a usando o critério d e d, passa a usar o "Table Scan".

SELECT a FROM t_heap WHERE d = 1 and e = 1;Copiar código
Se quiséssemos que esta consulta utilizasse o índice correto, bastaria incluir o campo a em T_heap_d.

Para isso, primeiro damos um DROP INDEX para apagar o índice T_heap_d.

drop INDEX T_heap_d ON T_heap;Copiar código
Mensagens:

Comandos concluídos com êxito.

Agora, vamos criá-lo de novo, porém, também vamos colocar o campo a no INCLUDE.

CREATE INDEX T_heap_d ON T_heap (d) INCLUDE (e, a); Copiar código
Com isso, vamos criar um índice para o campo d, com INCLUDE nos campos e e a.

Mensagens:

Comandos concluídos com êxito.

Índice criado.

SELECT a FROM t_heap WHERE d = 1 and e = 1;Copiar código
Agora essa consulta que envolve d, e e a, vai usar o índice.

--------------------------------------------------------------------

No vídeo passado, aprendemos que quando utilizamos um índice não clusterizado, precisamos sempre incluir no critério do índice ou no INCLUDE todos os campos que farão parte do filtro e também da seleção. Se faltar algum campo, o plano de execução não utilizará o índice.

No entanto, podemos criar o que chamamos de UNIQUE INDEX ou índice único.

Criação de índice único
Vamos criar um índice único chamada T_heap_f usando o campo f da tabela "T_heap".

CREATE UNIQUE INDEX T_heap_f ON T_heap (f); Copiar código
Por que vamos usar o campo f? Porque esse campo foi onde incluímos o contador do loop. Com isso, garantimos que o campo f é único.

Para colocar um campo como critério de UNIQUE INDEX, ele não pode ter valores repetidos dentro da tabela. Ou seja, funciona como chave primária, como já aprendemos nos cursos introdutórios sobre banco de dados e estruturas de tabela do SQL Server.

Mas qual será o impacto quando a tabela tiver um índice único?

Vamos verificá-lo ao selecionar e executar a criação do índice único T_heap_f.

Mensagens:

Comandos concluídos com êxito.

Em seguida, vamos selecionar o campo f, usando como filtro o próprio f igual à 1.

SELECT f FROM t_heap WHERE f = 1;Copiar código
Já sabemos que um índice será utilizado, pois apenas o campo f está sendo usado tanto na seleção quanto no filtro. Após executar o comando com o plano de execução ativo, verificamos que o índice único é usado no "Index Seek (NonClustered)" de custo 100% para chegar ao "SELECT".

Agora, qual será o resultado desta seleção?

SELECT a FROM t_heap WHERE f = 1;Copiar código
Selecionamos o campo a, usando como critério o f igual à 1. Pelo que verificamos no vídeo passado, se usássemos índices não clusterizados, o plano de execução não usaria nenhum índice. Mas, vamos conferir o que vai acontecer agora que usamos índice único.

O SQL Server faz um plano de execução diferente, onde foram usados "Index Seek (NonClustered)" com custo de 50% e "RID Loopkup (Heap)" com custo de 50% para chegar ao operador "Loops Aninhados (Junção Interna)" com custo de 0% que, por sua vez, chega ao "SELECT" com custo de 0%.

Mas, note que ainda usa o índice T_heap_f no "Index Seek". Isso significa que o índice único possibilita o uso de índice em qualquer tipo de seleção.

Sempre crie uma chave primária em suas tabelas criadas no SQL Server. Assim, você pode criar o índice único para essa coluna que não terá repetições de registros.

Muitas vezes, falamos índice único e chave primária como sinônimo. Mas, são conceitos diferentes.

A chave primária é a definição colocada quando se cria a tabela para garantir que um determinado campo não pode se repetir. Com isso, é criada uma restrição, como uma regra de negócio. Por exemplo, o código de cliente ou o código do produto. Já o índice único é um índice para o campo que não se repete.

O que acontece é que quando criamos uma chave primária, automaticamente criamos um índice único. Assim, o índice faz parte de qualquer tipo de seleção que seja feito na tabela.

---------------------------------------------------------

Agora vamos falar dos índices clusterizados.

Mas antes, vamos executar novamente a consulta SELECT a FROM t_heap WHERE f = 1 que fizemos no vídeo anterior para verificar seu plano de execução que usa o índice único T_heap_f. Repare que índice único é também um índice não clusterizado, ou seja, "NonClustered". Mas, é preciso necessariamente que a coluna que faz parte desse índice seja uma coluna única.

Criação da tabela e inserção de registros
Agora, vamos criar outra tabela que vai se chamar "T_clu", que servirá para treinamos os índices clusterizados. Vamos criar a tabela através da seguinte linha presente no arquivo que baixamos:

CREATE TABLE T_clu (a int NOT NULL, b int NOT NULL, c int NOT NULL, d int NOT NULL, e int NOT NULL, f int NOT NULL); Copiar código
Mensagens:

Comandos concluídos com êxito.

Após criar a tabela, vamos fazer outro loop para colocar dados dentro dessa nova tabela. A diferença é que agora o contador, que define qual é o campo único, vai estar tanto no campo f quanto no campo a. Desse modo, tanto o campo a como o campo f serão campos únicos. Vamos ter números aleatórios apenas nos campos b, c, d e e.

declare @contador int
declare @max int
SET @contador = 1
SET @max = 50
WHILE @contador <= @max
BEGIN
   insert into T_clu (a,b,c,d,e,f) values (@contador, [dbo].[NumeroAleatorio](1,100), [dbo].[NumeroAleatorio](1,100),[dbo].[NumeroAleatorio](1,100),[dbo].[NumeroAleatorio](1,100), @contador)
   set @contador = @contador + 1
END;Copiar código
Selecionamos e executamos o comando para criar 50 linhas dentro da tabela "T_clu".

Consulta com índice clusterizado
Com o próximo comando, vamos criar um campo único clusterizado chamado T_clu_a, usando como critério o campo a.

CREATE UNIQUE CLUSTERED INDEX T_clu_a ON T_clu (a);Copiar código
Mensagens:

Comandos concluídos com êxito.

Acabamos de criar um campo único clusterizado. Note que anteriormente usamos CREATE UNIQUE INDEX e não especificamos o tipo do índice, portanto, automaticamente ele foi "NonClustered". Logo, o campo único que criamos no vídeo passado era não clusterizado e agora criamos um clusterizado.

Campos únicos podem ser dos dois tipos. A única diferença é que o não clusterizado guarda na sua estrutura apenas as posições de memória. Com isso, você busca o dado desejado, acha a posição de memória e vai nessa posição de memória. Enquanto os clusterizados vão direto nas posições de memória do disco, porque já foram armazenadas no disco de forma ordenada.

Então, se T_clu_a é um campo único e dermos um SELECT *, ou seja, selecionar todos os campos, vamos ter o uso do índice no plano de execução.

SELECT * FROM T_clu where b = 68 and c= 55;Copiar código
Conferimos que operador usado foi um "Clustered Index Scan (Clustered)" com custo de 100% que usa T_clu_a para chegar ao "SELECT" com custo de 0%.

Se colocamos como critério da seleção o próprio campo a presente no índice único, o índice também vai ser usado.

SELECT * FROM T_clu where a = 50;Copiar código
No plano de execução, foi usado o operador "Busca de Índice Clusterizado (Clustered)", usando o índice único T_clu_a.

Agora, vamos criar um índice usando b e c chamado T_clu_b.

CREATE INDEX T_clu_b ON T_clu (b, c); Copiar código
Em seguida, usamos o critério da seleção do campo b e c.

SELECT b, c FROM T_clu where b = 50 and c = 50;Copiar código
No plano de execução, ele escolheu fazer um "Index Seek (NonClustered)" com o índice T_clu_b, porque é o índice mais adequado.

Em outro comando, colocamos o mesmo filtro, mas selecionamos o campo e, o qual não faz parte do índice T_clu_b. Como a tabela "T_clu" tem um índice clusterizado único chamado T_clu_a, talvez o SQL Server passe a usar esse índice.

SELECT e FROM T_clu where b = 50 and c = 50;Copiar código
Vamos verificar o que vai acontecer. Após executar e conferir o plano de execução, notamos que foi usado o índice T_clu_a, que é o índice único. Por quê?

Porque primeiro o SQL Server vai buscar o índice que encaixe perfeitamente na consulta. Ele sabe que tem um índice de b e c. Como temos o filtro b e c na consulta, esse índice T_clu_b é candidato. Porém, como selecionamos o campo e, não é possível usar o índice T_clu_b. Mas, antes de desistir, o SQL Server lembra que a tabela tem um índice único, portanto, ele pode usar esse índice único no lugar do índice específico para b e c.

Agora, vamos criar um índice para o campo d chamado T_clu_d, mas usando o INCLUDE para incluir o campo e.

CREATE INDEX T_clu_d ON T_clu (d) INCLUDE (e);Copiar código
Mensagens:

Comandos concluídos com êxito.

Quando fizermos a seleção de d e e, o SQL Server vai usar o índice que mais se adapta, que é o índice T_clu_d.

SELECT d, e FROM T_clu where d = 2 and e = 2;Copiar código
No plano de execução, conferimos que o operador usado foi um "Index Seek (NonClustered)" usando o T_clu_d.

Vamos criar um segundo índice único na tabela "T_clu" chamado T_clu_f, porque usa o campo f.

CREATE UNIQUE INDEX T_clu_f ON T_clu (f);Copiar código
Mensagens:

Comandos concluídos com êxito.

Agora, vamos fazer uma seleção de todos os campos da tabela, mas usando como critério o campo f igual à 1.

SELECT * FROM T_clu where f = 1;Copiar código
O SQL Server vai usar os dois índices para buscar as melhores informações para poder nos dar o resultado. No plano de execução, foram usados os operadores "Index Seek (NonClustered)" com o índice T_clu_f com custo de 50% e "Pesquisa de Chave (Clustered)" com o índice T_clu_a também com custo de 50%. Depois, é usado o operador "Loops Aninhados (Junção Interna)" com custo de 0% que, por sua vez, chega ao "SELECT" com custo de 0%.

Enfim, é importante que você entenda qual é o tipo de seleção que você vai fazer e qual é o melhor índice que você deve utilizar.

Agora que nós já entendemos a mecânica, o que vamos fazer no próximo vídeo? No início do curso mostramos para vocês a consulta para criação do nosso relatório de faturamento que está um pouco lenta. O cliente não gosta do relatório, porque demora muito. Vamos verificar se ao criar índices podemos melhor a consulta desse relatório.

Agora vamos retomar nosso problema original: otimizar o relatório de vendas de produtos por classificação. Quando nosso usuário reclamou sobre a performance do ambiente do SQL Server, ele estava se referindo a esse relatório.

Revisando nossa trajetória no curso
O que fizemos até agora?

1- Verificamos a linha base do funcionamento do nosso ambiente. A partir dessa análise, notamos que em algumas situações, o processamento do servidor do SQL Server foge a essa linha base original.

2 - Usamos o SQL Profiler para fazer um Trace e verificar todas as comunicações efetuadas entre clientes e o servidor. Depois, identificamos as consultas mais pesadas.

3 - Analisamos os planos de execução das consultas. Com esta análise, refletimos sobre as iniciativas possíveis para reduzir o custo de resolução dessas consultas.

É isso que faremos agora:

Analisar o relatório de vendas;

Observar o seu plano de execução;

Pensar iniciativas para melhorar a performance.

Nossa base original já foi bastante manipulada durante o curso, então, antes de analisarmos a consulta que gera o relatório, vamos:

Apagar a nossa base e recuperar o mesmo backup que recuperamos na primeira aula do nosso curso. Assim, teremos uma base de dados apenas com as tabelas do supermercado BitByte, sem nenhum índice que possa prejudicar nossa análise.
Este processo é bem rápido: basta clicar com o botão direito do mouse sobre a base DB Vendas que já instalada na máquina, e selecionar a opção "Excluir". Na próxima tela, vamos marcar a caixa de seleção "Fechar conexões existentes" e apertar "Ok".

Nosso próximo passo é, localizar na máquina onde está salvo o arquivo de backup. Se você não sabe onde salvou o arquivo, basta voltar à primeira aula do nosso treinamento e realizar novamente o download.

No meu caso, o arquivo está localizado no diretório "C:> Temp > Vendas".

De volta ao ambiente (Microsoft SQL Server Management Studio), vamos selecionar o "Banco de Dados" com o botão direito do mouse e escolher a opção "Restaurar banco de dados".

Na próxima tela, vamos marcar "Dispositivo". À frente, selecionaremos o botão de "três pontinhos". Uma janela será aberta e, nela, apertaremos "Adicionar". Na próxima tela, buscaremos o diretório onde o arquivo de backup está salvo: "temp > DBP_VENDAS".

Localizado o arquivo "BD_VENDAS.BAK", basta selecioná-lo e apertar "OK". Na outra janela, selecionamos o nome do arquivo, "C:\temp\DB_VENDAS\DB_VENDAS.BAK" e novamente apertamos "OK".

Em seguida, acessaremos "Opções" no menu lateral esquerdo, "Selecionar uma página". Em "Opções", vamos marcar "Substituir o banco de dados existente", apertar "Ok" e aguardar o backup ser recuperado.

Agora temos a base de dados está pronta e podemos começar a análise do relatório de vendas por classificação.

---------------------------------------------------------------

Estamos com o relatório de vendas por classificação aberto:

DECLARE @ESTE_MES INT DECLARE @ESTADP VARCHAR(2)
SET @ESTE_MES =
SET @ESTADO = 'SP'
SELECT VENDAS.classificacao AS CLASSIFICACAO,
       ROUND(VENDAS.VALOR_MES, 2) AS VALOR,
             ROUND(VENDAS.VALOR_MES/ TOTAL.VALOR_TOTAL) * 100, 2) AS PERCENTUAL

// código omitido 
Copiar código
Vamos escolher, aleatoriamente:

Um mês. Por exemplo, "3" março.
DECLARE @ESTE_MES INT DECLARE @ESTADP VARCHAR(2)
SET @ESTE_MES = 3
SET @ESTADO = 'SP'
SELECT VENDAS.classificacao AS CLASSIFICACAO,
       ROUND(VENDAS.VALOR_MES, 2) AS VALOR,
             ROUND(VENDAS.VALOR_MES/ TOTAL.VALOR_TOTAL) * 100, 2) AS PERCENTUAL

// código omitido 
Copiar código
Um estado da federação. Por exemplo, "RJ".
DECLARE @ESTE_MES INT DECLARE @ESTADP VARCHAR(2)
SET @ESTE_MES = 3
SET @ESTADO = 'RJ'
SELECT VENDAS.classificacao AS CLASSIFICACAO,
       ROUND(VENDAS.VALOR_MES, 2) AS VALOR,
             ROUND(VENDAS.VALOR_MES/ TOTAL.VALOR_TOTAL) * 100, 2) AS PERCENTUAL

// código omitido 
Copiar código
No menu superior da tela, vamos selecionar "Incluir Plano de Execução Real (Ctrl + M)" e apertar "Executar" para executarmos o relatório.

Estamos "resolvendo" o relatório no tempo original do usuário do supermercado BitByte. Na minha máquina, executei em 17 segundos.

CLASSIFICACAO	VALOR	PERCENTUAL
Frutas	321540	7.66
Legumes	178029	4.24
Doces	158522	3.78
...	...	...
Podemos observar o "Plano de execução". Ele é extremamente complexo, utiliza vários tables scans e faz joins porque, o comando SQL que está sendo resolvido é bastante complexo também.

O próprio plano de execução apresenta uma sugestão de índice:

Consulta 1: Custo da consulta (relativo ao lote: 100%
SELECT VENDAS.classificacao AS CLASSIFICACAO, ROUND(VENDAS.VALOR_MES, 2) AS VALOR, ROUND(VENDAS.VALOR_MES/ TOTAL.VALOR_TOTAL) * 
Índice Ausente (Impacto 46.4102): CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>] ON [dbo].[tb_item] ([codigo_prod...
Copiar código
A sugestão é criar um índice não clusterizado por código do produto e passar um include no campo número, quantidade e preço. Vamos criar esse índice.

Antes, não se esqueça de anotar o tempo de resolução do relatório. No meu caso, foi 17 segundos, com custo no plano de execução de 512.844 (Para visualizar esse valor, basta selecionar "SELEC Custo".

Então, vamos criar o índice não clusterizado na tabela tb_item por código do produto. Vamos escrever CREATE NONCLUSTERED INDEX seguido do nome do índice que será idx_tb_item_codigo_produto, sendo codigo_produto o campo em que criaremos o índice.

Depois, passaremos ON e o nome da tabela, tb_item. Entre parênteses, passaremos o campo que será critério do índice codigo_produto.

CREATE NONCLUSTERED INDEX idx_tb_item_codigo_produto ON tb_item (codigo_produto)
Copiar código
Vamos aplicar o INLCUDE nos campos numero, quantidade e preco.

CREATE NONCLUSTERED INDEX idx_tb_item_codigo_produto ON tb_item (codigo_produto)
INCLUDE (numero, quantidade, preco);
Copiar código
Agora, vamos executar o comando!

O índice foi criado. Na minha máquina, o processo demorou 3 minutos e 43. Não importa tanto o tempo de processamento, mas se o comando fez a base de dados crescer muito, principalmente porque temos um espaço limitado na nossa máquina. Podemos ter problemas se continuarmos a criar novos índices sem observar o crescimento da base.

Por exemplo, vamos selecionar a base DB_VENDAS com o botão direito do mouse. Acessaremos "Propriedades" e, na próxima tela, selecionaremos "Arquivos" e buscaremos a localização da base de dados.

Na minha máquina, a base de dados está no diretório: "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER2\MSSQL\DATA". Vamos copiar esse diretório, abrir um explorador de arquivos do Windows, colar esse caminho no campo de "Acesso rápido" e analisar a base de dados. A seguir, é possível conferir um trecho:

Nome	Data de modificação	Tipo	Tamanho
DB_VENDAS.mdf	22/03/2023 23:53	SQL Server Database	5.371.904 KB
DB_VENDAS_log.Idf	22/03/2023 23:56	SQL Server Database	2.891.776 KB
...	...	...	...
A base aumentou o arquivo de log. O motivo é que os arquivos de log são utilizados na criação de índices, principalmente porque a base de dados já tem muitos dados. Antes de seguirmos com as melhorias da nossa consulta, vamos fazer uma limpeza nessa base para não sermos surpreendidos por falta de espaço.

Lembrando que, na aula 2, passamos por um vídeo específico sobre o tamanho da base, onde fizemos download do script SQLQUERY16.sql-D...B_VENDAS (sa 53))*, responsável pela limpeza da base.

USE DB_VENDAS
ALTER DATABASE DB_VENDAS SET RECOVERY SIMPLE
DBBC SHRINKDATABASE ('DB_VENDAS', NOTRUNCATE)
DBCC SHRINKDATABASE ('DB_VENDAS', TRUNCATEONLY)
ALTER DA DATABASE DB_VENDAS SET RECOVERY FULL
Copiar código
Retornando à página da base dados, é possível conferir que esta base está com um arquivo de log de 2.8 GB. Se executarmos o comando anterior, ele vai limpar o arquivo de log. Executá-lo não melhora ou piora a performance, mas deixa a base mais enxuta.

Terminada a execução, notaremos que o arquivo de log caiu de 2.8 GB para 8 MB.

Nome	Data de modificação	Tipo	Tamanho
DB_VENDAS.mdf	22/03/2023 23:53	SQL Server Database	5.270,976 KB
DB_VENDAS_log.Idf	22/03/2023 23:56	SQL Server Database	8.192 KB
...	...	...	...
Vamos seguir! Será que o índice abaixo melhorou a nossa consulta?

CREATE NONCLUSTERED INDEX idx_tb_item_codigo_produto ON tb_item (codigo_produto)
INCLUDE (numero, quantidade, preco);
Copiar código
Vamos executar uma nova consulta, com mês de abril, "4" e estado de Minas Gerais, "MG".

DECLARE @ESTE_MES INT DECLARE @ESTADP VARCHAR(2)
SET @ESTE_MES = 4
SET @ESTADO = 'MG'
SELECT VENDAS.classificacao AS CLASSIFICACAO,
       ROUND(VENDAS.VALOR_MES, 2) AS VALOR,
             ROUND(VENDAS.VALOR_MES/ TOTAL.VALOR_TOTAL) * 100, 2) AS PERCENTUAL

// código omitido 
Copiar código
Verificaremos o tempo e o custo da consulta.

     AND MONTH(tb_nota.data) * @ESTE_MES
       AND tb_estado.sigla_estado * @ESTADO
   GROUP BY tb_classificacao.classificacao) VENDAS
ORDER BY (VENDAS.VALOR_MES/TOTAL.VALOR_TOTAL) * 100 DESC

-- 17 segundos (512,844)

CREATE NONCLUSTERED INDEX idx_tb_item_codigo_produto ON tb_item (codigo_produto)
INCLUDE (numero, quantidade, preco);
Copiar código
O tempo da consulta caiu para 6 segundos. Isso não quer dizer que a consulta já está com uma boa execução, porque se executarmos várias vezes o processamento, podemos obter resultado de tempo diferente. O importante é observarmos o tamanho do custo de resolução da consulta.

Voltando ao plano de execução e selecionado "SELECT Custo: 0", perceberemos que o custo da subárvore ficou em 512,884. Na verdade, não teve ganho nenhum. O tempo caiu para 6 segundos, mas o custo continua em 512,844.

     AND MONTH(tb_nota.data) * @ESTE_MES
       AND tb_estado.sigla_estado * @ESTADO
   GROUP BY tb_classificacao.classificacao) VENDAS
ORDER BY (VENDAS.VALOR_MES/TOTAL.VALOR_TOTAL) * 100 DESC

-- 17 segundos (512,844)

CREATE NONCLUSTERED INDEX idx_tb_item_codigo_produto ON tb_item (codigo_produto)
INCLUDE (numero, quantidade, preco);

-- 6 segundos
Copiar código
Parece que esse índice não melhorou muito a resolução da nossa consulta, mas o plano de execução está sugerindo a criação de outro índice (mesmo com um índice criado), agora pelo campo número, incluindo a quantidade e preço do campo.

CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]

ON [dbo].[tb item]([numero])

INCLUDE([quantidade],[preco])

Vamos criar esse segundo índice. Vou aproveitar o comando construído anteriormente. Ao invés de gerar o índice pelo código do produto, usaremos o campo número.

CREATE NONCLUSTERED INDEX idx_tb_item_numero ON tb_item (numero)
INCLUDE (quantidade, preco);
Copiar código
Executaremos o índice, a limpeza da base e conferiremos o resultado logo mais.

USE DB_VENDAS
ALTER DATABASE DB_VENDAS SET RECOVERY SIMPLE
DBBC SHRINKDATABASE ('DB_VENDAS', NOTRUNCATE)
DBCC SHRINKDATABASE ('DB_VENDAS', TRUNCATEONLY)
ALTER DA DATABASE DB_VENDAS SET RECOVERY FULL
Copiar código
O segundo índice foi criado! No meu caso, o processo levou 3 minutos e 40 segundos. Um detalhe importante é a base aumentou.

Nome	Data de modificação	Tipo	Tamanho
DB_VENDAS.mdf	22/03/2023 00:18	SQL Server Database	7.678.144 KB
DB_VENDAS_log.Idf	22/03/2023 00:18	SQL Server Database	8.192 KB
...	...	...	...
Agora ela está em 7.6 GB. O arquivo de log está pequeno, porque rodamos o script de limpeza de log, mas para a base, não podemos fazer nada.

Lembrando que, na aula passada, aprendemos que o índice é uma tabela auxiliar, composta pelos campos "critério do índice" ordenado de forma crescente, para facilitar a busca e "endereço do segmento de memória", onde a linha do campo está situada no disco. É como se estivéssemos criando outra tabela com dados na base, por isso ela cresce.

Mas vamos entender o impacto disso na consulta. Podemos selecionar outro mês, outro estado e rodar a consulta com o plano de execução selecionado.

DECLARE @ESTE_MES INT DECLARE @ESTADP VARCHAR(2)
SET @ESTE_MES = 7
SET @ESTADO = 'RS'
SELECT VENDAS.classificacao AS CLASSIFICACAO,
       ROUND(VENDAS.VALOR_MES, 2) AS VALOR,
             ROUND(VENDAS.VALOR_MES/ TOTAL.VALOR_TOTAL) * 100, 2) AS PERCENTUAL

// código omitido 
Copiar código
Nosso interesse é no custo e não no tempo. Mesmo assim, é interessante observar que agora ele rodou em 4 segundos. O custo do plano de execução caiu para 297,004.

Obtivemos um ganho no custo, que foi de 512.884 para 297.004. Mas, ainda podemos melhorar essa consulta. No próximo vídeo vamos discutir o que podemos fazer para que a consulta fique ainda mais rápida.

----------------------------------------------------

Analisando o Plano de execução após a criação dos dois índices sugeridos pelo próprio plano, perceberemos, primeiro, que não há mais nenhuma indicação de criação de índices.

Além disso, nota-se que, ao invés de utilizar a Table Scan, ele preferiu usar a busca do dado pelo índice, Index Seek.

Index Seek (NonClustered)
[tb_itew].[idx th_item_numero]
Custo: 8 %
0.043s [
485400 de
263324 (184%)
Copiar código
No entanto, ele ainda usa bastante o Table Scan. Podemos melhorar a resolução dessas consultas.

Analisando as tabelas da base de DB_VENDAS, percebemos que nenhuma tabela possui chave primária.

Colunas
cidade
sigla_estado
Chaves primárias são campos que não podem se repetir. Elas são importantes para a manutenção da integridade da base.

É comum encontrarmos bases de dados, mesmo nos bancos relacionais, que não possuem chaves primárias nem estrangeiras, pois a integridade é garantida pela aplicação e não pela base. Porém, isso pode gerar problemas de performance.

A criação da chave primária favorece a performance, porque gera uma restrição que impede a repetição de determinado valor da tabela. Além disso, internamente, o SQL cria um índice único (unique index) para o campo.

Na aula passada, aprendemos que quando temos um índice único, o plano de execução preferencialmente usa esse índice, independentemente dos campos selecionados na cláusula select.

Sendo assim, vamos criar chaves primárias para todas as tabelas da base, comparar o tempo e conferir se isso trará algum ganho. Começando pela tabela de cidades.

Tendo em vista os dois campos presentes, podemos considerar a cidade como candidata a chave primária, já que não podemos ter duas linhas na tabela com a mesma cidade.

Para criar essa chave primária, é necessário alterar a tabela. Utilizaremos o comando ALTER TABLE na tabela de cidades, seguido de ADD CONSTRAINT (adicionar uma restrição). A restrição será nomeada como pk_cidades, isto é, "PK" seguido do nome da tabela, pois a chave primária deve ser única.

O tipo de restrição será PRIMARY KEY. Entre parênteses, passaremos o campo que fará parte do critério da chave primária: cidade.

ALTER TABLE tb_cidade ADD CONSTRAINT pk_tb_cidade PRIMARY KEY (cidade);
Copiar código
Comando concluído com êxito.

O comando foi executado. Vamos selecionar a tabela de cidade, dbo.tb_cidade, com o botão direito do mouse e apertar "Atualizar". Agora a tabela de cidades possui uma chave primária.

Vamos para a tabela classificação. O campo que seria candidato a chave primária para essa tabela é codigo_classificacao. O nome da tabela será classificacao. A CONSTRAINT será tb_classificacao e como campo de critério teremos codigo_classificacao.

ALTER TABLE tb_cidade ADD CONSTRAINT pk_tb_cidade PRIMARY KEY (cidade);
ALTER TABLE tb_classificacao ADD CONSTRAINT pk_tb_classificacao PRIMARY KEY (codigo_classificacao);
Copiar código
Comandos concluidos com êxito

Já criamos duas chaves primárias em duas tabelas diferentes. Atualizando as tabelas, poderemos conferir as chaves primárias. A base de dados ainda não aumentou significativamente, mas isso pode ocorrer quando criarmos chaves primárias nas tabelas maiores. Nestes casos, é sempre recomendável executar o script para limpar o arquivo de log.

Vamos então para a tabela de clientes, cujo candidato a chave primária é o CPF, já que não podemos ter dois clientes com o mesmo CPF.

ALTER TABLE tb_cidade ADD CONSTRAINT pk_tb_cidade PRIMARY KEY (cidade);
ALTER TABLE tb_classificacao ADD CONSTRAINT pk_tb_classificacao PRIMARY KEY (codigo_classificacao);
ALTER TABLE tb_cliente ADD CONSTRAINT pk_tb_cliente PRIMARY KEY (cpf);
Copiar código
Comandos concluidos com êxito.

A tabela de clientes é grande, composta por muitas linhas, mesmo assim, foi gerada em quatro segundos. O tamanho da base subiu um pouco, mas ainda não é necessário executar o script para limpar o arquivo de log.

Por fim, vamos criar a chave primária para a tabela de estados. O campo candidato é sigla_estado, que é o que identifica um estado geográfico.

ALTER TABLE tb_cidade ADD CONSTRAINT pk_tb_cidade PRIMARY KEY (cidade);
ALTER TABLE tb_classificacao ADD CONSTRAINT pk_tb_classificacao PRIMARY KEY (codigo_classificacao);
ALTER TABLE tb_estado ADD CONSTRAINT pk_tb_estado PRIMARY KEY (sigla_estado);
Copiar código
Comandos concluidos com êxito.

Nós pularemos a tabela de itens e vamos para a tabela loja, cuja identificação é o código da loja, codigo_loja.

ALTER TABLE tb_cidade ADD CONSTRAINT pk_tb_cidade PRIMARY KEY (cidade);
ALTER TABLE tb_classificacao ADD CONSTRAINT pk_tb_classificacao PRIMARY KEY (codigo_classificacao);
ALTER TABLE tb_loja ADD CONSTRAINT pk_tb_loja PRIMARY KEY (codigo_loja);
Copiar código
Também vamos pular a tabela de notas e vamos para tb_produto. O campo candidato, neste caso, é codigo_produto.

ALTER TABLE tb_cidade ADD CONSTRAINT pk_tb_cidade PRIMARY KEY (cidade);
ALTER TABLE tb_classificacao ADD CONSTRAINT pk_tb_classificacao PRIMARY KEY (codigo_classificacao);
ALTER TABLE tb_loja ADD CONSTRAINT pk_tb_loja PRIMARY KEY (codigo_loja);
ALTER TABLE tb_produto ADD CONSTRAINT pk_tb_produto PRIMARY KEY (codigo_produto);Copiar código
Comandos concluidos com êxito.

Temos a chave primária para todas as tabelas.

Pulamos as tabelas de nota e item e o motivo é que teremos uma atividade de desafio após este vídeo.

Desafio: criar a chave primária para as tabelas de nota e de item. Não se esqueçam de observar os campos e sugerir os campos candidatos a chave primária, considerando que a tabela tb_nota tem o cabeçalho da nota e, na tabela de itens, cada nota pode ter vários itens/produtos vendidos.

Com essas informações, você está pronto para o desafio. Lembre-se de criar as chaves primárias para as duas tabelas. No próximo vídeo, vamos conferir o resultado e possíveis ganhos.

-------------------------------------------------

No vídeo anterior, criamos as chaves primárias para cada uma das tabelas cadastrais do supermercado BitByte. Essa etapa é importante porque a criação da chave primária gera automaticamente a construção de um índice único. Esse índice pode ser utilizado pelos planos de execução para fazer buscas de forma mais eficiente, evitando o uso do SCAN e dando preferência ao SEEK. Isso significa que as consultas serão executadas de forma mais rápida e com menor consumo de recursos do sistema. Por isso, é fundamental definir as chaves primárias corretamente e entender como elas impactam no desempenho das consultas.

Agora, é necessário que você crie as chaves primárias para as tabelas de notas fiscais e itens de notas fiscais. É importante identificar quais consultas serão candidatas a chaves primárias, e em seguida, criá-las utilizando os mesmos comandos apresentados no vídeo. Assim, será possível otimizar as consultas e evitar a busca por toda a tabela, dando preferência ao uso do índice.

----------------------------------------------------

Pronto! Executamos a criação de mais duas chaves primárias, uma para a tabela tb_nota e outra para a tabela tb_item.

ALTER TABLE tb_classificacao ADD CONSTRAINT pk_tb_classificacao PRIMARY KEY (codigo_classificaco);
ALTER TABLE tb_cliente ADD CONSTRAINT pk_tb_cliente PRIMARY KEY (cpf);
ALTER TABLE tb_estado ADD CONSTRAINT pk_tb_estado PRIMARY KEY (sigla estado);
ALTER TABLE tb_loja ADD CONSTRAINT pk_tb_loja PRIMARY KEY (codigo_loja);
ALTER TABLE tb_produto ADD CONSTRAINT pk_tb_produto PRIMARY KEY (codige_produto);

ALTER TABLE tb_nota ADD CONSTRAINT pk_tb_nota PRIMARY KEY (numero);
ALTER TABLE tb_item ADD CONSTRAINT pk_tb_item PRIMARY KEY (numero, codigo_produto);
Copiar código
O campo candidato para a chave primária da tabela tb_nota foi o campo numero, afinal, não podemos ter mais de uma nota fiscal com o mesmo número.

ALTER TABLE tb_nota ADD CONSTRAINT pk_tb_nota PRIMARY KEY (numero);
Copiar código
No caso da tabela tb_item, o candidato foi uma chave composta, afinal, não podemos ter mais de um item com o mesmo número e mesmo código do produto em notas fiscais. Por isso, neste caso a chave primária é composta.

ALTER TABLE tb_item ADD CONSTRAINT pk_tb_item PRIMARY KEY (numero, codigo_produto);
Copiar código
Vamos avaliar o ganho da nossa consulta após termos criado todas as chaves primárias. Novamente, vamos selecionar a consulta e executar.

Lembre-se de verificar a base de dados, DB_VENDAS, e selecionar o plano de execução.

Minha execução durou um segundo. Podemos anotar esse valor da duração.

 ALTER TABLE tb_classificacao ADD CONSTRAINT pk_tb_classificacao PRIMARY KEY (codigo_classificaco);
ALTER TABLE tb_cliente ADD CONSTRAINT pk_tb_cliente PRIMARY KEY (cpf);
ALTER TABLE tb_estado ADD CONSTRAINT pk_tb_estado PRIMARY KEY (sigla estado);
ALTER TABLE tb_loja ADD CONSTRAINT pk_tb_loja PRIMARY KEY (codigo_loja);
ALTER TABLE tb_produto ADD CONSTRAINT pk_tb_produto PRIMARY KEY (codige_produto);

ALTER TABLE tb_nota ADD CONSTRAINT pk_tb_nota PRIMARY KEY (numero);
ALTER TABLE tb_item ADD CONSTRAINT pk_tb_item PRIMARY KEY (numero, codigo_produto);

-- 1 segundo
Copiar código
Qual foi o custo da consulta? Acessando o "Plano de execução" e selecionando "SELECT Custo: 0", é possível conferir que o custo estimado da subárvore caiu para 74,21.

Analisando o plano de execução, é possível notar que em grande parte das tabelas, no momento das buscas, ele utilizou índice ao invés do scan. Por exemplo, na tabela de cidade, tb_cidade, ele usou um índice clusterizado, o sacn e o índice relacionado com a PK da tabela de cidade, pk_tb_cidade.

Clustered Index Scan (Clustered)
   [tb_cidade].[pk_tb_cidade]
            Custo: 0 %
                      0.00s
                      33 de
                        5 (660%)
Copiar código
Se observarmos outras tabelas, por exemplo, a tabela de estado, notaremos que ele também usou o SeeK com o índice clusterizado e a chave primária da tabela de estado.

Busca de Indice Clusterizado (Clust...
     [tb_estado].[pk_tb_estado]
                Custo: 0 %
                          0.000s
                           1 de
                        1 (100%)
Copiar código
Há outro caso também com a chave primária da tabela de nota.

Clustered Index Scan (Clustered)
     [tb_nota].[pk_tb_nota]
               Custo: 9 %
                      0.118s
                     183779 de 
                     153624 (119%)
Copiar código
Por isso ficou mais rápido.

E qual foi o nosso ganho total? Considerando as anotações do antes e depois da criação dos índices, fomos de 17 segundos com um custo de 512,84 para 1 segundo com um custo de 74,21.

-- 1 segundo (74,21)
-- 17 segundos (512,844)
Copiar código
Ou seja, obtivemos um grande ganho na performance da consulta. O plano de execução até sugere criamos novos índices após a criação das chaves primárias. Porém, não faremos isso, porque já chegamos a 1 segundo. É pouco produtivo começar a criar mais índices para ter ganhos irrisórios.

---------------------------------------------

No vídeo anterior, pudemos observar que a criação de chaves primárias no banco de dados relacional gerou índices que foram capazes de melhorar significativamente a performance das consultas realizadas. No entanto, vale ressaltar que os bancos de dados relacionais também possuem chaves estrangeiras que estabelecem relações entre as tabelas. Quando essas chaves estrangeiras são criadas, elas também geram índices que podem ajudar a aprimorar a performance do banco de dados. Isso ocorre porque as chaves estrangeiras permitem que as tabelas sejam relacionadas de forma mais eficiente, tornando as consultas mais rápidas e precisas. Assim, a criação de chaves estrangeiras é uma prática importante a ser considerada para otimizar o desempenho do banco de dados relacional.

-----------------------------------------------

===========RESUMO DO CURSO===============

Performance
Estudo de caso - Supermercados Bitbyte.
Começamos recuperando a nossa base de dados, a que foi usada nos exercícios práticos do curso. Para usá-la, tivemos que entender o funcionamento do nosso estudo de caso: o supermercado BitByte.

Notamos que as tabelas das bases de dados eram muito grandes. Além disso, havia um relatório de determinado usuário que estava demorando muito para ser gerado. Portanto, nossa função inicial foi melhorar o desempenho desse relatório.

Aspectos sobre performance.
Antes de atuar sobre esse relatório, foi necessário entender melhor o que é performance. Isto é, o que pode prejudicar a performance de um ambiente de um banco de dados.

Muitas das razões que prejudicam a performance não são de influência do DBA. Ou seja, o DBA não pode resolvê-las. Por exemplo: um hardware mal dimensionado, por estar processando muito a CPU; pouca memória RAM; o espaço em disco não é suficiente para que o banco possa crescer.

Tudo isso prejudica a performance. E o DBA, nesses casos, não tem muito o que fazer, além de informar esse mau dimensionamento para os departamentos responsáveis pela infraestrutura da empresa.

Em alguns outros aspectos, por exemplo, parametrização do servidor, gerenciamento do crescimento da base de dados e cuidado com a estrutura das consultas, o DBA pode atuar.

Active monitor.
Independentemente da razão pela qual o ambiente do banco de dados está com a sua performance comprometida, é necessário que o DBA tenha instrumentos para monitorar o ambiente. Para isso está à disposição o Active Monitor.

Durante o curso, aprendemos a acessar essa ferramenta, a acompanhar o desempenho dos principais indicadores que medem a performance do ambiente, como o consumo de CPU, tempo de espera, entrada e saída, dentre outros indicadores importantes.

Quando abordamos o Active Monitor, simulamos cenários de alto processamento que acabavam repercutindo numa maior utilização dos recursos, prejudicando o ambiente do banco de dados.

Tudo isso permite determinarmos um nível de consumo padrão do servidor. Isso porque conhecer como esses recursos são consumidos e qual é a sua sazonalidade de consumo ao longo do tempo é fundamental para que o DBA detecte anomalias e possa se antecipar aos problemas de performance que podem ocorrer.

SQL Profiler
No processo de identificação das anomalias, conhecemos outra ferramenta: o SQL Server Profiler. Nele, é possível verificar tudo que chega ao servidor, todos os comandos de SQL que são executados. Também conseguimos coletar algumas estatísticas referentes a esses processamentos.

Por exemplo: tempo de resposta; entrada e saída; linhas manipuladas; dentre outros indicadores. Diferentemente do Active Monitor, aqui pensamos nos indicadores específicos para cada comando. Chamamos isso de traces.

Os traces gerados no SQL Profiler podem ser salvos em arquivos para análises e comparações com traces coletados em dias diferentes. Inclusive, aprendemos que também é possível executar traces via comandos de TSQL. Logo, podemos fazer um script e agendar execuções periódicas.

Planos de execução.
Quando o profile apresenta as consultas problemáticas, podemos estudar o plano de execução de cada uma dessas consultas. Ele é o caminho que o SQL Server faz para apresentar o resultado final de uma consulta.

O SQL Server resolve a consulta através da execução que chamamos de operadores. Esses operadores possuem estatísticas em cada passo do plano. Cada operador executado tem estatísticas, por exemplo: linhas processadas; o custo da execução do passo; dentre outros.

Aprendemos a visualizar o plano de execução de uma consulta e as estatísticas de cada operador.

Índices.
Dois dos operadores mais utilizados nos planos de execução são o Seek e o Scan.

O Scan é mais lento, porque, quando é usado para encontrar algo em uma tabela, procura esse elemento percorrendo toda a tabela do início ao fim até encontrar as linhas que satisfaçam a condição de busca.

Já o Seek, não. Ele utiliza uma estrutura auxiliar chamada índice para realizar buscas mais eficientes que o Scan. Para transformar um plano de execução de Scan para Seek, temos que criar índices.

Existem muitos tipos de índices. Neste curso, estudamos os clusterizados, os não clusterizados e os índices únicos. A depender do tipo de índice usado e como está sendo construída a consulta — ou seja, quem está no filtro e quem está no Select — o plano de execução escolherá o Scan ou encontrará um índice específico para usar o Seek.

Utilizar uma consulta é fazer com que os planos de execução executem mais Seeks em detrimento aos Scans.

Também conhecemos mais a fundo como funciona o algoritmo de busca do índice, o B-tree, e por que ele é muito mais eficiente do que realizar uma busca procurando determinado filtro na tabela completa.

Caso prático.
Finalmente, voltamos ao relatório apresentado no início do curso. Efetuamos o plano de execução do relatório. O próprio plano sugeriu a criação de alguns índices. Criamos esses índices e percebemos uma melhora significativa no resultado do plano de execução, mas ainda não era o ideal.

Então, geramos as chaves primárias e as chaves estrangeiras da base de dados. Isso porque sempre que criamos uma chave primária ou uma chave estrangeira, por detrás dessas estruturas também são criados os índices.

Ao criar os índices sugeridos das chaves primárias e das chaves estrangeiras, notamos um ganho significativo na consulta do usuário com problemas de performance.

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