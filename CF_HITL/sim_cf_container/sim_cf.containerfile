FROM osrf/ros:kinetic-desktop-full-xenial
LABEL Author="Derrick Timmermans <derrick.timmermans@outlook.com>"

WORKDIR /root/

COPY ./setupDependencies.sh /root/setupDependencies.sh
RUN bash setupDependencies.sh

COPY ./setupWorkspace.sh /root/setupWorkspace.sh
RUN bash --login setupWorkspace.sh

ENV VSCODE_SERVER_PATCHELF_PATH=patchelf
ENV VSCODE_SERVER_CUSTOM_GLIBC_LINKER=/root/crosstools/sysroot/lib/ld-linux-x86-64.so.2
ENV VSCODE_SERVER_CUSTOM_GLIBC_PATH=/root/crosstools/sysroot/lib64:/root/crosstools/sysroot/lib:/root/crosstools/sysroot/usr/lib64:/root/crosstools/sysroot/usr/lib:/root/crosstools/sysroot/usr/libexec

COPY ./sysroot.tar.gz /root/sysroot.tar.gz
COPY ./setupCodeCLI.sh /root/setupCodeCLI.sh

RUN bash setupCodeCLI.sh

ENTRYPOINT ["/bin/bash"]