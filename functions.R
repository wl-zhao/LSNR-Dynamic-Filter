H <- function(omegas, n, d, alpha, omega_s){
  s <- rep(0, length(omegas))
  a <- cos(alpha)
  delta <- 10 ^(-d)
  i <- 1
  for (omega in omegas)
  {
    if (omega >= alpha)
    {
      phi <- (2 * cos(omega) - a + 1) / (a + 1)
      s[i] <- delta * cos(n * acos(phi))
    }
    else
    {
      phi <- (2 * cos(omega) -a + 1)/ (a + 1)
      s[i] <- (delta/2) * ((phi + sqrt(phi^2 - 1))^n + (phi - sqrt(phi^2-1))^n)
    }
    phi <- (2 * cos(omega_s)- a + 1)/(a + 1)
    adj1 <- (10^(-d)/2) * ((phi + sqrt(phi^2 - 1))^n + (phi-sqrt(phi^2 - 1))^n)
    s[i] <- s[i] / adj1;
    i <- i + 1
  }
  return(s)
}

test <- function(x){
  return(x)
}

oirf <- function(n, d, alpha, omega_s, omega_n){
  if (omega_s < omega_n)
  {
    H1 <- function(omega, n, d, alpha, omega_s){
      return(H(omega, n, d, alpha, omega_s))
    }
  }
  else
  {
    H1 <- function(omega, n, d, alpha, omega_s){
      return(H(2 * omega_s - omega, n, d, 2 * omega_s - alpha, omega_s))
    }
  }
  h <- rep(0, 2 * n + 1)
  for (k in -n : n)
  {
    f <- function(omega){
      return(H1(omega, n, d, alpha, omega_s) * cos(k * omega))
    }
    int <- integrate(f, 0, pi)
    h[k + n + 1] <- 1 / (2 * pi) * 2 * int[[1]];
  }
  return(h)
}

ofrf <- function(n, d, alpha, omega_s, omega_n){
  omega <- seq(omega_s, pi, 0.001)
  if (omega_s < omega_n)
  {
    H_omega <- H(omega, n, d, alpha, omega_s)
    return(plot(omega, H_omega, lty=1,col="#FFA500",type = "l", 
                main="OFRF", xlab=expression(omega), ylab="H", xlim = c(omega_s, pi)))
  }
  else
  {
    H_omega <- H(2 * omega_s - omega, n, d, 2 * omega_s - alpha, omega_s)
    return(plot(omega, H_omega, lty=1, type = "l", xlim=c(0, omega_s)))
  }
}

filter1 <- function(xt, ht){
  n <- (length(ht) - 1) / 2
  yt <- convolve(xt, rev(ht), type = "open");
  yt <- yt[(n + 1) : (n + length(xt))]
  t_plot <- (n + 1) : (length(xt) - n)
  return(list(yt=yt, t_plot=t_plot))
}

stem_plot <- function(x, y, main, xlab, ylab, col="black"){
  plot_range <- 1 : 100
  plot(x[plot_range], y[plot_range], type='h', main=main, xlab=xlab, ylab=ylab, col=col)
  points(x[plot_range], y[plot_range], pch=19, col=col)
}

estimate_N <- function(d, nsr, alpha){
  a <- cos(alpha)
  b <- (3 - a) / (a + 1)
  c <- b + sqrt(b ^ 2 - 1)
  d <- 2 / 10 ^ (-d) * nsr
  return(ceiling(log(d) / log(c)))
}
# print(integrate(test, 0, 1))
# 
# for (omega in seq(0, pi, 0.1))
#   print(H(omega, 6, 7, 2 * pi/3, pi/4))
