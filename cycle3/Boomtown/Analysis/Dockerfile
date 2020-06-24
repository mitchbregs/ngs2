# ###### Dockerfile #######
# FROM jrnold/rstan

# # Set the working directory to /app
# #RUN mkdir /home/rstudio

# # Copy the current directory contents into the container at /app
# #COPY NGS2_WITNESS_Cycle2_Notebook.Rmd /home/rstudio/
# WORKDIR /report

# RUN R -e "options(repos = \
#   list(CRAN = 'http://mran.revolutionanalytics.com/snapshot/2019-02-06/')); \
#   install.packages('pacman', dependencies=TRUE); \
#   install.packages('formatR', dependencies=TRUE); \
#   install.packages('Hmisc', dependencies=TRUE); \
#   install.packages('bridgesampling', dependencies=TRUE); \
#   install.packages('recipes', dependencies=TRUE); \
#   install.packages('caret', dependencies=TRUE); \
#   install.packages('pROC', dependencies=TRUE); \
#   install.packages('randomForest', dependencies=TRUE)"

# # Set the container to run `Rscript --vanilla ` by default
# ENTRYPOINT ["/usr/local/bin/Rscript", "--vanilla"]

# ADD . /report

# # Set the `example_report.R data.csv` as the default script to run with ENTRYPOINT's Rscript
# CMD ["ngs2.R"]

FROM r-base:latest

LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vcs-url="https://github.com/rocker-org/rocker" \
      maintainer="Dirk Eddelbuettel <edd@debian.org>"

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
                ghostscript \
                lmodern \
                pandoc-citeproc \
                qpdf \
                r-cran-formatr \
                r-cran-ggplot2 \
                r-cran-knitr \
		r-cran-rmarkdown \
                r-cran-runit \
                r-cran-testthat \
                texinfo \
                texlive-fonts-extra \
                texlive-fonts-recommended \
                texlive-latex-extra \
                texlive-latex-recommended \
                texlive-luatex \
                texlive-plain-generic \
                texlive-science \
                texlive-xetex \
        && install.r binb linl pinp tint \
        && mkdir ~/.R \
        && echo _R_CHECK_FORCE_SUGGESTS_=FALSE > ~/.R/check.Renviron \
        && cd /usr/local/bin \
        && ln -s /usr/lib/R/site-library/littler/examples/render.r .

WORKDIR /app
ADD . /app

CMD ["bash"]