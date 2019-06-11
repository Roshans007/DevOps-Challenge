# Taking the base image of python-alpine
FROM python:3.7-alpine

# Set maintainer
LABEL maintainer "surana.roshan@ymail.com"

# Copying app code from current dir
COPY . /devops_challenge

# Setting working dir
WORKDIR /devops_challenge

# Installing pip pakages
RUN pip install -r requirements.txt

# Starting the application
CMD ["python", "hello.py"]
