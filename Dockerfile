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
    jq && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Install Julia:
WORKDIR /downloads/
COPY install_julia_linux.sh .
RUN bash install_julia_linux.sh 1.7.1
# RUN wget https://julialang-s3.julialang.org/bin/linux/aarch64/1.7/julia-1.7.1-linux-aarch64.tar.gz && \
#     tar -xvf julia-1.7.1-linux-aarch64.tar.gz && \
#     mv julia-1.7.1 julia && \
#     rm julia-1.7.1-linux-aarch64.tar.gz && \
#     ln -s $PWD/julia/bin/julia /usr/local/bin/julia

# WORKDIR /opt/app/srbench/

# COPY environment.yml ./
# RUN micromamba env create -f environment.yml

# COPY install.sh ./
# COPY experiment/ ./experiment/

# RUN source /usr/local/bin/_activate_current_env.sh && \
#     micromamba activate srbench && \
#     cd /opt/app/srbench/experiment/methods/src/ && \
#     ./pysr_install.sh

# CMD ["bash"]