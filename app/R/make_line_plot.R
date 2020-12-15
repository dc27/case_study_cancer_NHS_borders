add_lines <- function (data, plot) {
  p <- plot +
    geom_line(data = data,
              aes(y = value, group = measurement)) +
    geom_ribbon(data = data,
                aes(ymin = lower_95pc_c_i,
                    ymax = upper_95pc_c_i), alpha = 0.2)
  return(p)
}


create_line_plot <- function (data, measurements) {
  plot <-
    ggplot() +
    aes(x = year)
  
  for (i in 1:length(measurements())) {
    filtered_data <- data %>% 
      filter(measurement == measurements()[i])
    plot <- add_lines(filtered_data, plot)
  }
  plot <- plot +
    theme_bw()
  return(plot)
}

