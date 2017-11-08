#
# Henry Samuelson
#
#Auto Key Cipher
#
# Description from Wikipedia
# An autokey cipher (also known as the autoclave cipher) is a cipher which
# incorporates the message (the plaintext) into the key. There are two forms
# of autokey cipher: key autokey and text autokey ciphers. A key-autokey
# cipher uses previous members of the keystream to determine the next element
# in the keystream. A text-autokey uses the previous message text to
# determine the next element in the keystream.
#
#' @examples
#' message <- "helloizyx"
#' key <- "zyaa"
#' autoEncrypt(message, key)
#' autoDecrypt(autoEncrypt(message, key), key)



asc <- function(x) { strtoi(charToRaw(x),16L) -96 } #to numeric
#chr <- function(n) { rawToChar(as.raw(n + 96))} #to charaters
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


autoEncrypt <- function(message, key){
  numbers <- asc(message)
  key <- asc(key)
  key <- c(key, numbers)
  options(warn=-1) #this throughs an invalid error
  encryptedMessage <- (numbers + key)##%%26
  options(warn = 0)
  encryptedMessage <- encryptedMessage[1:length(numbers)]
  return(chr(encryptedMessage))
}


autoDecrypt <- function(message, key){
  numbers <- asc(message)
  key <- asc(key)
  #key <- c(key, numbers) #The key difference from the viegnere is here

  encryptedMessage <- numeric()
  for(i in 1:length(numbers)){
    encryptedMessage[i] <- (numbers[i] - key[i])%%26
    key[length(key) + 1] <- encryptedMessage[i]
  }

  return(chr(encryptedMessage))
}
