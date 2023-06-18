FROM debian:bookworm-slim

WORKDIR /var/local

RUN useradd --system --uid 1000 --create-home --user-group latex-user

RUN apt-get update && \ 
  apt-get install -y \
  wget \
  perl \
  gpg \
  mercurial \
  libfontconfig1 && \
  apt-get clean

USER latex-user

RUN mkdir -p "${HOME}/bin"

RUN echo 'export PATH="${HOME}/bin:${PATH}"' >> ${HOME}/.bashrc

ARG TINYTEX_VERSION

RUN wget -qO- "https://yihui.name/gh/tinytex/tools/install-unx.sh" | sh \
  && "${HOME}/bin/"fmtutil-sys --all
