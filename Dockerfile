FROM cp2k/toolchain:latest

# install Ubuntu packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    vim                   \
    git                   \
    && rm -rf /var/lib/apt/lists/*

# download and compile libc2pk
RUN git clone https://github.com/cp2k/cp2k.git /opt/cp2k
RUN ln -vs /opt/cp2k-toolchain/install/arch/* /opt/cp2k/cp2k/arch/
WORKDIR /opt/cp2k/cp2k/makefiles
RUN source /opt/cp2k-toolchain/install/setup  && \
    make -j VERSION="popt" libcp2k

# import and compile omen
COPY . /opt/omen
WORKDIR /opt/omen/src
#RUN ./configure --with-arch=myarch --with-mumps --with-superlu --with-pexsi
RUN ./configure --with-arch=myarch --with-superlu --with-pexsi
RUN source /opt/cp2k-toolchain/install/setup  && \
    make -j
ENV PATH="/opt/omen/src:${PATH}"

WORKDIR /opt/omen/tests/input_files/gnr
CMD source /opt/cp2k-toolchain/install/setup  && \
    mpiexec -np 2 transport gnr.inp

#EOF

