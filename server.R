library(shiny)
source('functions.R')

function(input, output) {
  t = 1:2000
  dataset <- reactive({
    diamonds[sample(nrow(diamonds), input$sampleSize),]
  })
  
  St <- reactive({
    cos(input$omega_s * t)
  })
  nt <- reactive({
    input$nsr * cos(input$omega_n * t)
  })
  xt <- reactive({
    St() + nt()
  })
  
  ht <- reactive({
    oirf(input$N, input$d, input$cut_off, input$omega_s, input$omega_n)
  })
  
  result <- reactive({
    filter1(xt(), ht())
  })
  
  output$terms <- renderUI({ 
    N <- estimate_N(input$d, input$nsr, input$cut_off)
    "N" <- numericInput('N', paste('Number of terms(Recommended N =', 
                                   estimate_N(input$d, input$nsr, input$cut_off),")"), N, 1, 100)
  })
  
  output$st <- renderPlot({
    stem_plot(t, St(), main="Signal",col="#32CD32", xlab="t", ylab=expression(S[t]))
  })
  
  output$xt <- renderPlot({
    stem_plot(t, xt(), main="Input", xlab="t", ylab=expression(x[t]), col="#00BFFF")
  })
  
  output$Hw <- renderPlot({
    ofrf(input$N, input$d, input$cut_off, input$omega_s, input$omega_n)
  })
  
  output$ht <- renderPlot({
    n <- (length(ht()) - 1) / 2
    t_h <- -n : n
    stem_plot(t_h, ht(), main="OIRF", xlab="t", ylab=expression(h[t]), col="#FF33AA")
  })
  
  output$yt <- renderPlot({
    yt <- result()$yt
    t_plot <- result()$t_plot
    stem_plot(t_plot, yt[t_plot], "Filtering Result", "t", expression(y[t]), col="#32CD32")
  })
  
  output$Delta <- renderPlot({
    delta_t = result()$yt - St()
    t_plot <- result()$t_plot
    stem_plot(t_plot, delta_t[t_plot], "Filtering Error", "t", expression(Delta[t]),col="#FF0000")
  })
  
}