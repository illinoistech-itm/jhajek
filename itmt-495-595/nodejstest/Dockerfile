FROM node:lts-buster
WORKDIR /code
ENV FLASK_APP=app.js
ENV FLASK_RUN_HOST=192.168.33.30
RUN npm install mysql2
COPY ./ws/app.js app.js
EXPOSE 3000
CMD ["node", "app.js"]