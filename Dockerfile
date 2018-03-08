# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/r-notebook

# Install system libraries first as root
USER root

# R dependencies that conda can't provide (X, fonts, compilers)
RUN apt-get update && \
    apt-get install -y libxrender1 && \
    apt-get clean


# Switch back to jovyan for all conda and other installs
USER jovyan


# Add Anaconda's "R Essentials"
# (https://www.continuum.io/blog/developer/jupyter-and-conda-r)
RUN conda install -c r --quiet --yes \
    'r-essentials' \
    && conda clean -tipsy \
    && mkdir /home/$NB_USER/work/notebooks

RUN conda install r-gplots

# Add my own R file
COPY smp1.csv /home/$NB_USER/work
COPY outils_hdrs.csv /home/$NB_USER/work
COPY chap02.ipynb  /home/$NB_USER/work/notebooks

