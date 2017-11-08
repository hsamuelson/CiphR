# Ciphr
## Ciphr is a Collection of Ciphers for The R-Programming Language
Ciphr was created for a Independent Study on Cyber Security and Encryption, with a focus on Encrytion algorithms. Ciphr is the culminating product of the course.
## Installation:
If you dont have devtools already: <br>
```
install.packages("devtools")
```
Then use devtools to install Ciphr
```
install_github("ciphr", "hsamuelson")
```
After installation initilize the library using `library(ciphr)`

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
results <- TinyEncrypt(v0 = vq, v1 = vw)
v0.n <- results[1:32]
v1.n <- results[33:64]
TinyDecrypt(v0.n, v1.n)
```
### Two Square Cipher
```
#the functions are actually the same if you encrypt twice you decrypt
TwoSquare.encrypt("DoZa went to the store", "axc", "poa")
#the output put back in
TwoSquare.encrypt("xcwcvfntqcthgqqcqf", "axc", "poa")
```
### vienere Cipher
```
message <- "helloizyx"
key <- "zyaa"
VinereDecrypt(VienereEncrypt(message, key), key)
```
### Autokey Cipher
```
message <- "helloizyx"
key <- "zyaa"
autoEncrypt(message, key)
autoDecrypt(autoEncrypt(message, key), key)
```
