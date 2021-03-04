#' Collapse Rows
#'
#' for each group, sets the top row of the group to the group's value.  All other
#' rows in the group are set to "".  See the example
#'
#' @param df a data frame
#' @param variable group variable to be collapsed
#'
#' @return a data frame with an updated `variable` column
#'
#' @export
#'
#' @importFrom dplyr group_by mutate n ungroup select
#' @importFrom rlang enquo quo_name
collapseRows <- function(df, variable){

  group_var <- rlang::enquo(variable)

  df %>%
    dplyr::group_by(!! group_var) %>%
    dplyr::mutate(groupRow = 1:dplyr::n()) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(!!rlang::quo_name(group_var) := ifelse(groupRow == 1, as.character(!! group_var), "")) %>%
    dplyr::select(-c(groupRow))
}

str_to_quotes <- function(x) {
  if (is.character(x)) {
    x <- glue::glue('"{x}"')
  }
  x
}

# If x is string, quotes " are added on both sides of this string to work well
# with glue().
chk_arg_upgrade <- function(x) {
  checkmate::assert_choice(
    as.character(x),
    c(TRUE, "default", "ask", "always", "never", FALSE)
  )
  str_to_quotes(x)
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ui_msg_restart_rstudio <- function() {
  usethis::ui_todo(paste0(
    "To take effect, {underline('RStudio')} should be ",
    "{underline('closed and reopened')}."
  ))
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# str_glue_eval ==============================================================
str_glue_eval <- function(..., envir = parent.frame(), .sep = "",
                          .open = "{", .close = "}", envir_eval = envir,  envir_glue = envir) {

  commands_as_text <- glue::glue(...,
                                 .envir = envir_glue,
                                 .open  = .open,
                                 .close = .close
  )
  eval(parse(text = commands_as_text), envir = envir_eval)
}

make_unique_obj_names <- function(names, prefix = "", suffix = "",
                                  list_of_choices = objects(all.names = TRUE, envir = .GlobalEnv),
                                  all_numbered = TRUE) {

  if (length(names) == 0) {
    return(NULL)
  }
  initial_names <- glue::glue("{prefix}{names}{suffix}")
  n_names <- length(names)

  list_to_check <-
    if (all_numbered) {
      c(list_of_choices, initial_names, initial_names)

    } else {
      c(list_of_choices, initial_names)
    }

  list_to_check %>%
    make.unique(sep = "_") %>%
    rev() %>%
    .[1:n_names] %>%
    rev()
}
