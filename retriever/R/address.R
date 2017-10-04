#' Title Address Retriver
#' 
#' @description The 'address_lookup' function is a function that provides the user the address of a given
#' a set of coordinates The funtion uses the google geocode API to retrieve the result.
#' 
#' @param latlong A character string that includes the latitude and the longitude.
#'
#' @return A dataframe containing full address and coordinates.
#' 
#' @examples address(latlong = "58.3978, 15.5760")
#' 
#' @export
#' 
#' 

address <- function(latlong = NULL){
  requireNamespace("httr")
  #Intial
  if(is.null(latlong) | !is.character(latlong)){
    stop("Use character values")
  }
  
  if(!grepl("[[:digit:]]|[[:punct:]]",latlong)){
    stop("Use digits")
  }
  
  #Creating query and using GET verb
  
  cleaner <- function(x){
    
    x <- gsub("([[:space:]]|[[:punct:]])\\1+", "\\1", x)
    x <- gsub("[[:space:]]|[^[:alnum:],.+-]",",",x)
    x <- gsub("([[:punct:]])\\1+", "\\1", x)
    return(x)
  }
  
  latlong <- cleaner(latlong)
  url <- "https://maps.googleapis.com/maps/api/geocode/json?latlng="
  key <- "&key=AIzaSyCd2oCbFa2bo2p29qwX9J9Qfj4WYbRkmUI"
  url <- paste0(url,latlong,key)
  get_res <- httr::GET(url)
  
  #Checking for status code
  if(!grepl("^2",httr::status_code(get_res))){
    stop(httr::message_for_status(get_res))
  } else {
    
    
    #Handlig result and returning
    content_res <- httr::content(get_res)
    geometry_res <- lapply(content_res[["results"]], "[[", "geometry")
    coord <- as.data.frame(t(sapply(geometry_res, "[[", "location")))
    full_adress <- unlist(lapply(content_res[["results"]], "[[", "formatted_address"))
    
    res_df <- data.frame("Full_address" = full_adress,
                         "Latitude" = unlist(coord[,1]),
                         "Longitude" = unlist(coord[,2]),
                         stringsAsFactors = FALSE)
    
    rownames(res_df) <- NULL
    
    if(nrow(res_df) == 0){
      stop("No match found")
    }
    
    return(res_df)
  }
  
}
