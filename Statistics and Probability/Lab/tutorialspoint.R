#assing values and print
myString <- "Hello"
print(myString)

#convert string to date: as.Date(c("2012-01-01"))


#create a vector (c stands for combine)
apple <- c('red', 'green', "yellow")
print(apple)


#extend vector
apple <- c(apple, 'blue')
print(apple)

print(class(apple))


#create a list (can hold different types of elements)
li1 <- list(c(2,5,3), 21.3, sin)
print(li1)


#give names to elements in list
names(li1) <- c("un vector", "un nr", "o fct")
print(li1)


#access element by its given name or by index (INDEXED BY 1)
print(li1$"un nr")



#add, delete se pot doar la finalul listei. update, oriunde
l = list(1,2,3,4)
l[5] = "nou"  #ADD
print(l)

l[5] = NULL   #DELETE
print(l)


#extend list / merge list:
l1 <- list(1,2,3)
l2 <- list(4,5,6)
print(c(l1, l2))


#ca sa folosesti operatori pe liste, ii transformi in vectori cu unlist:
v1 <- unlist(l1)
v2 <- unlist(l2)
print(v1 + v2)



#__________________________________________________



#create a matrix
m = matrix(c('a','b','c','d','e','f'), nrow = 2, ncol = 3, byrow = TRUE)
print(m)

#byrow = true -> filling begins with the first line, continues w second etc
#byrow = false -> fill by columns
#dimnames = list(c(..), c(..)) -> give names to rows and columns


#accesarea elementelor  
print(m[1,1]) # -> primul el
print(m[2,]) #-> 2nd line
print(m[,3]) # > a 3a coloana


#matricele se pot aduna/ scadea/ inmulti /imparti
#inmultirea se face intre 2 matrice cu aceleasi dimensiuni (el. cu el.), nu inm. de matrice adevarata




#array (can be any number of dimensions - 3d matrix)

#create array with 2 3x3 matrices
a <- array(c('green', 'yellow'), dim = c(3,3,2))
print(a)

#print a doua matrice
print(a[,,2])

#print a[1][1][3]
print(result[1,3,1])  #ultimul arg -> a cata matrice. primii 2 -> in acea matrice

#set de date / map array -> functia apply(x, set_de_date, f)



#factor: stores a vector along with its distinct values
#      : similar to vct.extend(set(vct))

apple_colors <- c('green', 'red', 'red', 'yellow', 'green')
factor_apple <- factor(apple_colors)
print(factor_apple)
print(nlevels(factor_apple))  #nr. of elements in set(vct)


#factor levels: functia gl(n, k, labels)

# poti sa generezi k * n cuvinte/ elemente care se repeta astfel: fiecare din
# cele n cuvinte se repeta de k ori (nlevels() == n).
# argumentul labels sunt cuvintele efective

v <- gl(3, 4, labels=c("cuv1", "cuv2"))
# print(v) #asa scrie pe site, de fapt nu ruleaza


#data.frame -> a matrix which you define by named columns (like in an excel)
BMI <- data.frame(
  gender = c("M", "M", "F"),
  height = c(152, 171.5, 165),
  weight = c(81, 93, 78),
  age = c(42,38,26)
  #,stringsAsFactors = TRUE
)
print(BMI)



#stringAsFactors = TRUE => every column is a factor, 
#and you can print it to see the set of values in it. uita te mai sus pt ce e aia factor

print(BMI$gender)


 str(BMI)  #-> print the structure of data frame
 print(summary(BMI))  #get the statistical nature of data

 
#extract values from data frame
 
#extract specific columns
 print(data.frame(BMI$gender, BMI$age))

#extract first 2 rows then all columns
 print(BMI[1:2,])
 
#extract row 2 and 4 with columns 1 and 3
 print(BMI[c(2,4), c(1,3)])
 
# ADD COLUMN
 BMI$dept <- c("IT", "HR", "PR")
 print(BMI)
 
 
