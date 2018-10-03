caixeiro <- function(datasetX, datassetJ) {
  distancias = calcularPesos(datasetX, datassetJ)
  
  populacao<-list()
  pesosCaminho<-c()
  #Gerando os 50 caminhos para população inicial e calculando o peso de cada 1
  for(i in 1:50){
    caminho<-c()
    
    cidadesE <- 2:100
    caminho = sample(cidadesE, replace = FALSE)
    caminho[100] = 1
    
    populacao[[i]] = caminho
    pesosCaminho[i] = calcularPesosCaminho(caminho, distancias)
  }
  
  menoresCaminhos<-list()
  pesosMenoresCaminhos<-c()
  for(k in 1:1000) {
    #Gardando o peso e o menor caminho para população atual
    pesosMenoresCaminhos[k] = min(pesosCaminho)
    w = 1
    indiceMenor = 0
    while(w <= 50) {
      if(identical(pesosCaminho[w], min(pesosCaminho))) {
        indiceMenor = w
        w = 51
      }
      w = w + 1
    }
    menoresCaminhos[[k]] = populacao[[indiceMenor]]
  
    #Chama a função para calcular as aptidoes de cada caminho da população
    aptidoes = calcularAptidao(pesosCaminho)
    
    #Chama a função para gerar a roleta
    roleta = calcularRoleta(aptidoes)
    
    #Gerando nova população "com os elementos mais aptos" atrvés da roleta
    populacaoApta<-list()
    pesosCaminhoApto<-c()
    for(i in 1:50) {
      randon = runif(1)
      for(j in 1:50) {
        if(randon >= roleta[j] &&  randon <= roleta[j + 1]) {
          populacaoApta[[i]] = populacao[[j]]
          pesosCaminhoApto[i] = pesosCaminho[j]
        }
      }
      j = 1
    }
    
    #Gerando os pares aleatoreamente
    pares <- 1:50
    pares = sample(pares, replace = FALSE)
    
    populacaoDescendente<-list()
    pesosCaminhoDescendente<-c()
    
    #fazendo o cruzamento de 2 em 2
    i = 1
    while(i <= 49) {
      #Definindo os pontos de corte
      corte1 = sample(1:49, 1)
      corte2 = sample(1:49, 1)
      
      #Checando se o corte1 é maior que o corte dois, se for inverte
      if (corte1 > corte2) {
        aux = corte1
        corte1 = corte2
        corte2 = aux
      }
      
      #Busca o par dentro da população que vai se reproduzir
      pai = populacaoApta[[pares[i]]]
      mae = populacaoApta[[pares[i + 1]]]
      
      #Inicializando os filhos
      filho1<-c()
      filho2<-c()
      
      #Manter o controle dos intervalos exatos
      controle1<-seq(0,0, len=100)
      controle2<-seq(0,0, len=100)
      
      j = corte1 + 1
      while(j <= corte2) {
        filho1[j] = pai[j]  #Filho1 é inicializado como pai
        filho2[j] = mae[j]  #Filho2 é inicializado como mãe
        controle1[pai[j]] = 1
        controle2[mae[j]] = 1
        j = j + 1
      }
      
      #Copiando sequencialmente os genomas restantes para filho1
      x = 1
      index = 1
      while (x <= 100 && index <= 100) {
        if (controle1[mae[x]] != 1) {
          filho1[index] = mae[x]
          index = index + 1
        }
        
        if (index == corte1 + 1) {
          index = corte2 + 1
        }
        
        x = x + 1
      }
      
      #Copiando sequencialmente os genomas restantes para filho2
      x = 1
      index = 1
      while (x <= 100 && index <= 100) {
        if (controle2[pai[x]] != 1) {
          filho2[index] = pai[x]
          index = index + 1
        }
        if (index == corte1 + 1) {
          index = corte2 + 1
        }
        
        x = x + 1
      }
      
      #Verificando se existira mutação
      y = 1
      for(y in y:2) {
        randon = runif(1)
        
        if (randon <= 0.05) {
          p1 = sample(1:100, 1)
          p2 = sample(1:100, 1)
          
          if (y == 1) {
            aux = filho1[p1]
            filho1[p1] = filho1[p2]
            filho1[p2] = aux
          }
          else {
            aux = filho2[p1]
            filho2[p1] = filho2[p2]
            filho2[p2] = aux
          }
        }
      }
      
      populacaoDescendente[[i]] = filho1
      pesosCaminhoDescendente[i] = calcularPesosCaminho(filho1, distancias)
      
      populacaoDescendente[[i + 1]] = filho2
      pesosCaminhoDescendente[i + 1] = calcularPesosCaminho(filho2, distancias)
      
      i = i + 2
      
      #ret = list()
      #ret$pai = pai
      #ret$mae = mae
      #ret$filho1 = filho1
      #ret$filho2 = filho2
      #ret$controle1 = controle1
      #ret$controle2 = controle2
      #ret$corte1 = corte1
      #ret$corte2 = corte2
      
      #return(ret)
    }
    
    populacao = populacaoDescendente
    pesosCaminho = pesosCaminhoDescendente
  }
  
  #Verificando qual o melhor caminho gerado após as 1000 rodadas
  pesoMenorCaminhoGeral = min(pesosMenoresCaminhos)
  w = 1
  indiceMenorCaminhoGeral = 0
  while(w <= 1000) {
    if(identical(pesosMenoresCaminhos[w], min(pesosMenoresCaminhos))) {
      indiceMenorCaminhoGeral = w
      w = 1001
    }
    w = w + 1
  }
  
  ret = list()
  ret$menoresCaminhos = menoresCaminhos
  ret$pesosMenoresCaminhos = pesosMenoresCaminhos
  
  ret$menorCaminhoGeral = menoresCaminhos[[indiceMenorCaminhoGeral]]
  ret$pesoMenorCaminhoGeral = pesoMenorCaminhoGeral
  
  ret$primeiroCaminho = menoresCaminhos[[1]]
  ret$pesoPrimeiroCaminho = pesosMenoresCaminhos[1]
  
  ret$ultimoCaminho = menoresCaminhos[[1000]]
  ret$pesoUltimoCaminho = pesosMenoresCaminhos[1000]
  
  return (ret)
}

