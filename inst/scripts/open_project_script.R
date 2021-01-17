#! /usr/bin/Rscript --vanilla

require(jimstools)
tryCatch({
  jimstools:::open_project.shell()
}, error = function(e) {
  q()
})

