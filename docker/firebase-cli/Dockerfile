FROM node:latest

# Define working directory
WORKDIR /workdir

# Firebase toolsのインストール
RUN apt-get -y update 
RUN apt-get install -y openjdk-8-jdk
RUN npm install -g firebase-tools

# Expose ports
ENV HOST 0.0.0.0
EXPOSE 4000
EXPOSE 5000
EXPOSE 5001
EXPOSE 8080
EXPOSE 9005