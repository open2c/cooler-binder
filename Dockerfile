FROM andrewosh/binder-base:latest

RUN mkdir -p /home/main/notebooks
RUN chown main:main /home/main/notebooks
WORKDIR /home/main/notebooks

USER root
RUN apt-get update && apt-get install pigz tabix
COPY . /home/main/notebooks/
RUN chown -R main:main $HOME/notebooks

USER main
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8 
RUN find $HOME/notebooks -name '*.ipynb' -exec jupyter trust {} \;
ADD environment.yml environment.yml
RUN conda env create -n binder
RUN echo "export PATH=/home/main/anaconda2/envs/binder/bin/:/home/main/anaconda3/envs/binder/bin/:$PATH" >> ~/.binder_start
RUN conda install -n binder jupyter
RUN /bin/bash -c "source activate binder && jupyter kernelspec install-self --user"

USER main
WORKDIR $HOME/notebooks
