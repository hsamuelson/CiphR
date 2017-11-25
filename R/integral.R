#
# Henry Samuelson 11/23/17
#
# Integral cipher

message <- "hello world"
message <- gsub(" ", "", message)
message <- tolower(message)
num_message <- asc(message)




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


asc <- function(x) { strtoi(charToRaw(x),16L) -96 }

f <- function(x){x^2} #choose a key

#Total sum of message has to be less that the area under the full range.
.range <- sum(num_message)
no_range_cover <- T
counter <- 1
#find ideal range
while(no_range_cover){
  if(counter > 1000){
    print("Needs different key: Range to large")
  }
  if(integrate(f, 0, counter)$value > .range){
    no_range_cover <- F
    #print(counter)
    break()
  }
  counter = counter + 10
}

x <- seq(0,counter,0.001)

#integrate(f, 0.5, asd)$value

encryptedM <- 0
for(j in 1:length(num_message)){
  #cat("j is", j)

  for(i in 1:length(x)){
    inter <- integrate(f,encryptedM[j],x[i] )$value
    #print(inter)
    #print("1234")
    if(abs(inter - num_message[j]) < 0.05){
      encryptedM[j +1] <- x[i]
      #print(encryptedM)
      break()
    }
  }
}
encryptedM <- encryptedM[-1]



#Decrypt

new_message <- numeric()
encryptedM <- c(0, encryptedM)

for(i in 1:(length(encryptedM) -1)){
  new_message[i] <- integrate(f, encryptedM[i], encryptedM[i + 1])$value
}
return(chr(round(new_message)))
