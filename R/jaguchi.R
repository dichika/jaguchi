#' @export
jaguchi <- function(apiname, ...){
  checkPkg(apiname)
  class(apiname) <- apiname
  UseMethod("jaguchi", apiname)
}

#' @export
jaguchi.slideshare <- function(x,url,key,secret){
  require(slideshare)
  test <- Slideshare$new(apikey=key,sharedsecret=secret)
  res <- test$getSlideshow(url)
  return(res)
}

#' @export
jaguchi.speakerdeck <- function(x, url){
  require(speakerdeck)
  res <- getInfo(url)
  return(res)
}

sorry <- function(x){
  cat(sprintf("\nSorry, there is no jaguchi for %s...", x))
}

checkPkg <- function(x){
  lists <- c("slideshare", "speakerdeck")
  pkgnames <- c("slideshare", "speakerdeck")
  urls <- c("http://github.com/dichika/slideshare",
            "http://github.com/dichika/speakerdeck")
  
  trg_package <- pkgnames[match(x, lists)]
  trg_url <- urls[match(x, lists)]
  if(is.na(trg_package)){
    stop(sorry(x))
  }
  try(good <- find.package(trg_package, quiet=TRUE))
  if(length(good)==0){
    stop(sprintf("\nPlease install '%s'\ncheck %s", trg_package, trg_url))
  }
}
