#
# Henry Samuelson 9/10/17
#
# Two square cipher
#
# From Wikipedia
#The Two-square cipher, also called double Playfair, is a manual symmetric encryption technique .
# It was developed to ease the cumbersome nature of the large encryption/decryption matrix used
# in the four-square cipher while still being slightly stronger than the (single-square) Playfair
# cipher.
#
# IMPORTANT
#   Though this cipher is not case sensitive it will convert to all lowercase.
#   It is also important to note that it will ignore the letter "j"


#' @examples
#'  TwoSquare.Encrypt("Doza went to the store", "axc", "poa")
#' the output put back in
#' TwoSquare.Encrypt("xcwcvfntqcthgqqcqf", "axc", "poa")
#

#Get Val finds the new values for pairs accross matrixes
getNewVal <- function(num1, num2, zxc){

#Find num1 in the first matrix
  letter1.x <- 0
  letter1.y <- 0
  for(i in 1:5){
    for(j in 1:5){
      if(zxc[i,j] == num1){
        letter1.y <- i
        letter1.x <- j
      }
    }
  }

  #Find num2 in second matrix
  letter2.x <- 0
  letter2.y <- 0
  for(i in 1:5){
    for(j in 6:10){
      if(zxc[i,j] == num2){
        letter2.y <- i
        letter2.x <- j
      }
    }
  }
  #If they are the same letter keep the letters the same.
  if(letter2.y == letter1.y){
    return(paste(num1, num2, sep =""))
  }
  newPoints <- numeric()
  newPoints[1] <- zxc[letter2.y, letter1.x] #Preform the switch by switching on the selected corners of the square
  newPoints[2] <- zxc[letter1.y, letter2.x]
  return(newPoints)
}

#Creates alphebet list in order with message, creates 5x5 square
aplhaRemove <- function(texts){
  asd <- numeric()
  counter = 1
  alphWithoutJ <- letters[-10] #Remove J from alphebet so it fits into a 5x5 square
  for(i in 1:length(alphWithoutJ)){
    flag = T
    for(j in 1:length(texts)){
      if(alphWithoutJ[i] == texts[j]){
        flag = F
      }
    }
    if(flag){
      asd[counter] <- alphWithoutJ[i]
      counter = counter + 1
    }
  }

  return(asd)
}

TwoSquare.Encrypt <- function(message, key1, key2){

  #Make message all lower case to avoid Errors with different capital values
  x <- tolower(message)

  #format x
  x <- gsub(" ", "", x)

  #Put x into pairs of two
  x <- substring(x, seq(1,nchar(x),2), seq(2,nchar(x),2))
  #print(x)

  #Create two tables for the key words
  key1.Matrix <- matrix(0,5,5)
  key2.Matrix <- matrix(0,5,5)

  #appended the key words into the matrixes

  #Matrix 1
  key1.split <- strsplit(key1, "")[[1]]

  counter <- 1
  for(i in 1:length(key1.split)){
    key1.Matrix[i] <- key1.split[i]
    counter = counter + 1
  }

  alpha <- aplhaRemove(key1.split)

  for(i in counter:length(key1.Matrix)){
    #adding remaining alphabzet
    key1.Matrix[i] <- alpha[i-counter + 1]
  }

  #Matrix 2
  key2.split <- strsplit(key2, "")[[1]]

  counter <- 1
  for(i in 1:length(key2.split)){
    key2.Matrix[i] <- key2.split[i]
    counter = counter + 1
  }

  alpha <- aplhaRemove(key2.split)

  for(i in counter:length(key2.Matrix)){
    #adding remaining alphabet
    key2.Matrix[i] <- alpha[i-counter + 1]
  }


  #Finding distance between selected letters
  fullmatrix <- cbind(key1.Matrix, key2.Matrix)

  encryptMessage <- 0
  for(i in 1:length(x)){

    newPair <- getNewVal(strsplit(x[i], "")[[1]][1], strsplit(x[i], "")[[1]][2], as.matrix(fullmatrix))
    #old if it was a replacement
    if(length(newPair) != 1) {
      encryptMessage[i] <- paste(newPair[1], newPair[2],sep = "")

    }else {
      encryptMessage[i] <- newPair[1]
    }

  }

  #print(encryptMessage)
  #Removes pairings
  print(paste0(encryptMessage, collapse = ""))

}

