
#Loading Required Packages
library(shiny)
library(shinydashboard)
library(tidyverse)
library(dplyr)
library(treemap)
library(d3treeR) #helpful to make zoomable treemap
library(data.table) #needed to read large files fast
library(plotly)
library(DT)
library(knitr)
library(arules)#for Rule Mining
library(arulesViz)
library(visNetwork)#network net
library(igraph)
library(RColorBrewer)
library(billboarder)#for D3.js charts
library(shinyWidgets)
# we'll need the development version of data.tree. If you do not have, install it
#devtools::install_github("gluc/data.tree")
#remotes::install_github("d3treeR/d3treeR")

#read/import the file  that we use 
insta <- fread("./insta_ready.csv")

#PREPARE DATA FOR DRAWING 1ST AND 2ND MENUITEMS TREEMAPS

tree1<-insta %>% 
  distinct(product_name, .keep_all = TRUE)%>%
  group_by(department, aisle) %>% 
  summarize(n=n())

tree2 <- insta %>% 
  group_by(department, aisle) %>% 
  summarize(n=n())
#DATA FOR ORDER LEVEL ANALYSIS

orders_heat= insta%>% group_by(order_dow, order_hour_of_day)%>%
  summarise(Order_number=n())

#####DEPENDENCIES FOR BASKET ANALYSIS AND DRAWING visNETWORK###############

# get the shopping baskets and draw vis Network
order_baskets <- insta %>% 
  select(order_id, product_name) %>% 
  group_by(order_id) %>%
  summarise(basket = as.vector(list(product_name)))
transactions <- as(order_baskets$basket, "transactions")
rules1 <- apriori(transactions, parameter = list(supp = 0.003269976, conf = 0.01, maxlen=3), control = list(verbose = FALSE))


###   Frequent Item Sets #####
support <- 0.008
itemsets <- apriori(transactions, parameter = list(target = "frequent itemsets", supp=support, minlen=2), control = list(verbose = FALSE))

par(mar=c(5,18,2,2)+.1)
sets_order_supp <- DATAFRAME(sort(itemsets, by="support", decreasing = F))











