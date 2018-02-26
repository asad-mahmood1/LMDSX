# app.R

# Detect and install missing packages before loading them
if (!require('pacman')) install.packages('pacman')
# Install and load packages
pacman::p_load('ibmdbR', 'shiny', 'shinythemes', 'plyr', 'DT', 'plotly')

# Get connection details
source('connection.R', local = TRUE)

# Named colors for the pie graph
darkred <- rgb(139, 0, 0, maxColorValue = 255)
darkgreen <- rgb(0, 100, 0, maxColorValue = 255)
darkgoldenrod4 <- rgb(139, 101, 9, maxColorValue = 255)

# Severity categories as strings
category.as.string <- function(catnum) {
  i <- as.integer(catnum)
  if(!is.na(i)) {
    if (i == 2) return('HIGH')
    if (i == 1) return('MEDIUM')
    if (i == 0) return('LOW')
  }

}

shinyApp(
  ################################################################################
  # UI                                                                           #
  ################################################################################
  ui = fluidPage(
    #shinythemes::themeSelector(),
    tags$head(tags$style('body {background-color: #FFFFEF; }')),
    theme = shinythemes::shinytheme('yeti'),
    # Application title
    titlePanel('DSX PoT - Supply Chain Analysis'),
    sidebarLayout(
      sidebarPanel(
        width = 3,
        plotlyOutput('severityPie', height = 450),
        conditionalPanel(
          condition="(typeof input.tbl_rows_selected !== 'undefined' && input.tbl_rows_selected.length > 0)", hr(),
          verbatimTextOutput('selectionDetails'),
          wellPanel(
            fluidRow(
              column(
                width=6, radioButtons(
                  'severity', label='Severity',
                  choices=c('HIGH' = 2, 'MEDIUM' = 1, 'LOW' = 0)
                )
              )
            )
          ),
          actionButton('saveSeverity', label = 'Save', icon = icon('save', lib = 'glyphicon')),
          actionButton('reportProfile', label='Report Profile', icon=icon('id-card-o'))
        )
      ),
      mainPanel(
        width = 9,
        DT::dataTableOutput('tbl')
      )
    )
  ),
  
  ################################################################################
  # SERVER                                                                       #
  ################################################################################
  server = function(input, output, session) {
    # Connect to using a odbc Driver Connection string to a remote database
    conn <- idaConnect(
      paste0(
        dsn.database,
        ";DATABASE=", dsn.database,
        ";HOSTNAME=", dsn.hostname,
        ";PORT=", dsn.port,
        ";PROTOCOL=", dsn.protocol,
        ";UID=", dsn.uid,
        ";PWD=", dsn.pwd
      )
    )
    
    # Initialize the analytics package
    idaInit(conn)
    
    # Close the DB connection when the session ends
    cancel.onSessionEnded <- session$onSessionEnded(function() { idaClose(conn) })
    
    # Query to update the severity
    updateSeverity <- function(lcn, severity) {
      idaQuery(
        paste0('UPDATE ', data.table, ' SET "Severity" = ', severity, ' WHERE "LCN" = \'', lcn, '\'')
      )
    }
    
    # Server-side observable values
    v <- reactiveValues(
      data = {
         df <- idaQuery(
            paste0(
            'SELECT * FROM ', data.table, ' '
          )
        )
        df
      }, data.selected = NULL
    )
    
    # When rows are selected, update the data.selected reactive value
    observe({v$data.selected <- input$tbl_rows_selected})
    
    # When the data or the selection changes, update the radio button and the selection details
    output$selectionDetails <- reactive({
      df <- v$data
      selected <- v$data.selected
      shiny::validate(need(!is.null(df) && !is.null(selected), 'Nothing selected.'))
      updateRadioButtons(session, 'severity', selected = df$Severity[[selected]])
      paste0(
        '\nTitle: ', df$Title[[selected]],
        '\nReport Type: ', df$Report_Type[[selected]],
        '\nCategory: ', df$Category[[selected]],
        '\nLCN: ', df$LCN[[selected]],
        '\nPart Number: ', df$Part_Number[[selected]],
        '\nSeverity: ', df$Severity[[selected]]
      )
    })
    
    profileModal <- function(df, selected) {
      showModal(
        modalDialog(
          title=paste0('Profile for Action Request'),
          size='l',
          easyClose=TRUE,
          fluidRow(
            column(
              width=4,
            ),
            column(
              width=8,
              HTML({
                result <- '<h4>'
                result <- paste0(result, 'Title: ', df$Title[[selected]], br())
                result <- paste0(result, 'Category: ', df$Category[[selected]], br())
                result <- paste0(result, 'Report Type: ', df$Report_Type[[selected]], br())
                result <- paste0(result, 'Part Number: ', df$Part_Number[[selected]], br())
                result <- paste0(result, 'LCN: ', df$LCN[[selected]], br())
                paste0(result, '</h4>')
              })
            )
          )
        )
      )
    }
    
    observeEvent(input$reportProfile, {
      isolate({
        df <- v$data
        selected <- v$data.selected
        shiny::validate(need(!is.null(df) && !is.null(selected), 'Nothing selected.'))
        profileModal(df, selected)
      })
    })
    
    # When the data changes, update the severity pie graph
    output$severityPie <- renderPlotly({
      df <- v$data
      shiny::validate(need(is.data.frame(df) && nrow(df) > 0, 'No results.'))
      withProgress(
        message = 'Rendering pie graph',  {
          colors <- c(darkred, darkgreen, darkgoldenrod4)
          plot_ly(
            {
              df <- rbind({
                # Severity levels
                severityDf <- as.data.frame(table(df$Severity))
                severityDf$Var1 <- plyr::revalue(
                  warn_missing = FALSE, as.character(severityDf$Var1),
                  c('High' = 'High Severity', 'Medium' = 'Medium Severity', 'Low' = 'Low Severity')
                )
                severityDf
              })
              names(df)[names(df) == 'Var1'] <- 'Severity'
              df$Severity <- factor(
                df$Severity,
                c('High Severity', 'Medium Severity', 'Low Severity')
              )
              df
            }, labels = ~Severity, values = ~Freq, type = 'pie',
            textposition = 'inside',
            textinfo = 'label+percent',
            insidetextfont = list(color = '#FFFFFF'),
            hoverinfo = 'label+text+percent',
            source = 'severityPie',
            text = ~paste(Freq),
            marker = list(colors = colors, line = list(color = '#FFFFFF', width = 1))
          ) %>% plotly::config(displaylogo = FALSE, collaborate = FALSE) %>%
            layout(
              showlegend = TRUE, legend = list(orientation = 'h'),
              xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
              yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
        })
    })
    
    observeEvent(input$saveSeverity, {
      severity <- as.integer(isolate(input$severity))
      lcn <- isolate(v$data$LCN[v$data.selected[1]])
      if (!is.na(lcn)) {
        withProgress(
          message = 'Saving severity', detail = category.as.string(severity), {
            v$data$Severity[v$data.selected[1]] <- severity
            updateSeverity(lcn, severity)
          }
        )
      }
    })
    
    output$tbl <- DT::renderDataTable(
      {
        shiny::validate(need(is.data.frame(v$data) && nrow(v$data) > 0, 'No results.'))
        v$data
      }, 
      server = FALSE,
      class = 'cell-border stripe',
      filter = 'top',
      colnames = c('ROW_ID'=1),
      extensions = c('Buttons', 'Scroller'),
      selection = 'single',
      options = list(
        dom = 'Bfrtip',
        buttons=list(
          list(extend='colvis'),
          'copy', 'csv', 'excel', 'pdf', 'print'
        ),
        scrollX = TRUE,
        scrollY = 600,
        scroller = TRUE,
        searchHighlight = TRUE,
        autoWidth = TRUE
      )
    )
  }
)
