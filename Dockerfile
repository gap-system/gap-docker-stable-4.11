FROM gapsystem/gap-docker-base

MAINTAINER The GAP Group <support@gap-system.org>

ENV GAP_VERSION 4.11

RUN sudo pip3 install notebook jupyterlab_launcher jupyterlab traitlets ipython vdom

RUN    cd /home/gap/inst/ \
    && wget -q https://github.com/gap-system/gap/archive/stable-${GAP_VERSION}.zip \
    && unzip -q stable-${GAP_VERSION}.zip \
    && rm stable-${GAP_VERSION}.zip \
    && cd gap-stable-${GAP_VERSION} \
    && ./autogen.sh \
    && ./configure \
    && make \
    && mkdir pkg \
    && cd pkg \
    && wget -q https://www.gap-system.org/pub/gap/gap4pkgs/packages-stable-${GAP_VERSION}.tar.gz \
    && tar xzf packages-stable-${GAP_VERSION}.tar.gz \
    && rm packages-stable-${GAP_VERSION}.tar.gz \
    && ../bin/BuildPackages.sh \
    && test='JupyterKernel-*' \
    && mv ${test} JupyterKernel \
    && cd JupyterKernel \
    && python3 setup.py install --user

RUN jupyter serverextension enable --py jupyterlab --user

ENV PATH /home/gap/inst/gap-stable-${GAP_VERSION}/pkg/JupyterKernel/bin:${PATH}
ENV JUPYTER_GAP_EXECUTABLE /home/gap/inst/gap-stable-${GAP_VERSION}/bin/gap.sh

# Set up new user and home directory in environment.
# Note that WORKDIR will not expand environment variables in docker versions < 1.3.1.
# See docker issue 2637: https://github.com/docker/docker/issues/2637
USER gap
ENV HOME /home/gap
ENV GAP_HOME /home/gap/inst/gap-stable-${GAP_VERSION}
ENV PATH ${GAP_HOME}/bin:${PATH}

# Start at $HOME.
WORKDIR /home/gap

# Start from a BASH shell.
CMD ["bash"]
