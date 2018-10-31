FROM docker.tools.pnet.ch/r-base:latest

RUN yum install -y nodejs && yum clean all
USER baseuser

WORKDIR /app
ADD node_modules node_modules

CMD [ "node", "index.js"]

EXPOSE 3000

ADD index.js .