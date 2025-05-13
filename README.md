# DevOps Assignment – Secure, Monitored, and Automated Development Environment

## 👨‍💻 Team Members
- Rahul (Senior DevOps Engineer, Mentor)
- Sarah (Apache Web Server Developer)
- Mike (Nginx Web Server Developer)
- Vishal Singh (Fresher DevOps Engineer, Contributor)

---

## 📋 Project Overview

This project involves configuring a secure and monitored development environment with user management, system monitoring, and automated backups for Apache and Nginx servers. Tasks were performed under the guidance of a senior DevOps engineer to support Sarah and Mike, two new developers at TechCorp.

---

## ✅ Task 1: System Monitoring Setup

### 🎯 Objective

To set up basic system monitoring to track CPU, memory, disk usage, and identify resource-intensive processes on a development server using Linux (Ubuntu).

---

### 🧰 Tools Used

- htop – Interactive process viewer
- nmon – System performance monitor
- df – Reports disk space usage
- du – Shows disk usage by directory
- ps – Displays running processes
---

## 1. Creating directory
### 🔧 Commands Used
```bash
mkdir devops-assignment
```
### Output

![1](https://github.com/user-attachments/assets/c8b82d24-7063-4c03-9a66-8bbd82d7ea60)

---
## 2. Install Monitoring Tools

### 🔧 Commands Used
```bash
sudo apt update -y
sudo apt install htop nmon -y
```
### ✅ To verify installation:
```bash
htop
nmon
```
### Output

![2](https://github.com/user-attachments/assets/b0a9d04e-183a-465e-a285-1c5fe0381933)

These tools provide real-time monitoring of system metrics.
---
## 3. Check Disk Usage

- These commands check how much space is being used on your system and in each user’s home directory.

### 🔧 Commands Used
```bash
sudo df -h > disk_usage.log
sudo du -sh /home/* >> disk_usage.log
```

### 📘 Explanation

- `df -h`: Displays total, used, and available disk space for all mounted filesystems in a human-readable format (GB, MB).
- `du -sh /home/*`: Shows the size of each user's home directory, summarizing space used.
- `>` and `>>`: Used to redirect and append the output to `disk_usage.log`.
---
## 4. Check Top Processes by Memory and CPU

### 🔧 Commands Used
```bash
sudo ps aux --sort=-%mem | head -n 6 > top_processes.log
sudo ps aux --sort=-%cpu | head -n 6 >> top_processes.log
```

### 📘 Explanation

- `ps aux`: Lists all running processes.
- `--sort=-%mem`: Sorts by memory usage (descending).
- `--sort=-%cpu`: Sorts by CPU usage (descending).
- `head -n 6`: Shows top 5 processes plus header.
- `>` and `>>`: Redirects output to `top_processes.log`.

### Output

![3](https://github.com/user-attachments/assets/c29572b9-d18e-4e11-a849-312021706398)

---
## 5. Process Monitoring Implementation

We implemented process monitoring by:
- Using `ps aux` to extract top memory and CPU consuming processes.
- Saving results in `top_processes.log` for review.
- Using `htop` for interactive, real-time process monitoring.

### This setup helps in identifying system bottlenecks and optimizing application performance.
---
## 6. Reporting Structure

To maintain a clear audit trail and allow future diagnostics, all monitoring outputs were redirected to log files within the working directory.

### 📁 Location:
- All logs are saved in the `~/devops-assignment` folder.

### 📄 Log Files Created:

```
/devops-assignment/
├── disk_usage.log
└── top_processes.log
```

### 🔍 Purpose:
- Enables system admins and developers to **review usage trends**
- Detects **resource bottlenecks**
- Supports **future capacity planning**

These files form the base of a **basic reporting structure**, essential for any well-managed Linux environment.

---
## ✅ Task 2 – User Management and Access Control

### 🎯 Objective

To create and manage user accounts for new developers (Sarah and Mike), ensuring each has a secure, isolated working directory. Enforce password policies to meet organizational security standards.

---

## 🧑‍💻 Users to Create

- **Sarah**
- **Mike**

---
### 🔧 Commands Used

## 1. Create Users
```bash
sudo adduser sarah
sudo adduser mike
```
### Output

![4](https://github.com/user-attachments/assets/a1ce4a76-36fa-472a-927a-704512afbfe1)

![5](https://github.com/user-attachments/assets/ce330f29-2078-4fee-9731-5cfe025d857a)

- Prompts for passwords and user details.
- Automatically creates `/home/Sarah` and `/home/mike`.
---
## 2. Create and Secure Workspace Directories
```bash
sudo mkdir -p /home/Sarah/workspace
sudo chown Sarah:Sarah /home/Sarah/workspace
sudo chmod 700 /home/Sarah/workspace

sudo mkdir -p /home/mike/workspace
sudo chown mike:mike /home/mike/workspace
sudo chmod 700 /home/mike/workspace
```

📌 Explanation:
- `mkdir -p`: Creates directory if it doesn’t exist.
- `chown`: Gives ownership to the user.
- `chmod 700`: Only the owner has full access; others have none.

### ✅ To verify
```bash
sudo ls -ld /home/sarah/workspace
sudo ls -ld /home/mike/workspace
```
## Output

![6](https://github.com/user-attachments/assets/14afcb22-146e-419a-ad9b-e8d0cf8d105f)

![7](https://github.com/user-attachments/assets/064a082a-6ae3-464c-99d7-b94767e8dba4)

---

## 3. Password Policy Enforcement

### 1. Install Password Policy Module
```bash
sudo apt install libpam-pwquality -y
```
## Output

![8](https://github.com/user-attachments/assets/afd9f0df-c214-4193-b6bb-d7208c76d431)


### 2. Enforce Expiry in `/etc/login.defs`
```bash
sudo nano /etc/login.defs
```
Update or ensure the following:
```
PASS_MAX_DAYS   30
PASS_MIN_DAYS   0
PASS_WARN_AGE   7
```
### Output

![9](https://github.com/user-attachments/assets/a1b320dc-aa2c-4a48-97b9-32222a6ea701)


### 3. Optional: Set Expiry Manually
```bash
sudo chage -M 30 sarah
sudo chage -M 30 mike
```
### Output

![10](https://github.com/user-attachments/assets/2c2c5a34-19cf-4d2b-b853-ac53a92f39fd)

---

## 📂 Directory Layout

```
/home/
├── Sarah/
│   └── workspace/
└── Mike/
    └── workspace/
```
### Output

![11](https://github.com/user-attachments/assets/58cf4ad6-4803-4e9d-9cd6-b3d0ec83a33a)

![12](https://github.com/user-attachments/assets/17ff799d-bc80-4ef5-a7f7-05477a521f9a)


---
## ✅ Task 3: Backup Configuration for Web Servers

### 🎯 Objective

Configure automated backups for web server configurations and document root folders for two developers, Sarah (Apache) and Mike (Nginx). The goal is to ensure data safety, integrity, and disaster recovery readiness.

---

## 🧑‍💻 User Roles & Responsibility
### 🧑‍💻  Sarah
- User - `sarah`
- Web Server - `Apache`
- Config Directory - `/etc/apache2/`
- Document - `/var/www/html/`

### 🧑‍💻  Mike
- User - `mike`
- Web Server - `Nginx`
- Config Directory - `/etc/nginx/`
- Document - `/usr/share/nginx/html/`

> Note: In the assignment mentions `/etc/httpd/`, which is valid for CentOS/RedHat. But, this setup uses Ubuntu, the correct Apache config path is `/etc/apache2/`.

---

## 📂 Folder Structure and Location

Each user has their own backup folder:

- **Sarah**: `/home/sarah/backup/`
- **Mike**: `/home/mike/backup/`

Inside each folder is a shell script that automates the backup process.

### Output

![13](https://github.com/user-attachments/assets/951ee899-3e46-44e0-9bdf-fcda60747f8b)

---

## 🛠️ Step-by-Step Setup

### ✅ 1. Create Backup Directory for Each User

**As a Users**
```bash
mkdir -p ~/backup (Sarah)
mkdir -p ~/backup (Mike)
sudo chown -R sarah:sarah /home/sarah/backup
sudo chown -R mike:mike /home/mike/backup
```

---

### ✅ 2. Create Backup Scripts

#### 🔧 Sarah: `/home/sarah/backup/apache_backup.sh`

```bash
#!/bin/bash
DATE=$(date +%F)
mkdir -p ~/backup/output
tar -czf ~/backup/output/apache_backup_$DATE.tar.gz /etc/apache2/ /var/www/html/
tar -tzf ~/backup/output/apache_backup_$DATE.tar.gz > ~/backup/output/apache_verify_$DATE.log
```

**Make it executable:**
```bash
chmod +x /home/sarah/backup/apache_backup.sh
```
### Output

![Screenshot 2025-05-13 155546](https://github.com/user-attachments/assets/1acea340-4ae8-43bb-9613-872fb701931f)

---

#### 🔧 Mike: `/home/mike/backup/nginx_backup.sh`

```bash
#!/bin/bash
DATE=$(date +%F)
mkdir -p ~/backup/output
tar -czf ~/backup/output/nginx_backup_$DATE.tar.gz /etc/nginx/ /usr/share/nginx/html/
tar -tzf ~/backup/output/nginx_backup_$DATE.tar.gz > ~/backup/output/nginx_verify_$DATE.log
```

**Make it executable:**
```bash
chmod +x /home/mike/backup/nginx_backup.sh
```
### Output

![Screenshot 2025-05-13 160537](https://github.com/user-attachments/assets/dd128efd-0c06-4305-8934-db2ae6de11e6)

---

### ✅ 3. Manual Testing of Scripts

Run manually to ensure they work:

**Sarah:**
```bash
su - sarah
cd ~/backup
./apache_backup.sh
```

**Mike:**
```bash
su - mike
cd ~/backup
./nginx_backup.sh
```

---

### ✅ 4. Output Verification

Check the generated files:
```bash
ls ~/backup/output
```

Output for Sarah:
```
apache_backup_2025-05-13.tar.gz
apache_verify_2025-05-13.log
```

Output for Mike:
```
nginx_backup_2025-05-13.tar.gz
nginx_verify_2025-05-13.log
```

---

### ✅ 5. View Verification Log Content

To see if the backup worked:
```bash
cat ~/backup/output/apache_verify_2025-05-13.log | head
cat ~/backup/output/nginx_verify_2025-05-13.log | head
```

Example Output:
```
etc/apache2/
etc/apache2/apache2.conf
var/www/html/index.html
```

---

## 🕒 Cron Job Scheduling

### 🧑‍💻 Sarah

```bash
crontab -e
```

Add:
```
0 0 * * 2 /home/sarah/backup/apache_backup.sh
```

### 🧑‍💻 Mike

```bash
crontab -e
```

Add:
```
0 0 * * 2 /home/mike/backup/nginx_backup.sh
```

> This schedules the backup to run automatically every Tuesday at 12:00 AM.

---

## ✅ How to Check If Cron Job Is Set

```bash
crontab -l
```

Expected Output:
```
0 0 * * 2 /home/sarah/backup/apache_backup.sh
```
### Output

![Screenshot 2025-05-13 153341](https://github.com/user-attachments/assets/450c296b-60c8-440f-96e6-0d8b4dd57642)

---

# 🚀 GitHub Submission Instructions (with Token Authentication)

This guide explains the exact steps used to push your local DevOps assignment folder to GitHub, including setting up authentication using a Personal Access Token (PAT).

---

## ✅ Step-by-Step Git Commands with Explanation

### 1. Initialize Git in Your Project Folder
```bash
git init
```
Initializes an empty Git repository inside your current directory.

---

### 2. Add the Remote GitHub Repository
```bash
git remote add origin https://github.com/VishalSingh1996/devops-backup-assignment.git
```
Connects your local project to your GitHub repository.

---

### 3. Add All Project Files for Commit
```bash
git add .
```
Stages all files in the current directory for the commit.

---

### 4. Commit the Files with a Message
```bash
git commit -m "Added logs and user backup scripts"
```
Creates a snapshot of the current project state with a description.

---

### 5. First Attempt to Push to GitHub
```bash
git push -u origin main
```
This may fail if the remote repo already has commits (like an auto-created README).

---

### 6. Pull Remote Changes (If Push Fails)
```bash
git pull
```
Brings down the remote repository’s existing commits into your local project.

---

### 7. Set Upstream Branch to Track Remote
```bash
git branch --set-upstream-to=origin/main main
```
Tells Git to track the `main` branch on GitHub for future pulls/pushes.

---

### 8. Try to Push Again
```bash
git push
```
This may fail again if your branch is behind.

---

### 9. Pull Again with Rebase (to avoid conflicts)
```bash
git pull --rebase origin main
```
Safely pulls in changes by replaying your commits on top of the updated remote branch.

---

### 10. Final Push
```bash
git push
```
Now your code is successfully uploaded to GitHub.

---

## 🔐 Using a Personal Access Token (PAT)

GitHub no longer accepts passwords for pushing to repos. Use a token instead:

### 🔧 How to Create a Token

1. Go to GitHub → **Settings** → **Developer settings**
2. Click **Personal Access Tokens** → **Tokens (classic)**
3. Click **"Generate new token"**
4. Check `repo` scope
5. Set expiration and click **Generate token**
6. **Copy the token** (you won't see it again)

### 📌 When Git asks for credentials:
```
Username: VishalSingh1996
Password: [paste your GitHub token here]
```

To avoid repeating this:
```bash
git config --global credential.helper store
```
This saves the token for future pushes.

### Images of git-output

![Screenshot 2025-05-13 181422](https://github.com/user-attachments/assets/7334e717-e143-41da-a0f4-251efabdbb93)

![Screenshot 2025-05-13 181514](https://github.com/user-attachments/assets/1b8cedcc-a6fc-411e-a678-aa04b9174322)

### Error facing in this

![Screenshot 2025-05-13 181542](https://github.com/user-attachments/assets/4e0281ac-6d76-4163-a211-ffa384e082a5)

### Solved issue

![Screenshot 2025-05-13 181557](https://github.com/user-attachments/assets/c0050499-9edb-4412-9142-97bcd748589d)

# Thank you!
---
