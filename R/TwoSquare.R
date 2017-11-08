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

getNewVal <- function(num1, num2, zxc){


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
  #cat("letter1.y", letter1.y)
  #cat("cipher 1:", letter1.y, letter1.x, "...")

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
  #cat("cipher 2:", letter2.y, letter2.x, "...")

  if(letter2.y == letter1.y){
    #print("they are same row")
    return(paste(num1, num2, sep =""))
  }
  newPoints <- numeric()
  newPoints[1] <- zxc[letter2.y, letter1.x]
  newPoints[2] <- zxc[letter1.y, letter2.x]
  return(newPoints)
}

aplhaRemove <- function(texts){
  asd <- numeric()
  counter = 1
  alphWithoutJ <- letters[-10]
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

TwoSquare.encrypt <- function(message, key1, key2){
  #Put message into pairs of two
  x <- tolower(message)
  #CHANGE ALL TO LOWER CASE NEED TO DOO!!!!!
  #
  #
  x <- gsub(" ", "", x)
  x <- substring(x, seq(1,nchar(x),2), seq(2,nchar(x),2))
  #print(x)

  #Create two tables for the key words
  key1.Matrix <- matrix(0,5,5)
  key2.Matrix <- matrix(0,5,5)

  #appended the key words into the matrixes

  #Matrix 1
  key1.split <- strsplit(key1, "")[[1]]
  #cat("key split", key1.split, length(key1.split))

  counter <- 1
  for(i in 1:length(key1.split)){
    key1.Matrix[i] <- key1.split[i]
    counter = counter + 1
  }
  #print(key1.Matrix)
  #alpha <-alpha[alpha != key1.split]
  alpha <- aplhaRemove(key1.split)
  #cat("ALPAHA IS", alpha)
  for(i in counter:length(key1.Matrix)){
    #added remaining alphabet
    key1.Matrix[i] <- alpha[i-counter + 1]
  }
  #print(key1.Matrix)

  #Matrix 2
  key2.split <- strsplit(key2, "")[[1]]
  #cat("key split", key2.split, length(key2.split))

  counter <- 1
  for(i in 1:length(key2.split)){
    key2.Matrix[i] <- key2.split[i]
    counter = counter + 1
  }
  #print(key2.Matrix)
  #alpha <-alpha[alpha != key1.split]
  alpha <- aplhaRemove(key2.split)
  #cat("ALPAHA IS", alpha)
  for(i in counter:length(key2.Matrix)){
    #added remaining alphabet
    key2.Matrix[i] <- alpha[i-counter + 1]
  }
  #print(key2.Matrix)


  #Finding distance between selected letters
  fullmatrix <- cbind(key1.Matrix, key2.Matrix)
  #print("FULL MATRIX")
  #print(fullmatrix)
  #print(typeof(fullmatrix))
  encryptMessage <- 0
  for(i in 1:length(x)){
    #cat("INput1: ", strsplit(x[i], "")[[1]][1])
    #cat("INput2: ", strsplit(x[i], "")[[1]][2])
    #print("")

    newPair <- getNewVal(strsplit(x[i], "")[[1]][1], strsplit(x[i], "")[[1]][2], as.matrix(fullmatrix))
    #old if it was a replacement
    if(length(newPair) != 1) {
      encryptMessage[i] <- paste(newPair[1], newPair[2],sep = "")

    }else {
      encryptMessage[i] <- newPair[1]
    }
    #print(encryptMessage)
  }
  print("Printing encrypted message")
  print(encryptMessage)

}
#encrypt("doog", "axc", "poa")


#decrypt
#the functions are actually the same if you encrypt twice you decrypt
TwoSquare.decrypt <- function(num1, num2, message){
  TwoSquare.encrypt(num1, num2, message)
}

