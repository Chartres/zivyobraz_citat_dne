# Daily Bible Verse to Zivyobraz

This repository contains a simple setup to scrape daily Bible verses from [vira.cz](https://www.vira.cz/) and post them to [zivyobraz.eu](https://in.zivyobraz.eu/). It uses a Dockerized Python script that runs periodically (via `run.sh` scheduling) on a Raspberry Pi.

## Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Raspberry Pi Installation](#raspberry-pi-installation)
- [Usage](#usage)
- [Environment Variables](#environment-variables)

---

## Overview

1. **Scraping**: Pulls a Bible verse from `vira.cz`.
2. **Parsing**: Extracts the verse text and reference with BeautifulSoup.
3. **Posting**: Sends them to `zivyobraz.eu` using the `ZIVYOBRAZ_API_IMPORT_KEY`.
4. **Scheduling**: A simple `run.sh` script loops or runs the Python script on a defined interval.

---

## Requirements

- **Docker** and **Docker Compose** installed on the Pi.
- **Python dependencies** handled automatically by Docker (listed in `requirements.txt`).

---

## Raspberry Pi Installation

1. **Install Docker**  
   - Follow the official instructions for [Docker on Raspberry Pi](https://docs.docker.com/engine/install/debian/).  

2. **Install Docker Compose Plugin**  
   ```bash
   sudo apt-get update
   sudo apt-get install docker-compose-plugin
   ```

3. **Clone This Repository**  
   ```bash
   git clone git@github.com:Chartres/zivyobraz_citat_dne.git
   cd zivyobraz_citat_dne
   ```

4. **Set Up Environment Variables**  
   - Create a `.env` file in the same directory as `docker-compose.yml`.  
   - Add `ZIVYOBRAZ_API_IMPORT_KEY` and any other needed variables:
     ```bash
     echo "ZIVYOBRAZ_API_IMPORT_KEY=your-secret-key" >> .env
     ```
   - Make sure `.env` is listed in `.gitignore` to avoid pushing secrets.

5. **Build and Start the Docker Container**  
   ```bash
   docker compose up --build -d
   ```

6. **Check Logs**  
   ```bash
   docker logs citat_scheduler
   ```

---

## Usage

- **Periodic Execution**: By default, the `run.sh` script handles calling `script.py` in a loop or with your custom schedule.  
- **Logging**: Check the container logs to see output and posted verses:  
  ```bash
  docker logs citat_scheduler
  ```
- **Stopping**:  
  ```bash
  docker compose down
  ```

---

## Environment Variables

- **ZIVYOBRAZ_API_IMPORT_KEY**: Used to authenticate with the [zivyobraz.eu](https://in.zivyobraz.eu/) API.  
- Keep all sensitive variables in your `.env` (not committed to the repo).  

Example `.env`:
```bash
ZIVYOBRAZ_API_IMPORT_KEY=your-secret-key
```

Docker Compose automatically reads variables from `.env` in this directory during `docker compose up`.

---
