# Daily Bible Verse to Zivyobraz

This repository contains a simple setup to scrape daily Bible verses from [vira.cz](https://www.vira.cz/) and post them as variables to [zivyobraz.eu](https://in.zivyobraz.eu/). It uses a Dockerized Python script that runs periodically (via `run.sh` scheduling) on a Raspberry Pi.

## Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Raspberry Pi Installation](#raspberry-pi-installation)

---

## Overview

1. **Scraping**: Pulls the daily Bible verse from `vira.cz` (see [docs here](https://www.vira.cz/Servis-pro-vas/Sluzby-pro-webmastery/Zobrazeni-biblickeho-citatu)).
2. **Parsing**: Extracts the verse text and reference with BeautifulSoup.
3. **Posting**: Sends them to your `zivyobraz` as `bible_verse` and `bible_ref` values. It reads the `ZIVYOBRAZ_API_IMPORT_KEY` from an .env file (not included).
4. **Scheduling**: A simple `run.sh` script runs the Python script on a 24h interval.

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
   <img width="885" alt="zo_import_key" src="https://github.com/user-attachments/assets/1ba786ef-5f2a-4f29-bfb6-5a281a334bcc" />
   - Create a `.env` file in the same directory as `docker-compose.yml`.  
   - Add your `ZIVYOBRAZ_API_IMPORT_KEY`:
     ```bash
     echo "ZIVYOBRAZ_API_IMPORT_KEY=your-secret-key" >> .env
     ```
   - Docker Compose automatically reads variables from `.env` in this directory during `docker compose up`.

6. **Build and Start the Docker Container**  
   ```bash
   docker compose up --build -d
   ```

7. **Check Logs**  
   ```bash
   docker logs citat_dne
   ```
