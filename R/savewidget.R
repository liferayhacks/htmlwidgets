

#' Save a widget to an HTML file
#' 
#' Save a rendered widget to an HTML file (e.g. for sharing with others).
#' 
#' @param widget Widget to save
#' @param file File to save HTML into
#' @param selfcontained Whether to save the HTML as a single self-contained file
#'   (with external resources base64 encoded) or a file with external resources 
#'   placed in an adjacent directory.
#'
#' @export
saveWidget <- function(widget, file, selfcontained = TRUE) {
   
  # convert to HTML tags
  html <- toHTML(widget, standalone = TRUE)
  
  # form a path for dependenent files
  libdir <- paste(tools::file_path_sans_ext(basename(file)), "_files", sep = "")
  
  # save the file
  htmltools::save_html(html, file = file, libdir = libdir)
  
  # make it self-contained if requested
  if (selfcontained) {
    
    if (!pandoc_available()) {
      stop("Saving a widget with selfcontained = TRUE requires pandoc. For details see:\n",
           "https://github.com/rstudio/rmarkdown/blob/master/PANDOC.md")
    }
    
    pandoc_self_contained_html(file, file)
    unlink(libdir, recursive = TRUE)
  }
  
  invisible(NULL)
}
