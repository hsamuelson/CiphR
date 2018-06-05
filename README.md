# CiphR
## CiphR is a simple encryption library for the R-Programming Language
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

### Ceasar Cipher
In cryptography, a Caesar cipher, also known as Caesar's cipher, the shift cipher, Caesar's code or Caesar shift, is one of the simplest and most widely known encryption techniques. It is a type of substitution cipher in which each letter in the plaintext is replaced by a letter some fixed number of positions down the alphabet. For example, with a left shift of 3, D would be replaced by A, E would become B, and so on. 
```
ceasar.Decrypt(ceasar.Encrypt("helloworld", 13), 13)
```
### Affine Cipher
 Discription (from wiki)
 The affine cipher is a type of monoalphabetic substitution cipher, wherein each letter
 in an alphabet is mapped to its numeric equivalent, encrypted using a simple mathematical
 function, and converted back to a letter. The formula used means that each letter encrypts
 to one other letter, and back again, meaning the cipher is essentially a standard substitution
 cipher with a rule governing which letter goes to which. As such, it has the weaknesses
 of all substitution ciphers. Each letter is enciphered with the function (ax + b) mod 26,
 where b is the magnitude of the shift.
```
encryptedMessage <- affine.Encrypt(key.a = 3, key.b = 4, "hello world")
affine.Decrypt(key.a = 3, key.b = 4, encryptedMessage)
```
### Baconian Cipher
This cipher works by subing each letter for a series of A's and B's
this effectivly worls by converting each letter into a number 0-25 than giving it a binary value
A being zeros and B's being 1's
```
baconian.Decrypt(baconian.Encrypt("helloworld"))
```
### Two Square Cipher
The Two-square cipher, also called double Playfair, is a manual symmetric encryption technique .
 It was developed to ease the cumbersome nature of the large encryption/decryption matrix used
 in the four-square cipher while still being slightly stronger than the (single-square) Playfair
cipher.

#### IMPORTANT
Though this cipher is not case sensitive it will convert to all lowercase.
   It is also important to note that it will ignore the letter "j"
```
#The functions are the same if you encrypt twice you decrypt
TwoSquare.Encrypt("Doza went to the store", "axc", "poa")
#the output put back in
TwoSquare.Encrypt("xcwcvfntqcthgqqcqf", "axc", "poa")
```
### Vigenère Cipher
In a Caesar cipher, each letter of the alphabet is shifted along some number of places; for example, in a Caesar cipher of shift 3, A would become D, B would become E, Y would become B and so on. The Vigenère cipher consists of several Caesar ciphers in sequence with different shift values.
To encrypt, a table of alphabets can be used, termed a tabula recta, Vigenère square, or Vigenère table. It consists of the alphabet written out 26 times in different rows, each alphabet shifted cyclically to the left compared to the previous alphabet, corresponding to the 26 possible Caesar ciphers. At different points in the encryption process, the cipher uses a different alphabet from one of the rows. The alphabet used at each point depends on a repeating keyword.
```
message <- "helloizyx"
key <- "zyaa"
Vigenere.Decrypt(Vigenere.Encrypt(message, key), key)
```
### Autokey Cipher
An autokey cipher (also known as the autoclave cipher) is a cipher which
 incorporates the message (the plaintext) into the key. There are two forms
 of autokey cipher: key autokey and text autokey ciphers. A key-autokey
 cipher uses previous members of the keystream to determine the next element
 in the keystream. A text-autokey uses the previous message text to
 determine the next element in the keystream.
```
message <- "helloizyx"
key <- "zyaa"
auto.Encrypt(message, key)
auto.Decrypt(auto.Encrypt(message, key), key)
```
### TEA Cipher
TEA operates on two 32-bit unsigned integers (could be derived from a 64-bit data block
 and uses a 128-bit key. It has a Feistel structure with a suggested 64 rounds, typically
 implemented in pairs termed cycles. It has an extremely simple key schedule, mixing all
 of the key material in exactly the same way for each cycle. Different multiples of a
 magic constant are used to prevent simple attacks based on the symmetry of the rounds.
 The magic constant, 2654435769 or 0x9E3779B9 is chosen to be ⌊232/ϕ⌋, where ϕ is the
 golden ratio.
```
vq <- BINARY("10101010101010101010101010101010")
vw <- BINARY("11011011011011011011011011011011")
results <- tiny.Encrypt(v0 = vq, v1 = vw)
v0.n <- results[1:32]
v1.n <- results[33:64]
tiny.Decrypt(v0.n, v1.n)
```
### RSA 
RSA (Rivest–Shamir–Adleman) is one of the first practical public-key cryptosystems
and is widely used for secure data transmission. In such a cryptosystem, the
 encryption key is public and it is different from the decryption key which is kept
 secret (private). In RSA, this asymmetry is based on the practical difficulty of
 the factorization of the product of two large prime numbers, the "factoring problem"
```
RSAkeyGen()
RSA.Decrypt(RSA.Encrypt(2198, publicKey = publicKey), privateKey = privateKey)
```
### Integral Encryption
This is my own encryption algorithm. Read this for more information: https://github.com/hsamuelson/CiphR/blob/master/Integral%20Encryption.pdf
### Frequency Analysis 
This function uses frequency analysis to crack ceasar Ciphers. Simply input encrypted text and it will return the decrypted message
```
ceasar.FrequencyAnalysis(ceasar.Encrypt("hellomynameisbobandiliketogotheparkandeatfoodbecasueithinkitisfun", 4))
```
