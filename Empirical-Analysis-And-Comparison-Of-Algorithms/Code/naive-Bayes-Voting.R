sample <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/voting-records/house-votes-84.data",sep=",")
#COMPUTING G1

tp <- 0
fp <- 0
fn <- 0
tn <- 0
acc <- 0
prec_1 <- 0
prec_2 <- 0
rec_1 <- 0
rec_2 <- 0
f_1 <- 0
f_2 <- 0
alphac1 <- 0
alphac2 <- 0
intc1 <- 0
intc2 <- 0
g1 <- 1
g2 <- 1
sample1 <- sample[order(sample$V1),]
for(i in 2:17) {  alphac1[i] <- (sum(c(sample1[1:267,i]))/267) }
for(i in 2:17) {  alphac2[i] <- (sum(c(sample1[268:435,i]))/168) } 
diff_func <- 0
ycap <- 0
#plot(sample1$V1, sample1$V61, pch=21, bg=c("red","green3","blue")[unclass(sample1$V61)+1], main="SPAMBASE DATA(57-FEATURES)")
for(j in 1:435)
{
  for(i in 2:17) 
  {   
    
    if(is.nan((alphac1[i])^c(sample1[j,i]) * (1-alphac1[i])^(1-c(sample1[j,i]))) || is.na((alphac1[i])^c(sample1[j,i]) * (1-alphac1[i])^(1-c(sample1[j,i]))))
     {  intc1[i] <- 1 }
    else
    { intc1[i] <- ((alphac1[i])^c(sample1[j,i]) * (1-alphac1[i])^(1-c(sample1[j,i])   )) }
    g1 <- g1 * intc1[i]
    
    
    if(is.nan(intc2[i] <- ((alphac2[i])^c(sample1[j,i]) *(1-alphac2[i])^(1-c(sample1[j,i])))) || is.na((alphac1[i])^c(sample1[j,i]) * (1-alphac1[i])^(1-c(sample1[j,i]))))
    {   intc2[i] <- 1}
    else
    { intc2[i] <-  ((alphac2[i])^c(sample1[j,i]) *(1-alphac2[i])^(1-c(sample1[j,i])))}
    g2 <- g2 * intc2[i]        
    
  }
  g1 <- g1 * 267
  g2 <- g2 * 168
  diff_func[j] <- (g1-g2)
  if(diff_func[j]>0) { ycap[j] <- 0 } else { ycap[j] <- 1 }
  g1 <- 1
  g2 <- 1
}
ycap

y <- c(sample1$V1)
# Confusion matrix
conf_matrix = table(y, ycap)
print(conf_matrix)
tp = conf_matrix[1,1]
fp = conf_matrix[1,2]
fn = conf_matrix[2,1]
tn = conf_matrix[2,2]
# accuracy
acc = ((tp-fp)-(fn-tn))/208
print(acc)

# precision
prec_1 = tp/(tp+fp)
print(prec_1)

prec_2 = tn/(tn+fn)
print(prec_2)

# recall
rec_1 = tp/(tp+fn)
print(rec_1)

rec_2 = tn/(tn+fp)
print(rec_2)

# f-measure
f_1 = 2*((prec_1*rec_1)/(prec_1+rec_1))
print(f_1)

f_2 = 2*((prec_2*rec_2)/(prec_2+rec_2))
print(f_2)

ycap <- ycap + 1

plot(diff_func, sample1$V1, pch=21, bg=c("red","green3","blue")[unclass(ycap)], main="Prediction of voting data")
