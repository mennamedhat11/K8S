FROM python:3.11-slim
WORKDIR /app
COPY req.txt .
RUN pip install -r req.txt
COPY python.py .
CMD ["python", "python.py"]
