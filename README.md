# CiphR
## Ciphr is a simple encryption library for the R-Programming Language
CiphR was created for an Independent Study on Cyber Security and Encryption, with a focus on Encryption algorithms. CiphR hopes to provide a library which allows students to learn how ciphers and encryption algorithms work.
## Installation:
If you dont have devtools already: <br>
```
install.packages("devtools")
```
Then use devtools to install Ciphr
```
install_github("ciphr", "hsamuelson")
```
After installation initialize the library using `library(ciphr)`

## Commands & Usage 
### RSA 
```
RSAkeyGen()
RSA.Decrypt(RSA.Encrypt(2198, publicKey = publicKey), privateKey = privateKey)
```
### TEA Cipher
```
vq <- BINARY("10101010101010101010101010101010")
vw <- BINARY("11011011011011011011011011011011")
results <- tiny.Encrypt(v0 = vq, v1 = vw)
v0.n <- results[1:32]
v1.n <- results[33:64]
tiny.Decrypt(v0.n, v1.n)
```
### Two Square Cipher
```
#The functions are the same if you encrypt twice you decrypt
TwoSquare.Encrypt("Doza went to the store", "axc", "poa")
#the output put back in
TwoSquare.Encrypt("xcwcvfntqcthgqqcqf", "axc", "poa")
```
### vienere Cipher
```
message <- "helloizyx"
key <- "zyaa"
Vigenere.Decrypt(Vigenere.Encrypt(message, key), key)
```
### Autokey Cipher
```
message <- "helloizyx"
key <- "zyaa"
auto.Encrypt(message, key)
auto.Decrypt(auto.Encrypt(message, key), key)
```
