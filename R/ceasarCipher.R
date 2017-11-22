#
# Henry Samuelson 11/19/17
#
# Ceasar Cipher
#
# In cryptography, a Caesar cipher, also known as Caesar's cipher, the shift cipher, Caesar's code or Caesar shift,
# is one of the simplest and most widely known encryption techniques. It is a type of substitution cipher in which
# each letter in the plaintext is replaced by a letter some fixed number of positions down the alphabet. For
# example, with a left shift of 3, D would be replaced by A, E would become B, and so on.

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

ceasar.Encrypt <- function(message, shiftAmount){
  chr(asc(message) + shiftAmount)
}
ceasar.Decrypt <- function(message, shiftAmount){
  chr(asc(message) - shiftAmount)
}
