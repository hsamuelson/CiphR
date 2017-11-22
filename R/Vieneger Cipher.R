#
#Henry Samuelson
#
#Vigenère Cipher 10/10/17
#
#
# In a Caesar cipher, each letter of the alphabet is shifted along some number of places;
# for example, in a Caesar cipher of shift 3, A would become D, B would become E, Y would
# become B and so on. The Vigenère cipher consists of several Caesar ciphers in sequence
# with different shift values.
#
# To encrypt, a table of alphabets can be used, termed a tabula recta, Vigenère square,
# or Vigenère table. It consists of the alphabet written out 26 times in different rows,
# each alphabet shifted cyclically to the left compared to the previous alphabet, corresponding
# to the 26 possible Caesar ciphers. At different points in the encryption process, the cipher
# uses a different alphabet from one of the rows. The alphabet used at each point depends on
# a repeating keyword.
#
#' @examples
#' message <- "helloizyx"
#' key <- "zyaa"
#' Vigenere.Decrypt(Vigenere.Encrypt(message, key), key)



chr <- function(n) { #Converts and sequences numbers and returns letters
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

Vigenere.Encrypt <- function(message, key){
  message <- tolower(message) #make sure message is lower case
  numbers <- asc(message)
  key <- asc(key)

  options(warn=-1) #this throws an invalid error so we supress the error
  encryptedMessage <- (key + numbers)

  return(chr(encryptedMessage))
  options(warn = 0)
}

Vigenere.Decrypt <- function(message, key){
  message <- tolower(message)
  numbers <- asc(message)
  key <- asc(key)

  options(warn=-1) #this throughs an invalid error
  encryptedMessage <- (numbers - key)%%26 #Do the opposite and subtract the keys
  #options(warn = 0)

  return(chr(encryptedMessage))
  options(warn = 0)
}



