#
# Henry Samuelson 11/20/17
#
# Affine Cipher
#
# Discription (from wiki)
# The affine cipher is a type of monoalphabetic substitution cipher, wherein each letter
# in an alphabet is mapped to its numeric equivalent, encrypted using a simple mathematical
# function, and converted back to a letter. The formula used means that each letter encrypts
# to one other letter, and back again, meaning the cipher is essentially a standard substitution
# cipher with a rule governing which letter goes to which. As such, it has the weaknesses
# of all substitution ciphers. Each letter is enciphered with the function (ax + b) mod 26,
# where b is the magnitude of the shift.

#' @examples
#' message <- "Hello what a wonderful Day"
#' key.a <- 3 has to be co-prime with length of alphabet i.e. (26)
#' key.b <- 4

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



affine.Encrypt <- function(key.a = 3, key.b = 4, message){

  x <- tolower(message) #convert message to lower case
  x <- gsub(" ", "", x) #remove all splaces
  x <- asc(x) #convert message into numeric from string


  #use the mod equation described in the description to encrypt
  #E(x) = (ax +b)%%m
  #m being the number of letters in alphabet
  return(chr(((key.a * x) + key.b)%% 26))
}


#Decrypt
affine.Decrypt <- function(key.a = 3, key.b = 4, message){
  library(numbers)
  message <- asc(message)
  #use the mod equation described in the description to encrypt
  #D(x) = a^-1*(x-b) %% m
  #m being the number of letters in alphabet
  chr((modinv(key.a, 26) * (message - key.b))%%26)
}


