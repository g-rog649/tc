ARG python_version=latest

FROM python:${python_version}
WORKDIR /my_app
COPY ./myapp .
RUN pip install -r requirements.txt
CMD python -m flask run --host=0.0.0.0
