

shinyUI(dashboardPage(
  
  dashboardHeader(title = 'SMARTSIGHT'),
  
  dashboardSidebar(
    sidebarUserPanel("Abe Sadikov"),
    sidebarMenu(
      
      menuItem('Dashboard', tabName = 'dash', icon = icon("dashboard")),
      menuItem("Basket Analysis", tabName = 'order', icon=icon(' fa-shopping-cart')),
      menuItem("Network", tabName = "data", icon=icon(' fa-bezier-curve')),
      menuItem("Order Level Analysis", tabName = "heat_map", icon=icon(' fa-chart-bar')),
      menuItem("Product Map View", tabName = "topcategory", icon = icon("th")),
      menuItem("Sales Map View", tabName = "salesview", icon = icon("th"))
      
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
        fluidRow(title = "ORDER LEVEL ANALYSIS", align='center', status = "primary",
                 billboarderOutput("second", width='100%', height='400px')),
                          fluidRow(box(width =4,title = "Most often reordered", status = "primary", billboarderOutput("first")),
                                    #box(width =3,title = "Aisle Level Comparision", status = "primary",   billboarderOutput("second")),
                                   box(width =4,title = "Least Sold Items", status = "primary",   billboarderOutput("fourth")),
                                    box(width =4,title = "Department Bestseller", status = "primary", billboarderOutput("third")))  
        
        ),
        
#BASKET ANALYSIS        
tabItem(tabName = "order", 
        dropdownButton(
  tags$h3("List of Input"), 
  sliderInput(inputId = 'sup',
              label = 'Support Level',
              value = 0.001269976,
              min = .00001, max = .009),
  sliderInput(inputId = 'conf',
              label = 'Confidence Level',
              value = 0.01,
              min = 0.01, max = .5),
   circle = FALSE, status = "primary", icon = icon("sliders"), width = "325px", label = "Select Support and Confidence", 
  tooltip = tooltipOptions(title = "Click to see inputs !")
),
      
        
        fluidRow(title = "Item Frequency", status = "primary", DT::dataTableOutput("rules")),
                          # fluidRow(title = "Top Assosiation Rules ", align='right', plotOutput('rules' ))

         downloadButton('downloadData', 'Download Rules as CSV', style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
       
        
        ),        
        
      
      
#NETWORK
tabItem(tabName = "data", 
        dropdownButton(
          tags$h3("List of Input"), 
          selectInput(inputId = 'xcol', label = 'How many rules', choices = c(5, 10, 15, 20, 25, 30, 35, 40, 45, 50,55, 60,
                                                                              65,70,75,80,85,90,95,100)),
          circle = FALSE, status = "primary", icon = icon("gear"), width = "200px", label = "Select Number of Rules",
          tooltip = tooltipOptions(title = "Click to see inputs !")
        ),
        fluidRow(align= "center", status = "primary", visNetworkOutput("network", width = "85%", height="570px")))
      
    )
  ))
)



