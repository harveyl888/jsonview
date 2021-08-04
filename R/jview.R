#' jview JSON viewer
#'
#' Display a JSON string as a collapsible tree
#'
#' @param data A json string
#' @param width widget width
#' @param height widget height
#' @param elementId shiny ID
#' @param expanded Boolean.  If true then start in expanded form
#'
#' @import htmlwidgets
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(jsonview)
#'
#'   json_test <- '{
#'     "givenName": "Vas",
#'     "surName": "Sudanagunta",
#'     "children": [
#'       {
#'         "givenName": "Natalia",
#'         "age": 5
#'       },
#'       {
#'         "givenName": "Aida",
#'         "age": 17
#'       }
#'     ],
#'     "address": {
#'       "state": "NY",
#'       "city": "Brooklyn",
#'       "street": "718 Marcus Garvey Ave"
#'     }
#'   }'
#'
#'   shiny::shinyApp(
#'     ui = fluidPage(
#'       jsonview::jviewOutput("json")
#'     ),
#'     server = function(input, output) {
#'       output$json <- jsonview::renderJview({
#'         jsonview::jview(data = json_test, expanded = TRUE)
#'       })
#'     }
#'   )
#' }
#'
jview <- function(data, width = NULL, height = NULL, elementId = NULL, expanded = FALSE) {

  # forward options using x
  x = list(
    data = data,
    expanded = expanded
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'jview',
    x,
    width = width,
    height = height,
    package = 'jsonview',
    elementId = elementId
  )
}


#' Shiny bindings for jview
#'
#' Output and render functions for using jview within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a jview
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name jview-shiny
#'
#' @export
jviewOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'jview', width, height, package = 'jsonview')
}


#' @rdname jview-shiny
#' @export
renderJview <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, jviewOutput, env, quoted = TRUE)
}
