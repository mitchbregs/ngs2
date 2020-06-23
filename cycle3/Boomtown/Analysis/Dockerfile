FROM alpine:latest

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

ENV BUILD_DEPS \
    cairo-dev \
    libxmu-dev \
    openjdk8-jre-base \
    pango-dev \
    perl \
    tiff-dev \
    tk-dev

ENV PERSISTENT_DEPS \
    R-mathlib \
    gcc \
    gfortran \
    icu-dev \
    libjpeg-turbo \
    libpng-dev \
    make \
    openblas-dev \
    pcre-dev \
    readline-dev \
    xz-dev \
    zlib-dev \
    bzip2-dev \
    curl-dev

# Install R and R-dev ------------------

RUN apk upgrade --update && \
    apk add --no-cache --virtual .build-deps $BUILD_DEPS && \
    apk add --no-cache --virtual .persistent-deps $PERSISTENT_DEPS && \
    apk add --no-cache R R-dev && \
    apk del .build-deps

LABEL maintainer="Pablo Diego-Rosell c_Pablo_Diego-Rosell@gallup.co.uk"

RUN mkdir /app
WORKDIR /app

# COPY environment.yaml /tmp/environment.yaml

# RUN conda update -n base -c defaults conda \
#  && conda env create -f /tmp/environment.yaml \
#  && conda shell.posix activate ngs2 \
#  && conda install -c conda-forge pandoc \
#  && conda install -c anaconda libcurl \
#  && conda install -c anaconda make \
#  && conda install -c r r-mvtnorm \
#  && conda install r-png r-rcurl

ADD . /app

ENV HYPOTHESIS=15

CMD Rscript -e "library(rmarkdown); render('NGS2_WITNESS_Cycle3_h${HYPOTHESIS}_TOY.rmd', output_file='output/NGS2_WITNESS_Cycle3_h${HYPOTHESIS}_TOY.html')"