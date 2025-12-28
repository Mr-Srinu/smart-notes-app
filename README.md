# 📝 Smart Site Task Manager

[![Node.js](https://img.shields.io/badge/Backend-Node.js%20%2B%20Express-339933?style=flat-square&logo=node.js&logoColor=white)](https://nodejs.org/)
[![TypeScript](https://img.shields.io/badge/Language-TypeScript-3178C6?style=flat-square&logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![Flutter](https://img.shields.io/badge/Frontend-Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Supabase](https://img.shields.io/badge/Database-Supabase%20(PostgreSQL)-3ECF8E?style=flat-square&logo=supabase&logoColor=white)](https://supabase.com/)

A production-grade task management application that automatically classifies, prioritizes, and enriches tasks using intelligent content analysis[cite: 1, 3]. [cite_start]Built as a hybrid solution featuring a Node.js backend and a Material 3 Flutter mobile application[cite: 11, 20].

[cite_start]**Live Backend URL:** [https://smart-notes-app-x7o0.onrender.com](https://smart-notes-app-x7o0.onrender.com) [cite: 135]

---

## 🚀 Project Overview
[cite_start]The system transforms raw text input into structured data to automate workflow organization[cite: 3].
* [cite_start]**Intelligent Logic:** Detects categories and urgency from task descriptions[cite: 6, 7].
* [cite_start]**Entity Extraction:** Automatically parses dates, people, and actions[cite: 8].
* [cite_start]**Suggested Workflows:** Provides category-specific action buttons to speed up task completion[cite: 9].

---

## 🛠 Tech Stack
| Component | Technologies Used |
| :--- | :--- |
| **Backend** | [cite_start]Node.js, Express, TypeScript, Zod (Validation), API Key Auth, Rate Limiting [cite: 11, 95, 156] |
| **Database** | [cite_start]Supabase (PostgreSQL) with JSONB support [cite: 15, 37] |
| **Mobile** | [cite_start]Flutter (Material 3), Riverpod (State Management), Dio (Networking) [cite: 126, 130, 131] |
| **Infrastructure** | [cite_start]Render.com (Deployment), Offline status detection [cite: 134, 129] |

---

## 🧠 Auto-Classification Logic
[cite_start]The system uses an intelligent keyword-mapping engine to categorize and prioritize tasks upon creation[cite: 69, 70].

### [cite_start]**Category Detection** [cite: 71-78]
* **Scheduling:** meeting, schedule, call, appointment, deadline.
* **Finance:** payment, invoice, bill, budget, cost, expense.
* **Technical:** bug, fix, error, install, repair, maintain.
* **Safety:** safety, hazard, inspection, compliance, PPE.

### [cite_start]**Priority Mapping** [cite: 79-82]
* **High:** urgent, asap, immediately, today, critical, emergency.
* **Medium:** soon, this week, important.
* **Low:** default classification.

### [cite_start]**Suggested Actions** [cite: 88-93]
Generated based on the assigned category:
* **Scheduling:** ["Block calendar", "Send invite", "Prepare agenda", "Set reminder"]
* **Finance:** ["Check budget", "Get approval", "Generate invoice", "Update records"]
* **Technical:** ["Diagnose issue", "Check resources", "Assign technician", "Document fix"]
* **Safety:** ["Conduct inspection", "File report", "Notify supervisor", "Update checklist"]

---

## 📡 API Documentation
[cite_start]The backend exposes five core endpoints for task lifecycle management[cite: 11, 68].

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `POST` | `/api/tasks` | [cite_start]Create task + Auto-classify [cite: 68] |
| `GET` | `/api/tasks` | [cite_start]List tasks (Filters: status, category, priority) [cite: 68] |
| `GET` | `/api/tasks/{id}` | [cite_start]Get task details + audit history [cite: 68] |
| `PATCH` | `/api/tasks/{id}` | [cite_start]Update task status or fields [cite: 68] |
| `DELETE` | `/api/tasks/{id}` | [cite_start]Remove task record [cite: 68] |

---

## 🗄 Database Schema
[cite_start]Normalized PostgreSQL schema managed via Supabase[cite: 37, 38].

### [cite_start]`tasks` Table [cite: 39-56]
* `id`: uuid (PK)
* `title`: text (NOT NULL)
* `category`: text (scheduling, finance, technical, safety, general)
* `priority`: text (high, medium, low)
* `status`: text (pending, in_progress, completed)
* `extracted_entities`: jsonb
* `suggested_actions`: jsonb

### [cite_start]`task_history` Table [cite: 57-66]
* `id`: uuid (PK)
* `task_id`: uuid (FK)
* `action`: text (created, updated, status_changed)
* `old_value / new_value`: jsonb (Audit snapshots)

---

## 📱 Flutter Mobile Features
[cite_start]A polished, single-screen dashboard experience[cite: 102, 103].
* [cite_start]**Summary Cards:** Real-time counts for Pending, In Progress, and Completed tasks[cite: 104, 105].
* [cite_start]**Task List:** Color-coded category chips, priority badges, and status indicators [cite: 109-112].
* [cite_start]**Interactive Form:** Bottom sheet for task creation with classification preview[cite: 116, 123].
* [cite_start]**Network Resilience:** Built-in offline indicator and skeleton loaders for state transitions[cite: 127, 129].

---

## [cite_start]⚙️ Setup Instructions [cite: 140-142]

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
| Dashboard | Task Form |
| :---: | :---: |
| ![Dashboard Placeholder](https://via.placeholder.com/200x400?text=Dashboard+Screen) | ![Form Placeholder](https://via.placeholder.com/200x400?text=Creation+Sheet) |

---

## [cite_start]🧠 Architecture Decisions [cite: 147, 149]
* [cite_start]**Keyword Mapping:** Chosen for deterministic, fast, and high-accuracy classification without high LLM latency[cite: 160].
* [cite_start]**JSONB Storage:** Utilized in PostgreSQL to handle varied extracted entities (names, dates) flexibly[cite: 53, 54].
* [cite_start]**Riverpod:** Selected for its robust provider-based state management and ease of testing[cite: 130].

---

## [cite_start]🔮 Future Improvements [cite: 148, 150]
* [cite_start]**LLM Integration:** Moving from keyword-based to AI agent frameworks (LangGraph) for better context awareness[cite: 17, 23].
* [cite_start]**Real-time Updates:** Implementing Supabase subscriptions for instant dashboard refreshes[cite: 155].
* [cite_start]**Analytics Dashboard:** Deeper visual insights into task completion rates[cite: 26].
