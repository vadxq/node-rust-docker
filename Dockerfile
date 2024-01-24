# node:20-slim
FROM node:20-slim AS base

# config pnpm
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"

# enable corepack
RUN corepack enable

# open pnpm
RUN corepack prepare pnpm@latest --activate

# install rust
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/* && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Update PATH vars
ENV PATH="/root/.cargo/bin:${PATH}"

ENV USER root

CMD rustc --version && echo -n "Node:"; node --version
