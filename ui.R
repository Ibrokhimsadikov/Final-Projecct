

shinyUI(dashboardPage(
  
  dashboardHeader(title = 'SMARTSIGHT'),
  
  dashboardSidebar(
    sidebarUserPanel("Abe Sadikov"),
    sidebarMenu(
      menuItem("Product Map View", tabName = "topcategory"),
      menuItem("Sales Map View", tabName = "salesview"),
      menuItem("Order Level Analysis", tabName = "heat_map"),
      menuItem('Dashboard', tabName = 'dash'),
      menuItem("Basket Analysis", tabName = 'order'),
      menuItem("Network", tabName = "data")
      
    )
  ),
  
  dashboardBody(
    
    tabItems(
      #PRODUCT MAP VIEW
 tabItem(tabName = "topcategory", fluidRow(title = "Top", align= "center", status = "primary",
                                           d3tree2Output("d3Tree1", width = "90%", height="625px"))), 
 # SALES MAP VIEW
 tabItem(tabName = "salesview", fluidRow(title = "Top ", align= "center", status = "primary",
                                         d3tree2Output("d3Tree2", width = "90%", height="625px"))),
     
  #ORDER LEVEL ANALYSIS
tabItem(tabName = "heat_map", 
        fluidRow(title = "ORDER LEVEL ANALYSIS", align='center', status = "primary",
                 plotlyOutput('heat_map', width='100%', height='500px')),
        
        fluidRow(box(width =4,title = "Order Day of Week", status = "primary",plotlyOutput('bar')),
                 box(width =4,title = "Order Hour of Day", status = "primary", plotlyOutput('bar2')),
                 box(width =4,title = "Order Since Prior Order", status = "primary",plotlyOutput('bar3')))
      ),
   #DASHBOARD
tabItem(tabName = 'dash', fluidRow( align='center',  selectInput("dept","DEPARTMENT:", c(unique(as.character(insta$department))))),
                          
                          fluidRow(valueBoxOutput("sale"),
                                   valueBoxOutput("o"),
                                   valueBoxOutput("product")) ,                                       
        
                          fluidRow(box(width =4,title = "Most often reordered", status = "primary", billboarderOutput("first")),
                                    box(width =4,title = "Aisle Level Comparision", status = "primary",   billboarderOutput("second")),
                                    box(width =4,title = "Department Bestseller", status = "primary", billboarderOutput("third")))  
        
        ),
        
#BASKET ANALYSIS        
tabItem(tabName = "order", fluidRow(title = "Item Frequency", status = "primary",plotOutput('frequency')),
                           fluidRow(title = "Top Assosiation Rules ", align='right', plotOutput('rules' ))

        ),        
        
      
      
#NETWORK
tabItem(tabName = "data", 
        dropdownButton(
          tags$h3("List of Input"), 
          selectInput(inputId = 'xcol', label = 'How many rules', choices = c(5, 10, 15, 20, 25, 30, 35, 40, 45, 50,55, 60)),
          circle = TRUE, status = "danger", icon = icon("gear"), width = "300px",
          tooltip = tooltipOptions(title = "Click to see inputs !")
        ),
        fluidRow(align= "center", status = "primary", visNetworkOutput("network", width = "85%", height="570px")))
      
    )
  ))
)



