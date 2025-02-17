# 🛡️ ImunifyAV Mattermost Notification Script

This **Bash script** automates the detection of infected domains using **ImunifyAV** and sends alerts to a **Mattermost channel** via a webhook.

## 🚀 Features
- 🛠️ Automatically detects infected domains (`infected` or `infected_db` > 0).
- 🔔 Sends a notification to a **Mattermost channel**.
- 📊 Parses JSON output using `jq` for clean data extraction.
- 📅 Can be scheduled via **cron** or triggered automatically **after each scan** in ImunifyAV GUI or CLI.

---

## 📌 Prerequisites

### 1️⃣ Install `jq` (if not installed)
`jq` is required to process JSON output.

```bash
# Debian/Ubuntu
sudo apt install jq -y

# CentOS/RHEL
sudo yum install jq -y

# macOS (Homebrew)
brew install jq
```

### 2️⃣ Set Up a Mattermost Webhook
1. Go to **Mattermost** → **Main Menu** → **Integrations** → **Incoming Webhooks**.
2. Click **"Add Incoming Webhook"** and select the channel.
3. Copy the **Webhook URL** (you will need it in the script).

---

## 📜 Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/PJF16/imunify-mattermost-notifier.git
   cd imunify-mattermost-notifier
   ```

2. Make the script executable:

   ```bash
   chmod +x imunifyMattermostNotification.sh
   ```

3. Edit the script and **replace** `WEBHOOK_URL` with your Mattermost webhook:

   ```bash
   nano imunifyMattermostNotification.sh
   ```

   Change:

   ```bash
   WEBHOOK_URL="https://mattermost.example.com/hooks/your-webhook-id"
   ```

4. **(Optional) Customize the Mattermost bot username**  
   The script uses `"username": "ImunifyAV-Bot"` by default. You can change this to any name you prefer:

   ```json
   "username": "Custom-Bot-Name"
   ```

5. Run the script manually:

   ```bash
   sudo ./imunifyMattermostNotification.sh
   ```

---

## ⏳ Automate Execution

### 1️⃣ Run the Script Periodically via Cron
To run the script automatically every hour, add this line to **root's crontab**:

```bash
sudo crontab -e
```

Then add:

```bash
0 * * * * /path/to/imunifyMattermostNotification.sh >> /var/log/imunify_mattermost.log 2>&1
```

### 2️⃣ Run the Script **After Every Scan** in ImunifyAV
You can configure **ImunifyAV** to trigger the script automatically **after each scan**.

#### 🖥️ **Option 1: Set Up via ImunifyAV GUI**

#### 📌 **Option 2: Set Up via CLI**

---

## 🔍 Example Output

### ✅ No Infected Users:
```
✅ No infected users found.
```

### 🚨 Infected Users Detected:
```
🚨 Infected users detected:
```
```
test.user
hacked-user123
another-infected-user
```
_Message is formatted as a Mattermost notification._

---

## 🛠️ Troubleshooting

### ❌ `This script must (probably) be run as root!`
- Ensure you run the script with (depending on your system configuration):

  ```bash
  sudo ./imunifyMattermostNotification.sh
  ```

### ❌ `Command not found: imunify-antivirus`
- Ensure **ImunifyAV** is installed.
- Try running:

  ```bash
  imunify360-agent malware user list
  ```

  If it fails, check your **ImunifyAV installation**.

### ❌ `jq: command not found`
- Install `jq` as described in **Prerequisites**.

---

## 📜 License

This script is released under the **Apache License 2.0**.

---

## 📩 Support

Feel free to **open an issue** or **submit a PR** if you have suggestions or improvements. 🚀
