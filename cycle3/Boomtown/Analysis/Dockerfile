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
    g++ \
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

ENV PANDOC_VERSION 2.0.2
ENV PANDOC_DOWNLOAD_URL https://github.com/jgm/pandoc/archive/$PANDOC_VERSION.tar.gz
ENV PANDOC_DOWNLOAD_SHA512 5830e0d8670a0bf80d9e8a84412d9f3782d5a6d9cf384fc7a853ad7f4e41a94ed51322ca73b86ad93528a7ec82eaf343704db811ece3455e68f1049761544a88
ENV PANDOC_ROOT /usr/local/pandoc

RUN apk add --no-cache \
    gmp \
    libffi \
 && apk add --no-cache --virtual build-dependencies \
    --repository "http://nl.alpinelinux.org/alpine/edge/community" \
    ghc \
    cabal \
    linux-headers \
    musl-dev \
    zlib-dev \
    curl \
 && mkdir -p /pandoc-build && cd /pandoc-build \
 && curl -fsSL "$PANDOC_DOWNLOAD_URL" -o pandoc.tar.gz \
 && echo "$PANDOC_DOWNLOAD_SHA512  pandoc.tar.gz" | sha512sum -c - \
 && tar -xzf pandoc.tar.gz && rm -f pandoc.tar.gz \
 && ( cd pandoc-$PANDOC_VERSION && cabal update && cabal install --only-dependencies \
    && cabal configure --prefix=$PANDOC_ROOT \
    && cabal build \
    && cabal copy \
    && cd .. ) \
 && rm -Rf pandoc-$PANDOC_VERSION/ \
 && apk del --purge build-dependencies \
 && rm -Rf /root/.cabal/ /root/.ghc/ \
 && cd / && rm -Rf /pandoc-build

ENV PATH $PATH:$PANDOC_ROOT/bin

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

RUN Rscript -e "install.packages('rmarkdown', repos='http://cran.us.r-project.org')"

CMD Rscript -e "rmarkdown::render('NGS2_WITNESS_Cycle3_h${HYPOTHESIS}_TOY.rmd', output_file='output/NGS2_WITNESS_Cycle3_h${HYPOTHESIS}_TOY.html')"