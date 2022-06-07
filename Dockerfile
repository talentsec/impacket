FROM python:3.10-alpine as compile
WORKDIR /opt
RUN apk add --no-cache git gcc musl-dev python3-dev libffi-dev openssl-dev cargo
RUN python3 -m pip install virtualenv
RUN virtualenv -p python venv
ENV PATH="/opt/venv/bin:$PATH"
RUN git clone --depth 1 https://github.com/SecureAuthCorp/impacket.git
RUN python3 -m pip install impacket/ && python3 -m pip install paramiko


FROM python:3.10-alpine
COPY --from=compile /opt/venv /opt/venv
RUN wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/linpeas.sh -P /opt && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/linpeas_darwin_amd64 -P /opt && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/linpeas_darwin_arm64 -P /opt && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/linpeas_linux_386 -P /opt && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/linpeas_linux_amd64 -P /opt && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/linpeas_linux_arm -P /opt && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/linpeas_linux_arm64 -P /opt && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/winPEAS.bat -P /opt && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/winPEASany.exe -P /opt && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/winPEASany_ofs.exe -P /opt && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/winPEASx64.exe -P /opt && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/winPEASx64_ofs.exe -P /opt && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/winPEASx86.exe -P /opt && \
wget https://github.com/carlospolop/PEASS-ng/releases/download/20220605/winPEASx86_ofs.exe -P /opt && \
wget https://github.com/talentsec/impacket/raw/master/parsers/peas2json.py -P /opt
ENV PATH="/opt/venv/bin:$PATH"
ENTRYPOINT ["/bin/sh"]
