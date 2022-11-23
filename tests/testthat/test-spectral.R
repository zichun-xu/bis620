test_that(
  "The spectral_signature() returns a data.frame object",
  {
    data(ukb_accel)
    p <-  spectral_signature(ukb_accel[1:100, ])
    expect_true("data.frame" %in% class(p))
  }
)

test_that(
  "The spectral_signature() returns a
  data.frame with X, Y, Z, and fraq channels",
  {
    data(ukb_accel)
    p <-  spectral_signature(ukb_accel[1:100, ])
    expect_true(all(colnames(p) == c("X", "Y", "Z", "freq")))
  }
)

test_that(
  "The spectral_signature() errors when no time or freq column.",
  {
    data(iris)
    expect_error(spectral_signature(iris))
  }
)

test_that(
  "The spectral_signature() is correct.",
  {
    data(ukb_accel)
    p <- spectral_signature(ukb_accel[1:100, ])
    q <- readRDS(test_path("fixtures", "ukb_accel_100_fft"))
    expect_equal(q, p)
  }
)

test_that(
  "The spectral_signature() is correct when taking log.",
  {
    data(ukb_accel)
    p <- spectral_signature(ukb_accel[1:100, ], take_log = TRUE)
    q <- readRDS(test_path("fixtures", "ukb_accel_100_fft_log"))
    expect_equal(q, p)
  }
)

test_that(
  "The spectral_signature() is correct with no inverse.",
  {
    data(ukb_accel)
    p <- spectral_signature(ukb_accel[1:100, ], inverse = FALSE)
    q <- readRDS(test_path("fixtures", "ukb_accel_100_fft_noinverse"))
    expect_equal(q, p)
  }
)
