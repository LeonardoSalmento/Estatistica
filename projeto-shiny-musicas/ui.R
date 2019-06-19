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
            menuItem("Media Duracao das musicas", tabName = "mediadu", icon = icon("th")),
            menuItem("Media Danceabilidade", tabName = "dance", icon = icon("th")),
            menuItem("Mediana", tabName = "mediana", icon = icon("th")),
            menuItem("Moda", tabName = "moda", icon = icon("th")),
            menuItem("Sobre", tabName = "sb", icon = icon("th"))
            
            
            
        )
    ),
    
    dashboardBody(
        tabItems(
            tabItem(tabName = "Database",
                    DT::dataTableOutput("mytable")
                    
            ),
            
            tabItem(tabName = "grafico",
                    h4(align="center", "GRAFICOS"),
                    navbarPage(title = "Graficos Spotify",
                               tabPanel('Musica com popularidade acima de 80', 
                                        fluidRow(
                                          column(10, 
                                                 box(width = 30,
                                                     h4(align="center", "Histograma de s"),
                                                     plotOutput("hist_song_popularity")
                                                 )
                                          )
                                        )
                               )
                               
                    )
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
                    h2(align="center","Media popularidade das musicas"),
                    dataTableOutput("media_popularidade_musicas")),
            
            
            
            tabItem(tabName = "mediadu",
                    h2(align="center","Media duracao das musicas"),
                    dataTableOutput("media_song_duration")),
            tabItem(tabName = "dance",
                    h2(align="center","Media danceabilidade das musicas"),
                    dataTableOutput("media_danceabilidade")),
            tabItem(tabName = "mediana",
                    h2(align="center","Mediana popularidade das musicas"),
                    dataTableOutput("mediana")),
            tabItem(tabName = "moda",
                    h2(align="center","Moda popularidade das musicas"),
                    dataTableOutput("moda_musicas")),

            
            
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


  