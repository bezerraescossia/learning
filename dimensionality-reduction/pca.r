'''
MBA Business Analytics e Big Data - Métodos Matriciais e Análise de Clusters

Aula 1 - Análise Fatorial Exploratória

autor: Prof. Mateus Ponchio
editado por @bzesc
'''
# Vamos começar importando a base de dados dataset_AVALIACOES.xlsx, disponível no ECLASS.
data(iris)
head(iris)
dados = subset(iris, select = -c(Species))
View(dados)

matriz_correl <- cor(dados)

'''
Teste de esfericidade de Bartlett: Testa a hipótese de que as correlações entre 
as variáveis são maiores do que seria esperado pelo acaso: Tecnicamente, testa 
se a matriz de correlações é uma matriz identidade. O valor-p deve ser significante: 
ou seja, a hipótese nula de que todas as correlações fora da diagonal principal são 
iguais a zero é rejeitada.
'''

library(psych)
cortest.bartlett(matriz_correl, n = 30, diag=TRUE)

'''
Uma vez que o teste de correlação de Barlett apresentou um p-valor < 0.05
rejeitamos a hipótese de que a matriz de correlação é ortogonal, em outras
palavras, rejeitamos a hipótese de que as correlações são obras do acaso.
E, podemos continuar com a análise de PCA.

Mas, como determinamos o número de fatores a extrair? Iniciamos calculando
todos os PCAs, ou seja, todos os fatores.
'''

modelo <- psych::principal(dados, nfactors = 4, rotate = "none")
print(modelo, digits = 3)

scree(dados, pc=TRUE, factors=FALSE)

'''
os dados nos mostra que o PC1 possui 73% da variabilidade e PC2 22,9% que somando
da 95,9%. Indicando que os dos componentes explicam a maior parte da variabilidade
dos dados. Portanto, vamos utilizar apenas 2 componentes
'''

modelo2 <- psych::principal(dados, nfactors = 2, rotate = "none")
print(modelo2, digits=3)

# Solução rotacionando os fatores...

modelo2rot <- psych::principal(dados, nfactors = 2, rotate = "varimax", scores = TRUE)
print(modelo2rot, digits=3, sort = TRUE)

print(modelo2rot$scores)

plot(modelo2rot$scores[,1], modelo2rot$scores[,2], main="Mapa Perceptual", xlab="PC 1", ylab="PC 2")
abline(a=0, b=0)
abline(v=0)

iris$RC1 <- modelo2rot$scores[,1]
iris$RC2 <- modelo2rot$scores[,2]

plot(iris$RC1, iris$RC2, main="Mapa Perceptual", xlab="PC 1", ylab="PC 2", 
     col = as.numeric(iris$Species), pch = 21, bg = as.numeric(iris$Species), cex = 2.5)
legend("topright", legend = unique(iris$Species),
       col = 1:length(unique(iris$Species)), 
       pch = 21, pt.bg = 1:length(unique(iris$Species)), pt.cex = 1.5)

'''
conseguimos facilmente identicar a separação entre a setosa
com as duas outras. Entretanto, ainda a versicolor e virginica
estão mescladas. Vamos tentar identificar outliers, remove-las
e normalizá-las.
'''





