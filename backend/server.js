// This file is where we specify API calls that interact with the database
const express = require("express");
const mysql = require("mysql2");
const bodyParser = require("body-parser");
const cors = require("cors");
const bcrypt = require("bcrypt");
const dbConfig = require("./db_config.js");

const app = express();
app.use(bodyParser.json());
app.use(cors());

// Create a MySQL connection
const db = mysql.createConnection(dbConfig);

// Connect to the MySQL database
db.connect((err) => {
    if (err) {
        console.error("Error connecting to MySQL:", err);
        return;
    }
    console.log("Connected to MySQL database");
});

/**************************************************
 *      Employee INSERT, UPDATE, DELETE logic
 **************************************************/
// POST route to INSERT an employee
app.post("/api/employees", async (req, res) => {
    const { employeeId, firstName, lastName, email, password, supervisorId, healthProfId } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);
    // Insert the employee data into the Employees table
    const query = `INSERT INTO Employees (employeeId, firstName, lastName, email, supervisorId, healthProfId) VALUES (?, ?, ?, ?, ?, ?)`;
    db.query(query, [employeeId, firstName, lastName, email, supervisorId, healthProfId], (err) => {
        if (err) {
            console.error("Error inserting employee:", err);
            res.status(500).send("Error inserting employee");
            return;
        }
        const passwordQuery = `INSERT INTO EmployeePassword (employeeId, password) VALUES (?, ?)`;
        db.query(passwordQuery, [employeeId, hashedPassword], (err) => {
            if (err) {
                console.error("Error inserting password:", err);
                res.status(500).send("Error inserting password");
                return;
            }
            res.status(200).send("Employee added successfully");
        });
    });
});

app.put("/api/employees/:employeeId", async (req, res) => {
    const employeeId = req.params.employeeId;
    const { firstName, lastName, email, password, supervisorId, healthProfId } = req.body;

    // Hash the new password only if it is provided
    let hashedPassword;
    if (password) {
        hashedPassword = await bcrypt.hash(password, 10);
    }

    console.log("Received data:", req.body);

    // Create an array to hold the updates
    const updates = [];
    const values = [];

    // Check which fields are provided and build the query dynamically
    if (firstName !== undefined) {
        updates.push("firstName = ?");
        values.push(firstName);
    }
    if (lastName !== undefined) {
        updates.push("lastName = ?");
        values.push(lastName);
    }
    if (email !== undefined) {
        updates.push("email = ?");
        values.push(email);
    }

    // Handle supervisorId and healthProfId, including when they are null
    if (supervisorId !== undefined) {
        // If supervisorId is null, we set the field to NULL in the database
        updates.push("supervisorId = ?");
        values.push(supervisorId === null ? null : supervisorId);
    }

    if (healthProfId !== undefined) {
        // If healthProfId is null, we set the field to NULL in the database
        updates.push("healthProfId = ?");
        values.push(healthProfId === null ? null : healthProfId);
    }

    // Ensure there are fields to update
    if (updates.length === 0 && !password) {
        return res.status(400).send("No fields to update");
    }

    // Add the employeeId to the values array
    values.push(employeeId);

    // Build the update query
    const employeeQuery = `UPDATE Employees SET ${updates.join(", ")} WHERE employeeId = ?`;

    // Execute the query
    db.query(employeeQuery, values, (err) => {
        if (err) {
            console.error("Error updating employee:", err);
            return res.status(500).send("Error updating employee details");
        }

        // If the password is provided, update it in the employeepassword table
        if (password) {
            const passwordQuery = "UPDATE employeepassword SET password = ? WHERE employeeId = ?";
            db.query(passwordQuery, [hashedPassword, employeeId], (err) => {
                if (err) {
                    console.error("Error updating password:", err);
                    return res.status(500).send("Error updating password");
                }
                res.status(200).send("Employee and password updated successfully");
            });
        } else {
            res.status(200).send("Employee updated successfully");
        }
    });
});

// DELETE a specific employee by employeeId
app.delete("/api/employees/:employeeId", (req, res) => {
    const employeeId = req.params.employeeId;

    // Query to delete the employee from the Employees table
    const query = `DELETE FROM Employees WHERE employeeId = ?`;

    // Execute the query
    db.query(query, [employeeId], (err) => {
        if (err) {
            console.error("Error deleting employee:", err);
            return res.status(500).send("Error deleting employee");
        }

        res.status(200).send("Employee deleted successfully");
    });
});

/**************************************************
 * HealthProfessional INSERT, UPDATE, DELETE logic
 **************************************************/
// POST route to INSERT a health professional
app.post("/api/health-professional", async (req, res) => {
    const { healthProfId, firstName, lastName, email, specialization, password } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);
    // Insert the employee data into the Employees table
    const query = `INSERT INTO HealthProfessionals (healthProfId, firstName, lastName, email, specialization) VALUES (?, ?, ?, ?, ?)`;
    db.query(query, [healthProfId, firstName, lastName, email, specialization], (err) => {
        if (err) {
            console.error("Error inserting employee:", err);
            res.status(500).send("Error inserting employee");
            return;
        }

        const passwordQuery = `INSERT INTO HealthProfessionalPassword (healthProfId, password) VALUES (?, ?)`;
        db.query(passwordQuery, [healthProfId, hashedPassword], (err) => {
            if (err) {
                console.error("Error inserting password:", err);
                res.status(500).send("Error inserting password");
                return;
            }
            res.status(200).send("Health Professional added successfully");
        });
    });
});

