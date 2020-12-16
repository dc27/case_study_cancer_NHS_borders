add_lines <- function (data, plot) {
  # extract measurement name to apply colour
  measurement <- data %>% 
    select(measurement) %>% 
    unique() %>% 
    pull()

  # colour system
  colour <- case_when(
    measurement == "CRUDE" ~ "#e41a1c",
    measurement == "SIR" ~ "#377eb8",
    measurement == "WASR" ~ "#4daf4a",
    measurement == "EASR" ~ "#984ea3"
  )
  
  # add line to plot based on filtered measurement
  # include confidence intervals
  p <- plot +
    geom_line(data = data,
              aes(y = value, group = measurement), colour = colour) +
    geom_ribbon(data = data,
                aes(ymin = lower_95pc_c_i,
                    ymax = upper_95pc_c_i), fill = colour, alpha = 0.2)
  return(p)
}


create_line_plot <- function (data, measurements) {
  plot <-
    ggplot() +
    aes(x = year)
  
  # add lines for each specified measurement
  for (i in 1:length(measurements())) {
    filtered_data <- data %>% 
      filter(measurement == measurements()[i])
    plot <- add_lines(filtered_data, plot)
  }
  plot <- plot +
    theme_bw()
  # output complete plot
  return(plot)
}

