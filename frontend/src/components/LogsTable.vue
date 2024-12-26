<template>
    <div class="container my-4">
        <ul class="nav nav-tabs">
            <li class="nav-item">
                <a class="nav-link" :class="{ active: activeTab === 'mindfulness' }" @click="activeTab = 'mindfulness'">
                    Mindfulness Logs
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" :class="{ active: activeTab === 'timeManagement' }"
                    @click="activeTab = 'timeManagement'">
                    Time Management Logs
                </a>
            </li>
        </ul>

        <div class="tab-content">
            <div v-show="activeTab === 'mindfulness'" id="mindfulnessLogs">
                <table class="table table-bordered mt-3" v-if="mindfulnessLogs.length">
                    <thead>
                        <tr>
                            <th>Technique</th>
                            <th>Description</th>
                            <th>Comments</th>
                            <th>Timestamp</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="log in mindfulnessLogs" :key="log.logId">
                            <td>{{ log.techniqueName }}</td>
                            <td>{{ log.techniqueDescription }}</td>
                            <td>{{ log.comments }}</td>
                            <td>{{ log.timestamp }}</td>
                            <td>
                                <div>
                                    <button class="btn btn-primary w-100"
                                        @click="navigateToEditMindfulnessLog(log.logId)">
                                        Edit
                                    </button>
                                    <button class="btn btn-danger w-100" @click="deleteMindfulnessLog(log.logId)">
                                        Delete
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>

                </table>
                <p v-else>No mindfulness logs available.</p>
            </div>

            <div v-show="activeTab === 'timeManagement'" id="timeManagementLogs">
                <table class="table table-bordered mt-3" v-if="timeManagementLogs.length">
                    <thead>
                        <tr>
                            <th>Tool</th>
                            <th>Description</th>
                            <th>Comments</th>
                            <th>Timestamp</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="log in timeManagementLogs" :key="log.logId">
                            <td>{{ log.toolName }}</td>
                            <td>{{ log.toolDescription }}</td>
                            <td>{{ log.comments }}</td>
                            <td>{{ log.timestamp }}</td>
                            <td>
                                <div>
                                    <button class="btn btn-primary w-100"
                                        @click="navigateToEditTimeManagementLog(log.logId)">
                                        Edit
                                    </button>
                                    <button class="btn btn-danger w-100" @click="deleteTimeManagementLog(log.logId)">
                                        Delete
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>

                </table>
                <p v-else>No time management logs available.</p>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    props: {
        employeeId: String,
    },
    data() {
        return {
            activeTab: 'mindfulness',
            mindfulnessLogs: [],
            timeManagementLogs: [],
        };
    },

    watch: {
        $route(to) {
            if (to.name === "Dashboard") {
                this.fetchMindfulnessLogs();
                this.fetchTimeManagementLogs();
            }
        },
    },
    mounted() {
        this.fetchMindfulnessLogs();
        this.fetchTimeManagementLogs();
    },
    methods: {
        fetchMindfulnessLogs() {
            axios
                .get(`http://localhost:3000/api/mindfulness-logs/${this.employeeId}`)
                .then((response) => {
                    this.mindfulnessLogs = response.data
                        .map(log => ({
                            ...log,
                            techniqueName: log.techniqueName || "Unknown Technique",
                            techniqueDescription: log.techniqueDescription || "No Description Available",
                        }))
                        .sort((a, b) => b.timestamp.localeCompare(a.timestamp)); // Sort by timestamp descending
                })
                .catch((error) => {
                    console.error("Error fetching mindfulness logs:", error);
                });
        },
        fetchTimeManagementLogs() {
            axios
                .get(`http://localhost:3000/api/time-management-logs/${this.employeeId}`)
                .then((response) => {
                    this.timeManagementLogs = response.data
                        .map(log => ({
                            ...log,
                            toolName: log.toolName || "Unknown Tool",
                            toolDescription: log.toolDescription || "No Description Available",
                        }))
                        .sort((a, b) => b.timestamp.localeCompare(a.timestamp)); // Sort by timestamp descending
                })
                .catch((error) => {
                    console.error("Error fetching time management logs:", error);
                });
        },
        editMindfulnessLog(log) {
            const newComments = prompt('Enter new comments for the mindfulness log:', log.comments);
            if (newComments !== null) {
                axios
                    .put(`http://localhost:3000/api/mindfulness-logs/${log.logId}`, { comments: newComments })
                    .then(() => {
                        alert('Mindfulness log updated successfully.');
                        this.fetchMindfulnessLogs(); // Refresh after update
                    })
                    .catch((error) => {
                        console.error('Error updating mindfulness log:', error);
                    });
            }
        },
        editTimeManagementLog(log) {
            const newComments = prompt('Enter new comments for the time management log:', log.comments);
            if (newComments !== null) {
                axios
                    .put(`http://localhost:3000/api/time-management-logs/${log.logId}`, { comments: newComments })
                    .then(() => {
                        alert('Time management log updated successfully.');
                        this.fetchTimeManagementLogs(); // Refresh after update
                    })
                    .catch((error) => {
                        console.error('Error updating time management log:', error);
                    });
            }
        },
        deleteMindfulnessLog(logId) {
            if (confirm("Are you sure you want to delete this mindfulness log?")) {
                axios
                    .delete(`http://localhost:3000/api/mindfulness-logs/${logId}`)
                    .then(() => {
                        alert("Mindfulness log deleted successfully.");
                        this.fetchMindfulnessLogs(); // Refresh after delete
                    })
                    .catch((error) => {
                        console.error("Error deleting mindfulness log:", error);
                    });
            }
        },
        deleteTimeManagementLog(logId) {
            if (confirm("Are you sure you want to delete this time management log?")) {
                axios
                    .delete(`http://localhost:3000/api/time-management-logs/${logId}`)
                    .then(() => {
                        alert("Time management log deleted successfully.");
                        this.fetchTimeManagementLogs(); // Refresh after delete
                    })
                    .catch((error) => {
                        console.error("Error deleting time management log:", error);
                    });
            }
        },
        navigateToEditMindfulnessLog(logId) {
            this.$router.push(`/edit-mindfulness-log/${logId}`);
        },
        navigateToEditTimeManagementLog(logId) {
            this.$router.push(`/edit-time-management-log/${logId}`);
        },


    }
};
</script>