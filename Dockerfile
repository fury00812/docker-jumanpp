FROM python:3.6-slim

ENV HOME=/home/app

COPY . $HOME/myapp

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    bzip2 \
    libjuman \
    libcdb-dev \
    libboost-all-dev \
    make \
    cmake \
    zlib1g-dev 

RUN mkdir $HOME/src && \
    cd $HOME/src && \
    curl -L -o juman-7.01.tar.bz2 http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/juman/juman-7.01.tar.bz2 && \
    tar xf juman-7.01.tar.bz2 && \
    cd juman-7.01 && \
    ./configure --prefix=/usr/local/ && \
    make && \
    make install && \ 
    cp /usr/local/etc/jumanrc $HOME/.jumanrc

RUN cd $HOME/src && \
    curl -L -o jumanpp-2.0.0-rc2.tar.xz https://github.com/ku-nlp/jumanpp/releases/download/v2.0.0-rc2/jumanpp-2.0.0-rc2.tar.xz && \
    tar Jxfv jumanpp-2.0.0-rc2.tar.xz && \
    cd jumanpp-2.0.0-rc2/ && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local/ && \
    make && \
    make install

RUN cd $HOME/src && \
  curl -L -o knp-4.19.tar.bz2 http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/knp/knp-4.19.tar.bz2 && \
  tar xf knp-4.19.tar.bz2 && \
  cd knp-4.19 && \
  ./configure --prefix=/usr/local/ --with-juman-prefix=/usr/local/ && \
  make && \
  make install

RUN rm -rf $HOME/src && \
  apt-get purge -y \
  build-essential \
  curl \
  bzip2

WORKDIR $HOME/myapp
RUN pip install -r $HOME/myapp/requirements.txt

CMD /bin/bash