// PUT route to UPDATE a health professional
app.put("/api/health-professional/:healthProfId", async (req, res) => {
    const healthProfId = req.params.healthProfId;
    const { firstName, lastName, email, specialization, password } = req.body;

    console.log("Received data:", req.body);

    // Create an array to hold the updates
    const updates = [];
    const values = [];

    // Check which fields are provided and build the query dynamically
    if (firstName) {
        updates.push("firstName = ?");
        values.push(firstName);
    }
    if (lastName) {
        updates.push("lastName = ?");
        values.push(lastName);
    }
    if (email) {
        updates.push("email = ?");
        values.push(email);
    }
    if (specialization) {
        updates.push("specialization = ?");
        values.push(specialization);
    }

    // Ensure there are fields to update
    if (updates.length === 0 && !password) {
        return res.status(400).send("No fields to update");
    }

    // Add the healthProfId to the values array
    values.push(healthProfId);

    // Build the update query
    const healthProfQuery = `UPDATE HealthProfessionals SET ${updates.join(", ")} WHERE healthProfId = ?`;

    // Execute the query
    db.query(healthProfQuery, values, async (err) => {
        if (err) {
            console.error("Error updating health professional details:", err);
            return res.status(500).send("Error updating health professional details");
        }

        if (password) {
            try {
                const hashedPassword = await bcrypt.hash(password, 10);

                const passwordQuery = "UPDATE healthprofessionalpassword SET password = ? WHERE healthProfId = ?";
                db.query(passwordQuery, [hashedPassword, healthProfId], (err) => {
                    if (err) {
                        console.error("Error updating health professional password:", err);
                        return res.status(500).send("Error updating health professional password");
                    }

                    res.status(200).send("Health professional and password updated successfully");
                });
            } catch (error) {
                console.error("Error hashing password:", error);
                return res.status(500).send("Error hashing password");
            }
        } else {
            res.status(200).send("Health professional updated successfully");
        }
    });
});

// DELETE a specific health professional by healthProfId
app.delete("/api/health-professionals/:healthProfId", (req, res) => {
    const healthProfId = req.params.healthProfId;

    // Query to delete the health professional from the HealthProfessionals table
    const query = `DELETE FROM HealthProfessionals WHERE healthProfId = ?`;

    // Execute the query
    db.query(query, [healthProfId], (err) => {
        if (err) {
            console.error("Error deleting health professional:", err);
            return res.status(500).send("Error deleting health professional");
        }

        res.status(200).send("Health professional deleted successfully");
    });
});

/**************************************************
 *                   Login Logic
 **************************************************/
// POST route for employee login
app.post("/api/employees/login", (req, res) => {
    const { email, password } = req.body;

    // Step 1: Find the employee by email to get the employeeId
    const employeeQuery = `SELECT employeeId FROM Employees WHERE email = ?`;
    db.query(employeeQuery, [email], (err, results) => {
        if (err) {
            console.error("Error querying employee:", err);
            return res.status(500).send("Error querying employee");
        }

        if (results.length === 0) {
            return res.status(401).send("Invalid email or password");
        }

        const employeeId = results[0].employeeId;

        // Step 2: Find the hashed password using the employeeId
        const passwordQuery = `SELECT password FROM EmployeePassword WHERE employeeId = ?`;
        db.query(passwordQuery, [employeeId], (err, results) => {
            if (err) {
                console.error("Error querying password:", err);
                return res.status(500).send("Error querying password");
            }

            if (results.length === 0) {
                return res.status(401).send("Invalid email or password");
            }

            const hashedPassword = results[0].password;

            // Compare the hashed password with the entered password
            bcrypt.compare(password, hashedPassword, (err, match) => {
                if (err) {
                    console.error("Error comparing passwords:", err);
                    return res.status(500).send("Error processing request");
                }

                if (!match) {
                    return res.status(401).send("Invalid email or password");
                }

                // Successful login
                res.status(200).json({
                    employeeId: employeeId,
                    message: "Login successful",
                });
            });
        });
    });
});

// POST route for health professional login
app.post("/api/health-professional/login", (req, res) => {
    const { email, password } = req.body;

    // Step 1: Find the health prof by email to get the healthProfId
    const healthProfQuery = `SELECT healthProfId FROM HealthProfessionals WHERE email = ?`;
    db.query(healthProfQuery, [email], (err, results) => {
        if (err) {
            console.error("Error querying health professional:", err);
            return res.status(500).send("Error querying health professional");
        }

        if (results.length === 0) {
            return res.status(401).send("Invalid email or password");
        }

        const healthProfId = results[0].healthProfId;

        // Step 2: Find the hashed password using the healthProfId
        const passwordQuery = `SELECT password FROM HealthProfessionalPassword WHERE healthProfId = ?`;
        db.query(passwordQuery, [healthProfId], (err, results) => {
            if (err) {
                console.error("Error querying password:", err);
                return res.status(500).send("Error querying password");
            }

            if (results.length === 0) {
                return res.status(401).send("Invalid email or password");
            }

            const hashedPassword = results[0].password;

            // Compare the hashed password with the entered password
            bcrypt.compare(password, hashedPassword, (err, match) => {
                if (err) {
                    console.error("Error comparing passwords:", err);
                    return res.status(500).send("Error processing request");
                }

                if (!match) {
                    return res.status(401).send("Invalid email or password");
                }

                // Successful login
                res.status(200).json({
                    healthProfId,
                    message: "Login successful",
                });
            });
        });
    });
});

