

#' Operators
#'
#' Extensions of base operators.
#'
#' @param x Numeric or character vector.
#' @param vector Numeric or character vector.
#'
#' @name operators
#'
#' @return logical
NULL


#' `%notin%`
#'
#' inverse of `%in%`
#'
#' @rdname operators
#'
#' @keywords operators
#'
#' @seealso [base::any()], [base::match()], and [base::all()]
#'
#' @examples
#' data <- data.frame(
#'   id = 1:10,
#'   x = as.integer(runif(10, 0, 10))
#' )
#'
#' data[data$id %notin% c(1, 3, 5, 7, 9), ]
#'
#' @export
#'
#' @return logical
`%notin%` <- function(x, vector) {

  match(x, vector, nomatch=0) == 0

}

#' All In - Test for all objects within a vector.
#'
#' @rdname operators
#'
#' @export
#'
#' @examples
#' 1:2 %allin% 1:3  # TRUE
#' 3:4 %allin% 1:3  # FALSE
`%allin%` <- function(x, vector) {

  all(x %in% vector)

}

#' Any In - Test if any objects are in a vector.
#'
#' @rdname operators
#'
#' @export
#'
#' @examples
#' 3:4 %anyin% 1:3  # TRUE
#' 4:5 %anyin% 1:3  # FALSE
`%anyin%` <- function(x, vector) {

  any(x %in% vector)

}

#' None In - Test if no objects are in a vector.
#'
#' @rdname operators
#'
#' @export
#'
#' @examples
#' 3:4 %nonein% 1:3  # FALSE
#' 4:5 %nonein% 1:3  # TRUE
`%nonein%` <- function(x, vector) {

  !any(x %in% vector)

}

#' Part In - Match a pattern to a vector via \code{grepl}.
#'
#' @rdname operators
#'
#' @param pattern Character string containing \strong{regular expressions} to be matched.
#'
#' @export
#'
#' @examples
#' "Bei" %partin% c("Beijing", "Shanghai")  # TRUE
#' "bei" %partin% c("Beijing", "Shanghai")  # FALSE
#' "[aeiou]ng" %partin% c("Beijing", "Shanghai")  # TRUE
#'
#' @seealso [base::grepl()]
`%partin%` <- function(pattern, vector) {

  any(grepl(pattern, vector, perl=TRUE))

}





