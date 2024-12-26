<template>

    <!-- Back to Landing Page Button -->
    <router-link to="/" class="back-button">
        <button class="btn-back">Back to role select</button>
    </router-link>

    <div class="registration-container">
        <div class="card">
            <h2 class="text-center">Employee Registration</h2>
            <form @submit.prevent="submitForm">
                <div class="form-group">
                    <label for="firstName" class="form-label">First Name <span class="required">*</span></label>
                    <input type="text" id="firstName" v-model="form.firstName" class="form-control" required />
                </div>

                <div class="form-group">
                    <label for="lastName" class="form-label">Last Name <span class="required">*</span></label>
                    <input type="text" id="lastName" v-model="form.lastName" class="form-control" required />
                </div>

                <div class="form-group">
                    <label for="email" class="form-label">Email <span class="required">*</span></label>
                    <input type="email" id="email" v-model="form.email" class="form-control" required />
                </div>

                <div class="form-group">
                    <label for="password" class="form-label">Password <span class="required">*</span></label>
                    <input type="password" id="password" v-model="form.password" class="form-control" required />
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Register</button>
                </div>
            </form>

            <div class="login-link">
                <p>Already have an account?</p>
                <router-link to="/login-employee">
                    <button class="btn btn-link">Login</button>
                </router-link>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios';
import { v4 as uuidv4 } from 'uuid';

export default {
    data() {
        return {
            form: {
                firstName: "",
                lastName: "",
                email: "",
                supervisorId: "",
                healthProfId: "",
                password: "",
            },
        };
    },
    methods: {
        submitForm() {
            // Generate a unique employee ID
            const employeeId = uuidv4();
            const payload = {
                employeeId,
                firstName: this.form.firstName,
                lastName: this.form.lastName,
                email: this.form.email,
                supervisorId: this.form.supervisorId || null,
                healthProfId: this.form.healthProfId || null,
                password: this.form.password,
            };

            console.log("Submitting form:", payload);
            // POST request to register the employee
            axios.post('http://localhost:3000/api/employees', payload)
                .then(response => {
                    console.log(response.data);
                    alert('Employee added successfully!');
                    this.clearForm();
                })
                .catch(error => {
                    console.error(error);
                    alert('Error adding employee');
                });
        },
        clearForm() {
            // Reset form fields
            this.form = {
                firstName: "",
                lastName: "",
                email: "",
                supervisorId: "",
                healthProfId: "",
                password: "",
            };
        },
    },
};
</script>

<style scoped>
.registration-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-color: #f9f9f9;
}

.card {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    max-width: 400px;
    width: 100%;
}

.form-group {
    margin-bottom: 20px;
}

.form-label {
    font-size: 1rem;
    font-weight: 600;
    margin-bottom: 8px;
    display: block;
    color: #333;
}

.required {
    color: red;
}

.form-control {
    width: 100%;
    padding: 10px;
    font-size: 1rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    background-color: #f9f9f9;
    color: #333;
}

.form-control:focus {
    border-color: #007bff;
    outline: none;
    background-color: #fff;
}

.form-actions {
    display: flex;
    justify-content: center;
}

button {
    width: 100%;
    padding: 12px;
    font-size: 1rem;
    border-radius: 4px;
    border: none;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.3s ease;
}

.btn-primary {
    background-color: #007bff;
    color: white;
}

.btn-primary:hover {
    background-color: #0056b3;
    transform: translateY(-2px);
}

.btn-link {
    background-color: transparent;
    color: #007bff;
    text-decoration: none;
}

.btn-link:hover {
    color: #0056b3;
}

.login-link {
    text-align: center;
    margin-top: 20px;
}

.btn-back {
    color: #007bff;
    padding: 8px 16px;
    font-size: 1.4rem;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.3s ease;
}

.btn-back:hover {
    background-color: #007bff;
    color: #ffffff;
    transform: translateY(-2px);
}
</style>
