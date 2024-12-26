<template>
    <div class="container">
        <h2 class="text-center mb-4">Health Professional Lookup</h2>

        <div class="search-container">
            <input v-model="searchQuery" type="text" placeholder="Enter name or email"
                @input="searchHealthProfessionals" class="form-control" />
        </div>

        <div v-if="filteredHealthProfessionals.length > 0" class="healthProfessionals-list">
            <ul class="list-group">
                <li v-for="healthProfessional in filteredHealthProfessionals" :key="healthProfessional.healthProfId"
                    class="list-group-item d-flex justify-content-between align-items-center">

                    <div>
                        <strong>{{ healthProfessional.firstname }} {{ healthProfessional.lastname }}</strong>
                        <small class="text-muted"> ({{ healthProfessional.email }})</small>
                        <div class="specialization">{{ healthProfessional.specialization }}</div>
                    </div>

                    <div>
                        <button @click="goToProfile(healthProfessional.healthProfId)" class="btn btn-info btn-sm mr-2">
                            View Profile
                        </button>
                        <button v-if="!isHealthProfessional"
                            @click="updateHealthProfessional(healthProfessional.healthProfId)"
                            class="btn btn-primary btn-sm">
                            + Assign to me
                        </button>
                    </div>
                </li>
            </ul>
        </div>

        <div v-else>
            <p class="text-center text-muted">No health professional found based on your search.</p>
        </div>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    mounted() {
        this.fetchAllHealthProfessionals();
    },
    data() {
        return {
            searchQuery: '',
            healthProfessionals: [],
            filteredHealthProfessionals: []
        };
    },
    computed: {
        isHealthProfessional() {
            return localStorage.getItem('healthProfId') !== null;
        },
    },
    methods: {
        searchHealthProfessionals() {
            let query = this.searchQuery.trim().toLowerCase();

            if (query === '') {
                this.filteredHealthProfessionals = this.healthProfessionals;
                return;
            }

            if (query.includes('@')) {
                query = query.split('@')[0];
            }

            this.filteredHealthProfessionals = this.healthProfessionals.filter((healthProfessional) => {
                const fullName = `${healthProfessional.firstname} ${healthProfessional.lastname}`.toLowerCase();
                return (
                    fullName.includes(query) ||
                    healthProfessional.email.toLowerCase().includes(query)
                );
            });
        },

        fetchAllHealthProfessionals() {
            fetch(`http://localhost:3000/api/health-professionals`)
                .then(response => response.json())
                .then(data => {
                    this.healthProfessionals = data;
                    this.filteredHealthProfessionals = data;
                })
                .catch(error => {
                    console.error("Error fetching health professionals:", error);
                });
        },

        goToProfile(id) {
            this.$router.push(`/health-professional/${id}`);
        },

        updateHealthProfessional(healthProfId) {
            const payload = { healthProfId: healthProfId };

            axios.put(`http://localhost:3000/api/employees/${localStorage.getItem('employeeId')}`, payload)
                .then(response => {
                    console.log(response.data);
                    alert('Health Professional updated successfully!');
                })
                .catch(error => {
                    console.error(error);
                    alert('Error updating health professional');
                });
        }
    }
};
</script>

<style scoped>
.container {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
}

h2 {
    font-size: 2rem;
    font-weight: bold;
    color: #333;
}

.search-container {
    margin-bottom: 20px;
}

.form-control {
    width: 100%;
    padding: 10px;
    border-radius: 4px;
    border: 1px solid #ddd;
    box-sizing: border-box;
}

.form-control:focus {
    box-shadow: none;
    border-color: #007bff;
}

.healthProfessionals-list {
    margin-top: 20px;
}

.list-group-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px;
    margin-bottom: 10px;
    border-radius: 8px;
    background-color: #f8f9fa;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.list-group-item:hover {
    background-color: #e9ecef;
}

.specialization {
    font-size: 0.875rem;
    color: #6c757d;
    margin-top: 5px;
}

strong {
    color: #333;
}

.text-muted {
    color: #6c757d;
}

.btn-sm {
    padding: 5px 10px;
    font-size: 0.875rem;
    border-radius: 4px;
}

.btn-info {
    background-color: #17a2b8;
    border-color: #17a2b8;
    color: white;
}

.btn-info:hover {
    background-color: #138496;
    border-color: #117a8b;
    color: white;
}

.btn-primary {
    background-color: #007bff;
    border-color: #007bff;
}

.btn-primary:hover {
    background-color: #0056b3;
    border-color: #004085;
}

button:focus {
    box-shadow: none;
}

.text-center.text-muted {
    color: #6c757d;
}
</style>
