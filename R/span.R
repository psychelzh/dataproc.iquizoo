#' Span (spatial or verbal)
#'
#' There is a bunch of tests measuring working memory span or attention span.
#'
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:]
#'   \item{nc}{Count of correct responses.}
#'   \item{max_span}{Maximal span.}
#'   \item{mean_span}{Mean span.}
#' @export
span <- function(data, by, vars_input) {
  # "nc" is calculated from "correctness/accloc" column, but can be absent
  name_acc_cand <- c("correctness", "accloc")
  name_acc_chk <- rlang::has_name(data, name_acc_cand)
  if (any(name_acc_chk)) {
    name_acc <- name_acc_cand[name_acc_chk]
    nc <- data %>%
      mutate(acc = parse_char_resp(.data[[name_acc]])) %>%
      unnest(.data[["acc"]]) %>%
      group_by(across(all_of(by))) %>%
      summarise(
        nc = sum(.data[["acc"]] == 1),
        .groups = "drop"
      )
  } else {
    if (all(rlang::has_name(data, c("stim", "resp")))) {
      nc <- data %>%
        mutate(
          stim = parse_char_resp(.data[["stim"]]),
          resp = parse_char_resp(.data[["resp"]]),
          nc = purrr::map2_int(
            .data[["stim"]], .data[["resp"]],
            ~ sum(.x == .y)
          )
        ) %>%
        group_by(across(all_of(by))) %>%
        summarise(
          nc = sum(.data[["nc"]]),
          .groups = "drop"
        )
    } else {
      nc <- data %>%
        group_by(across(all_of(by))) %>%
        summarise(
          nc = NA_integer_,
          .groups = "drop"
        )
    }
  }
  spans <- data %>%
    group_by(across(
      all_of(c(by, vars_input[["name_slen"]]))
    )) %>%
    summarise(
      pc = mean(.data[[vars_input[["name_outcome"]]]] == 1),
      .groups = "drop_last"
    ) %>%
    summarise(
      max_span = max(.data[[vars_input[["name_slen"]]]]),
      mean_span = sum(.data[["pc"]]) +
        min(.data[[vars_input[["name_slen"]]]]) - .5,
      .groups = "drop"
    )
  left_join(nc, spans, by = by)
}
