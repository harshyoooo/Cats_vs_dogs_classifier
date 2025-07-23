# Use official Python 3.10 slim image
FROM python:3.10-slim

# Environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set working directory to /app
WORKDIR /app

# First copy only requirements.txt from root
COPY requirements.txt .

# Install dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Now copy entire project
COPY . .

# Set working directory where manage.py is
WORKDIR /app/cats_vs_dogs

# Expose port
EXPOSE 8000

# Run Gunicorn from correct location
CMD ["gunicorn", "cats_vs_dogs_api.wsgi:application", "--bind", "0.0.0.0:8000"]
