FROM centos:7.5.1804

MAINTAINER Tashrif Billah <tbillah@bwh.harvard.edu>

# set up user and working directory
ARG USER=pnlbwh
RUN useradd --no-user-group --create-home --shell /bin/bash $USER
WORKDIR /home/$USER

RUN chmod +x startup.sh

# libraries and commands for FSL
RUN yum -y install wget which file bzip2 && \
    yum clean all && \
# install python
    echo "Downloading miniconda3 installer" && \
    wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O Miniconda3-latest-Linux-x86_64.sh > /dev/null 2>&1 && \
    /bin/bash Miniconda3-latest-Linux-x86_64.sh -b -p miniconda3/ && \
    rm -f Miniconda3-latest-Linux-x86_64.sh && \
    source miniconda3/bin/activate && \
    cp ~/.bashrc . && \
    echo "source $PWD/miniconda3/bin/activate" >> .bashrc && \
    pip install pytest numpy nibabel
    

USER $USER

ENTRYPOINT ["/bin/bash","-c","$HOME/startup.sh"]

