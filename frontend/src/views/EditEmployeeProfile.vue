<template>
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card shadow-sm p-4" style="max-width: 500px; width: 100%;">
            <h2 class="text-center mb-4">Edit My Employee Profile</h2>
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

                <!-- Password Field -->
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" id="password" v-model="form.password" class="form-control" />
                </div>

                <!-- Supervisor Section -->
                <div class="mb-3">
                    <label for="supervisor" class="form-label">Supervisor</label>
                    <div>
                        <span v-if="supervisorData">
                            {{ supervisorData.firstName }} {{ supervisorData.lastName }}
                            <button type="button" class="btn btn-link text-danger p-0" @click="removeSupervisor">
                                Remove
                            </button>
                        </span>
                        <span v-else>
                            None
                        </span>
                    </div>
                </div>

                <!-- Health Professional Section -->
                <div class="mb-3">
                    <label for="healthProfessional" class="form-label">Health Professional</label>
                    <div>
                        <span v-if="healthProfData">
                            {{ healthProfData.firstName }} {{ healthProfData.lastName }}
                            <button type="button" class="btn btn-link text-danger p-0"
                                @click="removeHealthProfessional">
                                Remove
                            </button>
                        </span>
                        <span v-else>
                            None
                        </span>
                    </div>
                </div>

                <!-- Form Action Buttons -->
                <div class="d-flex justify-content-between mt-4">
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
            <button type="button" class="btn btn-secondary cancel-btn" @click="cancel">
                Return to Profile</button>
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
        this.fetchEmployeeProfile();
    },
    data() {
        return {
            form: {
                firstName: "",
                lastName: "",
                email: "",
                password: "",
                supervisorId: null,
                healthProfId: null,
            },
            employeeData: {},
            supervisorData: null, // Holds supervisor data
            healthProfData: null, // Holds health professional data
        };
    },
    methods: {
        checkUserPermission() {
            const employeeIdFromRoute = this.$route.params.employeeId;
            const employeeIdFromLocalStorage = localStorage.getItem('employeeId');
            const adminId = '3f5676fe-775e-4296-b6a3-7817820e0942';

            if (employeeIdFromRoute !== employeeIdFromLocalStorage && employeeIdFromLocalStorage !== adminId) {
                alert("You are not authorized to edit this profile.");
                this.$router.push('/dashboard');
            }
        },
        submitForm() {
            const employeeId = this.$route.params.employeeId;

            // If supervisorId or healthProfId is null (due to removal), make sure we send null to the backend
            const payload = {
                employeeId,
                firstName: this.form.firstName,
                lastName: this.form.lastName,
                email: this.form.email,
                supervisorId: this.form.supervisorId === null ? null : this.form.supervisorId,
                healthProfId: this.form.healthProfId === null ? null : this.form.healthProfId,
            };
            // Include the password if it is provided
            if (this.form.password) {
                payload.password = this.form.password;
            }

            console.log("Submitting form:", payload);

            axios.put(`http://localhost:3000/api/employees/${employeeId}`, payload)
                .then(response => {
                    console.log(response.data);
                    alert('Employee profile updated successfully!');
                })
                .catch(error => {
                    console.error(error);
                    alert('Error editing employee');
                });
        },
        cancel() {
            const employeeId = this.$route.params.employeeId;
            this.$router.push(`/employees/${employeeId}`);
        },

        deleteAccount() {
            const employeeId = this.$route.params.employeeId;
            if (!employeeId) {
                alert("Employee ID not found in local storage.");
                return;
            }

            // Confirm the action with the user
            if (confirm("Are you sure you want to delete this account? This action cannot be undone.")) {
                axios.delete(`http://localhost:3000/api/employees/${employeeId}`)
                    .then(response => {
                        console.log(response.data);
                        alert('Account deleted successfully!');

                        // Clear localStorage and navigate to the root
                        if (employeeId == localStorage.getItem('employeeId')) {
                            localStorage.removeItem('employeeId');
                            this.$router.push('/');
                        }
                        else {
                            this.$router.push('/supervisor-lookup');
                        }
                    })
                    .catch(error => {
                        console.error(error);
                        alert('Error deleting account');
                    });
            }
        },

        fetchEmployeeProfile() {
            const employeeId = this.$route.params.employeeId;
            if (!employeeId) return;

            fetch(`http://localhost:3000/api/employees/${employeeId}`)
                .then(response => response.json())
                .then(data => {
                    this.employeeData = data;
                    this.form.firstName = data.firstName;
                    this.form.lastName = data.lastName;
                    this.form.email = data.email;
                    this.form.supervisorId = data.supervisorId || null;
                    this.form.healthProfId = data.healthProfId || null;

                    if (data.supervisorId) {
                        this.fetchSupervisorProfile(data.supervisorId);
                    }
                    if (data.healthProfId) {
                        this.fetchHealthProfProfile(data.healthProfId);
                    }
                })
                .catch(error => {
                    console.error("Error fetching employee profile:", error);
                });
        },

        fetchSupervisorProfile(supervisorId) {
            fetch(`http://localhost:3000/api/employees/${supervisorId}`)
                .then(response => response.json())
                .then(data => {
                    this.supervisorData = data;
                })
                .catch(error => {
                    console.error("Error fetching supervisor profile:", error);
                });
        },

        fetchHealthProfProfile(healthProfId) {
            fetch(`http://localhost:3000/api/health-professionals/${healthProfId}`)
                .then(response => response.json())
                .then(data => {
                    this.healthProfData = data;
                })
                .catch(error => {
                    console.error("Error fetching health professional profile:", error);
                });
        },

        // Remove supervisor
        removeSupervisor() {
            this.form.supervisorId = null;
            this.supervisorData = null; // Clear the supervisor data
        },

        // Remove health professional
        removeHealthProfessional() {
            this.form.healthProfId = null;
            this.healthProfData = null; // Clear the health professional data
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
