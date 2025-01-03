FROM python:3.9-slim
WORKDIR /usr/src/app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy Python script and the run.sh scheduler
COPY citat_dne.py .
COPY run.sh .

# Make run.sh executable
RUN chmod +x run.sh

# Default command
CMD ["bash", "run.sh"]
