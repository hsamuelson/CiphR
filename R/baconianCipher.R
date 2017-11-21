#
# Henry Samuelson 11/21/17
#
# Baconian Cipher
#
# This cipher works by subing each letter for a series of A's and B's
# This effectivly worls by converting each letter into a number 0-25 than giving it a binary value
# A being zeros and B's being 1's
#
# This table shows the whole alphebet
# a =  "AAAAA";   g = "AABBA";    m =  "ABABB";   s  =  "BAAAB";     y  =  "BABBA";
# b =  "AAAAB";   h =   "AABBB";    n =   "ABBAA";   t =   "BAABA";     z =   "BABBB";
# c =  "AAABA";  i =   "ABAAA";   o  =  "ABBAB";   u =   "BAABB";
# d =  "AAABB";  j  =  "BBBAA";     p  =  "ABBBA";   v  =  'BBBAB';
# e =  "AABAA";  k  =  "ABAAB";    q  =  "ABBBB";   w  =  "BABAA";
# f =  "AABAB";   l =   "ABABA";    r =  "BAAAA";   x =   'BABAB';



library(compositions)
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

message <- "helloworld"
baconian.Encrypt <- function(message){
  x <- tolower(message) #convert message to lower case
  x <- gsub(" ", "", x) #remove all splaces
  x <- asc(x)
  x <- binary(x)
  x <- paste0(x, collapse = "")
  x <- strsplit(x, "")[[1]]
  for(i in 1:length(x)){
    x[i] <- if(x[i] == "0") "A" else "B"
  }
  return(paste0(x, collapse = ""))
}

baconian.Decrypt <- function(message){
  x <- strsplit(message, "")[[1]]
  for(i in 1:length(x)){
    x[i] <- if(x[i] == "A") "0" else "1"
  }
  results <- list()
  for(i in 1:(length(x)/ 5)){
    results[[i]] <- x[1:5]
    x <- x[-(1:5)]
  }
  finalRes <- numeric()
  options(warn=-1)
    for(i in 1:length(results)){
      finalRes[i] <- unbinary(paste0(results[[i]], collapse = ""))
    }
  options(warn=0)

  return(chr(finalRes))
}
