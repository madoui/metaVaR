subsetCov <- function  (cov , dev = 2, minCov = 8 ){
  N = nrow(cov)
  M = ncol(cov)
  sd = apply (cov , 2, sd)
  med = apply (cov , 2, median)
  covOk = matrix (rep ( 0, N*M), nrow = N, ncol = M )
  rownames (covOk) = rownames (cov)
  for (i in 1:N){
    for (j in 1:M){
      if (i > N || j > M){break}
      if ( cov[i,j] > med[j]-dev*sd[j] && cov[i,j] < med[j]+dev*sd[j] && cov[i,j] > minCov ){
        covOk[i,j] = 1
      }
    }
  }
  ok = apply ( covOk , 1, function (x) all ( x == 1 ) )
  cov = cov[ ok == 1, ]
  return (cov)
}
