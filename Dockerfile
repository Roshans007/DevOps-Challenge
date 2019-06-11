FROM python:3.7-alpine

# set maintainer
LABEL maintainer "surana.roshan@ymail.com"

COPY . /devops_challenge

WORKDIR /devops_challenge

RUN pip install -r requirements.txt

CMD ["python", "hello.py"]
