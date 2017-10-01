library(retriever)
library(testthat)

# Test for INPUT and OUTPUT of retriever function

context("Coordinates lookup")

test_that("Overall test",{
  expect_that(coordinates(address = 2),
              throws_error("Use character values"))
  expect_that(is.data.frame(coordinates(address = "bjornskogsgrnd 18")),
              is_true())
  expect_that(coordinates(address = "Parliament Dr, Canberra ACT 2600, Australia")[,"lat"],
              equals(-35.306486))
  expect_that(coordinates(address = "?"),
              throws_error("No match found"))
  expect_that(coordinates(address = "Parliament Dr, Canberra ACT 2600, Australia"),
              equals(coordinates(address = "Parliament Dr, Canberra ACT 2600, Australia")))
})


context('coord input parameters:')

test_that('Wrong input type:',  {
  expect_that(coordinates('a', 'b'), throws_error())
  expect_that(coordinates('a', 50.4), throws_error())
  expect_that(coordinates(-17.3, 'b'), throws_error())
})
test_that('Real values out of range:', {
  expect_that(coordinates(91, 72.01), throws_error())
  expect_that(coordinates(-91, 72.01), throws_error())
  expect_that(coordinates(14.82, 181), throws_error())
  expect_that(coordinates(14.82, -181), throws_error())

})

  







