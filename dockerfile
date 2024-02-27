FROM python:3.8-slim

# Set working directory
WORKDIR /app

COPY . .

# Install Python dependencies
RUN pip install -r requirements.txt

CMD ["python", "blackhole_watcher.py"]
