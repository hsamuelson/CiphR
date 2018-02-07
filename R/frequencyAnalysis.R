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
  e <- tolower(names(frequencyCount[length(frequencyCount)]))

  #Shift forward until the letter is e
  return(ceasar.Decrypt(messageF, (asc(e) - 5)))
}
#Example tests
#ceasar.FrequencyAnalysis(ceasar.Encrypt("hellomynameishenryandiliektogotheparkandeatfoodbecasueithinkitisfun", 4))


#Two primes
p1 <- 6659707331
p2 <- 2274922729


#messageF <- "hellomynameishenryandiliektogotheparkandeatfoodbecasueithinkitisfun" #test input

subsutution.FrequencyAnalysis <- function(messageF){
  frequencyLetter <- c("E", "T", "A", "O","I", "N", "S", "R", "H", "D", "L", "U", "C", "M", "F", "Y", "W", "G", "P", "B", "V", "K", "X", "Q", "J", "Z")
  frequencyChance <- as.double(c(	12.02,
                                  9.10,	8.12,	7.68,	7.31,	6.95,	6.28,	6.02,	5.92,
                                  4.32,	3.98,	2.88,	2.71,	2.61,	2.30,	2.11,	2.09,
                                  2.03,	1.82,	1.49,	1.11,  0.69,	0.17,	0.11,	0.10,
                                  0.07))

  frequencyTable <- cbind(frequencyLetter, frequencyChance)
  frequencyCount <- (sort(table(strsplit(messageF, "")[[1]])))
  #Issue here is often not all letters are used in a encrypted message
  #Which means we cannot run right through the list and find
  frequencysOfMessage <- frequencyCount/length(strsplit(messageF, "")[[1]])
  #Fill in the remaing area of the area to make 26 numbers so we can do matrix subtraction
  #frequencysOfMessage <- c(frequencysOfMessage ,rep(0,(26 -length(frequencysOfMessage))))

  newIndexs <- numeric()
  for(i in 1:length(frequencysOfMessage)){
    newIndexs[i] <- (which(abs(as.double(frequencyTable[,2])-frequencysOfMessage[i]*100)==min(abs(as.double(frequencyTable[,2])-frequencysOfMessage[i]*100))) )
  }
  letterList <- frequencyLetter[newIndexs] #Get guessed numbers in order
  officalGuesses <- cbind(names(frequencyCount), letterList) #pair them with the encrypted frequencys
  splittedMessage <- strsplit(messageF, "")[[1]]
  decrypedMessage <- numeric()
  for(i in 1:length(splittedMessage)){
    for(j in 1:length(officalGuesses[,1])){
      if(splittedMessage[i] == officalGuesses[j,1]){
        decrypedMessage[i] <- officalGuesses[j,2]
      }
    }
  }
  return(list(decrypedMessage, officalGuesses))
}

