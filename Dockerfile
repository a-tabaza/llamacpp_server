FROM ubuntu:22.04 AS build

RUN apt-get update \
    && apt-get install -y build-essential git cmake libcurl4-openssl-dev

WORKDIR /app

RUN git clone https://github.com/ggml-org/llama.cpp.git /app/llama.cpp \
    && cd llama.cpp \
    && cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -DGGML_NATIVE=OFF -DLLAMA_BUILD_TESTS=OFF -DGGML_BACKEND_DL=ON -DGGML_CPU_ALL_VARIANTS=ON \
    && cmake --build build -j 16 -t llama-server

RUN mkdir -p /app/lib \
    && find /app/llama.cpp/build -name "*.so" -exec cp {} /app/lib \;

RUN mkdir -p /app/full \
    && cp /app/llama.cpp/build/bin/* /app/full \
    && cp /app/llama.cpp/*.py /app/full \
    && cp -r /app/llama.cpp/gguf-py /app/full \
    && cp -r /app/llama.cpp/requirements /app/full \
    && cp /app/llama.cpp/requirements.txt /app/full \
    && cp /app/llama.cpp/.devops/tools.sh /app/full/tools.sh