/***********************************************************
 *     Logic to create and delete recommendations
 ***********************************************************/
// POST route to INSERT a mindfulness recommendation
app.post("/api/mindfulness-recommendations", (req, res) => {
    const { recommendationId, techniqueId, employeeId, supervisorId, healthProfId, recommendedAt } = req.body;
    // Insert the recommendation data into the mindfulness technique recommendations table
    const query = `INSERT INTO MindfulnessRecommendations (recommendationId, techniqueId, employeeId, supervisorId, healthProfId, recommendedAt) VALUES (?, ?, ?, ?, ?, ?)`;
    db.query(query, [recommendationId, techniqueId, employeeId, supervisorId, healthProfId, recommendedAt], (err) => {
        if (err) {
            console.error("Error inserting recommendation:", err);
            res.status(500).send("Error inserting recommendation");
            return;
        }
        res.status(200).send("Recommendation added successfully");
    });
    console.log("Inserting mindfulness recommendation:", req.body);
});

// DELETE route for mindfulness recommendation
app.delete("/api/mindfulnessrecommendations/:recommendationId", (req, res) => {
    const recommendationId = req.params.recommendationId;

    const query = `DELETE FROM mindfulnessrecommendations WHERE recommendationId = ?`;

    db.query(query, [recommendationId], (err) => {
        if (err) {
            console.error("Error deleting mindfulness recommendation:", err);
            return res.status(500).send("Error deleting mindfulness recommendation");
        }

        res.status(200).send("Mindfulness recommendation deleted successfully");
    });
});

// POST route to INSERT a time management tool
app.post("/api/time-management-recommendations", (req, res) => {
    const { recommendationId, toolId, employeeId, supervisorId, healthProfId, recommendedAt } = req.body;
    // Insert the recommendation data into the mindfulness tool recommendations table
    const query = `INSERT INTO TimeManagementRecommendations (recommendationId, toolId, employeeId, supervisorId, healthProfId, recommendedAt) VALUES (?, ?, ?, ?, ?, ?)`;
    db.query(query, [recommendationId, toolId, employeeId, supervisorId, healthProfId, recommendedAt], (err) => {
        if (err) {
            console.error("Error inserting recommendation:", err);
            res.status(500).send("Error inserting recommendation");
            return;
        }
        res.status(200).send("Recommendation added successfully");
    });
});

// DELETE route for time management recommendations
app.delete("/api/timemanagementrecommendations/:recommendationId", (req, res) => {
    const recommendationId = req.params.recommendationId;

    const query = `DELETE FROM timemanagementrecommendations WHERE recommendationId = ?`;

    db.query(query, [recommendationId], (err) => {
        if (err) {
            console.error("Error deleting time management recommendation:", err);
            return res.status(500).send("Error deleting time management recommendation");
        }

        res.status(200).send("Time management recommendation deleted successfully");
    });
});

/*************************************************************************
 *     Logic to get, update, create and delete activity logs
 *************************************************************************/
// POST route to INSERT a mindfulness activity log
app.post("/api/mindfulness-logs", (req, res) => {
    const { logId, comments, timestamp, techniqueId, employeeId } = req.body;

    // Insert the log data into the mindfulness activity log table
    const query = `INSERT INTO MindfulnessActivityLog (logId, comments, timestamp, techniqueId, employeeId) VALUES (?, ?, ?, ?, ?)`;
    db.query(query, [logId, comments, timestamp, techniqueId, employeeId], (err) => {
        if (err) {
            console.error("Error inserting log:", err);
            res.status(500).send("Error inserting log");
            return;
        }
        res.status(200).send("Log added successfully");
    });
});

// DELETE route for a specific mindfulness activity log
app.delete("/api/mindfulness-logs/:logId", (req, res) => {
    const logId = req.params.logId;
    const query = `DELETE FROM MindfulnessActivityLog WHERE logId = ?`;

    db.query(query, [logId], (err) => {
        if (err) {
            console.error("Error deleting mindfulness activity log:", err);
            return res.status(500).send("Error deleting mindfulness activity log");
        }
        res.status(200).send("Mindfulness activity log deleted successfully");
    });
});

// POST route to INSERT a time management activity log
app.post("/api/time-management-logs", (req, res) => {
    const { logId, comments, timestamp, toolId, employeeId } = req.body;

    // Insert the log data into the time management activity log table
    const query = `INSERT INTO TimeManagementActivityLog (logId, comments, timestamp, toolId, employeeId) VALUES (?, ?, ?, ?, ?)`;
    db.query(query, [logId, comments, timestamp, toolId, employeeId], (err) => {
        if (err) {
            console.error("Error inserting log:", err);
            res.status(500).send("Error inserting log");
            return;
        }
        res.status(200).send("Log added successfully");
    });
});

/// DELETE route for a specific time management activity log
app.delete("/api/time-management-logs/:logId", (req, res) => {
    const logId = req.params.logId;
    const query = `DELETE FROM TimeManagementActivityLog WHERE logId = ?`;

    db.query(query, [logId], (err) => {
        if (err) {
            console.error("Error deleting time management activity log:", err);
            return res.status(500).send("Error deleting time management activity log");
        }

        res.status(200).send("Time management activity log deleted successfully");
    });
});

// GET route to fetch wellness log for specific employee
app.get("/api/employee-wellness-logs/:employeeId", (req, res) => {
    const employeeId = req.params.employeeId;
    const query = `SELECT * FROM EmployeeWellnessLogs WHERE employeeId = ?`;
    db.query(query, [employeeId], (err, results) => {
        if (err) {
            console.error("Error querying wellness log", err);
            return res.status(500).send("Error querying wellness log");
        }

        // Return the employee's wellness log
        res.status(200).json(results);
    });
});

