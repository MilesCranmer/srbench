# FROM continuumio/anaconda3
FROM mambaorg/micromamba

USER root

# Install base packages.
RUN apt update && apt install -y \
    default-jdk \
    bzip2 \
    ca-certificates \
    curl \
    gcc \
    git \
    wget \
    vim \
    build-essential \
    zlib1g-dev \
    libedit-dev \
    libncurses5-dev \
    libssl-dev \
    bzip2 \
    libbz2-dev \
    libreadline-dev \
    jq && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Install Julia:
WORKDIR /downloads/
COPY install_julia_linux.sh .
RUN bash install_julia_linux.sh 1.7.1

WORKDIR /opt/app/srbench/

COPY environment.yml ./
RUN micromamba env create -f environment.yml

# Install dynamically linked python:
RUN curl https://pyenv.run | bash
ENV PATH="/root/.pyenv/bin:$PATH"
ENV PYTHON_VERSION="3.9.10"
RUN PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install ${PYTHON_VERSION}
ENV PATH="/root/.pyenv/versions/${PYTHON_VERSION}/bin:$PATH"

# Install PySR:
COPY install.sh ./
COPY experiment/ ./experiment/

RUN source /usr/local/bin/_activate_current_env.sh && \
    micromamba activate srbench && \
    cd /opt/app/srbench/experiment/methods/src/ && \
    ./pysr_install.sh

CMD ["bash"]