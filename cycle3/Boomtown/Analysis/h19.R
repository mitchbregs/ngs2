## Created by Pablo Diego Rosell, PhD, for Gallup inc. in September 2019

# Formula
formula.h19<-as.formula("inmot2~density+conformity+grmot1+support+framing+complexity+timeUncertainty+pressure+tolerance+competition+centralization+leaderWeight+density+(1|player)+(1|group)")

# Extract number of prior parameters ('ndim') to be declared

fittedGlmer <- stan_glmer(formula.h19, data=factorial, family=binomial(link="logit"), iter=3, chains=1)
ndim<-length(fittedGlmer$covmat[1,])-2

# Declare priors
# Baseline priors based on DESIM
priorSD <- 0.25
# h19.0 priors (null): Network Density will not increase Individual motivation to innovate (T2)
h19.0 <- normal(location = c(0.0, rep(0, ndim)), scale = c(rep(2.5,ndim), priorSD), autoscale=FALSE)
# h19.1 priors: Network Density will increase Individual motivation to innovate (T2)
h19.1 <- normal(location = c(0.5, rep(0, ndim)), scale = c(rep(2.5,ndim), priorSD), autoscale=FALSE)

# Run models 

bridge_19.0 <- bayesGlmer(formula.h19, h19.0)
bridge_19.1 <- bayesGlmer(formula.h19, h19.1)

# Calculate BFs for all comparisons

test_1_0<-bf(bridge_19.1, bridge_19.0)$bf

# Save BFs

BFs <- data.frame(19, test_1_0)
colnames(BFs) <- c("Hypothesis",
                    "Prediction 1 vs. Null")
write.csv(BFs, paste(od, "BFs19.csv", sep = '/'))                      
