FROM python:3.5

RUN apt-get update && \
    apt-get install -y apt-utils libssl-dev curl graphviz

RUN curl -L -o /usr/bin/solc https://github.com/ethereum/solidity/releases/download/v0.4.21/solc-static-linux && \
    chmod +x /usr/bin/solc

COPY ./constraints.txt /relay/constraints.txt
COPY ./requirements.txt /relay/requirements.txt

WORKDIR /relay

RUN pip install -c constraints.txt populus
RUN pip install -c constraints.txt -r requirements.txt

ENV THREADING_BACKEND gevent

COPY . /relay

RUN pip install -c constraints.txt .

ENTRYPOINT ["tl-relay"]
