FROM python:3.8-alpine
WORKDIR /docker-flask
COPY app.py /
ADD . /docker-flask
RUN pip install --disable-pip-version-check -r requirements.txt
EXPOSE 8080
CMD ["python", "app.py"]
