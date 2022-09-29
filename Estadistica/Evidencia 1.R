### VENTAS EN MXN

ventas <- sort(c(21348,42231,29156,19480,40250,20815,31028,38429,36912,20652,20351,43572,34335,42119,21699,42349,42737,42087,33731,29581,42537,21051,27755,24035,44654,20460,40204,28718,42692,28078,32915,39879,28797,34826,38868,29758,37772,22541,30974,18247,42897,24009,31173,25944,29421,42482,28028,35760,27677,19524,36279,35425,24346,43044,35652,40108,34209,19446,44341,19286,19369,36718,22520,33832,17599,18632,42345,35229,33270,35019,23477,27558,39112,36211,40489,19839,22661,20549,42795,31595,38681,24090,42854,33854,41543,39543,29262,20256,38708,39746))

#Tipo de variable y tamaño de muestra
class(ventas)
length(ventas)
summary(ventas)
#Medidas descriptivas: calcule el valor del rango, media, mínimo, máximo, varianza, coeficientes de variación. 

mínimo <- min(ventas)
máximo <- max(ventas)
rango <- max(ventas) - min(ventas) 
media <- round(mean(ventas), digits = 4)
varianza <- round(var(ventas, na.rm=TRUE), digits = 4)
desviacion <- sd(ventas)
coeficientes_variacion <- media/desviacion

#Métodos gráficos:  Realice la tabla de frecuencias y el histograma correspondiente  
table(ventas)
prop.table(ventas)
hist(ventas)
hist
rango
n <- length(ventas)
k <- round(1 + 3.322*log10(n), digits = 0)
a <- rango/k
excel

#Calcule cuartiles y realice el boxplot correspondiente, comente sobre la simetría de la distribución de los datos 
library(ggplot2)

cuartiles <- quantile(ventas)
boxplot(ventas)
ventas <- as.data.frame(ventas)
ggplot(data = ventas, mapping = aes(y=ventas)) + geom_boxplot(outlier.colour="pink")
