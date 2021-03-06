test_that("Should return with attributes (meta information):", {
  data <- tibble::tibble(
    user_id = 1,
    game_id = "aabb",
    game_time = "1990-01-01",
    game_data = jsonlite::toJSON(data.frame(a = 1:5, b = 1:5))
  )
  expect_snapshot(wrangle_data(data))
})

test_that("Can deal with invalid json (remove it)", {
  data_case_invalid <- tibble::tibble(
    user_id = 1,
    game_data = jsonlite::toJSON(
      data.frame(NHit = 10, Feedback = 1)
    ) %>%
      substr(1, 5)
  )
  expect_silent(be_null <- wrangle_data(data_case_invalid))
  expect_null(be_null)
})

test_that("Can deal with empty json (remove it)", {
  data_case_empty1 <- tibble::tibble(
    user_id = 1,
    game_data = "[]"
  )
  data_case_empty2 <- tibble::tibble(
    user_id = 1,
    game_data = "{}"
  )
  expect_silent(be_null <- wrangle_data(data_case_empty1))
  expect_null(be_null)
  expect_silent(be_null <- wrangle_data(data_case_empty2))
  expect_null(be_null)
})

test_that("Remove duplicates", {
  data <- tibble::tibble(
    user_id = 1:2,
    game_data = c(
      jsonlite::toJSON(data.frame(a = 1:5, b = 1:5)),
      jsonlite::toJSON(data.frame(a = 2:4, b = 1:3))
    )
  )
  data_dup <- data %>%
    slice(seq_len(nrow(data)), 1)
  parsed_dup <- wrangle_data(data_dup)
  expect_snapshot(parsed_dup)
  expect_identical(parsed_dup, wrangle_data(data))
})