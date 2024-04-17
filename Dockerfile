ARG ARCH=
FROM ${ARCH}python:3.9-slim-buster


RUN apt-get update && apt-get install  -y --no-install-recommends git ffmpeg make cmake g++

ENV CC=/usr/bin/gcc
ENV CXX=/usr/bin/g++


RUN pip install "git+https://github.com/k2-fsa/sherpa-onnx.git@v1.3.0" "https://download.pytorch.org/whl/cpu/torch-1.13.1%2Bcpu-cp39-cp39-linux_x86_64.whl#sha256=71636a5c21927236f4974d2355fb3f66a0b707c28219b0135ff65ed0f0e61287" "https://download.pytorch.org/whl/cpu/torchaudio-0.13.1%2Bcpu-cp39-cp39-linux_x86_64.whl#sha256=0f89fb3f6ecf894e4a287eb07fe41b07a5d2f8450d2c2ca62b994dedba63fefd" "https://download.pytorch.org/whl/cpu/torchvision-0.14.1%2Bcpu-cp39-cp39-linux_x86_64.whl#sha256=5d2b67028e2782e60fd667a8e95f071bf612282411cba7ae88720213c58a651a"
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt


COPY models /opt/models

RUN echo '2022-01-31_16:24' >/dev/null

RUN git clone https://github.com/alumae/online_speaker_change_detector.git /opt/online-speaker-change-detector

RUN mkdir /opt/kiirkirjutaja \
    && cd /opt/kiirkirjutaja && ln -s ../models


COPY *.py /opt/kiirkirjutaja/

ENV PYTHONPATH="/opt/online-speaker-change-detector"

WORKDIR /opt/kiirkirjutaja

CMD ["/bin/bash"]
