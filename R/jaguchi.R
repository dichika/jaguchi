#' @export
jaguchi <- function(apiname, ...){
  jaguchi::checkPkg(apiname)
  class(apiname) <- apiname
  res <- UseMethod("jaguchi", apiname)
  return(res)
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
  res <- speakerdeck::getInfo(url)
  return(res)
}

#' @export
jaguchi.hatenab <- function(x, url){
  require(hatenab)
  res <- getBookmarkCount(url)
  return(res)
}

#' @export
jaguchi.sinchokur <- function(x, username){
  require(sinchokur)
  res <- getPubContribution(username)
  return(res)
}

#' @export
jaguchi.yfj <- function(x, code, start_date, end_date){
  require(RFinanceJ)
  res <- rfinancej(code=code,
                   type="data.frame",
                   start_date=start_date,
                   end_date=end_date,
                   frequency="daily",
                   src="yahoo")
  res <- as.data.frame(res, stringsAsFactors=FALSE)
  return(res)
}

#' @export
jaguchi.niconicoi <- function(x, ids){
  require(niconico)
  res <- niconico::getInfo(ids)
  return(res)
}

#' @export
jaguchi.niconicos <- function(x, query, size, type=c("word","tag")){
  require(niconico)
  res <- niconico::getSearch(query, size, type)
  return(res)
}

#' @export
jaguchi.pixiv <- function(x, query){
  require(pixiv)
  res <- getSearch(query)
  return(res)
}


#' @export
sorry <- function(x){
  cat(sprintf("\nSorry, there is no jaguchi for %s...", x))
}

#' @export
checkPkg <- function(x){
  lists <- c("slideshare", "speakerdeck","hatenab","sinchokur","yfj","niconicoi","niconicos",
             "pixiv")
  pkgnames <- c("slideshare", "speakerdeck","hatenab","sinchokur","RFinanceJ","niconico","niconico",
                "pixiv")
  urls <- c("dichika/slideshare",
            "dichika/speakerdeck",
            "dichika/hatenab",
            "dichika/sinchokur",
            "teramonagi/RFinanceJ",
            "dichika/niconico",
            "dichika/niconico",
            "dichika/pixiv"
  )
  
  trg_package <- pkgnames[match(x, lists)]
  trg_url <- urls[match(x, lists)]
  if(is.na(trg_package)){
    stop(sorry(x))
  }
  try(good <- find.package(trg_package, quiet=TRUE))
  if(length(good)==0){
    stop(sprintf("\nPlease install '%s'\ntry devtools::install_github('%s')", trg_package, trg_url))
  }
}
