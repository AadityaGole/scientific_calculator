# 🧮 Scientific Calculator CI/CD Pipeline (Jenkins + Docker + Ansible + Ngrok + Email)

This repository demonstrates a complete **CI/CD pipeline** for a Python-based **Scientific Calculator**, automated using:
- **Jenkins**
- **GitHub Webhooks**
- **Docker**
- **Ansible**
- **Ngrok** (for external access to Jenkins)
- **Email Notifications**

---

## 🚀 Prerequisites

### On Windows:
1. **Install Jenkins**
   - Download from [jenkins.io](https://www.jenkins.io/download/)
   - Install as a Windows Service.
   - Open Jenkins at: [http://localhost:8080](http://localhost:8080)

2. **Install Docker Desktop**
   - Download from [docker.com](https://www.docker.com/products/docker-desktop/)
   - Ensure Docker Daemon is running.

3. **Install Python**
   ```powershell
   winget install Python.Python.3.11
