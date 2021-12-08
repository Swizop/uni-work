#LAB 5
x <- c(3, 8, 6, 6, 2, 2, 1, 2)
#sunt 3 mai mici ca 4, 8 note de 4, 6 de 5 etc
labels <- c("<4", "4", "5", "6", "7", "8", "9", "10")

piepercent<- round(100*x/sum(x), 1)

# Give the chart file a name.
png(file = "lab5.jpg")

# Plot the chart.
pie(x, labels = piepercent, main = "Note clasa (30 elevi)",col = rainbow(length(x)))
legend("topright", labels, cex = 0.8,
       fill = rainbow(length(x)))

# Save the file.
dev.off()


#3d chart