<template>
    <div>
        <h2>Create Time Management Recommendation</h2>
        <form @submit.prevent="submitForm">
            <div>
                <label for="toolId">Tool ID:</label>
                <input type="text" id="toolId" v-model="form.toolId" required />
            </div>
            <div>
                <label for="employeeId">Employee ID:</label>
                <input type="text" id="employeeId" v-model="form.employeeId" required />
            </div>
            <button type="submit">Submit Recommendation</button>
        </form>
    </div>
</template>

<script>
import { v4 as uuidv4 } from 'uuid';
import axios from 'axios';

export default {
    data() {
        return {
            form: {
                toolId: '',
                employeeId: '',
            }
           
        };
    },
    methods: {
        submitForm() {
            const recommendationId = uuidv4();
            const recommendedAt = new Date().toISOString().slice(0, 19).replace('T', ' ');
            const payload = {
                recommendationId,
                toolId: this.form.toolId,
                employeeId: this.form.employeeId,
                supervisorId: localStorage.getItem('employeeId') || null,
                healthProfId: localStorage.getItem('healthProfId') || null,
                recommendedAt,
            };

            // Log the JSON being sent out
            console.log("Submitting form:", payload);

            axios.post('http://localhost:3000/api/time-management-recommendations', payload)
                .then(response => {
                    console.log(response.data);
                    alert('Recommendation added successfully!');
                    this.clearForm();
                })
                .catch(error => {
                    console.error(error);
                    alert('Error adding recommendation');
                });

            
        },
        clearForm() {
            // Reset form fields
            this.form = {
                toolId: '',
                employeeId: '',
            };
        },
    }
};
</script>

<style scoped>
form {
    display: flex;
    flex-direction: column;
    max-width: 300px;
}

label {
    margin: 0.5em 0;
}

button {
    margin-top: 1em;
}
</style>
