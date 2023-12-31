% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ResFuz.R
\name{FCLP.classicObjective}
\alias{FCLP.classicObjective}
\alias{FCLP.fuzzyObjective}
\alias{FCLP.fuzzyUndefinedObjective}
\alias{FCLP.fuzzyUndefinedNormObjective}
\title{Solves a Fuzzy Linear Programming problem with fuzzy constraints trying to assure a minimum (maximum) value 
of the objective function.}
\usage{
FCLP.classicObjective(
  objective,
  A,
  dir,
  b,
  t,
  z0 = 0,
  maximum = TRUE,
  verbose = TRUE
)

FCLP.fuzzyObjective(
  objective,
  A,
  dir,
  b,
  t,
  z0 = 0,
  t0 = 0,
  maximum = TRUE,
  verbose = TRUE
)

FCLP.fuzzyUndefinedObjective(
  objective,
  A,
  dir,
  b,
  t,
  maximum = TRUE,
  verbose = TRUE
)

FCLP.fuzzyUndefinedNormObjective(
  objective,
  A,
  dir,
  b,
  t,
  maximum = TRUE,
  verbose = TRUE
)
}
\arguments{
\item{objective}{A vector \eqn{(c_1, c_2, \ldots, c_n)}{(c1, c2, \ldots, cn)} with the objective function coefficients \eqn{f(x)=c_1 x_1+\ldots+c_n x_n}{f(x)=c1*x1+\ldots+cn*xn}.}

\item{A}{Technological matrix of Real Numbers.}

\item{dir}{Vector of strings with the direction of the inequalities, of the same length as \code{b} and \code{t}. Each element 
of the vector must be one of "=", ">=", "<=", "<" or ">".}

\item{b}{Vector with the right hand side of the constraints.}

\item{t}{Vector with the tolerance of each constraint.}

\item{z0}{The minimum (maximum in a minimization problem) value of the objective function to reach. Only 
used in \code{FCLP.classicObjective} and \code{FCLP.fuzzyObjective}.}

\item{maximum}{\code{TRUE} to maximize the objective function, \code{FALSE} to minimize the objective function.}

\item{verbose}{\code{TRUE} to show aditional screen info, \code{FALSE} to hide aditional screen info.}

\item{t0}{The tolerance value to the minimum (or maximum) bound for the objective function. Only 
used in \code{FCLP.fuzzyObjective}.}
}
\value{
\code{FCLP.classicObjective} returns a solution reaching the given minimum (maximum) 
value of the objective function if the solver has found it (trying to maximize \eqn{\beta}) or NULL 
if not. Note that the found solution may not be the optimum for the \eqn{\beta} returned, trying \eqn{\beta} in 
\code{\link{FCLP.fixedBeta}} may obtain better results.

\code{FCLP.fuzzyObjective} returns a solution reaching the given minimum (maximum) 
value of the objective function if the solver has found it (trying to maximize \eqn{\beta}) or NULL 
if not. Note that the found solution may not be the optimum for the \eqn{\beta} returned, trying \eqn{\beta} in 
\code{\link{FCLP.fixedBeta}} may obtain better results.

\code{FCLP.fuzzyUndefinedObjective} returns a solution reaching the estimated minimum 
(maximum) value of the objective function if the solver has found it (trying to maximize \eqn{\beta}) 
or NULL if not.

\code{FCLP.fuzzyUndefinedNormObjective} returns a solution reaching the estimated 
minimum (maximum) value of the objective function if the solver has found it (trying to 
maximize \eqn{\beta}) or NULL if not.
}
\description{
The goal is to solve a linear programming problem having fuzzy constraints trying to assure a minimum (or maximum) value of the objective function.
\deqn{Max\, f(x)\ or\ Min\ f(x)}{Max f(x) or Min f(x)} 
\deqn{s.t.:\quad Ax<=b+(1-\beta)*t}{s.t.:  Ax<=b+(1-\beta)*t}
Where \eqn{t} means we allow not to satisfy the constraint, exceeding the bound \eqn{b} at most in \eqn{t}.

\code{FCLP.classicObjective} solves the problem trying to assure a minimum (maximum) value \eqn{z_0}{z0} 
of the objective function (\eqn{f(x)>=z_0}{f(x)>=z0} in maximization problems, \eqn{f(x)<=z_0}{f(x)<=z0} in minimization 
problems).

\code{FCLP.fuzzyObjective} solves the problem trying to assure a minimum (maximum) value
\eqn{z_0}{z0} of the objective function with tolerance \eqn{t_0}{t0} (\eqn{f(x)>=z_0-(1-\beta)t_0}{f(x)>=z0-(1-\beta)*t0} in maximization
 problems, \eqn{f(x)<=z_0+(1-\beta)t_0}{f(x)<=z0+(1-\beta)*t0} in minimization problems).

\code{FCLP.fuzzyUndefinedObjective} solves the problem trying to assure a minimum (maximum) 
value of the objective function with tolerance but the user doesn't fix the bound nor the 
tolerance. The function estimate a bound and a tolerance and call \code{\link{FCLP.fuzzyObjective}} 
using them.

\code{FCLP.fuzzyUndefinedNormObjective} solves the problem trying to assure a minimum (maximum) 
value of the objective function with tolerance but the user doesn't fix the bound nor the 
tolerance. The function normalize the objective, estimate a bound and a tolerance and call 
\code{\link{FCLP.fuzzyObjective}} using them.
}
\examples{
## maximize:   3*x1 + x2 >= z0
## s.t.:       1.875*x1   - 1.5*x2 <= 4 + (1-beta)*5
##              4.75*x1 + 2.125*x2 <= 14.5 + (1-beta)*6
##               x1, x2 are non-negative real numbers

obj <- c(3, 1)
A <- matrix(c(1.875, 4.75, -1.5, 2.125), nrow = 2)
dir <- c("<=", "<=")
b <- c(4, 14.5)
t <- c(5, 6)
max <- TRUE

# Problem with solution
FCLP.classicObjective(obj, A, dir, b, t, z0=11, maximum=max, verbose = TRUE)

# This problem has a bound impossible to reach
FCLP.classicObjective(obj, A, dir, b, t, z0=14, maximum=max, verbose = TRUE)


# This problem has a fuzzy bound impossible to reach
FCLP.fuzzyObjective(obj, A, dir, b, t, z0=14, t0=1, maximum=max, verbose = TRUE)

# This problem has a fuzzy bound reachable
FCLP.fuzzyObjective(obj, A, dir, b, t, z0=14, t0=2, maximum=max, verbose = TRUE)


# We want the function estimates a bound and a tolerance
FCLP.fuzzyUndefinedObjective(obj, A, dir, b, t, maximum=max, verbose = TRUE)


# We want the function estimates a bound and a tolerance
FCLP.fuzzyUndefinedNormObjective(obj, A, dir, b, t, maximum=max, verbose = TRUE)

}
\references{
Zimmermann, H. Description and optimization of fuzzy systems. International Journal of General Systems, 2:209-215, 1976.

Werners, B. An interactive fuzzy programming system. Fuzzy Sets and Systems, 23:131-147, 1987.

Tanaka, H. and Okuda, T. and Asai, K. On fuzzy mathematical programming. Journal of Cybernetics, 3,4:37-46, 1974.
}
\seealso{
\code{\link{FCLP.fixedBeta}}, \code{\link{FCLP.sampledBeta}}
}
