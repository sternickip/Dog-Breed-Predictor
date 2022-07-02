

# Define server logic required to draw a histogram
shinyServer(function(input, output) {


  
    output$output_image <- renderImage({
      req(input$input_image)
      outfile <- input$input_image$datapath
      contentType <- input$input_image$type
      list(src = outfile,
           contentType=contentType,
           width = 400)
    }, deleteFile = F)
       
   
  prob_table <- eventReactive(input$input_image,{


    x <- image_to_array(image_load(input$input_image$datapath,target_size = target_size))
    x <- array_reshape(x, c(1, dim(x)))
    x <- x/255
    pred <- model %>% predict(x)
    
    pred <- setDT(as.data.frame(t(pred),row.names = substring(gsub('_',' ',label_list),regexpr('-',label_list)+1)),keep.rownames = T)[order(-V1)]
    setnames(pred,c('rn','V1'),c('Breed','Probability'))
    pred[,Probability:= sprintf("%0.2f%%", Probability * 100)][]


  })
  output$Table <-  DT::renderDataTable({
    prob_table()[1:input$top_n]

  },
  filter='none',
  style='bootstrap4',
  options=list(lengthChange=FALSE,
               bInfo =FALSE,
               paging=FALSE,
               searching=FALSE))
  
})

# test_image <- image_load("labrador-biszkoptowy.jpg",
#                          target_size = target_size)
# x <- image_to_array(test_image)
# x <- array_reshape(x, c(1, dim(x)))
# x <- x/255
# pred <- model %>% predict(x)
# pred <- data.frame("breed" = label_list, "Probability" = t(pred))
# pred <- pred[order(pred$Probability, decreasing=T),][1:5,]
# pred$Probability <- paste(format(100*pred$Probability,2),"%")
# pred
