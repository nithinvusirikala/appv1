library(shiny)
library(ggplot2)
library(dplyr)
library(reshape2)
library(RColorBrewer) 

##setwd("C://Users//prasad//Desktop//app_1")
melt_crops<-read.csv("./data/crops.csv")
melt_live<-read.csv("./data/livelihood.csv")
melt_shg<-read.csv("./data/shg.csv")
melt_water<-read.csv("./data/water.csv")



# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
  
    
    output$plot1<-renderPlot({
      {
      if(input$All){
      if(input$option==1)
      {
        ggplot(melt_crops,aes(cpid,fill=as.character(crop.category)))+geom_bar()+scale_fill_brewer(palette="Set2",name="Crop Categories")
      }
      else if(input$option==2)
      {
        ggplot(melt_live,aes(cpid,fill=as.character(livelihood.category)))+geom_bar()+scale_fill_hue(name="Livelihood Categories")
      }
      else if(input$option==3)
      {
        ggplot(melt_shg,aes(cpid,))+geom_bar()
      }
      else if(input$option==4)
      {
        ggplot(melt_water,aes(cpid,fill=as.character(water.unit.type)))+geom_bar()+scale_fill_brewer(palette="Set2",name="Water Body Categories")
      }
      
    }
    
  else{
    
    if(input$option==1){
      ggplot(subset(melt_crops,cpid %in% (input$checkGroup)),aes(cpid,fill=as.character(crop.category)))+geom_bar()+scale_fill_brewer(palette="Set2",name="Crop Categories")
      
    }
    
    else if(input$option==2){
      
      ggplot(subset(melt_live,cpid %in% (input$checkGroup)),aes(cpid,fill=as.character(livelihood.category)))+geom_bar()+scale_fill_brewer(palette="Set3",name="Livelihood Categories")
    }
    
    else if(input$option==3){
      
      ggplot(subset(melt_shg,cpid %in% (input$checkGroup)),aes(cpid))+geom_bar()
    }
    
    else if(input$option==4){
      
      ggplot(subset(melt_water,cpid %in% (input$checkGroup)),aes(cpid,fill=as.character(water.unit.type)))+geom_bar()+scale_fill_brewer(palette="Set2",name="Water Body Categories")
    }
  }
  }
    }
  )
 output$plot2<-renderPlot({
   
   
   {
      if(input$option==1){
        if(input$view1==2)       
         ggplot(subset(subset(melt_crops,cpid %in% (input$checkGroup)), crop.category %in% (input$relation1)),aes(cpid))+geom_bar()+facet_wrap(~crop.category)
        else{
          
          ggplot(subset(subset(melt_crops,cpid %in% (input$checkGroup)), crop.category %in% (input$relation1)),aes(cpid,fill=as.character(crop.category)))+geom_bar(position="dodge")+scale_fill_brewer(palette="Set2",name="Crop Categories")
        }
        
       }
     
      else if (input$option==2){
       
      if(input$view2==2)
        ggplot(subset(subset(melt_live,cpid %in% (input$checkGroup)),livelihood.category %in% (input$relation2)),aes(cpid))+geom_bar()+facet_wrap(~livelihood.category)
      else{
        
        ggplot(subset(subset(melt_live,cpid %in% (input$checkGroup)),livelihood.category %in% (input$relation2)),aes(cpid,fill=as.character(livelihood.category)))+geom_bar(position="dodge")+scale_fill_brewer(palette="Set3",name="Livelihood Categories")
      }
    
      }
      else if (input$option==3){
     
        }
      else if (input$option==4){
       if(input$view4==2)
        ggplot(subset(subset(melt_water,cpid %in% (input$checkGroup)), water.unit.type %in% setdiff((input$relation4),setdiff(input$relation4,water.unit.type))),aes(cpid))+geom_bar()+facet_wrap(~water.unit.type)
        else{
          ggplot(subset(subset(melt_water,cpid %in% (input$checkGroup)), water.unit.type %in% (input$relation4)),aes(cpid,fill=as.character(water.unit.type)))+geom_bar(position="dodge")+scale_fill_brewer(palette="Set2",name="Water body Categories")
        }    
      }
   
   }
   
   
   
   
   
 })
  
 

})
