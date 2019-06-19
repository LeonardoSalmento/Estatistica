#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



library(datasets)
library(shinydashboard)
library(readr)
library(shiny)
library(rsconnect)
library(DT)
library(tidyverse)
library(plotly)
library(dygraphs)
library(xts)



ui <- dashboardPage(
    dashboardHeader(title = "Spotify DataBase"),
    
    dashboardSidebar(
        sidebarMenu(
            menuItem("Tabela", tabName = "Database",icon = icon("th")),
            menuItem("Histograma", tabName = "grafico", icon = icon("dashboard")),
            menuItem("Media de popularidade das musicas", tabName = "De", icon = icon("th")),
            menuItem("Sobre", tabName = "sb", icon = icon("th"))
            
            
            
        )
    ),
    
    dashboardBody(
        tabItems(
            tabItem(tabName = "Database",
                    DT::dataTableOutput("mytable")
                    
            ),
            tabItem(tabName = "analise_grafica",
                    mainPanel(
                        plotOutput('table_')
                    )
            ),
            tabItem(tabName = "grafico",
                    
                    box(title = "Histograma",
                        status = "warning", solidHeader = TRUE, collapsible = TRUE,
                        plotOutput("plot_popularity_songs",height = 290)
                    ), 
                    box(
                        title = "Inputs", status = "warning",
                        br(), height = 290,
                        sliderInput("Classes",
                                    "Numero de classes:",
                                    min = 1,
                                    max = 100,
                                    value = 30)
                    )
                    
            ),
            
            tabItem(tabName = "De",
                    h2(align="center","Dados Estatisticos"),
                    dataTableOutput("media_popularidade_musicas"),
                   dataTableOutput("media_song_duration"),
                   dataTableOutput("media_danceabilidade "),
                   dataTableOutput("moda_musicas")
                   
                    
            ),

            
            
            tabItem(tabName = "sb",
                    h2(align="center","Spotify DataBase"),
                    br(strong("Local:",a("https://www.kaggle.com/tomigelo/spotify-audio-features/version/2"))),
                    br(strong("Origem:"),"Caracteristicas de Audios de uma colecao de 116.000 musicas da web API do
Spotify."),
                    br(strong("Autor:"),"Nadin Tamer "),
                    br(strong("Variaveis Usadas:")," nome-musica (qualitativa), popularidade (quantitativa)","duracao da musica(quantitativa)","danceabilidade(quantitativa)"),
                    h3("Interesse"),
                    br("Analisar os dados para descobrir os parametros fundamentais que influenciaram diretamente
na reproducao das musicas em grande escala comparando com aquelas que foram
classificadas em posicao inferior.")
                    
            )
        )
    )
)


  