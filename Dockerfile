# Use official Python 3.10 image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
COPY . /app/
WORKDIR /app/cats_vs_dogs_api


# Install dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the entire project
COPY . /app/

# Expose port
EXPOSE 8000

# Run your Django app
CMD ["gunicorn", "cats_vs_dogs_api.wsgi:application", "--bind", "0.0.0.0:8000"]
