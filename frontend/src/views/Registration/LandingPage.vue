<template>
    <div class="landing-page-container">
        <div class="content">
            <h1>Welcome!</h1>
            <h1>Please Select Your Role</h1>
            <div class="buttons">
                <button class="btn btn-employee" @click="goToEmployeeRegister">I am an employee</button>
                <button class="btn btn-health-prof" @click="goToHealthProfRegister">I am a health professional</button>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "LandingPage",
    methods: {
        goToEmployeeRegister() {
            this.$router.push("/register-employee");
        },
        goToHealthProfRegister() {
            this.$router.push("/register-health-prof");
        },
    },
};
</script>

<style scoped>
.landing-page-container {
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: #f8f9fa;
    font-family: 'Arial', sans-serif;
}

.content {
    text-align: center;
    max-width: 500px;
    padding: 20px;
    background-color: white;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

h1 {
    font-size: 2rem;
    color: #333;
    margin-bottom: 20px;
    font-weight: 600;
}

.buttons {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

button {
    padding: 12px 20px;
    font-size: 1rem;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.3s ease;
}

.btn-employee {
    background-color: #007bff;
    color: white;
}

.btn-employee:hover {
    background-color: #0056b3;
    transform: translateY(-2px);
    color: white;
}

.btn-health-prof {
    background-color: #28a745;
    color: white;
}

.btn-health-prof:hover {
    background-color: #218838;
    transform: translateY(-2px);
    color: white;
}

button:focus {
    outline: none;
}
</style>
