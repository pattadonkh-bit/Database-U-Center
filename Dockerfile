FROM php:8.2-apache

# เปิด mod_rewrite (ถ้าใช้ .htaccess)
RUN a2enmod rewrite

# ติดตั้ง extension พื้นฐานที่ใช้บ่อย
RUN docker-php-ext-install mysqli pdo pdo_mysql

# กำหนด working directory
WORKDIR /var/www/html