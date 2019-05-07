

shinyServer(function(input, output) {
   
 #BUILDING TREE MAPS##################################
  
  output$d3Tree1 <- renderD3tree2(
    d3tree2(treemap(tree1,
            index = c("department","aisle")
            ,vSize = "n"
            ,type = "index"
            ,palette='Set3'),
    rootname = "General" )) 
    
  output$d3Tree2 <- renderD3tree2(
    d3tree2(treemap(tree2,
                    index = c("department","aisle")
                    ,vSize = "n"
                    ,type = "index"
                    ,palette='Set3'),
            rootname = "General" ))
  
  
  #ORDER LEVEL MENU PART#############################################
  
  output$heat_map <-renderPlotly({
    plot_ly(x =orders_heat$order_hour_of_day,  y =orders_heat$order_dow, z = orders_heat$Order_number,
            type = "heatmap", colors='YlOrRd')%>%
      layout(xaxis = list(type='category',title='Hour of Day'), 
             yaxis = list(title='Day of Week'))  })
  
  output$bar <-renderPlotly({
    k<-insta%>%
      group_by(order_dow)%>%
      summarize(count=n())
    plot_ly(x=k$order_dow, y=k$count,  type='bar')
    
  })
  
  output$bar2 <-renderPlotly({
    h<-insta%>%
      group_by(order_hour_of_day)%>%
      summarize(count=n())
    as.character(h$order_hour_of_day)
    
    plot_ly(x=h$order_hour_of_day, y=h$count, type='bar' )
  })
  
  
  output$bar3 <-renderPlotly({
    d<-insta%>%
      group_by(days_since_prior_order)%>%
      summarize(count=n())
    as.character(d$days_since_prior_order)
    plot_ly(x=d$order_hour_of_day, y=d$count, type='bar')
  })
  
  #DASHBOARD####################################################
  output$sale <- renderValueBox({
    sales_num<-insta %>%
      filter(department == input$dept) %>%
      summarize(n=n())
    valueBox( sales_num, "Total Sales", 
              icon = icon("shopping-cart"),
              color = "blue"
              )
  })
  output$product <- renderValueBox({
    product_num<-insta%>%
      filter(department==input$dept)%>%
      distinct(product_name, .keep_all = TRUE)%>%
      summarize(n=n())
    valueBox( product_num, "Total Unique Product Count", 
              icon = icon("list"),
              color = "green"
             )
  })
  
  output$o <- renderValueBox({
    num<-insta%>%
      filter(department==input$dept)%>%
      distinct(order_id, .keep_all = TRUE)%>%
      summarize(n=n())
    valueBox( num, "Total Orders", 
              icon = icon("credit-card"),
              color = "yellow"
             )
  })
  
  
  output$second <-renderBillboarder({
  pie1 <-insta%>%
  filter(department==input$dept)%>%
  group_by(aisle)%>%
  summarize(count=n())
  billboarder() %>% 
   bb_donutchart(data = pie1)%>% bb_legend(show = FALSE)
  
  
  })
  
  
  output$first <- renderBillboarder({
  pie2<-insta%>%
  filter(reordered=='YES'& department==input$dept)%>%
  group_by(product_name)%>%
  summarize(count=n())%>%
  arrange(desc(count)) %>% 
   head(10)
  billboarder() %>% 
  bb_donutchart(data = pie2)%>% bb_legend(show = FALSE)
  }) 
  
  
  output$third <- renderBillboarder({
  bestseller<-insta%>%
  filter(department==input$dept)%>%
  group_by(product_name)%>%
  summarize(count=n())%>%
  top_n(10, wt = count) %>%
  arrange(desc(count))
  billboarder() %>% 
   bb_donutchart(data = bestseller)%>% bb_legend(show = FALSE)
  })
  
  ###############BASKET ANALYSIS#############################
  output$frequency <-renderPlot({
    
 itemFrequencyPlot(transactions,topN=20,type="absolute", col=brewer.pal(8,'Pastel2'), 
                      main="Absolute Item Frequency Plot")  
  })
  
  output$rules <-renderPlot({
    
    par(mar=c(5,18,2,2)+.1)
    sets_order_supp <- DATAFRAME(sort(itemsets, by="support", decreasing = F))
    barplot(sets_order_supp$support, names.arg=sets_order_supp$items, 
            xlim=c(0,0.02), horiz = T, las = 2, cex.names = .8, col=brewer.pal(8,'Pastel2'), main = "Frequent Itemsets")
    mtext(paste("support:",support), padj = .8)
    })  
  
  ###VisNETWORK
  
  output$network <- renderVisNetwork({
    subrules2 <- head(sort(rules1, by="confidence"),input$xcol)
    ig <- plot( subrules2, method="graph", control=list(type="items") )
    ig_df <- get.data.frame( ig, what = "both" )
    nodesv <- data.frame(
      id = ig_df$vertices$name
      ,value = ig_df$vertices$support # could change to lift or confidence
      ,title = ifelse(ig_df$vertices$label == "",ig_df$vertices$name, ig_df$vertices$label)
      ,ig_df$vertices
    ) 
    edgesV = ig_df$edges
    visNetwork(nodes = nodesv, edges = edgesV, main = "Most Significant Assossiation Rules") %>%
      visNodes(size = 10) %>%
      visLegend() %>%
      visEdges(smooth = FALSE) %>%
      visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE) %>%
      visInteraction(navigationButtons = TRUE) %>%
      visEdges(arrows = 'from') %>%
      visPhysics(
        solver = "barnesHut",
        maxVelocity = 35,
        forceAtlas2Based = list(gravitationalConstant = -6000)
      ) 
  })
  
  
  
  
  
  
  
  
  
  
  
  
  
  
})
