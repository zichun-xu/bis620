data("ukb_accel")
ukb_accel_100 <- ukb_accel[1:100, ]

### fft
ret <- map_dfc(
  ukb_accel_100 |> select(X, Y, Z),
  ~ fft(.x, inverse = TRUE) |> Mod()
)
ret <- ret[seq_len(ceiling(nrow(ret) / 2)), ]
longest_period <-
  as.numeric(difftime(max(ukb_accel_100$time),
                      min(ukb_accel_100$time), units = "secs"))
xt <- ukb_accel_100$time[1:2]
shortest_period <- as.numeric(difftime(max(xt), min(xt), units = "secs"))
ret$freq <- 1 / seq(longest_period, shortest_period, length.out = nrow(ret))
saveRDS(ret, "tests/testthat/fixtures/ukb_accel_100_fft")

### fft, log
ret_log <- map_dfc(
  ukb_accel_100 |> select(X, Y, Z),
  ~ fft(.x, inverse = TRUE) |> Mod()
)
ret_log <- ret_log |>
  mutate_at(vars(X, Y, Z), log)
ret_log <- ret_log[seq_len(ceiling(nrow(ret_log) / 2)), ]
longest_period <-
  as.numeric(difftime(max(ukb_accel_100$time),
                      min(ukb_accel_100$time), units = "secs"))
xt <- ukb_accel_100$time[1:2]
shortest_period <- as.numeric(difftime(max(xt), min(xt), units = "secs"))
ret_log$freq <- 1 / seq(longest_period,
                        shortest_period, length.out = nrow(ret_log))
saveRDS(ret_log, "tests/testthat/fixtures/ukb_accel_100_fft_log")

### fft, no inverse
ret_noinverse <- map_dfc(
  ukb_accel_100 |> select(X, Y, Z),
  ~ fft(.x, inverse = FALSE) |> Mod()
)
ret_noinverse <- ret_noinverse[seq_len(ceiling(nrow(ret_noinverse) / 2)), ]
longest_period <-
  as.numeric(difftime(max(ukb_accel_100$time),
                      min(ukb_accel_100$time), units = "secs"))
xt <- ukb_accel_100$time[1:2]
shortest_period <- as.numeric(difftime(max(xt), min(xt), units = "secs"))
ret_noinverse$freq <- 1 / seq(longest_period, shortest_period,
                           length.out = nrow(ret_noinverse))
saveRDS(ret_noinverse, "tests/testthat/fixtures/ukb_accel_100_fft_noinverse")
