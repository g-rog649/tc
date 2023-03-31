FROM alpine
ARG python_version=3.9.8
ARG port=3000
RUN \
    apk add g++ gcc make libffi-dev openssl-dev zlib-dev; \
    wget -qO- https://www.python.org/ftp/python/${python_version}/Python-${python_version}.tgz | tar zxf -; \
    mv Python* python; \
    cd python; \
    ./configure; \
    make -s -j$(nproc); \
    /python/python -m ensurepip --default-pip; \
    /python/python -m pip install --upgrade pip; \
    /python/python -m pip install flask; \
    apk del g++ gcc make libffi-dev openssl-dev zlib-dev;
COPY ./app ./app
VOLUME app
WORKDIR /app
ENV FLASK_RUN_PORT=${port}
CMD /python/python -m flask run --host=0.0.0.0
# CMD sh
# https://devguide.python.org/getting-started/setup-building/
# https://www.python.org/ftp/python/
# https://stackoverflow.com/questions/31273157/how-to-install-pip-on-compiled-from-source-python

# 371.5 s