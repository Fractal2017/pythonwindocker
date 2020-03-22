# Dockerfile
FROM python:latest

RUN pip install pandas==1.0.3
RUN pip install scikit-learn
RUN pip install scipy
RUN pip install matplotlib