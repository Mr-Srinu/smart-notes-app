# 📝 Smart Site Task Manager

[![Node.js](https://img.shields.io/badge/Backend-Node.js%20%2B%20Express-339933?style=flat-square&logo=node.js&logoColor=white)](https://nodejs.org/)
[![TypeScript](https://img.shields.io/badge/Language-TypeScript-3178C6?style=flat-square&logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![Flutter](https://img.shields.io/badge/Frontend-Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Supabase](https://img.shields.io/badge/Database-Supabase%20(PostgreSQL)-3ECF8E?style=flat-square&logo=supabase&logoColor=white)](https://supabase.com/)

A production-grade task management application that automatically classifies, prioritizes, and enriches tasks using intelligent content analysis. Built as a hybrid solution featuring a Node.js backend and a Material 3 Flutter mobile application.

**Live Backend URL:** [https://smart-notes-app-x7o0.onrender.com](https://smart-notes-app-x7o0.onrender.com)

---

## 🚀 Project Overview
The system transforms raw text input into structured data to automate workflow organization.



* **Intelligent Logic:** Detects categories and urgency from task descriptions.
* **Entity Extraction:** Automatically parses dates, people, and actions.
* **Suggested Workflows:** Provides category-specific action buttons to speed up task completion.

---

## 🛠 Tech Stack
| Component | Technologies Used |
| :--- | :--- |
| **Backend** | Node.js, Express, TypeScript, Zod (Validation), API Key Auth, Rate Limiting |
| **Database** | Supabase (PostgreSQL) with JSONB support |
| **Mobile** | Flutter (Material 3), Riverpod (State Management), Dio (Networking) |
| **Infrastructure** | Render.com (Deployment), Offline status detection |

---

## 🧠 Auto-Classification Logic
The system uses an intelligent keyword-mapping engine to categorize and prioritize tasks upon creation.

### **Category Detection**
* **Scheduling:** meeting, schedule, call, appointment, deadline.
* **Finance:** payment, invoice, bill, budget, cost, expense.
* **Technical:** bug, fix, error, install, repair, maintain.
* **Safety:** safety, hazard, inspection, compliance, PPE.

### **Priority Mapping**
* **High:** urgent, asap, immediately, today, critical, emergency.
* **Medium:** soon, this week, important.
* **Low:** default classification.

### **Suggested Actions**
Generated based on the assigned category:
* **Scheduling:** ["Block calendar", "Send invite", "Prepare agenda", "Set reminder"]
* **Finance:** ["Check budget", "Get approval", "Generate invoice", "Update records"]
* **Technical:** ["Diagnose issue", "Check resources", "Assign technician", "Document fix"]
* **Safety:** ["Conduct inspection", "File report", "Notify supervisor", "Update checklist"]

---

## 📡 API Documentation
The backend exposes five core endpoints for task lifecycle management.

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `POST` | `/api/tasks` | Create task + Auto-classify |
| `GET` | `/api/tasks` | List tasks (Filters: status, category, priority) |
| `GET` | `/api/tasks/{id}` | Get task details + audit history |
| `PATCH` | `/api/tasks/{id}` | Update task status or fields |
| `DELETE` | `/api/tasks/{id}` | Remove task record |

---

## 🗄 Database Schema
Normalized PostgreSQL schema managed via Supabase.



### **tasks Table**
* `id`: uuid (PK)
* `title`: text (NOT NULL)
* `category`: text (scheduling, finance, technical, safety, general)
* `priority`: text (high, medium, low)
* `status`: text (pending, in_progress, completed)
* `extracted_entities`: jsonb
* `suggested_actions`: jsonb

### **task_history Table**
* `id`: uuid (PK)
* `task_id`: uuid (FK)
* `action`: text (created, updated, status_changed)
* `old_value / new_value`: jsonb (Audit snapshots)

---

## 📱 Flutter Mobile Features
A polished, single-screen dashboard experience.
* **Summary Cards:** Real-time counts for Pending, In Progress, and Completed tasks.
* **Task List:** Color-coded category chips, priority badges, and status indicators.
* **Interactive Form:** Bottom sheet for task creation with classification preview.
* **Network Resilience:** Built-in offline indicator and skeleton loaders for state transitions.

---

## ⚙️ Setup Instructions

### **Backend Setup**
1. Navigate to the `/backend` directory.
2. `npm install`
3. `npm run build`
4. `npm start`

### **Flutter Setup**
1. Ensure Flutter SDK is installed.
2. `flutter pub get`
3. `flutter run`

---

## 📸 Screenshots
| Dashboard | Task Form | Light Mode |
| :---: | :---: | :---: |
| ![Dashboard](https://raw.githubusercontent.com/Mr-Srinu/smart-notes-app/main/Screenshot%202025-12-29%20002301.png) | ![Form](https://raw.githubusercontent.com/Mr-Srinu/smart-notes-app/main/Screenshot%202025-12-29%20002410.png) | ![Light Mode](https://raw.githubusercontent.com/Mr-Srinu/smart-notes-app/main/Screenshot%202025-12-29%20003450.png) |

---

## 🧠 Architecture Decisions
* **Keyword Mapping:** Chosen for deterministic, fast, and high-accuracy classification without high LLM latency.
* **JSONB Storage:** Utilized in PostgreSQL to handle varied extracted entities (names, dates) flexibly.
* **Riverpod:** Selected for its robust provider-based state management and ease of testing.

---

## 🔮 Future Improvements
* **Search Optimization:** More filteriazed Search Optimizations.
* **Real-time Updates:** Implementing Supabase subscriptions for instant dashboard refreshes.
* **Real-time Notifications:** Using SNS, firebase Messaging etc. can send Realtime Notifications regarding Schedules, Next tasks, updates.
