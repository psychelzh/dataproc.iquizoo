# prepare data
set.seed(1)
data <- expand_grid(
  id = 1:100,
  block = 1:8
) %>%
  mutate(n = sample(0:50, n(), replace = TRUE)) %>%
  uncount(n, .id = "trial") %>%
  mutate(
    stimtype = sample(
      c("Incongruent", "Congruent"),
      n(),
      replace = TRUE
    ),
    task = case_when(
      block %in% c(1, 8) ~ "T1",
      block %in% c(2, 7) ~ "T2",
      TRUE ~ sample(c("T1", "T2"), n(), replace = TRUE)
    ),
    acc = sample(c(0, 1), n(), replace = TRUE),
    rt = rexp(n(), 0.001)
  ) %>%
  complete(
    block, nesting(id),
    fill = list(
      trial = 1,
      stimtype = "Congruent",
      task = "T1",
      acc = -1,
      rt = 0
    )
  ) %>%
  mutate(
    tasktype = case_when(
      block %in% c(1:2, 7:8) ~ "Pure",
      trial == 1 ~ "Filler",
      task == lag(task) ~ "Repeat",
      TRUE ~ "Switch"
    )
  )
data_miss_cond <- tibble::tibble(
  id = rep(1:2, each = 8),
  block = rep(1:8, 2),
  stimtype = "Incongruent",
  task = "T1",
  tasktype = rep(c(rep("Pure", 2), rep("Repeat", 4), rep("Pure", 2)), 2),
  acc = sample(c(0, 1), 16, replace = TRUE),
  rt = rexp(16, 0.001)
)
data_part_miss_cond <- tibble::tibble(
  id = rep(1:2, each = 8),
  block = rep(1:8, 2),
  stimtype = c(
    rep("Incongruent", 8),
    rep("Incongruent", 4),
    rep("Congruent", 4)
  ),
  task = "T1",
  tasktype = c(
    c(rep("Pure", 2), rep("Repeat", 4), rep("Pure", 2)),
    c(rep("Pure", 2), rep("Repeat", 2), rep("Switch", 2), rep("Pure", 2))
  ),
  acc = sample(c(0, 1), 16, replace = TRUE),
  rt = rexp(16, 0.001)
)

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, complexswitch, by = "id"))
})

test_that("All single condition", {
  expect_snapshot(preproc_data(data_miss_cond, complexswitch, by = "id"))
})

test_that("Part subject single condition", {
  expect_snapshot(preproc_data(data_part_miss_cond, complexswitch, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, complexswitch, by = c("id", "id1")))
})

test_that("Works when character case is messy", {
  data_case_messy <- data %>%
    mutate(
      stimtype = recode(stimtype, Congruent = "congruent"),
      tasktype = recode(tasktype, Pure = "pure"),
      task = recode(task, T1 = "t1")
    )
  expect_silent(
    case_messy <- preproc_data(data_case_messy, complexswitch, by = "id")
  )
  expect_identical(
    case_messy,
    preproc_data(data, complexswitch, by = "id")
  )
})
