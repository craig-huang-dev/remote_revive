<template>
    <div class="container">
        <h2 class="text-center mb-4">Employee Lookup</h2>

        <!-- Search input field -->
        <div class="search-container">
            <input v-model="searchQuery" type="text" placeholder="Enter name or email" @input="searchEmployees"
                class="form-control" />
        </div>

        <!-- Display search results -->
        <div v-if="filteredEmployees.length > 0" class="employees-list">
            <ul class="list-group">
                <li v-for="employee in filteredEmployees" :key="employee.employeeId"
                    class="list-group-item d-flex justify-content-between align-items-center">
                    <div>
                        <strong>{{ employee.firstName }} {{ employee.lastName }}</strong>
                        <small class="text-muted"> ({{ employee.email }})</small>
                    </div>
                    <div>
                        <button @click="goToProfile(employee.employeeId)" class="btn btn-info btn-sm mr-2">
                            View Profile
                        </button>
                        <button v-if="!isHealthProfessional" @click="updateSupervisor(employee.employeeId)"
                            class="btn btn-primary btn-sm">
                            + Assign as Supervisor
                        </button>
                    </div>
                </li>
            </ul>
        </div>

        <div v-else>
            <p class="text-center text-muted">No employees found based on your search.</p>
        </div>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    mounted() {
        this.fetchAllEmployees();
    },
    computed: {
        isHealthProfessional() {
            return localStorage.getItem('healthProfId') !== null;
        },
    },
    data() {
        return {
            searchQuery: '',
            employees: [],
            filteredEmployees: []
        };
    },
    methods: {
        // This method filters employees based on the search query
        searchEmployees() {
            let query = this.searchQuery.trim().toLowerCase();

            // If query is empty, show all employees
            if (query === '') {
                this.filteredEmployees = this.employees;
                return;
            }

            // If the query contains '@', trim everything after the '@' (for email-like searches)
            if (query.includes('@')) {
                query = query.split('@')[0];
            }

            // Filter employees based on the modified search query
            this.filteredEmployees = this.employees.filter((employee) => {
                const fullName = `${employee.firstName} ${employee.lastName}`.toLowerCase();
                return (
                    fullName.includes(query) ||
                    employee.email.toLowerCase().includes(query)
                );
            });
        },

        // Fetch all employees from the API
        fetchAllEmployees() {
            fetch(`http://localhost:3000/api/employees`)
                .then(response => response.json())
                .then(data => {
                    this.employees = data.filter(employee =>
                        employee.employeeId !== '3f5676fe-775e-4296-b6a3-7817820e0942'
                    );
                    this.filteredEmployees = this.employees;
                })
                .catch(error => {
                    console.error("Error fetching all employees:", error);
                });
        },

        // Go to employee profile page
        goToProfile(id) {
            this.$router.push(`/employees/${id}`);
        },

        // Update supervisor for the current employee
        updateSupervisor(supervisorId) {
            const payload = {
                supervisorId: supervisorId,
            };

            axios.put(`http://localhost:3000/api/employees/${localStorage.getItem('employeeId')}`, payload)
                .then(response => {
                    console.log(response.data);
                    alert('Supervisor updated successfully!');
                    this.clearForm();
                })
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

.employees-list {
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
</style>
