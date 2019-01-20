cls2gen <- function ( Clusters, freq, prefix ){
  cat (paste ("Population genomic analysis:","\n",sep = ""))
  for(i in names(Clusters)){
    cat(paste(i,"\n",sep = ""))
    ClsCov = Clusters[[i]]$cov
    ClsPop = Clusters[[i]]$pop
    nbVar = length (Clusters[[i]]$varID)
    NewCov = subsetCov(ClsCov)
    ClsFreq = freq[ row.names(NewCov) , ClsPop ]
    outdir = paste ( prefix,"/" , i ,"_",nbVar, sep = "" )
    write.table( ClsCov, paste ( outdir, "/cov.txt", sep = ""), quote = F , sep = "\t", col.names = TRUE, row.names = TRUE)
    write.table( NewCov, paste ( outdir, "/subset_cov.txt", sep = ""), quote = F , sep = "\t", col.names = TRUE, row.names = TRUE)
    write.table( ClsFreq, paste ( outdir, "/freq.txt", sep = ""), quote = F , sep = "\t", col.names = TRUE, row.names = TRUE)
    if(length(ClsPop) > 1){
      pdf ( paste ( outdir, "/viewPop.pdf", sep = "" ), 5, 6 )
      res = viewPop( ClsFreq )
      dev.off()
      write.table( res$pairwise, paste ( outdir, "/pairwise.txt", sep = ""), quote = F , sep = "\t", col.names = TRUE, row.names = TRUE)
      write.table( res$selection, paste ( outdir, "/selection.txt", sep = ""), quote = F , sep = "\t", col.names = TRUE, row.names = F)
    }
  }
}
