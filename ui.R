#LSNR 
library(shiny)
library(ggplot2)
dataset <- diamonds

fluidPage(
  
  titlePanel("Low Signal-Noise Ratio Dynamic Filter"),
  
  wellPanel(
    fluidRow(

      # signal, noise, cutoff frequency
      column(4,
      sliderInput('omega_s', 'Frequency of Signal', min=0.01, max=1.04,
                  value=0.5, step=0.01, round=-2)),
      column(4,
      sliderInput('cut_off', 'Cut-off Frequency', min=1.05, max=2.09, value = 1.57, step=0.01, round=-2)),
      column(4,
      sliderInput('omega_n', 'Frequency of Noise', min=2.10, max=3.14,
                  value=2.5 , step=0.01, round=-2))
    ),
    fluidRow(
      # amplitude
      column(4,
             sliderInput('nsr', 'Ratio of Noise to Signal,', min=1, max=10000, value=10000, step=1, round=0)
      ),
      # delta and N
      column(4,
      numericInput('d', 'd(delta = 10^(-d), e.g. input d = 2 means delta = 0.01)', 10, 1, 20)),
      
      
      column(4,
        uiOutput("terms") 
      )
    )
  ),
  
    tabsetPanel(
      tabPanel("Original Signal and Input",
               fluidRow(
                 column(6, plotOutput('st')),
                 column(6, plotOutput('xt'))
               )
      ),
      tabPanel("Optimum IRF and FRF",
               fluidRow(
                 column(6, plotOutput('ht')),
                 column(6, plotOutput('Hw'))
               )
      ),
      tabPanel("Filtering Result and Error",
               fluidRow(
                 column(6, plotOutput('yt')),
                 column(6, plotOutput('Delta'))
               )
      )
    )
)