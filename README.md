# OpenThreat Mail Migrator

OpenThreat Mail Migrator is a web application for synchronizing email accounts using [imapsync](https://github.com/imapsync/imapsync).  
Created by **[OpenThreat](https://openthreat.ro)** to simplify secure email synchronization. It features a modern graphical interface with real-time sync output display and notifications when the process is complete.

---

## 🚀 Features

- **Email synchronization between two IMAP accounts** using `imapsync`.
- **Modern and responsive user interface** powered by Bootstrap 5.
- **Real-time output display** of the sync process.
- **Completion notifications** using SweetAlert2.
- **Auto-scrolling** to the latest messages during synchronization.

---

## 🛠️ Dependencies

- **Docker**: The application runs in a Docker container based on Ubuntu 24.04.
- **Node.js**: Used for the backend.
- **imapsync**: The core tool for email synchronization.
- **Bootstrap 5**: For the user interface design.
- **SweetAlert2**: For user-friendly notifications.

---

## 🖥️ Installation and Usage

You can use the pre-built Docker image from Docker Hub or build the image locally.

### Option 1: Use the Pre-built Docker Image

1. Pull the Docker image from Docker Hub:

   ```bash
   docker pull razvan1/imapsync-web
   ```

2. Run the container:
   ```bash
   docker run -p 3000:3000 razvan1/imapsync-web
   ```
3. Access the web interface:
   Open your browser and go to: `http://localhost:3000`

---

### Option 2: Build the Docker Image Locally

1. Clone the repository:

   ```bash
   git clone https://github.com/OpenThreat-ro/imapsync-web.git
   cd imapsync-web
   ```

2. Build the Docker image:

   ```bash
   docker build -t openthreat-imapsync .
   ```

3. Run the container:

   ```bash
   docker run -p 3000:3000 openthreat-imapsync
   ```

4. Access the web interface:
    Open your browser and go to: `http://localhost:3000`

---

📝 Configuration

Source Host/Destination Host: Enter the IMAP server address for the source and destination accounts.
Source User/Destination User: Enter the email addresses or usernames for the source and destination accounts.
Source Password/Destination Password: Enter the respective passwords for authentication.

---

## 🌐 About OpenThreat

This project is brought to you by **[OpenThreat](https://openthreat.ro)**.  
Visit our website for more security and infrastructure solutions and services!

---

🛡️ Contributions

Contributions are welcome! If you'd like to propose improvements or fix issues, feel free to open a Pull Request.

---

🧾 License

This project is licensed under the MIT License. See the LICENSE file for details.
