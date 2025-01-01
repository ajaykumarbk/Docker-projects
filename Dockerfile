FROM ubuntu:latest

WORKDIR /app

COPY requirements.txt /app/

COPY manage.py /app/

COPY crud /app/crud/

COPY score /app/score/

RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv && \
    # Create a virtual environment inside the /app directory
    python3 -m venv /app/venv && \
    # Install Python dependencies into the virtual environment
    /app/venv/bin/pip install --no-cache-dir -r /app/requirements.txt

# Set the environment variable to activate the virtual environment
ENV VIRTUAL_ENV=/app/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

EXPOSE 8000

ENTRYPOINT ["python3"]

CMD ["manage.py", "runserver", "0.0.0.0:8000"]

