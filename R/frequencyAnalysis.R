#
# Henry Samuelson 1/3/18
#
# Frequency Analysis for Ceasar Ciphers
#


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

messagex <- ceasar.Encrypt("hellomynameishenryandiliektogotheparkandeatfoodbecasueithinkitisfun", 4)
asd <- strsplit(messagex, "")[[1]]
frequencyCount <- table(asd)
sortedTable <- sort(frequencyCount)

e <- tolower(names(sortedTable[length(sortedTable)]))

#Shift forward until the letter is e
ceasar.Decrypt(messagex, (asc(e) - 5))
