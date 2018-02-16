# optimal_stop_function.R
# daniel hough

# optimal stopping

# the idea is that you know you are going to be presented with n choices of differing value
# you choose when to stop and accept the maximum possible value.

# What's the optimal value to stop on? This function uses a method to maximise the expected rank

optimal_stop <- function(x) {
  
  # function to set the strategy
  # we take the first instance where y[i] (our relative rank) <= s[i] (our strategy vector).
  strategy_erank <- function(n) {
    
    c <- rep(NA,n) # min expected rank
    s <- rep(NA,n) # strategy
    
    step <- function(i){i+1}
    
    c[step(n-1)] <- (n+1)/2
    s[step(n)] <- n
    
    for (i in (n-1):1) {
      
      s[step(i)]   <- floor((i+1)/(n+1)*c[step(i)])
      c[step(i)-1] <- 1/i * ((n+1)/(i+1)*s[step(i)]*(s[step(i)]+1)/2 + (i-s[step(i)])*c[step(i)])
      
    }
    
    return(list(s=s,c=c))
    
  }
  
  # set strategy
  s <- strategy_erank(length(x))$s[-1] 
  
  # Function to compute sequential relative ranks, where smallest is best (i.e. first # looks best, how does 
  # next number compare to previously seen numbers)
  relative_rank <- function(x) {
    
    output <- rep(NA,length(x))
    
    # take vector and find relative ranks, if sequentially disclosed
    for (i in 1:length(x)) {
      output[i] <- sum(x[1:i] >= x[i])
    }
    
    return(output)
    
  }
  
  # compute ranks
  y <- relative_rank(x)
  z <- rank(-x)
  
  # make choices
  index_select <- which.max(y <= s) # the location, of the (first) max of a numeric vector.
  index_max <- which.min(z) # the location, of the (first) min of a numeric vector.
  
  # output
  return(list(value = x[index_select],
           rank = z[index_select], 
           position = index_select,
           best_value = x[index_max],
           best_position = index_max,
           strategy = s,
           x = x))
  
}


n <- 1e2
x <- sample(1:n,replace=FALSE)
optimal_stop(x)

