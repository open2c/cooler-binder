FROM andrewosh/binder-python-3.5-mini:latest

MAINTAINER Nezar Abdennur <nabdennur@gmail.com>

# system dependencies
USER root
RUN apt-get update && apt-get install pigz tabix

# set up environment
USER main
ADD environment.yml environment.yml
RUN conda env create -n binder
RUN /bin/bash -c "source activate binder"
RUN echo "export PATH=$HOME/miniconda3/envs/binder/bin/:$PATH" >> ~/.binder_start
RUN mkdir -p $HOME/.jupyter
RUN echo "c.NotebookApp.token = ''" >> $HOME/.jupyter/jupyter_notebook_config.py

USER main
WORKDIR $HOME/notebooks
