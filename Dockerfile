FROM python:3.7-alpine

COPY . /devops_challenge

WORKDIR /devops_challenge

RUN pip install -r requirements.txt

CMD ["python", "hello.py"]
