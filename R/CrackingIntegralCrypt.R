library(ciphr)
asd <- intCrypt.Encrypt("hi there how are you doing today zap", function(x){x^2})
#asd <- intCrypt.Encrypt("too small of a hight is a good thing while to much is dangerous", function(x){x})
encryptMsg <- asd
aa <- 1/encryptMsg
zz <- 26/encryptMsg


plot(c(1:length(zz))/2)
points(aa, type = "o")
points(zz, type = "o")

#encrptMsg
plot(encryptMsg)

encryptMsg <- c(0, encryptMsg)
spacing <- numeric()
for(i in 1:length(encryptMsg)){
  spacing[i] <- encryptMsg[i+1] - encryptMsg[i]
}

spacing #<- c(0, spacing[-length(spacing)])
spacing <- spacing[-length(spacing)]
encryptMsg <- encryptMsg[-1]

# This is the new stuff 9/21/18
aa <- 1/spacing
middleSplice <- 13/spacing
zz <- 26/spacing

plot(middleSplice, type = "o", col ="blue", ylab = " Estamated Y height of key")
points(aa, pch=2, type = "o", col = "green")
points(zz, pch=3, type = "o", col ="red")
points(encryptMsg^2, type = "o", col = "brown", pch = 5)
plot((zz- middleSplice) - (middleSplice - aa)) #interesting that hw far the aa and zz stray from eachothers error off the middleSplice looks exactly like regular plot


ciphr::chr(round(encryptMsg^2*spacing)) #modulos are handled in chr() func

expo <- sum(spacing)/ length(spacing)
plot(spacing)
points(c(1:length(spacing))^-expo, type = "o")
