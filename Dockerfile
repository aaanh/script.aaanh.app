FROM ubuntu/nginx:latest

RUN apt update && apt upgrade -y
RUN apt install -y python3-pip
WORKDIR /linux-docs
COPY . .
RUN pip install -r requirements.txt
RUN make html
RUN cp -r build/html /var/www/
EXPOSE 80
