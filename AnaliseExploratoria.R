# ----------------------------------------------------
# Script 2: Análise Exploratória 
# Disciplina: Prática Estatística 2
# ----------------------------------------------------

# 1. Carregar pacotes necessários
library(readxl)
library(dplyr)
library(ggplot2)
library(htmlwidgets)

# (Repetindo a importação e fatoração para este script ser independente)
dados <- read_xlsx("Base_trabalho.xlsx")

dados <- dados %>%
  mutate(
    escolaridade = factor(escolaridade, levels = c(1, 2, 3), labels = c("Fundamental", "Médio", "Superior")),
    reincidente = factor(reincidente, levels = c(0, 1), labels = c("Não", "Sim")),
    filhos = factor(filhos, levels = c(0, 1), labels = c("Não", "Sim")),
    sexo = factor(sexo, levels = c(0, 1), labels = c("Feminino", "Masculino")),
    casado = factor(casado, levels = c(0, 1), labels = c("Não", "Sim"))
  )

# A função summary() fornece a maioria dessas medidas
print("--- Resumo (Média, Quartis) das Variáveis Quantitativas ---")
variaveis_quant <- dados %>% select(score_periculosidade, idade, tempo_preso)
summary(variaveis_quant)

grafico_dispersao <- ggplot(dados, aes(x = tempo_preso, y = score_periculosidade)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", color = "red") + # Adiciona linha de tendência
  labs(title = "Dispersão: Tempo de Prisão vs. Score de Periculosidade",
       x = "Tempo Preso (meses)",
       y = "Score de Periculosidade")

ggsave("dispersao_tempo_score.png", plot = grafico_dispersao)
print(grafico_dispersao)

correlacao <- cor(dados$tempo_preso, dados$score_periculosidade)
print(paste("--- Correlação entre Tempo Preso e Score de Periculosidade ---"))
print(correlacao)


# Função para calcular todas as medidas
calcular_medidas <- function(vetor) {
  list(
    variancia = var(vetor, na.rm = TRUE),
    desvio_padrao = sd(vetor, na.rm = TRUE),
    amplitude = max(vetor, na.rm = TRUE) - min(vetor, na.rm = TRUE)
  )
}

print("--- Medidas de Dispersão (Variância, DP, Amplitude) ---")
medidas_score <- calcular_medidas(dados$score_periculosidade)
print("Score de Periculosidade:")
print(medidas_score)

medidas_idade <- calcular_medidas(dados$idade)
print("Idade:")
print(medidas_idade)

medidas_tempo <- calcular_medidas(dados$tempo_preso)
print("Tempo Preso:")
print(medidas_tempo)

print("--- Script de Análise Exploratória concluído! ---")


#### FIM ####