FROM --platform=$TARGETPLATFORM python:3.9-slim-buster

ARG TARGETARCH
ARG TARGETPLATFORM

RUN apt-get update && apt-get install  -y --no-install-recommends git ffmpeg make cmake g++

ENV CC=/usr/bin/gcc
ENV CXX=/usr/bin/g++


COPY $TARGETARCH/requirements.txt requirements.txt
RUN pip install -r requirements.txt


COPY models /opt/models

RUN git clone https://github.com/alumae/online_speaker_change_detector.git /opt/online-speaker-change-detector

RUN mkdir /opt/kiirkirjutaja \
    && cd /opt/kiirkirjutaja && ln -s ../models


COPY *.py /opt/kiirkirjutaja/

ENV PYTHONPATH="/opt/online-speaker-change-detector"

WORKDIR /opt/kiirkirjutaja

CMD ["/bin/bash"]
