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

ceasar.FrequencyAnalysis <- function(messageF){
  frequencyCount <- sort(table(strsplit(messageF, "")[[1]]))
  e <- tolower(names(sortedTable[length(sortedTable)]))

  #Shift forward until the letter is e
  return(ceasar.Decrypt(messageF, (asc(e) - 5)))
}
#Example tests
#ceasar.FrequencyAnalysis(ceasar.Encrypt("hellomynameishenryandiliektogotheparkandeatfoodbecasueithinkitisfun", 4))

