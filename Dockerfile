# -----------------------------
# Base image
# -----------------------------
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV POETRY_HOME="/opt/poetry"
ENV PATH="$POETRY_HOME/bin:$PATH"

# -----------------------------
# System dependencies
# -----------------------------
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    curl \
    git \
    build-essential \
    zip \
    make \
    g++ \
    zlib1g-dev \
    libboost-all-dev \
    wget \
    unzip \
    zsh \
    locales \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------
# Install XRT
# -----------------------------
ARG XRT_DEB_VERSION="xrt_202220.2.14.354_22.04-amd64-xrt"

RUN wget -U 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.27 Safari/537.17' \
    "https://www.xilinx.com/bin/public/openDownload?filename=${XRT_DEB_VERSION}.deb" \
    -O /tmp/${XRT_DEB_VERSION}.deb \
    && apt-get update \
    && apt-get install -y /tmp/${XRT_DEB_VERSION}.deb \
    && rm /tmp/${XRT_DEB_VERSION}.deb \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------
# Install Poetry
# -----------------------------
RUN curl -sSL https://install.python-poetry.org | python3 -
RUN apt-get update && apt-get install -y sudo

# -----------------------------
# Copy project into container
# -----------------------------
WORKDIR /workspace

# Copy only pyproject.toml and poetry.lock first for caching
COPY finn-plus/pyproject.toml finn-plus/poetry.lock* /workspace/

# Install Python dependencies via Poetry
# RUN poetry config virtualenvs.in-project true \
#   && poetry install --no-root

RUN sudo locale-gen en_US.UTF-8
RUN sudo update-locale LANG=en_US.UTF-8
ENV export LANG=en_US.UTF-8           
ENV export LC_ALL=en_US.UTF-8

RUN apt-get update && apt-get install -y pybind11-dev
ENV POETRY_VIRTUALENVS_IN_PROJECT=true
ENV PATH="/workspace/.venv/bin:$PATH"
RUN poetry add --dev "pathspec==0.10.3"
RUN poetry add --dev "dvc[webdav]==3.59.1"

# Optionally copy the full project (if you need source in container)

# -----------------------------
# Create user matching host
# -----------------------------
ARG USERNAME=devuser
ARG UID=1000
ARG GID=1000
RUN groupadd -g ${GID} ${USERNAME} \
    && useradd -m -u ${UID} -g ${GID} -s /bin/zsh ${USERNAME}

# -----------------------------
# Passwordless sudo (still root)
# -----------------------------
RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# -----------------------------
# Switch to non-root
# -----------------------------
USER ${USERNAME}
WORKDIR /workspace
CMD ["/bin/zsh"]
