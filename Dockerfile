# Use official Python 3.10 slim image
FROM python:3.10-slim

# Environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set working directory to outer project root
WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy full project
COPY . .

# Expose default port
EXPOSE 8000

# Set Gunicorn entrypoint to the correct inner module path
CMD ["gunicorn", "cats_vs_dogs_api.cats_vs_dogs_api.wsgi:application", "--bind", "0.0.0.0:8000"]
