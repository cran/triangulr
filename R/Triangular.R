#' The Triangular Distribution
#'
#' @name Triangular
#'
#' @description These functions provide information about the triangular
#'  distribution on the interval from \code{min} to \code{max} with mode equal
#'  to \code{mode}. \code{dtri} gives the density function, \code{estri} gives
#'  the expected shortfall, \code{mgtri} gives the moment generating function,
#'  \code{ptri} gives the distribution function, \code{qtri} gives the quantile
#'  function, and \code{rtri} gives the random variate generator.
#'
#' @param x,q Vector of quantiles.
#' @param p Vector of probabilities.
#' @param n Number of observations. Must have length of one.
#' @param t Vector of dummy variables.
#' @param min Lower limit of the distribution. Must have \code{min} \eqn{<}
#'  \code{max}.
#' @param max Upper limit of the distribution. Must have \code{max} \eqn{>}
#'  \code{min}.
#' @param mode The mode of the distribution. Must have \code{mode} \eqn{\ge}
#'  \code{min} and \code{mode} \eqn{\le} \code{max}.
#' @param log,log_p Logical; if \code{TRUE}, probabilities \code{p} are given as
#'  \code{log(p)}.
#' @param lower_tail Logical; if \code{TRUE} (default), probabilities \code{p}
#'  are \eqn{P[X \le x]}, otherwise, \eqn{P[X > x]}.
#'
#' @details
#'  If \code{min}, \code{max}, or \code{mode} are not specified they assume the
#'  default values of \code{0}, \code{1}, and \code{0.5} respectively.
#'
#'  The triangular distribution has density
#'  \deqn{0}{0}
#'  for \eqn{x < min} or \eqn{x > max}
#'  \deqn{f(x) = \frac{2(x - min)}{(max - min)(mode - min)}}{f(x) = 2(x - min) /
#'   (max - min)(mode - min)}
#'  for \eqn{min \le x < mode}, and
#'  \deqn{f(x) = \frac{2(max - x)}{(max - min)(max - mode)}}{E(x) = 2(max - x) /
#'   (max - min)(max - mode)}
#'  for \eqn{mode < x \le max}.
#'
#'  \code{rtri} will not generate either of the extreme values unless
#'  \code{max - min} is small compared to \code{min}, and in particular not for
#'  the default arguments.
#'
#' @return
#'  \code{dtri} gives the density function,
#'  \code{estri} gives the expected shortfall,
#'  \code{mgtri} gives the moment generating function,
#'  \code{ptri} gives the distribution function,
#'  \code{qtri} gives the quantile function, and
#'  \code{rtri} gives the random variate generator.
#'
#'  The numerical arguments other than \code{n} with values of size one are
#'  recycled to the length of \code{t} for \code{mgtri}, the length of \code{x}
#'  for \code{dtri}, the length of \code{p} for \code{estri} and \code{qtri},
#'  the length of \code{q} for \code{ptri}, and \code{n} for \code{rtri}. This
#'  determines the length of the result.
#'
#'  The logical arguments \code{log}, \code{lower_tail}, and \code{log_p} must
#'  be of length one each.
#'
#' @note The characteristics of output from pseudo-random number generators
#'  (such as precision and periodicity) vary widely. See
#'  \code{\link{.Random.seed}} for more information on R's random number
#'  generation algorithms.
#'
#' @seealso
#'  \code{\link{RNG}} about random number generation in \R.
#'
#'  \link{Distributions} for other standard distributions.
#'
#' @useDynLib triangulr, .registration = TRUE
#'
#' @importFrom rlang cnd_signal
#' @importFrom vctrs vec_recycle_common
#'
#' @examples
#'
#' # min, max, and mode with lengths equal to the length of x
#' x <- c(0, 0.5, 1)
#' d <- dtri(x,
#'           min = c(0, 0, 0),
#'           max = c(1, 1, 1),
#'           mode = c(0.5, 0.5, 0.5))
#' # min and max will be recycled to the length of x
#' rec_d <- dtri(x,
#'               min = 0,
#'               max = 1,
#'               mode = c(0.5, 0.5, 0.5))
#' all.equal(d, rec_d)
#'
#' # min, max, and mode with lengths equal to the length of x
#' n <- 3
#' set.seed(1)
#' r <- rtri(n,
#'           min = c(0, 0, 0),
#'           max = c(1, 1, 1),
#'           mode = c(0.5, 0.5, 0.5))
#' # min and max will be recycled to the length of n
#' set.seed(1)
#' rec_r <- rtri(n,
#'               min = 0,
#'               max = 1,
#'               mode = c(0.5, 0.5, 0.5))
#' all.equal(r, rec_r)
#'
#' # Log quantiles
#' x <- c(0, 0.5, 1)
#' log_d <- dtri(x, log = TRUE)
#' d <- dtri(x, log = FALSE)
#' all.equal(log(d), log_d)
#'
#' # Upper tail probabilities
#' q <- c(0, 0.5, 1)
#' upper_p <- ptri(q, lower_tail = FALSE)
#' p <- ptri(q, lower_tail = TRUE)
#' all.equal(upper_p, 1 - p)
#'
#' # Log probabilities
#' q <- c(0, 0.5, 1)
#' log_p <- ptri(q, log_p = TRUE)
#' p <- ptri(q, log_p = FALSE)
#' all.equal(upper_p, 1 - p)
#'
#' # The quantile function
#' p <- c(0, 0.5, 1)
#' upper_q <- ptri(1 - p, lower_tail = FALSE)
#' q <- ptri(p, lower_tail = TRUE)
#' all.equal(upper_q, q)
#' p <- c(0, 0.5, 1)
#' log_q <- qtri(log(p), log_p = TRUE)
#' q <- qtri(p, log_p = FALSE)
#' all.equal(log_q, q)
#'
#' # Moment generating function
#' t <- c(1, 2, 3)
#' mgtri(t)
#'
#' # Expected Shortfall
#' p <- c(0.1, 0.5, 1)
#' estri(p)
#'
NULL

