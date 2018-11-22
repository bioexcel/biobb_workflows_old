FROM gromacs/gromacs
#FROM quay.io/biocontainers/gromacs:2018.2--h470a237_0

# avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Set up locales properly
RUN apt-get update && \
    apt-get install --yes --no-install-recommends locales && \
    apt-get purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Use bash as default shell, rather than sh
ENV SHELL /bin/bash

# Set up user
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}

RUN wget --quiet -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key |  apt-key add - && \
    DISTRO="bionic" && \
    echo "deb https://deb.nodesource.com/node_10.x $DISTRO main" >> /etc/apt/sources.list.d/nodesource.list && \
    echo "deb-src https://deb.nodesource.com/node_10.x $DISTRO main" >> /etc/apt/sources.list.d/nodesource.list

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
       less \
       nodejs \
       unzip \
       && apt-get purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8888

# Environment variables required for build
ENV APP_BASE /srv
ENV CONDA_DIR ${APP_BASE}/conda
ENV NB_PYTHON_PREFIX ${CONDA_DIR}
ENV KERNEL_PYTHON_PREFIX ${NB_PYTHON_PREFIX}
# Special case PATH
ENV PATH ${CONDA_DIR}/bin:$HOME/.local/bin:${PATH}
# If scripts required during build are present, copy them

COPY conda/install-miniconda.bash /tmp/install-miniconda.bash

COPY conda/environment.frozen.yml /tmp/environment.yml
RUN bash /tmp/install-miniconda.bash && \
rm /tmp/install-miniconda.bash /tmp/environment.yml



# Copy and chown stuff. This doubles the size of the repo, because
# you can't actually copy as USER, only as root! Thanks, Docker!
USER root
COPY src/ ${HOME}
RUN chown -R ${NB_USER}:${NB_USER} ${HOME}

# Run assemble scripts! These will actually build the specification
# in the repository into the image.
USER ${NB_USER}
RUN conda env update -n root -f "binder/environment.yml" && \
conda clean -tipsy && \
conda list -n root



# Container image Labels!
# Put these at the end, since we don't want to rebuild everything
# when these change! Did I mention I hate Dockerfile cache semantics?


# We always want containers to run as non-root
USER ${NB_USER}

# Make sure that postBuild scripts are marked executable before executing them
RUN chmod +x binder/postBuild
RUN ./binder/postBuild

# Add start script
# Specify the default command to run
CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]

