#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(markdown)
library(plotly)
library(tidyverse)
library(readxl)
library(shiny)
library(shinydashboard)
library(dygraphs)
library(xts)


server <- function(input, output,session) {
  
  output$hist_song_popularity <- renderPlot({
    
    base_filtrada_popularity %>%
      ggplot(aes(x=song_popularity)) + 
      geom_histogram(color="black", fill="pink")
    
    histograma <-base_filtrada_popularity %>%
      drop_na(song_popularity) %>%
      ggplot(aes(x=song_popularity)) + 
      geom_histogram(color="black",
                     fill="white",stat = "bin",
                     bins = 30) +
      ylab("Frequencia") +
      xlab("Popularidade") +
      geom_vline(aes(xintercept=mean(song_popularity)),
                 color="blue", linetype="dashed", size=1) + 
      geom_vline(aes(xintercept=median(song_popularity)),
                 color="red", linetype="dashed", size=1)
    
    histograma
  })
  
    
    
    
    song_media_popularity_musicas <- base_filtrada  %>%
        group_by(song_name) %>%
        summarise(MEDIA_POPULARIDADE_DAS_MUSICAS = mean(song_popularity,na.rm = T))
    
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
    
    song_moda_musica <- base_filtrada %>%
        group_by(song_name) %>%
        summarise(MODA_MUSICAS = max(song_popularity))
    
    output$plot_popularity_songs <- renderPlot({
        
        x    <- layout_dic$song_popularity
        Classes <- seq(min(x), max(x), length.out = input$Classes + 1)  # Dados do bd
        
        # desenhar o histograma com o nÃºmero especificado de intervalos
        hist(x, breaks = Classes, col = 'darkgray', border = 'white', xlab = "Popularidade das Musicas",
             main = "Histograma de Popularidade das Faixas ")
    })
    
        
                
            
    output$mytable = DT::renderDataTable({
        layout_dic
    })
    
    output$media_popularidade_musicas = DT::renderDataTable({
        song_media_popularity_musicas
    })
    
    output$media_song_duration = DT::renderDataTable({
      song_media_song_duration}) 
    output$media_danceabilidade = DT::renderDataTable({
      song_media_danceability}) 
    output$moda_musicas = DT::renderDataTable(song_moda_musica )
    output$mediana = DT::renderDataTable(song_mediana_musicas)
    
}

