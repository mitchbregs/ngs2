FROM continuumio/conda_builder_linux

LABEL maintainer="Pablo Diego-Rosell c_Pablo_Diego-Rosell@gallup.co.uk"

RUN mkdir /app
WORKDIR /app

COPY environment.yaml /tmp/environment.yaml

RUN conda update -n base -c defaults conda \
 && conda env create -f /tmp/environment.yaml \
 && conda shell.posix activate ngs2 \
 && conda install -c conda-forge pandoc \
 && conda install -c anaconda libcurl \
 && conda install -c anaconda make \
 && conda install -c r r-mvtnorm

ADD . /app

ENV HYPOTHESIS=15

CMD /opt/conda/envs/ngs2/bin/Rscript -e "library(rmarkdown); render('NGS2_WITNESS_Cycle3_h${HYPOTHESIS}_TOY.rmd', output_file='output/NGS2_WITNESS_Cycle3_h${HYPOTHESIS}_TOY.html')"