// GET route to fetch wellness logs for a supervisor's employees
app.get("/api/employee-wellness-logs/supervisor/:supervisorId", (req, res) => {
    const supervisorId = req.params.supervisorId;
    const query = `SELECT e.employeeId, e.firstName, e.lastName, wl.mood, wl.stress, wl.physicalSymptoms, wl.comments FROM Employees e JOIN EmployeeWellnessLogs wl ON e.employeeId = wl.employeeId WHERE e.supervisorId = ?`;
    db.query(query, [supervisorId], (err, results) => {
        if (err) {
            console.error("Error querying wellness logs for supervised employees", err);
            return res.status(500).send("Error querying wellness logs for supervised employees");
        }

        res.status(200).json(results);
    });
});

// GET route to fetch wellness logs for a health professionals's employees
app.get("/api/employee-wellness-logs/health-professional/:healthProfId", (req, res) => {
    const healthProfId = req.params.healthProfId;
    const query = `SELECT e.employeeId, e.firstName, e.lastName, wl.mood, wl.stress, wl.physicalSymptoms, wl.comments FROM Employees e JOIN EmployeeWellnessLogs wl ON e.employeeId = wl.employeeId WHERE e.healthProfId = ?`;
    db.query(query, [healthProfId], (err, results) => {
        if (err) {
            console.error("Error querying wellness logs for supervised employees", err);
            return res.status(500).send("Error querying wellness logs for supervised employees");
        }

        res.status(200).json(results);
    });
});

// GET request for employee for mindfulness activity logs for a specific employee
app.get("/api/mindfulness-logs/:employeeId", (req, res) => {
    const employeeId = req.params.employeeId;
    const query = `
        SELECT 
            logId, 
            comments, 
            timestamp, 
            techniqueId, 
            (SELECT title FROM MindfulnessTechniques WHERE techniqueId = MindfulnessActivityLog.techniqueId) AS techniqueName,
            (SELECT description FROM MindfulnessTechniques WHERE techniqueId = MindfulnessActivityLog.techniqueId) AS techniqueDescription
        FROM MindfulnessActivityLog 
        WHERE employeeId = ?`;
    db.query(query, [employeeId], (err, results) => {
        if (err) {
            console.error("Error querying mindfulness activity logs", err);
            return res.status(500).send("Error querying mindfulness activity logs");
        }
        res.status(200).json(results);
    });
});

// GET request for employee for time management logs for a specific employee
app.get("/api/time-management-logs/:employeeId", (req, res) => {
    const employeeId = req.params.employeeId;
    const query = `
        SELECT 
            logId, 
            comments, 
            timestamp,
            toolId, 
            (SELECT title FROM TimeManagementTools WHERE toolId = TimeManagementActivityLog.toolId) AS toolName,
            (SELECT description FROM TimeManagementTools WHERE toolId = TimeManagementActivityLog.toolId) AS toolDescription
        FROM TimeManagementActivityLog 
        WHERE employeeId = ?`;
    db.query(query, [employeeId], (err, results) => {
        if (err) {
            console.error("Error querying time management activity logs", err);
            return res.status(500).send("Error querying time management activity logs");
        }
        res.status(200).json(results);
    });
});

// EDIT request for employee for mindfulness activity logs 
app.put("/api/mindfulness-logs/:logId", (req, res) => {
    const logId = req.params.logId;
    const { comments } = req.body;

    const query = `UPDATE MindfulnessActivityLog SET comments = ? WHERE logId = ?`;
    db.query(query, [comments, logId], (err) => {
        if (err) {
            console.error("Error updating mindfulness activity log", err);
            return res.status(500).send("Error updating mindfulness activity log");
        }

        res.status(200).send("Mindfulness activity log updated successfully");
    });
});

// EDIT request for employee for time management logs 
app.put("/api/time-management-logs/:logId", (req, res) => {
    const logId = req.params.logId;
    const { comments } = req.body;

    const query = `UPDATE TimeManagementActivityLog SET comments = ? WHERE logId = ?`;
    db.query(query, [comments, logId], (err) => {
        if (err) {
            console.error("Error updating time management activity log", err);
            return res.status(500).send("Error updating time management activity log");
        }

        res.status(200).send("Time management activity log updated successfully");
    });
});

/***********************************************************
 *     Logic to create, update, and delete resources
 ***********************************************************/
// POST route to INSERT a mindfulness technique
app.post("/api/mindfulness-techniques", (req, res) => {
    const { techniqueId, title, description, duration, difficultyLevel, createdAt, healthProfId, link } = req.body;
    // Insert the data into the mindfulness technique table
    const query = `INSERT INTO MindfulnessTechniques (techniqueId, title, description, duration, difficultyLevel, createdAt, healthProfId, link) VALUES (?, ?, ?, ?, ?, ?, ?, ?)`;
    db.query(query, [techniqueId, title, description, duration, difficultyLevel, createdAt, healthProfId, link], (err) => {
        if (err) {
            console.error("Error inserting mindfulness technique:", err);
            res.status(500).send("Error inserting mindfulness technique");
            return;
        }
        res.status(200).send("Mindfulness technique added successfully");
    });
});

