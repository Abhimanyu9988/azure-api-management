FROM python:3.9

WORKDIR /code

COPY requirements.txt .

RUN pip3 install -r requirements.txt

COPY main.py .

EXPOSE 8000
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
CMD ["./entrypoint.sh"]
#CMD ["sleep", "infinity"]