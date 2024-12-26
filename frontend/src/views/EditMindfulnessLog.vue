<template>
    <div class="container mt-4">
        <h3>Edit Mindfulness Log</h3>
        <form @submit.prevent="updateLog">
            <div class="mb-3">
                <label for="comments" class="form-label">Comments</label>
                <textarea id="comments" class="form-control" v-model="logData.comments"
                    placeholder="Enter your comments" rows="4"></textarea>
            </div>
            <div class="d-flex justify-content-between">
                <button type="button" class="btn btn-secondary" @click="returnToLogs">Return to Logs</button>
                <button type="submit" class="btn btn-primary">Update Log</button>
            </div>
        </form>
    </div>
</template>

<script>
import axios from "axios";

export default {
    props: {
        logId: {
            type: String,
            required: true,
        },
    },
    data() {
        return {
            logData: {
                comments: "",
            },
        };
    },
    mounted() {
        this.fetchLog();
    },
    methods: {
        fetchLog() {
            axios
                .get(`http://localhost:3000/api/mindfulness-logs/${this.logId}`)
                .then((response) => {
                    this.logData = response.data;
                })
                .catch((error) => {
                    console.error("Error fetching log:", error);
                });
        },
        updateLog() {
            axios
                .put(`http://localhost:3000/api/mindfulness-logs/${this.logId}`, {
                    comments: this.logData.comments,
                })
                .then(() => {
                    alert("Log updated successfully!");
                    this.$router.push("/dashboard"); // Redirect to dashboard after success
                })
                .catch((error) => {
                    console.error("Error updating log:", error);
                });
        },
        returnToLogs() {
            this.$router.push("/my-logs"); // Redirect back to the dashboard
        }
    }
};
</script>

<style>
.container {
    max-width: 600px;
    margin: auto;
}
</style>