# install conda environment
micromamba env create -f environment.yml

eval "$(conda shell.bash hook)"

micromamba init bash
micromamba activate srbench
micromamba info 