# ADD ROWS: creeaza un data.frame nou cu exact aceeasi structura si foloseste rbind
 #also lipeste 2 data frame-uri
 
 BMI2 <- data.frame(
   gender = c("F", "F"),
   height = c(182, 155),
   weight = c(91, 50),
   age = c(27,19),
   dept = c("HR", "It")
   #,stringsAsFactors = TRUE
 )
 
 BMI = rbind(BMI, BMI2)
 print(BMI)
 
 # cbind(x,y,z) creaza un data.frame din vectorii x,y,z

 
#cat -> print multiple variables
var.1 = c(0,1,2,3)
cat("var.1: ", var.1, "\n")


#ls() -> listeaza variabilele din environment. poate lua argumente
#rm() -> sterge variabilele din env


#______________________________________________________________________________
#TOTI OPERATORII SE POT FOLOSI SI PE VECTORI
v <- c(3, 4, 5)
t <- c(1,2,1)
print(v ^ t)


#RESTUL: OPERATOR %%
print(7 %% 5)

#IMPARTIREA REALA: OPERATOR /
print(7 / 5)

#IMPARTIREA INTREAGA: OPERATOR %/%
print(7 %/% 5)


#TOTI OPERATORII DE COMPARATIE SE FOLOSESC SI PE VECTORI
#REZULTATUL E UN VECTOR DE TRUE / FALSE IN FUNCTIE DE COMPARATIILE INDIVIDUALE
v <- c(1,2,3,4)
t <- c(0,0,10,5)
print(v < t)


#AND PE VECTORI: & 
v <- c(3, 1, TRUE)
t <- c(2, FALSE, 0)
print(v && t)   # => TRUE, FALSE, FALSE

#SAU PE VECTORI: |

#AND, OR PE NUMERE SINGURE / primul el din v + primul din t: &&, ||
print(5 && FALSE)


#OPERATORUL :   -> creeaza seria de numere consecutive x : y
v <- 8:6
print(v)

#OPERATORUL %in%   -> TRUE daca un el e in vector, false altfel
v <- 5:8
print(8 %in% v)

#OPERATORUL %*%    -> INMULTIRE DE MATRICE

#FUNCTIA t(M) returneaza traspunsa lui M

M = matrix(c(1,0,0,0,1,0,0,0,1), nrow=3, ncol=3, byrow=TRUE)
rez = M %*% t(M)
print(rez)


#_______________________________________________________________

#if else ----> TREBUIE SCRIS EXACT CA MAI JOS (spatierea), DACA NU, eroare
x <- 30L
if(is.integer(x)) {
  print(x + 20L)
} else {
  print("aaa")
}

v <- 10:20
if(9 %in% v) {
  print("da1")
} else if(10 %in% v) {
  print("da2")
} else {
  print("nu")
}

#switch -> neclar -> cauta pe net

#_____________________________________________

#WHILE

c <-2
while(c < 7){
  print(c)
  c = c + 1
}

#FOR
v <- LETTERS[1:6]
for(i in v) {
  if(i == 'D')
    next
  if(i == 'F')
    break
  print(i)
}


#FUNCTII UTILE

# seq -> secventa de nr de la x la y. secventa cu pas in vector
print(seq(32,44))
t <- seq(5, 9, by=0.4)
print(t)

# indexarea unui vector -> INCEPE DE LA 1
t <- c("monday", "tue", "wed", "thu", "fri", "sat", "sun")
u <- t[c(2,3)]
print(u)     #returneaza tue wed

#STERGEREA UNUI ELEMENT DINTR-UN VECTOR
u <- t[-2]    #se sterge el. de pe pozitia 2
u <- t[c(-2, -3)]   #se sterge si dp poz 2 si dp poz 3
print(u)

# sum -> suma numerelor dintr-un vector
print(sum(1:10))

#sortare -> rez = sort(v, decreasing=TRUE)

#CREAREA DE FUNCTII

f1 = function(a) {
  for(i in 1:a)
  {
    b <- i ^ 2
    print(b)
  }
}

f1(3)

