<template>
    <div>
        <h2>Create Mindfulness Recommendation</h2>
        <form @submit.prevent="submitForm">
            <div>
                <label for="techniqueId">Technique ID:</label>
                <input type="text" id="techniqueId" v-model="form.techniqueId" required />
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
                techniqueId: '',
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
                techniqueId: this.form.techniqueId,
                employeeId: this.form.employeeId,
                supervisorId: localStorage.getItem('employeeId') || null,
                healthProfId: localStorage.getItem('healthProfId') || null,
                recommendedAt,
            };
            console.log("Recommendation payload:", payload);


            // Log the JSON being sent out
            console.log("Submitting form:", payload);

            axios.post('http://localhost:3000/api/mindfulness-recommendations', payload)
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
                techniqueId: '',
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
