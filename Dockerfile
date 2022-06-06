FROM python:3.10-alpine as compile
WORKDIR /opt
RUN apk add --no-cache git gcc musl-dev python3-dev libffi-dev openssl-dev cargo
RUN python3 -m pip install virtualenv
RUN virtualenv -p python venv
ENV PATH="/opt/venv/bin:$PATH"
RUN git clone --depth 1 https://github.com/SecureAuthCorp/impacket.git
RUN python3 -m pip install impacket/ && python3 -m pip install paramiko
RUN wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/linpeas.sh && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/linpeas_darwin_amd64 && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/linpeas_darwin_arm64 && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/linpeas_linux_386 && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/linpeas_linux_amd64 && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/linpeas_linux_arm && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/linpeas_linux_arm64 && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/winPEAS.bat && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/winPEASany.exe && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/winPEASany_ofs.exe && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/winPEASx64.exe && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/winPEASx64_ofs.exe && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/winPEASx86.exe && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/winPEASx86_ofs.exe

FROM python:3.10-alpine
COPY --from=compile /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
ENTRYPOINT ["/bin/sh"]
