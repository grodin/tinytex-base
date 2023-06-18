FROM debian:bookworm-slim

LABEL org.opencontainers.image.source=https://github.com/grodin/tinytex-base

WORKDIR /var/local

RUN useradd --system --uid 1000 --create-home --user-group latex-user

RUN apt-get update && \
  apt-get install -y \
  wget \
  perl \
  gpg \
  libfontconfig1 && \
  apt-get clean

USER latex-user

RUN mkdir -p "${HOME}/bin"

RUN echo 'export PATH="${HOME}/bin:${PATH}"' >> ${HOME}/.bashrc

ARG TINYTEX_VERSION

ENV TINYTEX_VERSION=${TINYTEX_VERSION:-v2023.06}

RUN wget -qO- "https://yihui.name/gh/tinytex/tools/install-unx.sh" | sh \
  && "${HOME}/bin/"fmtutil-sys --all
