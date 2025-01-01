FROM ubuntu:latest

# Set the working directory in the container
WORKDIR /app

# Copy the requirements.txt file into the container
COPY requirements.txt /app/

# Copy manage.py into the /app directory in the container
COPY manage.py /app/

# Copy the Django apps (crud, score) into the container
COPY crud /app/crud/
COPY score /app/score/

# Install Python and dependencies
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv && \
    # Create a virtual environment inside the /app directory
    python3 -m venv /app/venv && \
    # Install Python dependencies into the virtual environment
    /app/venv/bin/pip install --no-cache-dir -r /app/requirements.txt

# Set the environment variable to activate the virtual environment
ENV VIRTUAL_ENV=/app/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Expose port 8000 for Django
EXPOSE 8000

# Default entry point to run your Django application
ENTRYPOINT ["python3"]

# Command to run the Django server
CMD ["manage.py", "runserver", "0.0.0.0:8000"]

