library("DMRcaller")
library(betareg)
args <- commandArgs(trailingOnly=TRUE)
a = args[1]
b = args[2]
c = args[3]
d = args[4]
out = args[5]
po = as.character(out)
cga = paste ("CG",po,"DMR.txt",sep = ".")
chga= paste ("CHG",po,"DMR.txt",sep = ".")
chha= paste ("CHH",po,"DMR.txt",sep = ".")
methylationDataA <- readBismark(a)
methylationDataB <- readBismark(b)
methylationDataC <- readBismark(c)
methylationDataD <- readBismark(d)
methylationDataList <- GRangesList("1" = methylationDataA,"2" = methylationDataB, "3" = methylationDataC, "4" = methylationDataD)
merge <- joinReplicates(methylationDataList[[1]],methylationDataList[[2]])
merge <- joinReplicates(merge,methylationDataList[[3]])
merge <- joinReplicates(merge,methylationDataList[[4]])
condition <- c("a", "a", "b", "b")
DMRsBinsCG1 <- computeDMRsReplicates(methylationData = merge,condition = condition,regions = NULL,context = "CG",method = "bins",binSize = 100,test = "betareg",pseudocountM = 1,pseudocountN = 2,pValueThreshold = 0.05,minCytosinesCount = 4,minProportionDifference = 0.4,minGap = 0,minSize = 50,minReadsPerCytosine = 4,cores = 4)

DMRsBinsCHG1 <- computeDMRsReplicates(methylationData = merge,condition = condition,regions = NULL,context = "CHG",method = "bins",binSize = 100,test = "betareg",pseudocountM = 1,pseudocountN = 2,pValueThreshold = 0.05,minCytosinesCount = 4,minProportionDifference = 0.2,minGap = 0,minSize = 50,minReadsPerCytosine = 4,cores = 4)

DMRsBinsCHH1 <- computeDMRsReplicates(methylationData = merge,condition = condition,regions = NULL,context = "CHH",method = "bins",binSize = 100,test = "betareg",pseudocountM = 1,pseudocountN = 2,pValueThreshold = 0.05,minCytosinesCount = 4,minProportionDifference = 0.1,minGap = 0,minSize = 50,minReadsPerCytosine = 4,cores = 4)

write.table(DMRsBinsCG1,cga, sep="\t",quote=FALSE)
write.table(DMRsBinsCHG1,chga, sep="\t",quote=FALSE)
write.table(DMRsBinsCHH1,chha, sep="\t",quote=FALSE)
