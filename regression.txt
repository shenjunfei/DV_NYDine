

Call:
lm(formula = eigenvector ~ fans + yelping_since + votes + review_count + 
    compliments, data = df_ctrl)

Residuals:
     Min       1Q   Median       3Q      Max 
-0.23905 -0.10551 -0.03179  0.04536  0.43704 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)    8.045e+01  2.179e+01   3.692 0.000402 ***
fans           6.023e-04  1.410e-04   4.272 5.25e-05 ***
yelping_since -4.001e-02  1.086e-02  -3.683 0.000415 ***
votes          6.537e-06  4.001e-06   1.634 0.106207    
review_count  -8.373e-06  3.901e-05  -0.215 0.830588    
compliments   -2.418e-05  1.533e-05  -1.578 0.118576    

Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.1565 on 81 degrees of freedom
Multiple R-squared:  0.5341,	Adjusted R-squared:  0.5053 
F-statistic: 18.57 on 5 and 81 DF,  p-value: 3.008e-12
