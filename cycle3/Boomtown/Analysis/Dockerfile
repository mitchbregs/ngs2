FROM frolvlad/alpine-glibc:alpine-3.12

ARG CONDA_VERSION="4.7.12.1"
ARG CONDA_MD5="81c773ff87af5cfac79ab862942ab6b3"
ARG CONDA_DIR="/opt/conda"

ENV PATH="$CONDA_DIR/bin:$PATH"
ENV PYTHONDONTWRITEBYTECODE=1

# Install conda
RUN echo "**** install dev packages ****" && \
    apk add --no-cache --virtual .build-dependencies bash ca-certificates wget && \
    \
    echo "**** get Miniconda ****" && \
    mkdir -p "$CONDA_DIR" && \
    wget "http://repo.continuum.io/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh" -O miniconda.sh && \
    echo "$CONDA_MD5  miniconda.sh" | md5sum -c && \
    \
    echo "**** install Miniconda ****" && \
    bash miniconda.sh -f -b -p "$CONDA_DIR" && \
    echo "export PATH=$CONDA_DIR/bin:\$PATH" > /etc/profile.d/conda.sh && \
    \
    echo "**** setup Miniconda ****" && \
    conda update --all --yes && \
    conda config --set auto_update_conda False && \
    \
    echo "**** cleanup ****" && \
    apk del --purge .build-dependencies && \
    rm -f miniconda.sh && \
    conda clean --all --force-pkgs-dirs --yes && \
    find "$CONDA_DIR" -follow -type f \( -iname '*.a' -o -iname '*.pyc' -o -iname '*.js.map' \) -delete && \
    \
    echo "**** finalize ****" && \
    mkdir -p "$CONDA_DIR/locks" && \
    chmod 777 "$CONDA_DIR/locks"

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
 && conda install -c r r-mvtnorm \
 && conda install r-png r-rcurl

ADD . /app

ENV HYPOTHESIS=15

CMD /opt/conda/envs/ngs2/bin/Rscript -e "library(rmarkdown); render('NGS2_WITNESS_Cycle3_h${HYPOTHESIS}_TOY.rmd', output_file='output/NGS2_WITNESS_Cycle3_h${HYPOTHESIS}_TOY.html')"