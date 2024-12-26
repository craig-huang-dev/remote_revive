<template>
    <div class="container mt-5">
        <div v-if="healthProfData" class="card shadow-sm p-4 mb-4">
            <h2 class="text-center mb-3">
                {{ healthProfData.firstName }} {{ healthProfData.lastName }}
            </h2>
            <div class="mb-3">
                <p class="mb-1"><strong>Specialization:</strong> {{ healthProfData.specialization }}</p>
            </div>
            <div class="mb-3">
                <p class="mb-1"><strong>Email:</strong> {{ healthProfData.email }}</p>
            </div>


            <!-- Add other health professional details here -->
        </div>
        <div v-if="isCurrentUser" class="text-center">
            <button class="btn btn-primary btn-lg" @click="goToEditProfile(healthProfData.healthProfId)">Edit
                Profile</button>
        </div>
    </div>
</template>

<script>
export default {
    props: ['healthProfId'], // Receive healthProfId as a prop
    data() {
        return {
            healthProfData: null, // To hold the fetched health professional data
        };
    },
    mounted() {
        this.fetchHealthProfessionalProfile();
    },
    computed: {
        isCurrentUser() {
            // Check if the healthProfId matches the one in localStorage
            return this.healthProfId === localStorage.getItem('healthProfId') || localStorage.getItem('employeeId') === '3f5676fe-775e-4296-b6a3-7817820e0942';
        }
    },
    methods: {
        fetchHealthProfessionalProfile() {
            // Fetch health professional details using the healthProfId
            fetch(`http://localhost:3000/api/health-professionals/${this.healthProfId}`)
                .then(response => response.json())
                .then(data => {
                    this.healthProfData = data; // Store the fetched data
                })
                .catch(error => {
                    console.error("Error fetching health professional profile:", error);
                });
        },
        goToEditProfile(healthProfId) {
            // Navigate to the edit health professional profile route
            this.$router.push(`/edit-health-professional-profile/${healthProfId}`);
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
</style>