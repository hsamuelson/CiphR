#
# Henry Samuelson 10/18/17
#
# Tiny Encryption Algorithm
#
#' @examples
#' results <- TinyEncrypt(v0 = vq, v1 = vw)
#'v0.n <- results[1:32]
#'v1.n <- results[33:64]
#'TinyDecrypt(v0.n, v1.n)

library(compositions)
library(gmp)
library(magrittr)



#takes string
BINARY <- function(xx) {  #NEEDS TO RETURN exactly 32 regardless, should remove from front
  library(compositions)
  library(gmp)
  library(magrittr)

  numberIN <- as.double(strsplit(xx, "")[[1]])
  if(length(numberIN) > 32){
    while(length(numberIN) > 32){
      numberIN<- numberIN[-1]
    }
  }
  output <- rep(0,(32 - length(numberIN)))
  output <- c(output, numberIN)#output[(length(output) - length(numberIN)):length(output)]

  return(output)
}

BITTONUM <- function(xx) { #FIX ME !?!?!?!??!? WHY DOES 0^0 = 1!?!?!??!
  #for(i in 1:length(xx)){
  #  if(xx[i] == 1) { xx[i] <- 2}
  #}
  library(compositions)
  library(gmp)
  library(magrittr)

  xx <- xx * 2
  #print((length(xx) - 1):0)
  #if(xx[length(xx)] == 2){ xx[length(xx)] <- 1}
  suber <- 0
  if(xx[length(xx)] == 0){suber <- 1}
  return(sum(xx^((length(xx) - 1):0)) - suber)
}

BITL <- function(xx, shiftAmount) {
  xx[(length(xx) + 1): (length(xx) + shiftAmount)] <- 0
  output <- xx[-(1:shiftAmount)]
  return(output)
}

BITR <- function(xx, shiftAmount){
  xx <- xx[-((length(xx) - shiftAmount + 1):length(xx))]
  placment <- rep(0,shiftAmount)
  #return(output)
  return(c(placment, xx))
}

#xx has to be the larger integer
BITXOR <- function(xx, yy){
  output <- numeric()

  #correct yy (add zeros to the front)
  yy <- c((rep(0,length(xx) - length(yy))), yy)
  for(i in 1:length(xx)){
    if(xx[i] != yy[i]){
      output[i] <- 1
    } else {
      output[i] <- 0
    }

  }
  return(output)
}


#NOt finished
NOBINARY <- function(xx){
  library(compositions)
  library(gmp)
  library(magrittr)

  bitstring <- numeric()
  counter <- 1
  number <- as.bigz(paste0(asd, collapse = ""))
  while(number > 0){
    quotient <- round(div.bigz(number,2))
    bitz <- mod.bigz(number, 2)
    bitstring[counter] <- as.double(paste((mod.bigz(bitz, 2))))
    number <- quotient
    counter = counter + 1
    print(number)
  }
}

BITADD <- function(xx, yy) {
  #xx = dataframe
  #yy <- is number to muiltiply
  return((BITTONUM(xx) + yy))

}
#Demo inputs
vq <- BINARY("10101010101010101010101010101010")
vw <- BINARY("11011011011011011011011011011011")

TinyEncrypt <- function(v0, v1){
  library(compositions)
  library(gmp)
  library(magrittr)

  sum <- 0
  delta <- 0x9e3779b9

  for(i in 1:32){
    sum = sum + delta
    v0 <- BINARY(binary(BITTONUM(v0) + BITTONUM(BITXOR(BITXOR(BITL(v1, 4), (BINARY(binary(BITADD(v1, sum))))), BITR(v1, 5)))))
    v1 <- BINARY(binary(BITTONUM(v1) + BITTONUM(BITXOR(BITXOR(BITL(v0, 4), (BINARY(binary(BITADD(v0, sum))))), BITR(v0, 5)))))
  }
  return(c(v0, v1))
}

TinyDecrypt <- function(v0, v1){
  library(compositions)
  library(gmp)
  library(magrittr)

  sum <- 0xC6EF3720
  delta <- 0x9e3779b9

  for(i in 1:32){
    v1 <- BINARY(binary(BITTONUM(v1) - BITTONUM(BITXOR(BITXOR(BITL(v0, 4), (BINARY(binary(BITADD(v0, sum))))), BITR(v0, 5)))))
    v0 <- BINARY(binary(BITTONUM(v0) - BITTONUM(BITXOR(BITXOR(BITL(v1, 4), (BINARY(binary(BITADD(v1, sum))))), BITR(v1, 5)))))
    sum = sum - delta
  }
  return(c(v0, v1))
}



