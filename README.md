# 🧘‍♀️ Fitness Management Project

## 📌 Project Description
Fitness Management is a web-based application. 
It allows users to register, log in, track their daily workouts, monitor BMI, receive workout tips, and view visualizations based on their health data.

The system uses **Java (Servlets & JSP)** for the backend, **MySQL** for data storage, and **Apache Tomcat** as the server. It helps users improve health habits by recording daily weight and visualizing progress.

---

## 🚀 Key Features
- User registration and login system  
- Displays health data like age, weight, BMI, category, diet, and workout tips  
- Records daily weight via "Add Workout"  
- Tracks BMI changes and activity logs  
- Displays graphs:  
  - Workout status (pie chart)  
  - Weight progress (chart)  
  - BMI progress (chart)  
- Admin portal for management  

---

## 🛠️ Tech Stack Used
- **Frontend**: HTML, CSS, JSP  
- **Backend**: Java (Servlets)  
- **Database**: MySQL (XAMPP/phpMyAdmin)  
- **Server**: Apache Tomcat  
- **IDE**: Eclipse  


---

## 🧱 System Architecture
The system follows a **Model-View-Controller (MVC)** pattern:

- **Model**: Java Servlets & database (MySQL)  
- **View**: JSP pages for interaction  
- **Controller**: Servlet logic controlling data flow  

---

## Activity Diagram
The system follows the following

User -> Login/Register

-> View Profile & BMI

-> Add Today's Workout

-> View Progress Charts

-> Logout

---

## ▶️ How to Run This Project

1. Open project in **Eclipse IDE**
2. Install and run **XAMPP**, start Apache and MySQL
3. Import the **`fitness.sql`** database using phpMyAdmin
4. Deploy project on **Apache Tomcat Server**
5. Visit: `http://localhost:8080/FitnessManagement`

---

## 🧾 Database Details

**Database Name**: `fitness`  
**Tables**:
- `admin` – stores admin credentials  
- `clients` – stores user registration and profile info  
- `workout` – stores daily workout and BMI logs

📂 SQL file: `database/fitness.sql` (included in this repo)

---



## 🔮 Future Enhancements
- Add email verification during signup  
- Weekly health summary emails  
- Integration with fitness wearables  
- Admin analytics dashboard  

---





