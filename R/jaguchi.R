#' @export
jaguchi <- function(apiname, pkgcheck=TRUE, ...){
  if(pkgcheck){
    jaguchi::checkPkg(apiname)    
  }
  class(apiname) <- apiname
  res <- UseMethod("jaguchi", apiname)
  return(res)
}

#' @export
jaguchi.slideshare <- function(x,url,key,secret, ...){
  require(slideshare)
  test <- Slideshare$new(apikey=key,sharedsecret=secret)
  res <- test$getSlideshow(url)
  return(res)
}

#' @export
jaguchi.speakerdeck <- function(x, url, ...){
  require(speakerdeck)
  res <- speakerdeck::getInfo(url)
  return(res)
}

#' @export
jaguchi.hatenab <- function(x, url, ...){
  require(hatenab)
  res <- getBookmarkCount(url)
  return(res)
}

#' @export
jaguchi.sinchokur <- function(x, username, ...){
  require(sinchokur)
  res <- getPubContribution(username)
  return(res)
}

#' @export
jaguchi.yfj <- function(x, code, start_date, end_date, ...){
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
jaguchi.niconicoi <- function(x, ids, ...){
  require(niconico)
  res <- niconico::getInfo(ids)
  return(res)
}

#' @export
jaguchi.niconicos <- function(x, query, size, type=c("word","tag"), ...){
  require(niconico)
  res <- niconico::getSearch(query, size, type)
  return(res)
}

#' @export
jaguchi.pixiv <- function(x, query, ...){
  require(pixiv)
  res <- pixiv::getSearch(query)
  return(res)
}

#' @export
jaguchi.connpass <- function(x, event_id, ...){
  require(connpass)
  res <- connpass::getInfo(event_id)
  return(res)
}

#' @export
jaguchi.brewdata <- function(x, years=2015, term="F", degree="phd", focus="statistics", resolution=10, ...){
  require(brewdata)
  res <- brewdata::brewdata(years=years, term=term, degree=degree, focus=focus, resolution=resolution)
  return(res)
}

#' @export
jaguchi.nhk <- function(x, login_id, password, ...){
  require(NHKG)
  res <- getSinchokuGogaku(options()$NHK_G_ID,options()$NHK_G_PWD)
  return(res)
}

#' @export
jaguchi.ore <- function(x, ...){
  require("RCurl")
  u <- getURL("https://raw.githubusercontent.com/dichika/mydata/master/ore.csv")
  res <- read.csv(text=u, as.is=TRUE)
  return(res)
}

#' @export
jaguchi.myroom <- function(x, ...){
  require("RCurl")
  u <- getURL("https://raw.githubusercontent.com/dichika/mydata/master/room.csv")
  res <- read.csv(text=u, as.is=TRUE)
  return(res)
}

#' @export
jaguchi.ore_weight <- function(x, ...){
  require("RCurl")
  u <- getURL("https://raw.githubusercontent.com/dichika/mydata/master/ore_wt.csv")
  res <- read.csv(text=u, as.is=TRUE)
  return(res)
}

#' @export
sorry <- function(x){
  cat(sprintf("\nSorry, there is no jaguchi for %s...", x))
}

#' @export
checkPkg <- function(x){
  lists <- c("slideshare", "speakerdeck","hatenab","sinchokur","yfj","niconicoi","niconicos",
             "pixiv", "connpass","brewdata","nhk","ore","myroom","ore_weight")
  pkgnames <- c("slideshare", "speakerdeck","hatenab","sinchokur","RFinanceJ","niconico","niconico",
                "pixiv", "connpass","brewdata","NHKG","RCurl","RCurl","RCurl")
  urls <- c('devtools::install_github("dichika/slideshare")',
            'devtools::install_github("dichika/speakerdeck")',
            'devtools::install_github("dichika/hatenab")',
            'devtools::install_github("dichika/sinchokur")',
            'devtools::install_github("teramonagi/RFinanceJ")',
            'devtools::install_github("dichika/niconico")',
            'devtools::install_github("dichika/niconico")',
            'devtools::install_github("dichika/pixiv")',
            'devtools::install_github("dichika/connpass")',
            'install.packages("brewdata")',
            'devtools::install_github("dichika/NHKG")',
            'install.packages("RCurl")',
            'install.packages("RCurl")',
            'install.packages("RCurl")'
  )
  
  trg_package <- pkgnames[match(x, lists)]
  trg_url <- urls[match(x, lists)]
  if(is.na(trg_package)){
    stop(sorry(x))
  }
  try(good <- find.package(trg_package, quiet=TRUE))
  if(length(good)==0){
    stop(sprintf("\nPlease install '%s'\ntry %s)", trg_package, trg_url))
  }
}
