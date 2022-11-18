rm(list = ls())
options(scipen = 99)
graphics.off()
cat("\014")

## Instalar paquete siebanxicor
install.packages("siebanxicor")

## Instalar libreria siebanxicor
library("siebanxicor")

## Especificar token
token_banxico <- "7c1723ed623ae40638973db4e8979a32b6f1cb2aba401c6000aa77da45a5f415"
setToken(token_banxico)


## Consulta de series
fecha <- c('2019-12-31', '2022-10-31')
Tipo_Cambio <- as.data.frame(getSeriesData(series = "SF43718", startDate = as.Date(fecha[1]), endDate = as.Date(fecha[2])))
colnames(Tipo_Cambio) <- c('Fecha','Tipo de cambio')     

## Realizar ejercicio
library(tidyverse)
boxplot(Tipo_Cambio$`Tipo de cambio`)
plot(Tipo_Cambio$Fecha, Tipo_Cambio$`Tipo de cambio`, type = "l")


