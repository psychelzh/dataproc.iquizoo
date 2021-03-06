#' Number Line Estimation
#'
#' A classical test on subject's numerical estimation skills.
#'
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mean_abs_err}{Mean absolute error.}
#'   \item{mean_log_err}{Mean log absolute error.}
#' @export
nle <- function(data, by, vars_input) {
  data %>%
    mutate(
      err = abs(.data[[vars_input[["name_number"]]]] -
        .data[[vars_input[["name_resp"]]]])
    ) %>%
    group_by(across(all_of(by))) %>%
    summarise(
      mean_abs_err = mean(.data[["err"]]),
      mean_log_err = mean(log(.data[["err"]] + 1)),
      .groups = "drop"
    )
}
