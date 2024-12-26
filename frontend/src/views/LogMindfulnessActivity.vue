<template>
    <div>
        <h2>Log  Mindfulness Activity</h2>
        <form @submit.prevent="submitForm">
            <div>
                <label for="techniqueId">Technique ID:</label>
                <input type="text" id="techniqueId" v-model="form.techniqueId" required />
            </div>
            <div>
                <label for="comments">Comments:</label>
                <textarea
					id="comments"
					v-model="form.comments"
				></textarea>
            </div>
            <button type="submit">Save Activity</button>
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
                comments: '',
            }
           
        };
    },
    methods: {
        submitForm() {
            const logId = uuidv4();
            const timestamp = new Date().toISOString().slice(0, 19).replace('T', ' ');
            const payload = {
                logId,
                techniqueId: this.form.techniqueId,
                comments: this.form.comments,
                timestamp, // Use the timestamp
				employeeId: localStorage.getItem('employeeId')
            };

            // Log the JSON being sent out
            console.log("Submitting form:", payload);

            axios.post('http://localhost:3000/api/mindfulness-logs', payload)
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
                techniqueId: '',
                comments: '',
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
