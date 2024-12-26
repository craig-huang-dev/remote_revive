<template>
    <div id="app">
        <!-- Bootstrap Navbar -->
        <nav class="navbar navbar-expand-lg custom-navbar" v-if="employeeId || healthProfId">
            <div class="container-fluid">
                <!-- Toggler for mobile view -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <!-- Navbar Links -->
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <router-link class="nav-link" to="/dashboard">Dashboard</router-link>
                        </li>
                        <li class="nav-item" v-if="employeeId">
                            <router-link class="nav-link" :to="`/employees/${employeeId}`">My Profile</router-link>
                        </li>
                        <li class="nav-item" v-if="healthProfId">
                            <router-link class="nav-link" :to="`/health-professional/${healthProfId}`">My
                                Profile</router-link>
                        </li>
                        <li class="nav-item">
                            <router-link class="nav-link" to="/supervisor-lookup">Employee Lookup</router-link>
                        </li>
                        <li class="nav-item">
                            <router-link class="nav-link" to="/health-professional-lookup">Health Professional
                                Lookup</router-link>
                        </li>
                        <li class="nav-item">
                            <router-link class="nav-link" to="/techniques">Mindfulness Techniques</router-link>
                        </li>
                        <li class="nav-item">
                            <router-link class="nav-link" to="/tools">Time Management Tools</router-link>
                        </li>
                        <li class="nav-item">
                            <router-link class="nav-link" to="/recommendations">Recommendations</router-link>
                        </li>
                        <li class="nav-item" v-if="healthProfId">
                            <router-link class="nav-link" to="/create-mindfulness-technique">Create Mindfulness
                                Technique</router-link>
                        </li>
                        <li class="nav-item" v-if="healthProfId">
                            <router-link class="nav-link" to="/create-time-management-tool">Create Time Management
                                Tool</router-link>
                        </li>
                        <li class="nav-item" v-if="employeeId">
                            <router-link class="nav-link" to="/my-logs">My Logs</router-link>
                        </li>

                    </ul>

                    <!-- Align logout button to the right -->
                    <ul class="navbar-nav ms-auto">

                        <li class="nav-item">
                            <button class="btn btn-outline-secondary" @click="logout">Logout</button>
                        </li>
                    </ul>
                </div>

            </div>
        </nav>

        <!-- Other routes will be rendered here -->
        <router-view />
    </div>
</template>

<script>
export default {
    name: "App",
    methods: {
        logout() {
            // Clear all items from localStorage
            localStorage.clear();
            this.employeeId = null;
            this.healthProfId = null;
            // Optionally redirect to the login page or home page
            this.$router.push('/');
        },
        updateUserState() {
            this.employeeId = localStorage.getItem('employeeId');
            this.healthProfId = localStorage.getItem('healthProfId');
        }
    },
    mounted() {
        this.updateUserState();
    },
    data() {
        return {
            employeeId: null,
            healthProfId: null,
        };
    },
    created() {
        this.$router.beforeEach((to, from, next) => {
            this.updateUserState();
            next();
        });
    }
};
</script>

<style>
/* Additional styles for the navbar can be added here */
.navbar {
    padding: 0.5rem;
}

.custom-navbar {
    background-color: #30d5c8 !important;
}

.nav-link {
    color: #000 !important;
}

.nav-link:hover {
    color: #0056b3 !important;
}

button {
    margin-left: 1rem;
}
</style>
