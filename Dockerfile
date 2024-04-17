FROM python:3.9-slim-buster


ARG TARGETPLATFORM

RUN apt-get update && apt-get install  -y --no-install-recommends git ffmpeg make cmake g++

ENV CC=/usr/bin/gcc
ENV CXX=/usr/bin/g++

WORKDIR /opt/kiirkirjutaja

RUN pip install "git+https://github.com/k2-fsa/sherpa-onnx.git@v1.3.0"

COPY linux/ /installer/
RUN /installer/$TARGETPLATFORM.sh

COPY requirements.txt requirements.txt
# RUN pip install -r requirements.txt

# RUN pip3 install pytorch-lightning==1.2.5 'ray[default]' torchmetrics==0.2.0 \
#     tokenizers pytorch-nlp py-term matplotlib scipy \
#     librosa==0.8.0 lxml audiomentations pytest event-scheduler \
#     onnx sherpa-onnx 


# COPY models /opt/models

# RUN echo '2022-01-31_16:24' >/dev/null

# RUN git clone https://github.com/alumae/online_speaker_change_detector.git /opt/online-speaker-change-detector

# RUN mkdir /opt/kiirkirjutaja \
#     && cd /opt/kiirkirjutaja && ln -s ../models
    
# COPY *.py /opt/kiirkirjutaja/

# ENV PYTHONPATH="/opt/online-speaker-change-detector"

# WORKDIR /opt/kiirkirjutaja

CMD ["/bin/bash"] 
