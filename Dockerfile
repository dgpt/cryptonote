FROM ubuntu:16.04

ENV SRC_DIR /usr/local/src/jewelcoin

RUN set -x \
  && buildDeps=' \
      ca-certificates \
      cmake \
      g++ \
      git \
      libboost1.58-all-dev \
      libssl-dev \
      make \
      pkg-config \
  ' \
  && apt-get -qq update \
  && apt-get -qq --no-install-recommends install $buildDeps

RUN git clone https://github.com/dgpt/jewelcoin.git $SRC_DIR
WORKDIR $SRC_DIR
RUN make -j$(nproc)

RUN cp build/release/src/jewelcoind /usr/local/bin/jewelcoind
#  \
#  && rm -r $SRC_DIR \
#  && apt-get -qq --auto-remove purge $buildDeps

# Contains the blockchain
VOLUME /root/.jewelchain

VOLUME /wallet

EXPOSE 18880
EXPOSE 18881

CMD jewelcoind
