FROM alpine:latest

ARG PYTHON_VERSION
ARG PORT

ENV PYTHON_VERSION=$PYTHON_VERSION
ENV PORT=$PORT

RUN apk update && \
    apk add python3 && \
    apk add py-pip && \
    apk add libpq && \
    apk add postgresql-dev && \
    apk add build-base && \
    rm -rf /var/cache/apk/*

WORKDIR /app

COPY myapp /app

COPY requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt

VOLUME /app/data

CMD ["python", "/app/app.py", "--port", "${PORT}"]


