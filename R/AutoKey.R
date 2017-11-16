#
# Henry Samuelson 09/20/17
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

chr <- function(n) { #Same function used for the Viengere Cipher
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


auto.Encrypt <- function(message, key){
  message <- tolower(message) #make sure all numbers are lowercase
  numbers <- asc(message)
  key <- asc(key)
  key <- c(key, numbers)
  options(warn=-1) #this throughs an invalid error
  encryptedMessage <- (numbers + key)##%%26
  options(warn = 0)
  encryptedMessage <- encryptedMessage[1:length(numbers)]
  return(chr(encryptedMessage))
}


auto.Decrypt <- function(message, key){
  message <- tolower(message)
  numbers <- asc(message)
  key <- asc(key)

  #In order to decrypt one cannont repeat in a similar mannor to the Viginere Cipher because
  #You do not know the letters of the decryption key excet the inital numbers of the encryption key
  #So you need to recursivly decript the message.
  encryptedMessage <- numeric()
  for(i in 1:length(numbers)){
    encryptedMessage[i] <- (numbers[i] - key[i])%%26
    key[length(key) + 1] <- encryptedMessage[i]
  }

  return(chr(encryptedMessage))
}
