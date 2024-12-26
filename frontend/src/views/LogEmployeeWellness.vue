<template>
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card shadow-sm p-4" style="max-width: 500px; width: 100%;">
            <h2 class="text-center mb-4">How are you feeling today?</h2>
            <form @submit.prevent="submitForm">
                <div class="mb-3">
                    <label for="stress" class="form-label">Stress (1-5):</label>
                    <input type="number" id="stress" v-model="form.stress" class="form-control" required min="1" max="5"
                        step="1" />
                </div>

                <div class="mb-3">
                    <label for="mood" class="form-label">Mood:</label>
                    <input type="text" id="mood" v-model="form.mood" class="form-control" required />
                </div>
                <div class="mb-3">
                    <label for="comments" class="form-label">Comments:</label>
                    <textarea id="comments" v-model="form.comments" class="form-control"></textarea>
                </div>
                <div class="mb-3">
                    <label for="physicalSymptoms" class="form-label">Physical Symptoms:</label>
                    <textarea id="physicalSymptoms" v-model="form.physicalSymptoms" class="form-control"></textarea>
                </div>
                <button type="submit" class="btn btn-primary w-100">Update Wellness</button>
            </form>
            <button @click="deleteWellnessLog" class="btn btn-danger w-100 mt-3">Clear Wellness Status</button>
            <button type="button" class="btn btn-secondary cancel-btn w-100 mt-3" @click="cancel">
                Return to Profile</button>
        </div>
    </div>
</template>

<script>
import { v4 as uuidv4 } from 'uuid';
import axios from 'axios';

export default {
    data() {
        return {
            form: {
                stress: '',
                mood: '',
                comments: '',
                physicalSymptoms: '',
            }
        };
    },
    methods: {
        cancel() {
            this.$router.push(`/employees/${localStorage.getItem('employeeId')}`);
        },
        submitForm() {
            const logId = uuidv4();
            const recordedAt = new Date().toISOString().slice(0, 19).replace('T', ' ');
            const payload = {
                logId,
                stress: this.form.stress,
                mood: this.form.mood,
                comments: this.form.comments,
                physicalSymptoms: this.form.physicalSymptoms,
                recordedAt,
                employeeId: localStorage.getItem('employeeId')
            };

            // Log the JSON being sent out
            console.log("Submitting form:", payload);

            axios.post('http://localhost:3000/api/employee-wellness-logs', payload)
                .then(response => {
                    console.log(response.data);
                    alert('Log added successfully!');
                    this.clearForm();
                })
                .catch(error => {
                    console.error(error);
                    alert('Error adding log');
                });
        },
        clearForm() {
            // Reset form fields
            this.form = {
                stress: '',
                mood: '',
                comments: '',
                physicalSymptoms: '',
            };
        },
        deleteWellnessLog() {
            this.clearForm();
            axios.delete(`http://localhost:3000/api/employee-wellness-logs/${localStorage.getItem('employeeId')}`)
                .then(response => {
                    console.log(response.data);
                    alert('Log deleted successfully!');
                    this.clearForm();
                })
                .catch(error => {
                    console.error(error);
                    alert('Error deleting log');
                });
        }
    }
};
</script>

<style scoped>
.container {
    height: 100vh;
    /* Full viewport height */
}

.card {
    width: 100%;
}

.form-label {
    font-weight: 600;
}

input.form-control,
textarea.form-control {
    width: 100%;
}

button {
    width: 100%;
}

.mb-3 {
    margin-bottom: 1.5rem;
}

.card {
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
</style>
