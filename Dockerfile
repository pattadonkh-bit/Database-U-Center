FROM python:3.11-slim

# ป้องกัน py cache
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# ติดตั้ง dependency ที่ Oracle ต้องใช้
RUN apt-get update && \
    apt-get install -y unzip libaio1 && \
    rm -rf /var/lib/apt/lists/*

# สร้างโฟลเดอร์ oracle
RUN mkdir -p /opt/oracle

# copy zip เข้า container
COPY instantclient-basiclite-linux.x64-23.26.1.0.0.zip /tmp/

# แตกไฟล์
RUN unzip /tmp/instantclient-basiclite-linux.x64-23.26.1.0.0.zip -d /opt/oracle && \
    rm /tmp/instantclient-basiclite-linux.x64-23.26.1.0.0.zip

# ตั้ง path (โฟลเดอร์จะชื่อ instantclient_23_26)
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient_23_26
ENV PATH=$PATH:/opt/oracle/instantclient_23_26

# ตั้ง working dir
WORKDIR /app

# install python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# copy source code
COPY . .

# เปิด port (ถ้าใช้ Flask)
EXPOSE 5000

CMD ["python", "app.py"]