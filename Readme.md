## Ubuntu OS Hardening Tool (GUI-Based)
Hackathon Submission – Software Category

Organization Context: National Technical Research Organisation (NTRO)

### 📌 Problem Statement

Develop a GUI-based hardening tool for Ubuntu OS that allows organizations to enforce security policies with flexibility, ease of use, and high security assurance.
The tool should enable even non-expert users to apply system hardening measures based on organizational IT security requirements.

### 🎯 Objective

The objective of this project is to design and implement a secure, modular, and user-friendly Ubuntu OS hardening solution that:

Enforces industry-standard security best practices

Provides policy-driven customization

Uses a Graphical User Interface (GUI) for accessibility

Minimizes human error during system hardening

Maintains system stability and auditability

### 🛡️ Key Features
✅ GUI-Based Hardening Controls

Simple checkbox and toggle-based interface

Designed for users with minimal IT/security background

✅ Policy-Driven Security

### Users can enable or disable hardening features based on organizational policies, including:

🔒 Disable SSH access

🚫 Block USB storage devices

🌐 Block TOR network usage

🔐 Enforce strong password policies

🧱 Enable firewall (UFW)

📁 Secure file permissions

🖥️ GRUB bootloader password protection

📜 Logging & audit configuration

✅ Security-First Design

Requires root privileges for execution

Uses trusted Linux hardening practices

Prevents insecure defaults

Logs all applied changes

### 🧰 Technologies Used

#### Operating System: Ubuntu (18.04 / 20.04 / 22.04)

Scripting: Bash

GUI Framework: (e.g., Zenity / GTK / Tkinter – specify your choice)

Security References:

CIS Benchmarks

konstruktoid/hardening

conduro/ubuntu
