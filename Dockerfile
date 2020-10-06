FROM python:3.6

WORKDIR /install

RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get install -y wget

RUN pip install -U pip

RUN wget -c https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh
RUN chmod +x Anaconda3-2020.07-Linux-x86_64.sh
RUN yes | ./Anaconda3-2020.07-Linux-x86_64.sh -b

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /app

RUN addgroup app && useradd --gid app --home-dir /app --shell /bin/bash app

RUN chown -R app:app /app
USER app

VOLUME [ "/app" ]

EXPOSE 8889

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
