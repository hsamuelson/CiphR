#
#Henry Samuelson
#
#vienere Cipher
#

#' @examples
#' message <- "helloizyx"
#' key <- "zyaa"
#' VinereDecrypt(VienereEncrypt(message, key), key)



chr <- function(n) {
  final <- character()
  for(i in 1:length(n)){
    if(n[i] != 0){
      final[i] <- rawToChar(as.raw(n[i]%%26 + 96))
    }
    else{
      final[i] <- "z"
    }
  }
  for(i in 1:length(final)){
    if(final[i] == "`"){
      final[i] <- "z"
    }
  }
  return(paste0(final, collapse = ""))
} #to charaters


asc <- function(x) { strtoi(charToRaw(x),16L) -96 } #to numeric

VienereEncrypt <- function(message, key){
  numbers <- asc(message)
  key <- asc(key)

  options(warn=-1) #this throughs an invalid error
  encryptedMessage <- (key + numbers)#%%26
  #options(warn = 0)

  return(chr(encryptedMessage))
  options(warn = 0)
}

VinereDecrypt <- function(message, key){
  numbers <- asc(message)
  key <- asc(key)

  options(warn=-1) #this throughs an invalid error
  encryptedMessage <- (numbers - key)%%26
  #options(warn = 0)

  return(chr(encryptedMessage))
  options(warn = 0)
}



