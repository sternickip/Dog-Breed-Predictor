rm(list=ls())
library(keras)
library(tidyr)
library(ggplot2)
set.seed(2137)
library(shiny)
library(shinydashboard)
library(data.table)


target_size <-  c(331, 331)

#creating a trained model to load for future uses
if(!file.exists('trained_model')){

  
  #creating and splitting the data set if not already there
  if(!file.exists('train')) {
  
    download.file('http://vision.stanford.edu/aditya86/ImageNetDogs/images.tar','images.tar', mode='wb')
    untar('images.tar')
    file.rename('Images','train')
    label_list <- dir("train")
    path1 <- file.path("train", label_list)
    path2 <- file.path("validation", label_list)
    dir.create("validation")
    lapply(path2, dir.create)
    Map(function(x, y){
      file <- dir(x) ; n <- length(file)
      file_selected <- file.path(x, sample(file, ceiling(n * 0.2)))
      file.copy(file_selected, y)
      file.remove(file_selected)
    }, path1, path2)

    file.remove('images.tar')

    
    
  }



train_data_gen <- image_data_generator( rescale= 1/255
                                        ,zoom_range = 0.2,width_shift_range = 0.05
                                        ,height_shift_range = 0.05,rotation_range = 15
                                        ,horizontal_flip = T)

validation_data_gen <- image_data_generator( rescale= 1/255)

train_images <- flow_images_from_directory('train',
                                           train_data_gen,
                                           target_size = target_size,
                                           class_mode = "categorical",
                                           shuffle=F,
                                           classes = label_list,
                                           seed = NULL)

validation_images <- flow_images_from_directory('validation',
                                            validation_data_gen,
                                           target_size = target_size,
                                           class_mode = "categorical",
                                           shuffle=F,
                                           classes = label_list,
                                           seed = NULL)



freeze_weights(mod_base) 

base_model <-  application_inception_resnet_v2(
  include_top=F,
  weights='imagenet',
  input_shape=c(target_size,3)
)
freeze_weights(base_model) 



model <-  keras_model_sequential() %>% 
  base_model() %>%    
  layer_batch_normalization(renorm=T) %>% 
  layer_global_average_pooling_2d() %>% 
  layer_dense(512, activation='relu') %>% 
  layer_dense(256, activation='relu') %>% 
  layer_dropout(0.5) %>% 
layer_dense(128, activation='relu') %>% 
layer_dense(120, activation='softmax')

model %>% compile(
  loss = "categorical_crossentropy",
  optimizer = optimizer_adam(),
  metrics = "accuracy"
)





batch_size <- 32
epochs <- 25
hist <- model %>% fit(
  train_images,
  steps_per_epoch = train_images$n %/% batch_size, 
  epochs = epochs, 
  validation_data = validation_images,
  validation_steps = validation_images$n %/% batch_size,
  verbose = 1,
  callbacks = callback_early_stopping(patience=10,
                                      min_delta=0.001,
                                      restore_best_weights=T)
)


save_model_tf(model,'trained_model')



}
label_list <- dir("train")
model <- keras::load_model_tf('trained_model')

