#' Get variable names of data
#'
#' An internal data-set is used to store data variables, which should not be
#' visited directly by any other functions. Here is two functions to get its
#' "input" and "output" variables.
#'
#' @rdname get_vars
#' @param prep_fun_name The name of the called pre-processing function.
.get_input_vars <- function(prep_fun_name) {
  config_data_vars[[prep_fun_name]][["input"]]
}

#' @rdname get_vars
.get_output_vars <- function(prep_fun_name) {
  config_data_vars[[prep_fun_name]][["output"]]
}