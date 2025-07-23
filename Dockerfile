# Use official Python 3.10 slim image
FROM python:3.10-slim

# Environment settings
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set working directory inside the container
WORKDIR /app

# Copy and install dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy entire Django project into /app
COPY . .

# Expose the port Render expects
EXPOSE 8000

# Run Gunicorn pointing to the correct WSGI module
CMD ["gunicorn", "cats_vs_dogs_api.wsgi:application", "--bind", "0.0.0.0:8000"]
