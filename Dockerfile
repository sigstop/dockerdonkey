#FROM fastscore/engine:1.7.1
FROM resin/raspberry-pi-alpine:3.4
WORKDIR /usr/local/src
RUN apk --update add python3 python3-dev libxml2-dev libxslt-dev libffi-dev gcc g++ musl-dev libgcc openssl-dev curl git make cmake binutils
RUN apk --update add jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev boost-dev 
RUN echo hello10
RUN git clone https://github.com/sigstop/libspatialindex.git
#RUN mkdir -p libspatialindex/spatialindex
#RUN git clone https://github.com/libspatialindex/libspatialindex.git
RUN cd libspatialindex && \
cmake . \
	-DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_SYSTEM_NAME=Linux \
        -DCMAKE_BUILD_TYPE=Release && \
 make  && \
 make install
#RUN apk --update add xsel xclip libzmq-dev libspatialindex-dev 
ADD ./requirements.txt .
RUN pip3 install -r requirements.txt

RUN git clone https://github.com/sigstop/donkey.git

RUN cd donkey && pip install -e .[pi] && python scripts/setup.py
