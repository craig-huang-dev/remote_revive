# RemoteRevive

## About RemoteRevive

**RemoteRevive** is a project designed to address the growing mental health challenges faced by remote workers in the post-COVID era. While remote work offers flexibility and many benefits, it also presents significant challenges such as burnout, isolation, and blurred workplace boundaries. RemoteRevive provides personalized, workplace-specific mindfulness techniques to combat these issues and promote mental health for virtual workers.  

### Motivation
RemoteRevive aims to tackle the negative impacts of these challenges, which affect both employees and employers. By improving work-life balance and mental health, employees can become more productive and motivated, while employers can maintain a positive and thriving work culture. This system benefits both parties by fostering an environment where workers can flourish.

### Key Features
The platform connects three types of professional users: employees, supervisors, and health professionals. Each user has specific roles:
- **Employees** can access mental health tools and log their stress levels in wellness logs.  
- **Supervisors** can oversee employees' wellbeing and recommend tools and techniques.  
- **Health Professionals** can create, edit, and recommend mental health resources tailored to employees' needs.  

The system emphasizes the management of mental health resources through features such as:
1. **Tools & Techniques**: Exercises and skills employees can use to reduce stress.  
2. **Recommendations**: Personalized suggestions for mental health practices from supervisors or health professionals.  
3. **Wellness Logs**: A platform for employees to log their stress levels and wellbeing, enabling tailored support.

This project also serves as a demonstration of database management systems, showcasing the use of relational databases to manage user interactions, resource recommendations, and wellness tracking effectively.

## Steps for Initial Setup

### 1. Download MySQL Workbench or a MySQL Server/Connector
- **Download MySQL Workbench**: [Website link](https://dev.mysql.com/downloads/workbench/)

### 2. Clone the Repository
- Go to the [RemoteRevive GitHub repository](https://github.com/craig-huang-dev/remote_revive.git) and clone it to your local machine.

### 3. Initialize Your Database in MySQL Workbench
- The project includes a `.sql` file that creates all required tables and inserts the initial data.
- Navigate to the `/sql` directory in your terminal and run the following command:
  ```bash
  mysql -u root -p < ./db_init_with_data.sql
- After running the command:
  - Check in MySQL Workbench for a database named RemoteRevive.
  - Ensure all the tables and data are present.
- Note: If you make changes to the database and want to reset it with the original data, re-run the above command.

### 4. Create db_config.js
- The server.js file uses a configuration file named db_config.js to log in and access the database for backend operations.
- Copy and paste the following code into a file called db_config.js and save it in the /backend directory:
  ```javascript
  module.exports = {
    host: "localhost",
    user: "root", // Replace with your MySQL username (this should stay the same)
    password: "", // Replace with your MySQL password
    database: "RemoteRevive"
  };
- Replace your MySQL password:
  - In db_config.js, replace the password field with your MySQL password for your local machine.
  - This file remains on your local machine and is excluded from Git using .gitignore for security.

### 5. Start the Server
- Navigate to the /backend directory and run the following command:
  ```bash
  node server.js
### 6. Start the Frontend
- In another terminal, navigate to the /frontend directory and run:
  ```bash
  npm run dev

### You’re all set! 🎉
Feel free to explore and contribute to RemoteRevive. For any questions, refer to the project documentation or reach out through the GitHub repository.