#' @rdname Triangular
#' @export
dtri <- function(x,
                 min = 0,
                 max = 1,
                 mode = 0.5,
                 log = FALSE) {
  check_numeric(x, min, max, mode)
  check_scalar_lgl(log)
  is_scalar_params <- is_scalar(min, max, mode)
  if (!is_scalar_params) {
    try_recycle(x, min, max, mode)
  }
  dtri_cpp(x, min, max, mode, log, is_scalar_params)
}

#' @rdname Triangular
#' @export
ptri <- function(q,
                 min = 0,
                 max = 1,
                 mode = 0.5,
                 lower_tail = TRUE,
                 log_p = FALSE) {
  check_numeric(q, min, max, mode)
  check_scalar_lgl(lower_tail, log_p)
  is_scalar_params <- is_scalar(min, max, mode)
  if (!is_scalar_params) {
    try_recycle(q, min, max, mode)
  }
  ptri_cpp(q, min, max, mode, lower_tail, log_p, is_scalar_params)
}

#' @rdname Triangular
#' @export
qtri <- function(p,
                 min = 0,
                 max = 1,
                 mode = 0.5,
                 lower_tail = TRUE,
                 log_p = FALSE) {
  check_numeric(p, min, max, mode)
  check_scalar_lgl(lower_tail, log_p)
  is_scalar_params <- is_scalar(min, max, mode)
  if (!is_scalar_params) {
    try_recycle(p, min, max, mode)
  }
  qtri_cpp(p, min, max, mode, lower_tail, log_p, is_scalar_params)
}

#' @rdname Triangular
#' @export
rtri <- function(n,
                 min = 0,
                 max = 1,
                 mode = 0.5) {
  check_numeric(n, min, max, mode)
  if (length(n) != 1 || n < 1) {
    cnd_signal(tri_error_n(n))
  }
  n <- as.integer(n)
  is_scalar_params <- is_scalar(min, max, mode)
  if (!is_scalar_params) {
    try_recycle(n, min, max, mode, .f = c)
  }
  rtri_cpp(n, min, max, mode, is_scalar_params)
}

#' @rdname Triangular
#' @export
mgtri <- function(t,
                  min = 0,
                  max = 1,
                  mode = 0.5) {
  check_numeric(t, min, max, mode)
  is_scalar_params <- is_scalar(min, max, mode)
  if (!is_scalar_params) {
    try_recycle(t, min, max, mode)
  }
  mgtri_cpp(t, min, max, mode, is_scalar_params)
}

#' @rdname Triangular
#' @export
estri <- function(p,
                  min = 0,
                  max = 1,
                  mode = 0.5,
                  lower_tail = TRUE,
                  log_p = FALSE) {
  check_numeric(p, min, max, mode)
  check_scalar_lgl(lower_tail, log_p)
  is_scalar_params <- is_scalar(min, max, mode)
  if (!is_scalar_params) {
    try_recycle(p, min, max, mode)
  }
  estri_cpp(p, min, max, mode, lower_tail, log_p, is_scalar_params)
}
