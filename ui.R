library(shiny)
library(shiny)
library(ggplot2)
library(dplyr)
library(reshape2)
library(RColorBrewer) 

blocks<-toupper(c("KACHCHH","DEVAS","KHANDWA","MAHBUBNAGAR","MALKANGIRI","PALAMU","BANKURA"))
crop_categories<-toupper(c("Cereals","Pulses","Oilseeds","Fibre","Fruit","Vegetables","Others"))
live_categories<-toupper(c("agriculture","tree based livelihood","sheep/goat rearing","dairy cattle","other livestocks","fishing/aquaculture","home production(small-scale processing)","trade/business/services","ntfp collection","salaried job","pension / remittances","local labor (agri,skilled,unskilled)","migratory labor(agri,skilled,unskilled)"))
shg_categories<-toupper(c("Public Institutions","Community initiated Civic Institutions","NGO initiated Civic Institutions","Government initiated Civic Institutions","Self-Help Micro finance Groups"))
water_categories<-toupper(c("Pond","Tank","Ahar","Check dam","Spring","Stream or River","Canal"))



shinyUI(fluidPage(
  fluidRow(column(12,
    titlePanel("  Interactive App for Data Visualisation ")
  )),
      
  fluidRow(
  column(3,  
      sidebarPanel(checkboxGroupInput("checkGroup", 
                         label = h5("Select the blocks you want to study : "), 
                         choices = blocks,
                                        selected=blocks[1:4]),
                  checkboxInput("All",label="All Blocks together ",value=FALSE),
                   
      conditionalPanel(condition="input.checkGroup.length>=1",
                       selectInput("option",label=h5("Select what you want to see :"),
                       choices=list("Crops"=1,"Livelihoods"=2,"Self Help Groups"=3,"Surface Water"=4,"None"=5),selected=5)),
      ##conditionalPanel(condition="input.option>=1",submitButton("Submit"))
      
          
      width=20
      )
      ),
  column(9,
         
         textOutput("text1"),
         plotOutput("plot1",width="90%",height="400")
         
         )
  
  ),
    
  fluidRow(
    column(3,
           
           sidebarPanel(
           conditionalPanel(condition="input.option==1",
                            selectInput("view1",label="Select the way you want to look : ",choices=list("Combined"=1,"Seperated"=2),selected=2),
                            checkboxGroupInput("relation1",label="Select sub-categories :",choices=crop_categories)
                            ),
           
           conditionalPanel(condition="input.option==2",
                            selectInput("view2",label="Select the way you want to look : ",
                                        choices=list("Combined"=1,"Seperated"=2),
                                        ),
                            checkboxGroupInput("relation2",label="Select sub-categories :",
                            choices=live_categories)
                            
                            ),
           
           conditionalPanel(condition="input.option==3",
                            selectInput("xx","Select the sub-category 1 ",choices=shg_categories,selected=head(shg_categories,n=1)),selectInput("yy","Select the sub-category 2 ",choices=shg_categories,selected=tail(shg_categories,n=1))),
           
           conditionalPanel(condition="input.option==4",
                            selectInput("view4",label="Select the way you want to look : ",
                                        choices=list("Combined"=1,"Seperated"=2),
                                        ),
                            checkboxGroupInput("relation4",label="Select sub-categories :",
                            choices=water_categories)
                            
                            ),
           
           
           width=10)
           ),
    column(9,
           textOutput("text2"),
           plotOutput("plot2",height="400")
           
           )
    
    )  
    
    
  )
)