// DELETE route for a mindfulness techniques given a techniqueId
app.delete("/api/mindfulnesstechniques/:techniqueId", (req, res) => {
    const techniqueId = req.params.techniqueId;

    const query = `DELETE FROM mindfulnesstechniques WHERE techniqueId = ?`;

    db.query(query, [techniqueId], (err) => {
        if (err) {
            console.error("Error deleting mindfulness technique:", err);
            return res.status(500).send("Error deleting mindfulness technique");
        }

        res.status(200).send("Mindfulness technique deleted successfully");
    });
});

// POST route to INSERT a time management tool
app.post("/api/time-management-tools", (req, res) => {
    const { toolId, title, description, createdAt, healthProfId, link } = req.body;
    // Insert the data into the time management tools table
    const query = `INSERT INTO TimeManagementTools (toolId, title, description, createdAt, healthProfId, link) VALUES (?, ?, ?, ?, ?, ?)`;
    db.query(query, [toolId, title, description, createdAt, healthProfId, link], (err) => {
        if (err) {
            console.error("Error inserting time management tool:", err);
            res.status(500).send("Error inserting time management tool");
            return;
        }
        res.status(200).send("Time management tool added successfully");
    });
});

// DELETE route for a specific time management tool given a toolId
app.delete("/api/timemanagementtools/:toolId", (req, res) => {
    const toolId = req.params.toolId;

    const query = `DELETE FROM timemanagementtools WHERE toolId = ?`;

    db.query(query, [toolId], (err) => {
        if (err) {
            console.error("Error deleting time management tool:", err);
            return res.status(500).send("Error deleting time management tool");
        }

        res.status(200).send("Time management tool deleted successfully");
    });
});

/***********************************************************
 *  Logic to create, update, delete, and get wellness logs
 ***********************************************************/
// POST route to create (or replace) an employee wellness log
app.post("/api/employee-wellness-logs", (req, res) => {
    const { logId, stress, mood, comments, physicalSymptoms, recordedAt, employeeId } = req.body;

    // First, delete any existing wellness log for this employee
    const deleteQuery = `DELETE FROM EmployeeWellnessLogs WHERE employeeId = ?`;
    db.query(deleteQuery, [employeeId], (deleteErr) => {
        if (deleteErr) {
            console.error("Error deleting existing wellness log:", deleteErr);
            return res.status(500).send("Error deleting existing wellness log");
        }

        // Insert the new wellness log
        const insertQuery = `INSERT INTO EmployeeWellnessLogs (logId, stress, mood, comments, physicalSymptoms, recordedAt, employeeId) VALUES (?, ?, ?, ?, ?, ?, ?)`;
        db.query(insertQuery, [logId, stress, mood, comments, physicalSymptoms, recordedAt, employeeId], (insertErr) => {
            if (insertErr) {
                console.error("Error inserting employee wellness log:", insertErr);
                return res.status(500).send("Error inserting employee wellness log");
            }
            res.status(200).send("Employee wellness log added successfully");
        });
    });
});

// DELETE route for employee wellness log given an employeeId
app.delete("/api/employee-wellness-logs/:employeeId", (req, res) => {
    const employeeId = req.params.employeeId;
    const query = `DELETE FROM EmployeeWellnessLogs WHERE employeeId = ?`;
    db.query(query, [employeeId], (err, results) => {
        if (err) {
            console.error("Error deleting wellness log", err);
            return res.status(500).send("Error deleting wellness log");
        }
        // Return the employee's wellness log
        res.status(200).json(results);
    });
});

/***********************************************************
 *              GET requests to fetch Employees
 ***********************************************************/
// GET route to fetch a specific employee by employeeId
app.get("/api/employees/:employeeId", (req, res) => {
    const employeeId = req.params.employeeId;

    // Query to get the employee's profile
    const query = `SELECT employeeId, firstName, lastName, email, supervisorId, healthProfId FROM Employees WHERE employeeId = ?`;
    db.query(query, [employeeId], (err, results) => {
        if (err) {
            console.error("Error querying employee profile:", err);
            return res.status(500).send("Error querying employee profile");
        }

        if (results.length === 0) {
            return res.status(404).send("Employee not found");
        }

        // Return the employee profile
        res.status(200).json(results[0]);
    });
});

// GET route to fetch all employees
app.get("/api/employees", (req, res) => {
    const supervisorId = req.params.supervisorId;

    // Query to get all employees
    const query = `SELECT * FROM Employees`;
    db.query(query, [supervisorId], (err, results) => {
        if (err) {
            console.error("Error querying all employees:", err);
            return res.status(500).send("Error querying all employees");
        }

        // Return the list of supervised employees
        res.status(200).json(results);
    });
});

// GET route to fetch the employees supervised by a specific employee
app.get("/api/employees/supervised/:supervisorId", (req, res) => {
    const supervisorId = req.params.supervisorId;

    // Query to get employees supervised by the given supervisorId
    const query = `SELECT employeeId, firstName, lastName, email FROM Employees WHERE supervisorId = ?`;
    db.query(query, [supervisorId], (err, results) => {
        if (err) {
            console.error("Error querying supervised employees:", err);
            return res.status(500).send("Error querying supervised employees");
        }

        // Return the list of supervised employees
        res.status(200).json(results);
    });
});

// GET route to fetch the employees supervised by a specific health professional
app.get("/api/health-professionals/supervised-professional/:healthProfId", (req, res) => {
    const healthProfId = req.params.healthProfId;

    // Query to get employees supervised by the given healthProfId
    const query = `SELECT employeeId, firstName, lastName, email FROM Employees WHERE healthProfId = ?`;
    db.query(query, [healthProfId], (err, results) => {
        if (err) {
            console.error("Error querying supervised employees:", err);
            return res.status(500).send("Error querying supervised employees");
        }

        // Return the list of supervised employees
        res.status(200).json(results);
    });
});

