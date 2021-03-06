set.seed(1)
n_subject <- 100
data <- expand_grid(
  id = seq_len(n_subject),
  angle = sample(c(6:9, -(6:9)) * 6)
) %>%
  rowwise() %>%
  mutate(
    resp_base = list(sample(c(-1, 1), sample(1:100, 1), replace = TRUE)),
    resp = recode(resp_base, `1` = "Left", `-1` = "Right") %>%
      stringr::str_c(collapse = "-"),
    resp_angle = sum(resp_base) * 6,
    resp_err = abs(resp_angle - angle) %% 360,
    acc = ifelse(resp_err %in% c(0, 180), 1, 0)
  ) %>%
  ungroup() %>%
  select(-contains("_"))

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, jlo, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, jlo, by = c("id", "id1")))
})

test_that("Works when character case is messy", {
  data_case_messy <- data %>%
    mutate(
      resp = recode(resp, Left = "left")
    )
  expect_silent(
    case_messy <- preproc_data(data_case_messy, jlo, by = "id")
  )
  expect_identical(
    case_messy,
    preproc_data(data, jlo, by = "id")
  )
})
