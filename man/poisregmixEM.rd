\name{poisregmixEM}
\title{EM Algorithm for Mixtures of Poisson Regressions}
\alias{poisregmixEM}
\usage{
poisregmixEM(y, x, lambda = NULL, beta = NULL, k = 2,
             addintercept = TRUE, epsilon = 1e-08, 
             maxit = 10000, verb = FALSE)
}

\description{
  Returns EM algorithm output for mixtures of Poisson regressions with
  arbitrarily many components.
}
\arguments{
  \item{y}{An n-vector of response values.}
  \item{x}{An nxp matrix of predictors.  See \code{addintercept} below.}
  \item{lambda}{Initial value of mixing proportions.  Entries should sum to
    1.  This determines number of components.  If NULL, then \code{lambda} is
    random from uniform Dirichlet and number of
    components is determined by \code{beta}.}
  \item{beta}{Initial value of \code{beta} parameters.  Should be a pxk matrix,
    where p is the number of columns of x and k is number of components.
    If NULL, then \code{beta} is generated by binning the data into k bins and using \code{glm} on
    the values in each of the bins.  If both \code{lambda} and \code{beta} are NULL, then 
    number of components is determined by \code{k}.}
  \item{k}{Number of components.  Ignored unless \code{lambda} and \code{beta} are both NULL.}
  \item{addintercept}{If TRUE, a column of ones is appended to the x
    matrix before the value of p is calculated.}
  \item{epsilon}{The convergence criterion.}
  \item{maxit}{The maximum number of iterations.}
  \item{verb}{If TRUE, then various updates are printed during each iteration of the algorithm.} 
}
\value{
  \code{poisregmixEM} returns a list of class \code{mixEM} with items:
  \item{x}{The predictor values.}
  \item{y}{The response values.}
  \item{lambda}{The final mixing proportions.}
  \item{beta}{The final Poisson regression coefficients.}
  \item{loglik}{The final log-likelihood.}
  \item{posterior}{An nxk matrix of posterior probabilities for
    observations.}
  \item{all.loglik}{A vector of each iteration's log-likelihood.}
  \item{ft}{A character vector giving the name of the function.}
}
\seealso{
\code{\link{logisregmixEM}}
}
\references{
  McLachlan, G. J. and Peel, D. (2000) \emph{Finite Mixture Models}, John Wiley \& Sons, Inc.
  
  Wang, P., Puterman, M. L., Cockburn, I. and Le, N.  (1996)
  Mixed Poisson Regression Models with Covariate Dependent Rates, \emph{Biometrics},
  \bold{52(2)}, 381--400.
}
\examples{
## EM output for data generated from a 2-component model.

beta<-matrix(c(1, .5, .7, -.8), 2, 2)
x<-runif(50, 0, 10)
xbeta<-cbind(1, x)\%*\%beta
w<-rbinom(50, 1, .5)
y<-w*rpois(50, exp(xbeta[, 1]))+(1-w)*rpois(50, exp(xbeta[, 2]))
out<-poisregmixEM(y, x, verb = TRUE)
out
}


\keyword{file}