/***********************************************************
 *        GET requests to fetch health professionals
 ***********************************************************/
// GET route to fetch a specific health professional by healthProfId
app.get("/api/health-professionals/:healthProfId", (req, res) => {
    const healthProfId = req.params.healthProfId;

    // Query to get the healthProf's profile
    const query = `SELECT healthProfId, firstName, lastName, email, specialization FROM HealthProfessionals WHERE healthProfId = ?`;
    db.query(query, [healthProfId], (err, results) => {
        if (err) {
            console.error("Error querying health professional profile:", err);
            return res.status(500).send("Error querying health professional profile");
        }

        if (results.length === 0) {
            return res.status(404).send("health professional not found");
        }

        // Return the health professional profile
        res.status(200).json(results[0]);
    });
});

// GET route to fetch all health professionals
app.get("/api/health-professionals", (req, res) => {
    const supervisorId = req.params.supervisorId;

    // Query to get all employees
    const query = `SELECT * FROM HealthProfessionals`;
    db.query(query, [supervisorId], (err, results) => {
        if (err) {
            console.error("Error querying all health professionals:", err);
            return res.status(500).send("Error querying all health professionals");
        }

        // Return the list of supervised employees
        res.status(200).json(results);
    });
});

/***********************************************************
 *     GET requests for Recommendations by Supervisor, Employee or Health Professional
 ***********************************************************/

// GET route for mindfulness recommendations by supervisor ID
app.get("/api/mindfulness-recommendations/supervisor/:supervisorId", (req, res) => {
    const supervisorId = req.params.supervisorId;
    const query = `
        SELECT * FROM MindfulnessRecommendations
        WHERE supervisorId = ?
    `;
    db.query(query, [supervisorId], (err, results) => {
        if (err) {
            console.error("Error querying mindfulness recommendations:", err);
            return res.status(500).send("Error querying mindfulness recommendations");
        }
        res.status(200).json(results);
    });
});

// GET route for time management recommendations by supervisor ID
app.get("/api/time-management-recommendations/supervisor/:supervisorId", (req, res) => {
    const supervisorId = req.params.supervisorId;
    const query = `
        SELECT * FROM TimeManagementRecommendations
        WHERE supervisorId = ?
    `;
    db.query(query, [supervisorId], (err, results) => {
        if (err) {
            console.error("Error querying time management recommendations:", err);
            return res.status(500).send("Error querying time management recommendations");
        }
        res.status(200).json(results);
    });
});

// GET route for health professional recommendations (both mindfulness and time management)
app.get("/api/recommendations/health-professional/:healthProfId", (req, res) => {
    const healthProfId = req.params.healthProfId;
    const query = `
        SELECT * FROM MindfulnessRecommendations WHERE healthProfId = ?
        UNION ALL
        SELECT * FROM TimeManagementRecommendations WHERE healthProfId = ?
    `;
    db.query(query, [healthProfId, healthProfId], (err, results) => {
        if (err) {
            console.error("Error querying health professional recommendations:", err);
            return res.status(500).send("Error querying health professional recommendations");
        }
        res.status(200).json(results);
    });
});

app.get("/api/recommendations/for-user/:employeeId", (req, res) => {
    const employeeId = req.params.employeeId;
    const query = `
        SELECT 
            'mindfulness' as type, 
            MindfulnessRecommendations.recommendationId,
            MindfulnessTechniques.techniqueId,
            MindfulnessTechniques.title, 
            MindfulnessTechniques.description, 
            IFNULL(CONCAT(recommender.firstName, ' ', recommender.lastName), 'Unknown') AS recommender
        FROM MindfulnessRecommendations
        JOIN MindfulnessTechniques ON MindfulnessRecommendations.techniqueId = MindfulnessTechniques.techniqueId
        LEFT JOIN Employees as recommender ON MindfulnessRecommendations.supervisorId = recommender.employeeId
        WHERE MindfulnessRecommendations.employeeId = ?

        UNION ALL

        SELECT
            'time-management' as type,
            TimeManagementRecommendations.recommendationId,
            TimeManagementTools.toolId,
            TimeManagementTools.title, 
            TimeManagementTools.description, 
            IFNULL(CONCAT(recommender.firstName, ' ', recommender.lastName), 'Unknown') AS recommender
        FROM TimeManagementRecommendations
        JOIN TimeManagementTools ON TimeManagementRecommendations.toolId = TimeManagementTools.toolId
        LEFT JOIN Employees as recommender ON TimeManagementRecommendations.supervisorId = recommender.employeeId
        WHERE TimeManagementRecommendations.employeeId = ?
    `;

    db.query(query, [employeeId, employeeId], (err, results) => {
        if (err) {
            console.error("Error fetching user recommendations:", err);
            return res.status(500).send("Error fetching user recommendations");
        }
        res.status(200).json(results);
    });
});


