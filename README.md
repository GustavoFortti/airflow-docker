# 🚀 Apache Airflow with Docker

This project provides a minimal and customizable setup to run **Apache Airflow** using **Docker**. It's designed to help you get Airflow up and running quickly in a containerized environment, with flexibility to adapt to your team's workflow.

---

## 📦 What's Inside

- **Dockerfile** – Custom Docker image for Airflow
- **build.sh** and **update.sh** – Helper scripts to build and maintain your container
- **app/** – Your Airflow DAGs and application logic
- **config/** – Airflow configuration files
- **shared/** – Shared volumes or libraries used across components

---

## 🛠️ How to Use

### 1. Build the Docker Image
```bash
./build.sh
