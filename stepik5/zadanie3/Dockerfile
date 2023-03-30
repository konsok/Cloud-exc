FROM python:latest

ARG PYTHON_VERSION

ENV PYTHON_VERSION=$PYTHON_VERSION

WORKDIR /app

COPY myapp /app

COPY requirements.txt /app

RUN pip install -r requirements.txt

CMD ["python", "app.py"]


