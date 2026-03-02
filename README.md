# 💰 Taipei Wallet — Personal Finance Tracker

Full-featured personal finance tracker with **Django + PostgreSQL + Docker**.
Tracks expenses, income, transfers, and top-ups with real-time balances per account.

---

## 🚀 Quick Start

### 1. Prerequisites
```bash
sudo apt update && sudo apt install -y docker.io docker-compose-plugin
sudo usermod -aG docker $USER && newgrp docker
```

### 2. Place your Excel file
```bash
# The import_data folder already contains your Excel file.
# On future re-imports, replace it:
cp /path/to/Expenses_V2_Taiwan_1.xlsx import_data/
```

### 3. Configure environment
```bash
cp .env.example .env
nano .env   # Change passwords, add your server IP
```

### 4. Launch
```bash
docker compose up -d
```

**On first boot it will automatically:**
- Run migrations
- Create your admin account
- Seed Cash / iPass / Taishin Bank / LINE Pay with starting balances (Dec 26, 2025)
- Import all 225 transactions from your Excel file

Visit `http://YOUR_SERVER_IP` and log in!

---

## 💱 Transaction Types

| Type | Icon | Effect on Balances |
|------|------|--------------------|
| **Expense** | 🔴 | From account balance ↓ |
| **Income** | 🟢 | Into account balance ↑ |
| **Transfer** | 🔵 | From account ↓, To account ↑ (automatic) |
| **Top-up** | 🟡 | From account ↓, To account ↑ (automatic) |

**Example: Withdraw ₺5,000 from Taishin Bank to Cash**
→ Select type: Transfer, From: Taishin Bank, To: Cash, Amount: 5000
→ Both balances update instantly

---

## 💰 Starting Balances (Dec 26, 2025)
- Cash: TWD 5,432
- iPass: TWD 449  
- Taishin Bank: TWD 0
- LINE Pay: TWD 0

---

## 📤 Re-importing Excel Data
```bash
# To re-run the import (clears existing transactions first):
docker compose exec backend python manage.py import_excel --clear
```

---

## 🔧 Useful Commands
```bash
docker compose logs -f backend        # View logs
docker compose exec backend python manage.py shell   # Django shell
docker compose exec db pg_dump -U expenseuser expensetracker > backup.sql
docker compose down && docker compose up -d --build  # Rebuild
```