// GET route for recommendations made by a specific supervisor or health professional
app.get("/api/recommendations/made-by/:userId", (req, res) => {
    const userId = req.params.userId;
    const query = `
        SELECT 
            'mindfulness' as type,
            MindfulnessRecommendations.recommendationId,
            MindfulnessTechniques.techniqueId,
            MindfulnessTechniques.title,
            MindfulnessTechniques.description,
            CONCAT(recipient.firstName, ' ', recipient.lastName) AS recipient,
            CONCAT(recommender.firstName, ' ', recommender.lastName) AS recommender
        FROM MindfulnessRecommendations
        JOIN MindfulnessTechniques ON MindfulnessRecommendations.techniqueId = MindfulnessTechniques.techniqueId
        LEFT JOIN Employees as recommender ON MindfulnessRecommendations.supervisorId = recommender.employeeId
        LEFT JOIN Employees as recipient ON MindfulnessRecommendations.employeeId = recipient.employeeId
        WHERE MindfulnessRecommendations.supervisorId = ? OR MindfulnessRecommendations.healthProfId = ?

        UNION ALL

        SELECT 
            'time-management' as type,
            TimeManagementRecommendations.recommendationId,
            TimeManagementTools.toolId,
            TimeManagementTools.title,
            TimeManagementTools.description,
            CONCAT(recipient.firstName, ' ', recipient.lastName) AS recipient,
            CONCAT(recommender.firstName, ' ', recommender.lastName) AS recommender
        FROM TimeManagementRecommendations
        JOIN TimeManagementTools ON TimeManagementRecommendations.toolId = TimeManagementTools.toolId
        LEFT JOIN Employees as recommender ON TimeManagementRecommendations.supervisorId = recommender.employeeId
        LEFT JOIN Employees as recipient ON TimeManagementRecommendations.employeeId = recipient.employeeId
        WHERE TimeManagementRecommendations.supervisorId = ? OR TimeManagementRecommendations.healthProfId = ?
    `;

    db.query(query, [userId, userId, userId, userId], (err, results) => {
        if (err) {
            console.error("Error fetching recommendations made by user:", err);
            return res.status(500).send("Error fetching recommendations made by user");
        }
        res.status(200).json(results);
    });
});


/***********************************************************
 *                 GET requests for logs
 ***********************************************************/
// GET route to fetch wellness log for specific employee
app.get("/api/employee-wellness-logs/:employeeId", (req, res) => {
    const employeeId = req.params.employeeId;
    const query = `SELECT * FROM EmployeeWellnessLogs WHERE employeeId = ?`;
    db.query(query, [employeeId], (err, results) => {
        if (err) {
            console.error("Error querying wellness log", err);
            return res.status(500).send("Error querying wellness log");
        }

        // Return the employee's wellness log
        res.status(200).json(results);
    });
});

// GET route to fetch wellness logs for a supervisor's employees
app.get("/api/employee-wellness-logs/supervisor/:supervisorId", (req, res) => {
    const supervisorId = req.params.supervisorId;
    const query = `SELECT e.employeeId, e.firstName, e.lastName, wl.mood, wl.stress, wl.physicalSymptoms, wl.comments FROM Employees e JOIN EmployeeWellnessLogs wl ON e.employeeId = wl.employeeId WHERE e.supervisorId = ?`;
    db.query(query, [supervisorId], (err, results) => {
        if (err) {
            console.error("Error querying wellness logs for supervised employees", err);
            return res.status(500).send("Error querying wellness logs for supervised employees");
        }

        res.status(200).json(results);
    });
});

// GET route to fetch wellness logs for a health professionals's employees
app.get("/api/employee-wellness-logs/health-professional/:healthProfId", (req, res) => {
    const healthProfId = req.params.healthProfId;
    const query = `SELECT e.employeeId, e.firstName, e.lastName, wl.mood, wl.stress, wl.physicalSymptoms, wl.comments FROM Employees e JOIN EmployeeWellnessLogs wl ON e.employeeId = wl.employeeId WHERE e.healthProfId = ?`;
    db.query(query, [healthProfId], (err, results) => {
        if (err) {
            console.error("Error querying wellness logs for supervised employees", err);
            return res.status(500).send("Error querying wellness logs for supervised employees");
        }

        res.status(200).json(results);
    });
});

/***********************************************************
 *        GET requests for all resources (Tools & Techniques)
 ***********************************************************/

// GET all time management tools
app.get("/api/time-management-tools", (req, res) => {
    const query = "SELECT * FROM TimeManagementTools";
    db.query(query, (err, results) => {
        if (err) {
            console.error("Error fetching time management tools:", err);
            return res.status(500).send("Error fetching time management tools");
        }
        res.status(200).json(results);
    });
});

// GET all mindfulness techniques
app.get("/api/mindfulness-techniques", (req, res) => {
    const query = "SELECT * FROM MindfulnessTechniques";
    db.query(query, (err, results) => {
        if (err) {
            console.error("Error fetching mindfulness techniques:", err);
            return res.status(500).send("Error fetching mindfulness techniques");
        }
        res.status(200).json(results);
    });
});

/***********************************************************
 *        GET requests for specific resources (Tool/Technique)
 ***********************************************************/

// GET a specific time management tool by toolId
app.get("/api/time-management-tools/:toolId", (req, res) => {
    const toolId = req.params.toolId;
    const query = "SELECT * FROM TimeManagementTools WHERE toolId = ?";
    db.query(query, [toolId], (err, results) => {
        if (err) {
            console.error("Error fetching time management tool:", err);
            return res.status(500).send("Error fetching time management tool");
        }
        if (results.length === 0) {
            return res.status(404).send("Time management tool not found");
        }
        res.status(200).json(results[0]);
    });
});