f2 = function(x = 2) {
  y = x * 2
  return(y)
}

f2()


#concatenare string-uri: functia paste
# https://stackoverflow.com/questions/18475202/paste-collapse-in-r

str1 <- paste("hello", "how", "are you? ", sep="-")
print(str1)

#functia format -> pentru numere si string-uri. primeste urmatoarele arg:
# un numar / un string/ un vector

# digits = 5 (sa se afiseze doar 5 cifre pe ecran, incluzand dupa virgula)
# nsmall = 3 (sa se afiseze minim 3 cifre dupa virgula - se compl. cu 0)
# scientific = True => ni le pune ca 1.5e+32 etc
# width = 8 => sa avem minim 8 caractere in string, se completeaza cu spatii la inceput
# justify = "c" / "l" / "r"  -> mana in mana cu width, se pune string-ul initial central fata de spatiile adaugate

result <- format(c(60,13.14521), digits=5)
print(result)
result <- format("hello", width=8, justify="c")
print(result)

# STRLEN = nchar(str)
# toupper(str), tolower(str)

# substring(str, first, last) => extract from str from position first to last



# Pie Chart ( ca in google forms)

#pie(x, labels, radius, main, col, clockwise)

# x -> c(valori), labels -> descrierea feliilor, radius -> pentru cerc, main -> titlul pie-ului
    #col -> culori, clockwise -> cum sunt desenate feliile

x <- c(21, 62, 3)
labels <- c ("Bucharest", "Prague", "Cluj")

#give name to chart file
png(file="pie.png")

pie(x, labels, main="Titlu", col=rainbow(length(x)))  #get length(x) colors from rainbow

#save file
dev.off()



#PIE CHART WITH PERCENTAGES AND COLOR LEGEND

x <- c(10,3,28, 4)
labels <- c("Bucharest", "Iasi", "Cluj", "Oradea")

percent <- round(100*x/sum(x), 1)

#open file
png(file="percentage_pie.jpg")

#add pie
pie(x, labels = percent, main="Cities", col = rainbow(length(x)))

#add legend
legend("topright", labels, cex = 0.8, fill = rainbow(length(x)))

#close file
dev.off()


#3d pie chart -> library(plotrix), pie3D(.., explode = 0.1, ...) dev.off()




#BAR CHART

# barplot(H, xlab, ylab, main, names.arg, col)

# H - > vector sau matrice cu numerele din barchart. xlab-> label pt axa ox
# ylab -> label pt axa oy, main-> titlul barchart-ului, names.arg -> vector de nume care
# apar sub fiecare bara. col -> culorile lor


H <- c(7, 12, 28, 3)
W <- c("Mar", "Apr", "May", "Jun")

png(file="barchart.jpg")

#add barplot
barplot(H, names.arg=W, xlab="Month", ylab="Revenue", col="blue", border="red")

dev.off()


#foloseste o matrice pentru group bar chart (o bara sa aiba mai multe "etaje" pe ea)

colors <- c("orange", "green", "brown")   #un bar va avea etajele astea
months <- c("Mar", "Apr", "Ju", "Aug", "Sep")
regions <- c("E", "W", "N")   #un etaj va reprezenta una dintre astea

M <- matrix(c(2,9,3,11,9,4,8,7,3,12,5,2,8,10,11), nrow=3, ncol=5, byrow=TRUE)

png(file="stacked_barchart.jpg")

barplot(M, main="total rev", names.arg=months, xlab="month", ylab="revenue", col=colors)

legend("topleft", regions, cex=1.3, fill = colors)
dev.off()




#Boxplot -> distributie

#boxplot(x, data, notch, varwidth, names, main, col)    #x-> vector / formula. data -> data frame

#notch -> TRUE => deseneaza un notch, varwidth -> TRUE => deseneaza cutia proportional cu sample size
#names -> labels pt fiecare boxplot. main -> titlul img. col -> colors

input <- mtcars[,c('mpg', 'cyl')]      #luam doar coloanele cu numele mpg si cyl din mtcars
print(head(input))


