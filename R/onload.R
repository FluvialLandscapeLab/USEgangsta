.onLoad <- function(libname, pkgname) {
  op <- options()
  op.USEgangsta <- list(
    USEgangsta.OCLtags = list(
      "^model\\>",
      c("^class\\>",
        "^composition\\>",
        "^association\\>",
        "^constraints\\>"
      ),
      c("^attributes$",
        "^operations$"
      )
    )
  )

  toset <- !(names(op.USEgangsta) %in% names(op))
  if(any(toset)) options(op.USEgangsta[toset])

  invisible()
}
