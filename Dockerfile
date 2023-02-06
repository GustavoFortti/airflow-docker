# Escolha uma imagem base, por exemplo, uma imagem Ubuntu com Python 3 instalado
FROM python:3.5-slim-buster

# Configure o timezone
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Instale as dependências do Apache Airflow
RUN apt-get update && apt-get install -y \
    build-essential \
    default-libmysqlclient-dev \
    libssl-dev \
    libffi-dev \
    libsasl2-dev \
    libkrb5-dev \
    libsasl2-modules \
    libsasl2-dev \
    libsasl2-modules-gssapi-mit \
    libldap2-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && /usr/local/bin/python -m pip install --upgrade pip

# Defina um diretório de trabalho no contêiner
WORKDIR /app

# Copie o arquivo requirements.txt para o diretório de trabalho
COPY ./config/requirements.txt /root/

# Instale as dependências do Python listadas no arquivo requirements.txt
RUN pip install --no-cache-dir -r /root/requirements.txt
RUN pip install wtforms[compat]==2.3.3
# Exporte a porta 8080 para que o Airflow possa ser acessado externamente
EXPOSE 8080

RUN echo "FLAG"
# Defina o comando padrão a ser executado quando o contêiner for iniciado
# CMD ["airflow", "webserver"]
COPY ./config/entrypoint.sh /root/
COPY ./app/dags/* /root/airflow/dags
COPY ./app/airflow.cfg /usr/local/airflow/

CMD ["bash", "/root/entrypoint.sh"]
