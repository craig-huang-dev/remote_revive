<template>
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card shadow-sm p-4" style="max-width: 500px; width: 100%;">
            <h2 class="text-center mb-4">Edit My Health Professional Profile</h2>
            <form @submit.prevent="submitForm">
                <!-- First Name Field -->
                <div class="mb-3">
                    <label for="firstName" class="form-label">First Name</label>
                    <input type="text" id="firstName" v-model="form.firstName" class="form-control" required />
                </div>

                <!-- Last Name Field -->
                <div class="mb-3">
                    <label for="lastName" class="form-label">Last Name</label>
                    <input type="text" id="lastName" v-model="form.lastName" class="form-control" required />
                </div>

                <!-- Email Field -->
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" id="email" v-model="form.email" class="form-control" required />
                </div>

                <!-- Specialization Field -->
                <div class="mb-3">
                    <label for="specialization" class="form-label">Specialization</label>
                    <input type="text" id="specialization" v-model="form.specialization" class="form-control"
                        required />
                </div>

                <!-- Password Field -->
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" id="password" v-model="form.password" class="form-control" />
                </div>

                <!-- Form Action Buttons -->
                <div class="d-flex justify-content-between mt-4">
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
            <button type="button" class="btn btn-secondary cancel-btn mt-3" @click="cancel">Return to Profile</button>
        </div>
    </div>

    <!-- Delete Account Button -->
    <div class="delete-btn-container d-flex justify-content-end position-fixed bottom-0 end-0 mb-3 me-3">
        <button type="button" class="btn btn-danger btn-sm" @click="deleteAccount">
            Delete Account
        </button>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    mounted() {
        this.checkUserPermission();
        this.fetchHealthProfessionalProfile();
    },
    data() {
        return {
            form: {
                firstName: "",
                lastName: "",
                email: "",
                specialization: "",
                password: "",
            },
            healthProfData: {},
        };
    },
    methods: {
        checkUserPermission() {
            const healthProfIdFromRoute = this.$route.params.healthProfId;
            const healthProfIdFromLocalStorage = localStorage.getItem('healthProfId');
            const employeeIdFromLocalStorage = localStorage.getItem('employeeId');
            const adminId = '3f5676fe-775e-4296-b6a3-7817820e0942';

            if (healthProfIdFromRoute !== healthProfIdFromLocalStorage && employeeIdFromLocalStorage !== adminId) {
                alert("You are not authorized to edit this profile.");
                this.$router.push('/dashboard');
            }
        },
        cancel() {
            const healthProfId = this.$route.params.healthProfId;
            this.$router.push(`/health-professional/${healthProfId}`);
        },
        submitForm() {
            // GET the current health professional ID
            const healthProfId = this.$route.params.healthProfId;

            const payload = {
                healthProfId,
                firstName: this.form.firstName,
                lastName: this.form.lastName,
                email: this.form.email,
                specialization: this.form.specialization,
                password: this.form.password,
            };

            console.log("Submitting form:", payload);

            axios.put(`http://localhost:3000/api/health-professional/${healthProfId}`, payload)
                .then(response => {
                    console.log(response.data);
                    alert('Health Professional profile updated successfully!');
                })
                .catch(error => {
                    console.error(error);
                    alert('Error editing health professional');
                });
        },
        deleteAccount() {
            const healthProfId = this.$route.params.healthProfId;
            if (!healthProfId) {
                alert("Health professional ID not found in local storage.");
                return;
            }

            // Confirm the action with the user
            if (confirm("Are you sure you want to delete your account? This action cannot be undone.")) {
                axios.delete(`http://localhost:3000/api/health-professionals/${healthProfId}`)
                    .then(response => {
                        console.log(response.data);
                        alert('Account deleted successfully!');

                        // Clear localStorage and navigate to the root
                        localStorage.removeItem('healthProfId');
                        this.$router.push('/');

                        if (healthProfId == localStorage.getItem('healthProfId')) {
                            localStorage.removeItem('healthProfId');
                            this.$router.push('/');
                        }
                        else {
                            this.$router.push('/health-professional-lookup');
                        }
                    })
                    .catch(error => {
                        console.error(error);
                        alert('Error deleting account');
                    });
            }
        },
        fetchHealthProfessionalProfile() {
            const healthProfId = this.$route.params.healthProfId;
            if (!healthProfId) return;

            fetch(`http://localhost:3000/api/health-professionals/${healthProfId}`)
                .then(response => response.json())
                .then(data => {
                    this.form.firstName = data.firstName;
                    this.form.lastName = data.lastName;
                    this.form.email = data.email;
                    this.form.specialization = data.specialization;
                })
                .catch(error => {
                    console.error("Error fetching health professional profile:", error);
                });
        },
    },
};
</script>

<style scoped>
.container {
    height: 100vh;
}

.card {
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.form-label {
    font-weight: 600;
}

button {
    width: 100%;
}

button:focus {
    box-shadow: none;
}

.cancel-btn {
    margin-top: 15px;
}

.delete-btn-container {
    z-index: 100;
}
</style>
