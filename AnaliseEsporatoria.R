#### bibliotecas ####
library(readxl)
library(naniar)
library(ggplot2)
library(dplyr)
#### base ####

base = read_xlsx("Base_trabalho.xlsx")

#### tratamento de dados ####

base$filhos = as.factor(base$filhos)
base$sexo = as.factor(base$sexo)
base$escolaridade = as.factor(base$escolaridade)
base$casado = as.factor(base$casado)

vis_miss(base)


base %>% 
  ggplot(mapping = aes(x = idade))+
  geom_histogram(breaks = c(10,20,30,40,50,60,70,80,90,100), fill = "red",color = "white")
  
                 