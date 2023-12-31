% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CosFuz.R
\name{FOLP.multiObj}
\alias{FOLP.multiObj}
\alias{FOLP.interv}
\alias{FOLP.strat}
\title{Solves a fuzzy objective linear programming problem using Representation Theorem.}
\usage{
FOLP.multiObj(
  objective,
  A,
  dir,
  b,
  maximum = TRUE,
  min = 0,
  max = 1,
  step = 0.25
)

FOLP.interv(
  objective,
  A,
  dir,
  b,
  maximum = TRUE,
  w1 = 0.5,
  min = 0,
  max = 1,
  step = 0.25
)

FOLP.strat(objective, A, dir, b, maximum = TRUE, min = 0, max = 1, step = 0.25)
}
\arguments{
\item{objective}{A vector \eqn{(c_{1}^{f}, c_{2}^{f}, ..., c_{n}^{f})}{(c1, c2, ..., cn)} of 
Trapezoidal Fuzzy Numbers with the objective function coefficients 
\eqn{f(x)=c_{1}^{f} x_1+\ldots+c_{n}^{f} x_n}{f(x)=c1*x1+\ldots+cn*xn}. Note that any of the 
coefficients may also be Real Numbers.}

\item{A}{Technological matrix of Real Numbers.}

\item{dir}{Vector of strings with the direction of the inequalities, of the same length as \code{b}. Each element 
of the vector must be one of "=", ">=", "<=", "<" or ">".}

\item{b}{Vector with the right hand side of the constraints.}

\item{maximum}{\code{TRUE} to maximize the objective function, \code{FALSE} to minimize the objective function.}

\item{min}{The lower bound of the interval to take the sample.}

\item{max}{The upper bound of the interval to take the sample.}

\item{step}{The sampling step.}

\item{w1}{Weight to be used, \code{w2} is calculated as \code{w2=1-w1}. \code{w1} must 
be in the interval \code{[0,1]}. Only used in \code{FOLP.interv}.}
}
\value{
\code{FOLP.multiObj} returns the solutions for the sampled \eqn{\beta's} if the solver has found them. 
If the solver hasn't found solutions for any of the \eqn{\beta's} sampled, return NULL.

\code{FOLP.interv} returns the solutions for the sampled \eqn{\beta's} if the solver has found them. 
If the solver hasn't found solutions for any of the \eqn{\beta's} sampled, return NULL.

\code{FOLP.strat} returns the solutions and the value of \eqn{\lambda} for the sampled 
\eqn{\beta's} if the solver has found them. If the solver hasn't found solutions for any of the 
\eqn{\beta's} sampled, return NULL. A greater value of \eqn{\lambda} may be interpreted as  the 
obtained solution is better.
}
\description{
The goal is to solve a linear programming problem having Trapezoidal Fuzzy Numbers 
as coefficients in the objective function (\eqn{f(x)=c_{1}^{f} x_1+\ldots+c_{n}^{f} x_n}{f(x)=c1*x1+\ldots+cn*xn}). 
\deqn{Max\, f(x)\ or\ Min\ f(x)}{Max f(x) or Min f(x)}  
\deqn{s.t.:\quad Ax<=b}{s.t.:  Ax<=b}

\code{FOLP.multiObj} uses a multiobjective approach. This approach is based on each \eqn{\beta}-cut
of a Trapezoidal Fuzzy Number is an interval (different for each \eqn{\beta}). So the problem may be
considered as a Parametric Linear Problem. For a value of \eqn{\beta} fixed, the problem becomes a 
Multiobjective Linear Problem, this problem may be solved from different approachs, \code{FOLP.multiObj} 
solves it using weights, the same weight for each objective.

\code{FOLP.interv} uses an intervalar approach. This approach is based on each \eqn{\beta}-cut
of a Trapezoidal Fuzzy Number is an interval (different for each \eqn{\beta}). Fixing an \eqn{\beta}, 
using interval arithmetic and defining an order relation for intervals is posible to compare intervals, 
this transforms the problem in a biobjective problem (involving the minimum and the center of intervals). 
Finally \code{FOLP.interv} use weights to solve the biobjective problem.

\code{FOLP.strat} uses a stratified approach. This approach is based on that \eqn{\beta}-cuts are a 
sequence of nested intervals. Fixing an \eqn{\beta} two auxiliary problems are solved, the first 
replacing the fuzzy coefficients by the lower limits of the \eqn{\beta}-cuts, the second doing the 
same with the upper limits. The results of the two auxiliary problems allows to formulate a new 
auxiliary problem, this problem tries to maximize a parameter \eqn{\lambda}.
}
\examples{
## maximize:   [0,2,3]*x1 + [1,3,4,5]*x2
## s.t.:         x1 + 3*x2 <= 6
##               x1 +   x2 <= 4
##               x1, x2 are non-negative real numbers

obj <- c(FuzzyNumbers::TrapezoidalFuzzyNumber(0,2,2,3), 
         FuzzyNumbers::TrapezoidalFuzzyNumber(1,3,4,5))
A<-matrix(c(1, 1, 3, 1), nrow = 2)
dir <- c("<=", "<=")
b <- c(6, 4)
max <- TRUE

# Using a Multiobjective approach.
FOLP.multiObj(obj, A, dir, b, maximum = max, min=0, max=1, step=0.2)


# Using a Intervalar approach.
FOLP.interv(obj, A, dir, b, maximum = max, w1=0.3, min=0, max=1, step=0.2)


# Using a Stratified approach.
FOLP.strat(obj, A, dir, b, maximum = max, min=0, max=1, step=0.2)

}
\references{
Verdegay, J.L. Fuzzy mathematical programming. In: Fuzzy Information and Decision Processes, pages 231-237, 1982. M.M. Gupta and E.Sanchez (eds).

Delgado, M. and Verdegay, J.L. and Vila, M.A. Imprecise costs in mathematical programming problems. Control and Cybernetics, 16 (2):113-121, 1987.

Bitran, G.. Linear multiple objective problems with interval coefficients. Management Science, 26(7):694-706, 1985.

Alefeld, G. and Herzberger, J. Introduction to interval computation. 1984.

Moore, R. Method and applications of interval analysis, volume 2. SIAM, 1979.

Rommelfanger, H. and Hanuscheck, R. and Wolf, J. Linear programming with fuzzy objectives. Fuzzy Sets and Systems, 29:31-48, 1989.
}
\seealso{
\code{\link{FOLP.ordFun}}, \code{\link{FOLP.posib}}
}
