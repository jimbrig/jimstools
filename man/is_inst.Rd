% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/config-packages.R
\name{is_inst}
\alias{is_inst}
\title{is_inst}
\usage{
is_inst(pkg)
}
\arguments{
\item{pkg}{string: package to search installation path for}
}
\value{
logical (TRUE/FALSE)
}
\description{
Check if a package is installed.
}
\details{
This function provides a lightweight alternative to
\code{\link[utils:installed.packages]{utils::installed.packages()}} by using \link{nzchar} instead.
}
\examples{
\dontrun{
is_inst("dplyr")
}
}
\references{
\itemize{
\item \href{https://stackoverflow.com/questions/9341635/check-for-installed-packages-before-running-install-packages/38082613#38082613}{Check for installed packages before running install.packages-Stack Overflow}
}
}