// GET a specific mindfulness technique by techniqueId
app.get("/api/mindfulness-techniques/:techniqueId", (req, res) => {
    const techniqueId = req.params.techniqueId;
    const query = "SELECT * FROM MindfulnessTechniques WHERE techniqueId = ?";
    db.query(query, [techniqueId], (err, results) => {
        if (err) {
            console.error("Error fetching mindfulness technique:", err);
            return res.status(500).send("Error fetching mindfulness technique");
        }
        if (results.length === 0) {
            return res.status(404).send("Mindfulness technique not found");
        }
        res.status(200).json(results[0]);
    });
});

/***********************************************************
 *        PUT requests for specific resources (Tool/Technique)
 ***********************************************************/

// PUT request to edit a specific time management tool
app.put("/api/time-management-tools/:toolId", (req, res) => {
    const toolId = req.params.toolId; // Extract toolId from URL
    const { title, description, link } = req.body; // Extract fields from request body

    // Build the SQL query dynamically based on provided fields
    const updates = [];
    const values = [];

    // Check each field and add to the updates array if present
    if (title) {
        updates.push("title = ?");
        values.push(title);
    }
    if (description) {
        updates.push("description = ?");
        values.push(description);
    }
    if (link) {
        updates.push("link = ?");
        values.push(link);
    }

    // Ensure there's something to update
    if (updates.length === 0) {
        return res.status(400).send("No fields to update");
    }

    values.push(toolId); // Add toolId to the values array for the WHERE clause

    // Construct the SQL query
    const query = `UPDATE timemanagementtools SET ${updates.join(", ")} WHERE toolId = ?`;

    db.query(query, values, (err) => {
        if (err) {
            console.error("Error updating time management tool:", err);
            return res.status(500).send("Error updating time management tool");
        }
        res.status(200).send("Time management tool updated successfully");
    });
});

// PUT request to edit a specific mindfulness technique
app.put("/api/mindfulness-techniques/:techniqueId", (req, res) => {
    const techniqueId = req.params.techniqueId; // Extract techniqueId from URL
    const { title, description, duration, difficultyLevel, link } = req.body; // Extract fields from request body

    // Build the SQL query dynamically based on provided fields
    const updates = [];
    const values = [];

    // Check each field and add to the updates array if present
    if (title) {
        updates.push("title = ?");
        values.push(title);
    }
    if (description) {
        updates.push("description = ?");
        values.push(description);
    }
    if (duration !== undefined) {
        updates.push("duration = ?");
        values.push(duration);
    }
    if (difficultyLevel !== undefined) {
        updates.push("difficultyLevel = ?");
        values.push(difficultyLevel);
    }
    if (link) {
        updates.push("link = ?");
        values.push(link);
    }

    // Ensure there's something to update
    if (updates.length === 0) {
        return res.status(400).send("No fields to update");
    }

    values.push(techniqueId); // Add techniqueId to the values array for the WHERE clause

    // Construct the SQL query
    const query = `UPDATE mindfulnessTechniques SET ${updates.join(", ")} WHERE techniqueId = ?`;

    db.query(query, values, (err) => {
        if (err) {
            console.error("Error updating mindfulness technique:", err);
            return res.status(500).send("Error updating mindfulness technique");
        }
        res.status(200).send("Mindfulness technique updated successfully");
    });
});


/***********************************************************
 *                 Reporting Facility
 ***********************************************************/

// GET route to fetch mindfulness log counts for a specific employee
app.get("/api/mindfulness-logs-count/:employeeId", (req, res) => {
    const employeeId = req.params.employeeId;
    const query = `
        SELECT techniqueId, COUNT(*) AS logCount
        FROM MindfulnessActivityLog
        WHERE employeeId = ?
        GROUP BY techniqueId
    `;
    db.query(query, [employeeId], (err, results) => {
        if (err) {
            console.error("Error querying mindfulness log count", err);
            return res.status(500).send("Error querying mindfulness log count");
        }
        res.status(200).json(results); // Return the counts grouped by techniqueId
    });
});

// GET route to fetch time management log counts for a specific employee
app.get("/api/time-management-logs-count/:employeeId", (req, res) => {
    const employeeId = req.params.employeeId;
    const query = `
        SELECT toolId, COUNT(*) AS logCount
        FROM TimeManagementActivityLog
        WHERE employeeId = ?
        GROUP BY toolId
    `;
    db.query(query, [employeeId], (err, results) => {
        if (err) {
            console.error("Error querying time management log count", err);
            return res.status(500).send("Error querying time management log count");
        }
        res.status(200).json(results); // Return the counts grouped by toolId
    });
});

// GET route to fetch recommendation counts for a specific employee and health professional
app.get("/api/recommendations-count/:employeeId/:healthProfId", (req, res) => {
    const { employeeId, healthProfId } = req.params;
    const query = `
        SELECT 
            'recommendationsForYou' AS type,
            employeeId,
            COUNT(*) AS count
        FROM MindfulnessRecommendations
        WHERE employeeId = ?
        GROUP BY employeeId
        UNION ALL
        SELECT 
            'recommendationsByYou' AS type,
            supervisorId,
            COUNT(*) AS count
        FROM MindfulnessRecommendations
        WHERE (supervisorId = ? OR healthProfId = ? OR employeeId = ?)
        GROUP BY supervisorId
    `;
    db.query(query, [employeeId, healthProfId, healthProfId, employeeId], (err, results) => {
        if (err) {
            console.error("Error querying recommendation counts", err);
            return res.status(500).send("Error querying recommendation counts");
        }
        res.status(200).json(results); // Return the counts grouped by type
    });
});

/****************************************************************************************/

// Start the Express server
app.listen(3000, () => {
    console.log("Server running on http://localhost:3000");
});
