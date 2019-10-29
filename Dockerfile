FROM centos

LABEL maintainer="Matteo Capitanio <matteo.capitanio@gmail.com>"
LABEL maintainer="kc14 <kemmer.consulting+kc14@gmail.com>"

ENV JAVA_DOWNLOAD_URL "https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u232-b09/OpenJDK8U-jdk_x64_linux_hotspot_8u232b09.tar.gz"
ENV JAVA_VERSION "jdk8u232-b09"

ENV JAVA_HOME "/opt/${JAVA_VERSION}"

# Install Packages
RUN yum update -y; \
    yum install -y wget unzip curl vim python-setuptools sudo; \
    easy_install supervisor
    
# RUN wget "https://download.java.net/java/GA/jdk13/5b8a42f3905b406298b72d750b6919f6/33/GPL/openjdk-${JAVA_VERSION}_linux-x64_bin.tar.gz" -O /opt/jdk.tar.gz
RUN wget "${JAVA_DOWNLOAD_URL}" -O /opt/jdk.tar.gz
RUN cd /opt; \
    tar --no-same-owner -xvf jdk.tar.gz; \
    rm jdk.tar.gz

RUN cd "${JAVA_HOME}"; \
    alternatives --install /usr/bin/java java "${JAVA_HOME}/bin/java" 2

RUN yum clean all

CMD ["/bin/bash"]