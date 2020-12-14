make_line_plot <- function (data) {
  data %>% 
    ggplot() +
    aes(x = year) +
    geom_line(
      aes(y = crude_rate), size = 2
    ) +
    geom_ribbon(
      aes(ymin = crude_rate_lower95pc_confidence_interval,
          ymax = crude_rate_upper95pc_confidence_interval), fill = "grey", alpha = 0.5
    ) +
    geom_line(
      aes(y = easr), colour = "blue"
    ) +
    geom_ribbon(
      aes(ymin = easr_lower95pc_confidence_interval,
          ymax = easr_upper95pc_confidence_interval), fill = "light blue", alpha = 0.2
    ) +
    geom_line(
      aes(y = wasr), colour = "green"
    ) +
    geom_ribbon(
      aes(ymin = wasr_lower95pc_confidence_interval,
          ymax = wasr_upper95pc_confidence_interval), fill = "light green", alpha = 0.2
    ) +
    theme_bw()
}