#boxplot-ul va fi folosit pt a arata relatia dintre mpg(miles per gallon) si cyl(nr of cylinders)
png(file="boxplot.png")
boxplot(mpg ~ cyl, data=mtcars, xlab="Nr of cylinders", ylab="Miles/gallon", main = "data")

dev.off()




# HISTOGRAMA -> frecventa numerelor aflate intr-un anumit interval (intervalul e o bara)

# hist(v,main,xlab,xlim, ylim,breaks,col,border)
# xlim -> range of values in x-axis
# breaks -> width of each bar


v <- c(9, 13, 21, 8, 36, 22, 12, 41, 31, 33, 19)
png(file="histogram.png")
hist(v,xlab="weight", col="yellow", border="blue")
dev.off()

#daca am fi pus xlim=c(0,20), in exemplul de mai sus, nu mai erau incluse in histograma
  #valorile peste 20. se opreau coloanele la 20.




# Line Graph    -> niste puncte unite pe graf

# plot(v, type, col, xlab, ylab)
# type: "o" => points and lines ; ="l" => only lines ; ="p" => only points


v <- c(7, 12, 28, 3, 41)
png(file="line_chart.png")
plot(v, type="o")

# lines(c(10,33,2), type="o", col="blue)

dev.off()

#add a second / third line: use lines() function



# SCATTERPLOTS -> un punct reprezinta valoarea a 2 variabile(una pe ox una pe oy)

#plot(x, y, main, xlab, ylab, xlim, ylim, axes)
# x -> datele puse pe ox, y-> datele puse pe oy; xlab-> xlabel; 
# xlim -> limita valorilor dp ox; ylim -> pe oy; axes -> spune daca trb desenate si ox si oy

input = mtcars[,c('wt','mpg')]
png(file = "scatterplot.png")


#plot chart for cars with weight between 2.5 to 5 and mileage btw 15 and 30

plot(x=input$wt, y=input$mpg, xlab="weight", ylab="mileage", xlim=c(2.5,5), ylim=c(15,30))
dev.off()



#SCATTERPLOT MATRICES

#folosim fct pairs(formula, data). formula -> series of variables used in pairs
#comparam fiecare variabila cu fiecare variabila

# pairs(~wt+mpg+disp+cyl, data=mtcars)


#___________________________________________________


# mean -> media aritmetica unui vector / media unei variabile aleatoare ( E(X) )

print(mean(1:10))


#calculeaza m.a. dintr-un vector, exceptand primele 3 si ultimele 3 el. din el sortat
# mean(v,  trim=0.3)

#avem v = c(1,2,3,NA,4). gaseste m.a. fara valorile NA:
#result = mean(x, na.rm=TRUE)


#median -> sorteaza vectorul crescator si mediana e pe poz de mijl.
# daca are length par, vor fi 2 nr la mijloc si rezultatul medianei este media lor aritmetica

v = c(7,3,2,1,NA)
print(median(v, na.rm=TRUE))



#moda -> iti da cea mai frecventa valoare dintr-un vector (poate fi si de string-uri)

getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

v <- c(1,2,3,1,1,3)
print(getmode(v))

#1. Aruncam 2 zaruri corecte ¸si fie X suma. Presupunem c˘a funct¸ia de plat˘a 
#este dat˘a de Y = X^2 − 6X + 1. Faceti media in R

#rez pe foaie:
#Tabelul:
#  X             2 3 4 5 6 7 8 9 10 11 12
# Y              −7 −8 −7 −4 1 8 17 28 41 56 73
# probabilitatea 1/36 2/36 3/36 4/36 5/36 6/36 5/36 4/36 3/36 2/36 1/36



#cod in R:
x=2:12
y=x^ 2-6*x+1
p=c(1,2,3,4,5,6,5,4,3,2,1)/36
sum(p*y)

#2. Repartitia normala in R (curs 3, pg 19). Calculati F(x) pentru N(µ, σ2).
pnorm(1,0,1)

  