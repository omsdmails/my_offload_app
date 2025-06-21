FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    python3-pip \
    openjdk-11-jdk \
    zip unzip git wget curl \
    libgl1-mesa-dev \
    libsdl2-dev \
    build-essential \
    python3-setuptools \
    python3-dev \
    libffi-dev \
    libssl-dev \
    libsqlite3-dev \
    zlib1g-dev \
    && pip3 install buildozer cython

WORKDIR /app
COPY . /app

CMD ["buildozer", "android", "debug"]
