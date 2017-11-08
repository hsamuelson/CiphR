#
# Henry samuelson 11/2/17
#
# RSA
#
#' @examples
#' RSA.Decrypt(RSA.Encrypt(2198, publicKey = publicKey), privateKey = privateKey)

library(numbers)
library(gmp)
RSAkeyGen <- function(
  p = 61,
  q = 53) {
  library(numbers)
  library(gmp)
  n = q*p
  #n
  totient <- LCM(q-1, p-1)

  e <- 17 # e has to to be co prome with totient
  e <- numeric()
  coPrime.T <- T
  while(coPrime.T) {
    ran.int <- floor(runif(1, 0, totient))
    if(coprime(totient, ran.int)){
      coPrime.T <- F
      e <- ran.int
    }
  }

  #euler Metheod
  # (d * e) %% totient = 1
  for (x in 1:1000000){
    if ((1+x*totient)%%e == 0 && isprime((1+x*totient)/e)==0 ){
      d <<- (1+x*totient)/e
      if (isprime(d) != 0){
        return("D is prime, Error")
      }
      break
    }
  }

  publicKey <<- list(n, e)
  privateKey <<- list(n, d)
  #return(c(publicKey, privateKey))
  #print(publicKey)
  #print(privateKey)
}

message <- 1234 #Up to four digits if more the program breaks

RSA.Encrypt <- function(message, publicKey) {
  library(numbers)
  library(gmp)
  n1 <- publicKey[[1]]
  e1 <- publicKey[[2]]
  return(as.integer(mod.bigz(as.bigz(pow.bigz(message, e1)), n1)))
}
RSA.Decrypt <- function(message.Rescived, privateKey){
  library(numbers)
  library(gmp)
  n1 <- privateKey[[1]]
  d1 <- privateKey[[2]]
  return(as.integer(mod.bigz(as.bigz(pow.bigz(message.Rescived, d1)), n1)))
}





