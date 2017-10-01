#' Title Coordinates Retriver
#' 
#' @description The coodinate function uses the google geocode API to retriever coordinates given address.
#' 
#' @param address A character string that includes address components
#'
#' @return A dataframe cointaining Full address and the coordinates
#' 
#' @examples coordinates(address="Master Mattias vag 7, Linkoping, Sweden")
#' 
#' @export
#' 
#' 
coordinates <- function(address = NULL){
  requireNamespace("httr")
  #Intial
  if(is.null(address) | !is.character(address)){
    stop("Use character values")
  }
  
  #Creating query and using GET verb
  address <- gsub("[[:space:]]","+",address)
  
  url <- "https://maps.googleapis.com/maps/api/geocode/json?address="
  key <- "&key=AIzaSyCd2oCbFa2bo2p29qwX9J9Qfj4WYbRkmUI"
  url <- paste0(url,address,key)
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
                         "lat" = unlist(coord[,1]),
                         "lng" = unlist(coord[,2]),
                         stringsAsFactors = FALSE)
    
    rownames(res_df) <- NULL
    
    if(nrow(res_df) == 0){
      stop("No match found")
    }
    
    return(res_df)
  }
  
}

