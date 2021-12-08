#assing values and print
myString <- "Hello"
print(myString)


#create a vector (c stands for combine)
apple <- c('red', 'green', "yellow")
print(apple)

print(class(apple))


#create a list (can hold different types of elements)
li1 <- list(c(2,5,3), 21.3, sin)
print(li1)

#create a matrix
m = matrix(c('a','b','c','d','e','f'), nrow = 2, ncol = 3, byrow = TRUE)
print(m)

#byrow = true -> filling begins with the first line, continues w second etc
#byrow = false -> fill by columns


#array (can be any number of dimensions - 3d matrix)

#create array with 2 3x3 matrices
a <- array(c('green', 'yellow'), dim = c(3,3,2))
print(a)


#factor: stores a vector along with its distinct values
#      : similar to vct.extend(set(vct))

apple_colors <- c('green', 'red', 'red', 'yellow', 'green')
factor_apple <- factor(apple_colors)
print(factor_apple)
print(nlevels(factor_apple))  #nr. of elements in set(vct)


#data.frame -> a matrix which you define by named columns (like in an excel)
BMI <- data.frame(
  gender = c("Male", "M", "F"),
  height = c(152, 171.5, 165),
  weight = c(81, 93, 78),
  age = c(42,38,26)
)
print(BMI)