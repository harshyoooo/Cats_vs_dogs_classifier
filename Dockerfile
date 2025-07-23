# Use official Python 3.10 slim image
FROM python:3.10-slim

# Environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DJANGO_SETTINGS_MODULE=cats_vs_dogs_api.settings

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy entire project
COPY . .

# Expose port
EXPOSE 8000

# Run the application using correct module path
CMD ["gunicorn", "cats_vs_dogs_api.wsgi:application", "--bind", "0.0.0.0:8000"]
