FROM alpine:latest
WORKDIR /app
COPY ./app.py .
COPY ./requirements.txt .
RUN apk add python3 py3-pip
RUN pip install -r requirements.txt
