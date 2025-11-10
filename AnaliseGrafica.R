# ----------------------------------------------------
# Script 1: Análise Gráfica
# Disciplina: Prática Estatística 2
# ----------------------------------------------------

# 1. Carregar pacotes necessários

library(readxl)    # Para ler as planilhas em xlsx
library(dplyr)    # Para manipulação de dados
library(ggplot2)  # Para gráficos
library(naniar)   # Para análise de dados faltantes

# 2. Importar a base de dados

dados <- read_xlsx("Base_trabalho.xlsx")

dados <- dados %>%
  mutate(
    escolaridade = factor(escolaridade, 
                          levels = c(1, 2, 3), 
                          labels = c("Fundamental", "Médio", "Superior")),
    reincidente = factor(reincidente, 
                         levels = c(0, 1), 
                         labels = c("Não", "Sim")),
    filhos = factor(filhos, 
                    levels = c(0, 1), 
                    labels = c("Não", "Sim")),
    sexo = factor(sexo, 
                  levels = c(0, 1), 
                  labels = c("Feminino", "Masculino")),
    casado = factor(casado, 
                    levels = c(0, 1), 
                    labels = c("Não", "Sim"))
  )

print("--- Análise de Dados Faltantes ---")
gg_miss_var(dados)
ggsave("grafico_dados_faltantes.png") 


grafico_idade <- ggplot(dados, aes(x = idade)) +
  geom_histogram(binwidth = 5, fill = "blue", color = "black") +
  labs(title = "Histograma da Idade dos Detentos",
       x = "Idade (em anos)",
       y = "Frequência")

ggsave("histograma_idade.png", plot = grafico_idade)
print(grafico_idade)


grafico_tempo_preso <- ggplot(dados, aes(y = tempo_preso)) +
  geom_boxplot(fill = "orange") +
  labs(title = "Boxplot do Tempo de Prisão",
       y = "Tempo Preso (em meses)") +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) 

ggsave("boxplot_tempo_preso.png", plot = grafico_tempo_preso)
print(grafico_tempo_preso)


grafico_score_escolaridade <- ggplot(dados, aes(x = escolaridade, y = score_periculosidade, fill = escolaridade)) +
  geom_boxplot() +
  labs(title = "Score de Periculosidade por Escolaridade",
       x = "Escolaridade",
       y = "Score de Periculosidade") +
  theme(legend.position = "none")
ggsave("boxplot_score_escolaridade.png", plot = grafico_score_escolaridade)
print(grafico_score_escolaridade)

grafico_reincidente <- ggplot(dados, aes(x = reincidente, fill = reincidente)) +
  geom_bar() +
  labs(title = "Contagem de Reincidência",
       x = "Reincidente?",
       y = "Contagem") +
  theme(legend.position = "none")
ggsave("barras_reincidente.png", plot = grafico_reincidente)
print(grafico_reincidente)

print("--- Script de Análise Gráfica concluído e gráficos salvos! ---")

