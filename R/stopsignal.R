#' Stop Signal Paradigm
#'
#' A classical test on inhibition skills.
#'
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] with the following variables:
#'   \item{pc_all}{Percent of correct for all the responses.}
#'   \item{pc_go}{Percent of correct for the go trials only.}
#'   \item{medrt_go}{Median reaction time (ms) of go trials.}
#'   \item{ssrt}{Stop signal reaction time (ms).}
#' @export
stopsignal <- function(data, by, vars_input) {
  data_cor <- data %>%
    mutate(
      # remove rt of 100 or less for go trials
      rt_cor = ifelse(
        .data[[vars_input[["name_rt"]]]] <= 100 &
          .data[[vars_input[["name_type"]]]] == "go",
        NA, .data[[vars_input[["name_rt"]]]]
      )
    )
  indices_from_acc <- data_cor %>%
    group_by(across(all_of(by))) %>%
    summarise(
      pc_all = mean(.data[[vars_input[["name_acc"]]]] == 1),
      pc_go = sum(
        .data[[vars_input[["name_acc"]]]] == 1 &
          .data[[vars_input[["name_type"]]]] == "go"
      ) / sum(.data[[vars_input[["name_type"]]]] == "go")
    ) %>%
    ungroup()
  indices_from_rt <- data_cor %>%
    group_by(across(all_of(by))) %>%
    group_modify(
      ~ .calc_ssrt(
        .x,
        name_type = vars_input[["name_type"]],
        name_acc = vars_input[["name_acc"]],
        name_rt = "rt_cor",
        name_ssd = vars_input[["name_ssd"]]
      )
    ) %>%
    ungroup()
  left_join(indices_from_acc, indices_from_rt, by = by)
}

.calc_ssrt <- function(data, name_type, name_acc, name_rt, name_ssd) {
  calc_ssd <- purrr::possibly(
    ~ mean(
      c(
        pracma::findpeaks(.x)[, 1],
        -pracma::findpeaks(-.x)[, 1]
      )
    ),
    otherwise = NA_real_
  )
  data %>%
    filter(.data[[name_type]] != "go") %>%
    group_by(.data[[name_type]]) %>%
    summarise(
      ssd = calc_ssd(.data[[name_ssd]]),
      .groups = "drop"
    ) %>%
    summarise(mean_ssd = mean(.data[["ssd"]])) %>%
    transmute(
      medrt_go = stats::median(
        data[[name_rt]][data[[name_type]] == "go" & data[[name_acc]] == 1],
        na.rm = TRUE
      ),
      ssrt = .data[["medrt_go"]] - .data[["mean_ssd"]]
    )
}
