FROM gapsystem/gap-docker-base

MAINTAINER The GAP Group <support@gap-system.org>

RUN    mkdir /home/gap/inst/ \
    && cd /home/gap/inst/ \
    && wget -q https://github.com/gap-system/gap/archive/stable-4.11.zip \
    && unzip -q stable-4.11.zip \
    && rm stable-4.11.zip \
    && cd gap-stable-4.11 \
		&& ./autogen.sh \
    && ./configure \
    && make \
    && cp bin/gap.sh bin/gap \
    && mkdir pkg \
    && cd pkg \
    && wget -q https://www.gap-system.org/pub/gap/gap4pkgs/packages-stable-4.11.tar.gz \
    && tar xzf packages-stable-4.11.tar.gz \
    && rm packages-stable-4.11.tar.gz \
    && ../bin/BuildPackages.sh \
    && test='JupyterKernel-*' \
    && mv ${test} JupyterKernel \
    && cd JupyterKernel \
    && python3 setup.py install --user

RUN jupyter serverextension enable --py jupyterlab --user

ENV PATH /home/gap/inst/gap-stable-4.11/pkg/JupyterKernel/bin:${PATH}
ENV JUPYTER_GAP_EXECUTABLE /home/gap/inst/gap-stable-4.11/bin/gap.sh

ENV GAP_HOME /home/gap/inst/gap-stable-4.11
ENV PATH ${GAP_HOME}/bin:${PATH}
