<template>
    <div class="container mt-5">
        <div v-if="employeeData" class="card shadow-sm p-4 mb-4">
            <h2 class="text-center mb-3">{{ employeeData.firstName }} {{ employeeData.lastName }}</h2>
            <p class="text-center text-muted mb-4">Employee</p>

            <!-- Employee Info -->
            <div class="mb-3">
                <p class="mb-1"><strong>Email:</strong> {{ employeeData.email }}</p>
            </div>

            <!-- Supervisor Section -->
            <div class="mb-3">
                <p class="mb-1"><strong>Supervisor:</strong></p>
                <div class="d-flex justify-content-between align-items-center">
                    <span v-if="supervisorData">
                        {{ supervisorData.firstName }} {{ supervisorData.lastName }}
                    </span>
                    <span v-else>
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <span class="text-muted">None</span>

                        </div>
                    </span>
                    <button v-if="isCurrentUser" class="btn btn-link text-primary" @click="findSupervisor">Find
                        your supervisor</button>
                </div>
            </div>

            <!-- Health Professional Section -->
            <div class="mb-3">
                <p class="mb-1"><strong>Health Professional:</strong></p>
                <div class="d-flex justify-content-between align-items-center">
                    <span v-if="healthProfData">
                        {{ healthProfData.firstName }} {{ healthProfData.lastName }}
                    </span>
                    <span v-else>
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <span class="text-muted">None</span>

                        </div>

                    </span>
                    <button v-if="isCurrentUser" class="btn btn-link text-primary" @click="findHealthProfessional">Find
                        a health professional</button>
                </div>
            </div>
        </div>

        <!-- Edit Profile Button -->
        <div v-if="isCurrentUser" class="text-center">
            <button class="btn btn-primary btn-lg" @click="goToEditProfile">Edit Profile</button>
        </div>

        <!-- Wellness Log Component -->
        <EmployeeWellnessLog :employeeId="employeeId" class="mt-4" />
    </div>
</template>

<script>
import EmployeeWellnessLog from '../components/EmployeeWellnessLog.vue';

export default {
    props: ['employeeId'],
    data() {
        return {
            employeeData: {}, // Holds main employee data
            supervisorData: null, // Holds supervisor data
            healthProfData: null, // Holds health professional data
        };
    },
    components: {
        EmployeeWellnessLog, // Register the component here
    },
    mounted() {
        this.fetchEmployeeProfile();
    },
    watch: {
        employeeId(newId, oldId) {
            if (newId !== oldId) {
                this.fetchEmployeeProfile(); // Refetch profile data if employeeId changes
            }
        },
        '$route.params.employeeId': function (newId) {
            this.fetchEmployeeProfile();
        }
    },
    computed: {
        isCurrentUser() {
            return this.employeeId === localStorage.getItem('employeeId') || localStorage.getItem('employeeId') === '3f5676fe-775e-4296-b6a3-7817820e0942';
        }
    },
    methods: {
        fetchEmployeeProfile() {
            fetch(`http://localhost:3000/api/employees/${this.employeeId}`)
                .then(response => response.json())
                .then(data => {
                    this.employeeData = data;
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
        goToEditProfile() {
            this.$router.push(`/edit-employee-profile/${this.employeeId}`);
        },
        findSupervisor() {
            this.$router.push(`/supervisor-lookup`);
        },
        findHealthProfessional() {
            this.$router.push(`/health-professional-lookup`);
        },
    }
};
</script>

<style scoped>
/* General styling */
.container {
    max-width: 800px;
    margin: 0 auto;
}

/* Card styling */
.card {
    background-color: #f8f9fa;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.card h2 {
    color: #343a40;
    font-size: 1.75rem;
}

.card p {
    font-size: 1rem;
    color: #6c757d;
}

.card .btn-link {
    font-size: 1rem;
    text-decoration: underline;
}

.card .btn-link:hover {
    text-decoration: none;
}

/* Centered buttons */
.btn-primary {
    padding: 12px 24px;
    font-size: 1.1rem;
    font-weight: 600;
}

.btn-link {
    font-size: 1rem;
    text-decoration: underline;
    color: #007bff;
}

/* Wellness log component */
.EmployeeWellnessLog {
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    padding: 20px;
    margin-top: 40px;
}
</style>
