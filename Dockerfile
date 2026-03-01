FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && \
    apt-get install -y unzip libaio-dev && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/oracle

COPY instantclient-basiclite-linux.x64-23.26.1.0.0.zip /tmp/

RUN unzip /tmp/instantclient-basiclite-linux.x64-23.26.1.0.0.zip -d /opt/oracle && \
    rm /tmp/instantclient-basiclite-linux.x64-23.26.1.0.0.zip

ENV LD_LIBRARY_PATH=/opt/oracle/instantclient_23_26
ENV PATH=$PATH:/opt/oracle/instantclient_23_26

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD python db/init_db.py || true && python app.py