install.packages("plotly")
install.packages("shinydashboard")
install.packages("dygraphs")
install.packages("xts")
install.packages("DT")


library(tidyverse)
library(readxl)

layout_dic <- read_csv("song_data.csv")
head(layout_dic)

base_filtrada <- layout_dic %>% select(song_name,song_popularity,song_duration_ms,danceability)


song_media_popularity_musicas <- base_filtrada  %>%
  group_by(song_name) %>%
  summarise(MEDIA_POPULARIDADE_DAS_MUSICAS = mean(song_popularity,na.rm = T))

view(base_filtrada)
song_media_song_duration <- base_filtrada %>%
  group_by(song_name)%>%
  summarise(MEDIA_DURACAO_DAS_MUSICAS = mean(song_duration_ms,na.rm = T))

song_media_danceability <- base_filtrada %>%
  group_by(song_name)%>%
  summarise(MEDIA_DANCEABILIDADE_DAS_MUSICAS = mean(danceability,na.rm=T))

song_moda_musica <- base_filtrada %>%
  group_by(song_name) %>%
  summarise(MODA_MUSICAS = max(song_popularity))

song_mediana_musicas <- base_filtrada %>%
  group_by(song_name) %>%
  summarise(MEDIANA = median(song_popularity))



base_filtrada_popularity <- base_filtrada %>%
  filter(song_popularity > 80)


