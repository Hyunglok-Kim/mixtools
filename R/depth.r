######################################################################
# the following depth function can compute the depth for             #
# multi points at one time                                           #
######################################################################

#dyn.load("~fxuan/depth/spherical/sphericaldepth.so")
depth <- function(pts,x,Cx=var(x)){
  x=x%*%t(chol(solve(Cx)))
  pts=pts%*%t(chol(solve(Cx)))
  y <- .Fortran("mudepth",
                as.integer(nrow(x)),
                as.integer(nrow(pts)),
                as.integer(ncol(x)),
                as.single(pts),
                as.single(x),
                as.integer(1:nrow(pts)),
                as.single(1:nrow(pts)),
                PACKAGE="mixtools")
  count <- y[[6]]
  n <- nrow(x)
  depth <- sqrt(8)*(count-n*(n-1)/4)/sqrt((n*(n-1)))#this is to standardize the depth
  depth
}