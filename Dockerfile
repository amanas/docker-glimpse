
FROM ubuntu:20.04

RUN apt-get update -yq \
 && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    apt-utils \
    curl \
    wget \
    build-essential \
    libssl-dev \
    pkg-config \
    libcurl4-openssl-dev \
    autoconf \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    mlocate \
    git \
    tabix \
    unzip \
    python3 \
    python3-pip \
    libncurses5-dev 
    
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y      
      
RUN python3 -m pip install -U matplotlib==3.2.2

RUN wget -q https://github.com/samtools/htslib/releases/download/1.11/htslib-1.11.tar.bz2 \
 && tar -xf htslib-1.11.tar.bz2 \
 && rm htslib-1.11.tar.bz2 \
 && mv htslib-1.11 htslib \
 && cd htslib \
 && autoheader \
 && autoconf \
 && ./configure \
 && make  \
 && ln -s /htslib /usr/local/include/htslib \
 && ln -s /htslib/libhts.a /usr/local/lib/libhts.a
 
RUN wget -q https://boostorg.jfrog.io/artifactory/main/release/1.73.0/source/boost_1_73_0.tar.bz2 \
 && tar --bzip2 -xf boost_1_73_0.tar.bz2 \
 && cd boost_1_73_0 \
 && ./bootstrap.sh --with-libraries=iostreams,program_options --prefix=../boost \
 && ./b2 install \
 && ln -s /boost/lib/libboost_iostreams.a /usr/local/lib/libboost_iostreams.a \
 && ln -s /boost/lib/libboost_program_options.a /usr/local/lib/libboost_program_options.a \
 && ln -s /boost/lib/libboost_serialization.a /usr/lib/x86_64-linux-gnu/libboost_serialization.a \
 && ln -s /boost/include/boost /usr/include/boost \
 && cd ../ \
 && rm -rf boost_1_73_0*

RUN wget -q https://github.com/samtools/bcftools/releases/download/1.9/bcftools-1.9.tar.bz2 \
 && tar -vxjf bcftools-1.9.tar.bz2 \
 && mv bcftools-1.9 bcftools \
 && cd bcftools \
 && make \
 && cd ../ \
 && rm bcftools-1.9.tar.bz2

ENV PATH="$PATH:/bcftools"

RUN wget -q https://github.com/samtools/samtools/releases/download/1.14/samtools-1.14.tar.bz2 \
 && tar xvjf samtools-1.14.tar.bz2 \
 && cd samtools-1.14 \
 && ./configure --prefix=/samtools \
 && make \
 && make install \
 && cd / \
 && rm -rf samtools-1.14*
 
ENV PATH="$PATH:/samtools/bin"

RUN wget -q https://github.com/odelaneau/GLIMPSE/archive/refs/tags/v1.1.1.zip \
 && unzip v1.1.1.zip \
 && mv GLIMPSE-1.1.1 GLIMPSE \
 && rm v1.1.1.zip \
 && sed -i "s/system: DYN_LIBS=.*/system: DYN_LIBS=-lz -lpthread -lbz2 -llzma -lcurl -lssl -lcrypto/g" /GLIMPSE/chunk/makefile \
 && sed -i "s/system: DYN_LIBS=.*/system: DYN_LIBS=-lz -lpthread -lbz2 -llzma -lcurl -lssl -lcrypto/g" /GLIMPSE/phase/makefile \
 && sed -i "s/system: DYN_LIBS=.*/system: DYN_LIBS=-lz -lpthread -lbz2 -llzma -lcurl -lssl -lcrypto/g" /GLIMPSE/ligate/makefile \
 && sed -i "s/system: DYN_LIBS=.*/system: DYN_LIBS=-lz -lpthread -lbz2 -llzma -lcurl -lssl -lcrypto/g" /GLIMPSE/sample/makefile \
 && sed -i "s/system: DYN_LIBS=.*/system: DYN_LIBS=-lz -lpthread -lbz2 -llzma -lcurl -lssl -lcrypto/g" /GLIMPSE/concordance/makefile

ENV PATH="$PATH:/GLIMPSE/chunk/bin:/GLIMPSE/concordance/bin:/GLIMPSE/ligate/bin:/GLIMPSE/phase/bin:/GLIMPSE/sample/bin"

WORKDIR /GLIMPSE/tutorial

RUN /GLIMPSE/tutorial/step1_script_setup.sh
# RUN ./step2_script_reference_panel.sh  
# RUN ./step3_script_GL.sh  
# RUN ./step4_script_chunk.sh  
# RUN ./step5_script_impute.sh  
# RUN ./step6_script_ligate.sh  
# RUN ./step7_script_sample.sh  
# RUN ./step8_script_concordance.sh 
# RUN ./step9_script_cleanup.sh

WORKDIR /

ENTRYPOINT ["/bin/bash"]
