#FROM resin/raspberry-pi-alpine:3.4
FROM alpine
WORKDIR /usr/local/src
RUN apk --update add python3 python3-dev libxml2-dev libxslt-dev libffi-dev gcc g++ musl-dev libgcc openssl-dev curl git make cmake binutils
RUN apk --update add jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev boost-dev \
            musl-dev \
            gfortran \
            libgfortran \
            openblas \
            openblas-dev
RUN echo hello10
#RUN git clone https://github.com/Reference-LAPACK/lapack.git
#RUN mkdir -p lapack-build
#RUN cd lapack-build &&  \
#cmake ../lapack \
#        -DCMAKE_INSTALL_PREFIX=/usr \
#        -DCMAKE_SYSTEM_NAME=Linux \
#        -DCMAKE_BUILD_TYPE=Release && \
# make  && \
# make install
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
#RUN apk --update add tensorflow
RUN pip3 install https://github.com/better/alpine-tensorflow/releases/download/alpine3.7-tensorflow1.7.0/tensorflow-1.7.0-cp36-cp36m-linux_x86_64.whl
#RUN git clone https://github.com/tensorflow/tensorflow.git
#RUN cd tensorflow && ./configure && make && make install
RUN apk --upgrade add wget
#RUN sed -i -e 's/v[[:digit:]]\.[[:digit:]]/testing/g' /etc/apk/repositories
RUN apk --update  --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing --no-cache add hdf5 hdf5-dev
#RUN wget https://support.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.10.1.tar.gz
#RUN tar xvfz hdf5-1.10.1.tar.gz 
#RUN mkdir -p hdf5-build
#RUN cd hdf5-build && \
#cmake ../hdf5-1.10.1 \
#        -DCMAKE_INSTALL_PREFIX=/usr \
#        -DCMAKE_SYSTEM_NAME=Linux \
#        -DCMAKE_BUILD_TYPE=Release && \
# make  && \
# make install
ADD ./requirements.txt .
RUN pip3 install -r requirements.txt
RUN find / | grep hdf5

RUN git clone https://github.com/sigstop/donkey.git

RUN cd donkey && pip3 install -e .[pi] && python scripts/setup.py
