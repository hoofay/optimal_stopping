# optimal_stopping
A function to apply a maximisation of expected rank method for optimal stopping.

# inputs
An ordered numerical vector of values (x).  

# process
A strategy is defined for choosing a stop value against a relative rank vector. The relative rank vector is a vector of sequential relative ranks, where largest is best (i.e. first # looks best, how does next numeric compare to previously seen numerics).

# output
value = the chosen value from x.
rank =  the rank of the chosen value.
position = the position of the chosen value.
best_value = the best possible choice.
best_position = the position of the best possible choice. 
strategy = the strategy vector for stopping. We take the first instance where y[i] (our relative rank vector) <= s[i] (our strategy vector).
x = the input vector
