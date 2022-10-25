FROM ubuntu:22.04 AS builder

WORKDIR /source

RUN export DEBIAN_FRONTEND=non-interactive
RUN apt update && apt upgrade -y

RUN apt install -y curl build-essential

RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly -y

ENV PATH="/root/.cargo/bin:${PATH}"

COPY . .

RUN cargo install mdbook
RUN mdbook build

FROM nginx AS server

COPY --from=builder /source/book/** /usr/share/nginx/html
EXPOSE 80