<template>

    <!-- Back to Landing Page Button -->
    <router-link to="/" class="back-button">
        <button class="btn-back">Back to role select</button>
    </router-link>

    <div class="login-container">
        <div class="card">
            <h2 class="text-center">Health Professional Login</h2>
            <form @submit.prevent="submitForm">
                <div class="form-group">
                    <label for="email" class="form-label">Email <span class="required">*</span></label>
                    <input type="email" id="email" v-model="form.email" class="form-control" required />
                </div>

                <div class="form-group">
                    <label for="password" class="form-label">Password <span class="required">*</span></label>
                    <input type="password" id="password" v-model="form.password" class="form-control" required />
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Login</button>
                </div>
            </form>

            <div class="signup-link">
                <p>Don't have an account yet?</p>
                <router-link to="/register-health-prof">
                    <button class="btn btn-link">Register</button>
                </router-link>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    data() {
        return {
            form: {
                email: "",
                password: "",
            },
        };
    },
    methods: {
        submitForm() {
            const payload = {
                email: this.form.email,
                password: this.form.password,
            };

            console.log("Submitting form:", payload);
            axios.post('http://localhost:3000/api/health-professional/login', payload)
                .then(response => {
                    console.log(response.data);
                    // Store healthProfId in local storage (or session storage)
                    localStorage.setItem('healthProfId', response.data.healthProfId);
                    alert('Login successful!');
                    this.$router.push('/dashboard');
                })
                .catch(error => {
                    console.error(error);
                    alert('Invalid email or password');
                });
        },
    },
};
</script>

<style scoped>
.login-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-color: #f7f7f7;
}

.card {
    background-color: white;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 500px;
}

h2 {
    font-size: 1.8rem;
    font-weight: bold;
    margin-bottom: 20px;
    text-align: center;
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
    padding: 12px;
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

.signup-link {
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
