# Name: Sam Delaney
# Student ID: 564284
# CMPT 360 Fall 2018
# Lab 7
# Random Number Generator

#R version 3.5.1

seedA <- 2L
seedB <- 3L
seedC <- 4L
seedD <- 5L
seedE <- 0L

i <- 0 #iterator for for loop later

xorwow <- function() {
  
  #assignment phase 1
  t <- as.integer(seedD)
  
  #operational phase 1
  t <- bitwShiftR(t, 2L)
  t <- bitwShiftL(t, 1L)
  
  #assignment phase 2
  seedD <- seedC
  seedC <- seedB
  seedB <- seedA
  s <- as.integer(seedA)
  
  #operational phase 2
  t <- bitwXor(t, s)
  t <- bitwXor(t, bitwShiftL(s, 4L))
  
  #assignment phase 3
  seedE <- seedE + 362437
  
  #return statement
  t + seedE
}

getinput <- function()
{ 
  n <- readline(prompt="Enter a positive integer: ")
  n <- as.integer(n)
  if(is.na(n) | n <= 0)
  {
    print("Invalid input!")
    return(getinput())
  }
  return(n)
}

print("Welcome to the R xorwow Random Number Generator")
print("This random generator needs seeds. Please provide 5.")
seedA <- getinput()
seedB <- getinput()
seedC <- getinput()
seedD <- getinput()
seedE <- getinput()

repeat
{
  print("To get a new random number, provide a maximum value.(Press ESC to exit)")
  n <- getinput()
  n <- xorwow() %% n
  cat("Random Number: ", n, "\n")
}