#Função para gerar um array que simula uma roleta
calcularRoleta <- function(aptidoes) {
  roleta<-c()
  roleta[1] = 0
  j = 2
  for(i in 1:50) {
    roleta[j] = roleta[i] + aptidoes[i]
    j = j + 1
  }
  
  return(roleta)
}

#Função para calcular aptidoes dos caminhos da população
calcularAptidao <- function(pesosCaminho) {
  aptidoes<-c()
  somatorioPesos = 0
  
  for(i in 1:50) {
    somatorioPesos = somatorioPesos + (pesosCaminho[i])^(-1)
  }
  
  for(i in 1:50) {
    aptidoes[i] = (pesosCaminho[i])^(-1) / somatorioPesos
  }
  
  return(aptidoes)
}

#Função para calcular o pesos de um caminho
calcularPesosCaminho <- function(caminho, distancias) {
  peso = 0
  for(i in 1:99) {
    if (i == 1)
      peso = peso + distancias$pesos[[1]][caminho[i]] + distancias$pesos[[caminho[i]]][caminho[i + 1]]
    else
      peso = peso + distancias$pesos[[caminho[i]]][caminho[i + 1]]
  }
  
  return(peso)
}

#Função que calcula as distancias de cada cidade para todas as outras
#Exemplo de acesso, distancia da cidade 1 p cidade 43 = result$pesos[[1]][43]
calcularPesos <- function(datasetX, datassetJ) {
  pesos<-list()
  cidades<-c()
  
  for (i in 1: nrow(datasetX)) {
    pesosCidade<-c()
    for (j in 1: nrow(datasetX)) {
      peso = sqrt((datasetX[i,] - datasetX[j,])^2 + (datassetJ[i,] - datassetJ[j,])^2)
      pesosCidade[j] = peso
    }
    j=1
    pesos[[i]] = pesosCidade
    cidades[i] = i
  }
  
  #Retornando uma lista com os pesos
  ret = list()
  ret$pesos = pesos
  ret$cidades = cidades
  
  return (ret)
}