#EX 3

v = rnorm(100, 1, 0.3)
print(v)

media = mean(v)
print(media)

getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

moda = getmode(v)
print(moda)

mediana = median(v)
print(mediana)

# b)
png(file="neagu_histograma.png")
hist(v, col="green")
dev.off()


#EX 4


Mfct = function(i, j){
  return (1 / sqrt( (i + 2) * (j + 2) ))
}


Nfct = function(i, j){
  return ( (i + 1) / (j + 1) )
}

v1 = seq(1, 15)
v2 = seq(1, 15)

M = outer(v1, v2, Mfct)
N = outer(v1, v2, Nfct)


print(M)
print(N)

MN = M %*% N
if(det(MN) != 0){
  print("Inversabila!")
} else {
  print("Nu e inversabila!")
}
