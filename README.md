<h1>Definição do Trabalho</h1>

Algoritmo Genético: Problema do Caixeiro Viajante 

- Descrição do Problema: 
O problema do caixeiro viajante (Travelling Salesman Problem – TSP) é de natureza combinatória e é uma referência para diversas aplicações, e.g., projeto de circuitos integrados, roteamento de veículos, programação de produção, robótica, etc. Em sua forma mais simples, no TSP o caixeiro deve visitar cada cidade somente uma vez e depois retornar a cidade de origem. Dado o custo da viagem (ou distância) entre cada uma das cidades, o problema do caixeiro é determinar qual o itinerário que possui o menor custo? Neste projeto, considere que o grafo (mapa) que representa as ligações entre as cidades é completo, ou seja, uma cidade se liga a todas as outras. Objetivo da Atividade.Esta atividade consiste em implementar um algoritmo genético para resolver o problema do caixeiro. As coordenadas das cidades serão passadas em separado pelo professor.

- Considerações
Deve-se calcular a distância Euclidiana entre uma cidade e todas as demais. 

As três representações mais utilizadas para o Problema do Caixeiro Viajante são: adjacency, ordinal e path. 

Order Operator (OX) 

Proposto por Davis. Constrói um descendente escolhendo uma subsequência de um tour de um pai e preservando a ordem relativa das cidades do outro pai. 
Exemplo: 

p1 = (1 2 3 | 4 5 6 7 | 8 9) 
p2 = (4 5 2 | 1 8 7 6 | 9 3) 
- mantém os segmentos selecionados 

o1 = (x x x | 4 5 6 7 | x x) 
o2 = (x x x | 1 8 7 6 | x x) 

A seguir, partindo do ponto do segundo corte de um dos pais, as cidades do outro pai são copiadas na mesma ordem, omitindo-se as cidades que estão entre os pontos de corte. Ao se atingir o final do vetor continua-se no início do mesmo.

o1 = (2 1 8 | 4 5 6 7 | 9 3) 
o2 = (3 4 5 | 18 7 6 | 9 2)

<h1> Instruções </h1>


                                        Disciplina: Inteligência Artificial
                                        Professor: Aragão Junior
                                        Equipe: 
                                        Reginaldo Maranhão
                                        Ruan Nícolas


Trabalho Algoritmo Genético – Caixeiro Viajante

1.	Requisitos: 
- Instalar o R-Studio
- Instalar o pacote: combinat

2.	Pseudo-Algoritmo: 
- Calcula a distância euclidiana
- Seleciona a população inicial
- * Roda a função objetiva (Calculo de aptidão)
- Monta a roleta
- Seleciona os 50 novos elementos da população com base na roleta
- Seleciona os pares
- Faz o crossover
- Verifica se existe mutação
- Altera a população e volta para o *

3.	O código é composto por 5 funções:
- Caixeiro: Função principal que chama as demais e onde foi implementada a rotina de cruzamento e mutação. Retorna uma lista com os seguintes resultados:

	* menoresCaminhos = Lista com os 1000 melhores caminhos gerados

	* pesosMenoresCaminhos = Lista com os pesos correspondentes a cada menor caminho

	* menorCaminhoGeral = Array com a sequência das cidades do menor caminho geral, dentre os 1000

	* pesoMenorCaminhoGeral = Peso do menor caminho geral

	* primeiroCaminho = Array com a sequência das cidades do primeiro  menor caminho.

	* pesoPrimeiroCaminho = Peso do primeiro menor caminho

	* ultimoCaminho = Array com a sequência das cidades do último  menor caminho.

	* pesoUltimoCaminho = Peso do primeiro menor caminho

- CalcularPesos: Função que recebe os dois datasets e calcula os pesos de cada cidade para todas as outras e retorna uma lista

- CalcularPesosCaminho : Calcula o peso de uma caminho(Array com uma sequencia de cidades)

- CalcularAptidao: Recebe os pesos dos caminhos de uma população e retorna um array com as aptidões de cada caminho.

- CalcularRoleta: Recebe as aptidões e retorna um array com a aptidão acumulada.

- OBS: 
	* As cidades foram representadas de 1 a 100 na ordem que foi sendo lido os arquivos com as coordenadas
	* Foi utilizado o algoritmo Order Operator para cruzamento
	* Taxa de 0.05 para mutação.

4.	Passo a passo:
- Carrega o arquivo com as funções: 

	* source("C:\\Caminho até o arquivo\\caixeiroViajanteAG.r")

- Carrega os arquivo de dados:

	* datasetX = read.table("C:\\Caminho até o arquivo\\ coordenadasx.dat")

	* datasetY = read.table("C:\\Caminho até o arquivo\\ coordenadasy.dat")

- Chama a função caixeiro e passa as variáveis onde carregou os dados por parâmetro:

	resultado = caixeiro(datasetX, datasetY)

	Um gráfico com o histórico dos pesos dos melhores caminhos pode ser plotado com o comando: plot(resultado$pesosMenoresCaminhos)
 
<img src="http://i65.tinypic.com/2w4xtv9.png"/>

	Para saber o caminho da rodada 1000: resultado$ultimoCaminho

	Para saber o peso da rodada 1000: resultado$pesoUltimoCaminho

	Para saber o menor caminho geral: resultado$menorCaminhoGeral

	Para saber o peso do menor caminho geral: resultado$pesoMenorCaminhoGeral


                                        #algoritmoGenetico #caixeiroViajante #algoritmos #ia 

