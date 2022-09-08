dirr <- tempdir()
dat <- mtcars

test_that("cache to qs file works", {
  write_cache(dat, cache_dir = dirr)
  testthat::expect_true(file.exists(fs::path(dirr, "dat")))
})

test_that("read_cache works", {
  read_cache(dat, cache_dir = dirr)
  testthat::expect_identical(mtcars, dat)
})
