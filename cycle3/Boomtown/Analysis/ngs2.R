# Make report using Docker
library(rmarkdown)

# Make the report
render('NGS2_WITNESS_Cycle3_Hyp.RMD', output_file='NGS2_WITNESS_Cycle3.html')
