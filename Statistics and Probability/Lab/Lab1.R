x = 2
print(x)


apple <- c('r', 'g', 'y', 6, 7, "abc")
print(apple)
print(class(apple))


x = 2
x

list1 = list(c(2, 5, 3), 21.3, sin)
print(list1)


# Create a matrix.
M = matrix( c('a','a','b','c','b','a'), nrow = 2, ncol = 3, byrow = TRUE)
print(M)

#byrow = true -> se incepe fill-ul pe linii

M = matrix( c('a','a','b','c','b','a'), nrow = 2, ncol = 3, byrow = FALSE)
print(M)



BMI <- 	data.frame(
  gender = c("Male", "Male","Female"), 
  height = c(152, 171.5, 165), 
  weight = c(81,93, 78),
  Age = c(42,38,26)
)
print(BMI)


var.1 = c(0, 1, 2, 3)
print(var.1)
cat("var.1 is", var.1, "\n")


ls()    #GLOBAL VARIABLES LIST
list_var = ls()
print(list_var)


rm(MI)  #delete global variable
print(MI)   #ERROR


list_var_2  = ls()
rm(list_var_2)  #deletes only the variable l_v_2

rm(list = ls()) #delete all variables


x = 2.5
y = 3
a = X + y
b = x - y
c = x * y
d = x / y
cat(a, b, c, d)

x = 8
y = 3
d = x /y   #impartire reala
d

v = c(2, 5.5, 6)
t <- c(8, 3, 4)
print( v+ t)  #2+8, 5.5 +3, 6 + 4
print(v - t)
print(v / t)

print(v > t)

v = c(2, 5.5, 6, 9)
t <- c(8, 3, 4)
print( v+ t)  #2+8, 5.5 +3, 6 + 4, !!!!!!! 9 + 8 bc v is shorter


x = 5:22
print(x)

x = 1:100
M = matrix(x, nrow = 4, ncol = 25, byrow= TRUE)
M


v1 <- 8
v2 <- 12
t <- 1: 10
t
print(v1 %in% t)  #TRUE
print(v2 %in% t)

x = c("what", "is", "truth")
if("Truth" %in% x) {
  print("yes")
} else {                 #ELSE SHOULD BE ON THIS LINE
  print("no")
}

x <- switch(
  3,
  "first",
  "second",
  "third",
  "fourth"
)
print(x)

#switch 6 => null


