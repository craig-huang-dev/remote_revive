<template>
    <div class="container mt-5">
        <h5 class="text-muted mb-4 border-bottom pb-3">
            Time management tools help employees stay organized, meet deadlines, and work more efficiently, leading to
            less stress and better productivity.
        </h5>
        <h2 class="text-center mb-4">Create Time Management Tool</h2>
        <form @submit.prevent="submitForm">
            <div class="row mb-3">
                <div>
                    <label for="title" class="form-label">Title</label>
                    <input type="text" id="title" v-model="form.title" class="form-control" required />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-12">
                    <label for="description" class="form-label">Description</label>
                    <textarea id="description" v-model="form.description" class="form-control" rows="4"></textarea>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-12">
                    <label for="link" class="form-label">Link</label>
                    <input type="url" id="link" v-model="form.link" class="form-control" />
                </div>
            </div>

            <div class="d-flex justify-content-center mt-4">
                <button type="submit" class="btn btn-primary">Create</button>
            </div>
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
                title: "",
                description: "",
                link: "",
            },
        };
    },
    methods: {
        submitForm() {
            // POST request with form data
            const toolId = uuidv4();
            const createdAt = new Date().toISOString().slice(0, 19).replace('T', ' ');

            const payload = {
                toolId,
                title: this.form.title,
                description: this.form.description,
                createdAt,
                healthProfId: localStorage.getItem('healthProfId'),
                link: this.form.link,
            };

            console.log("Submitting form:", payload);
            axios.post('http://localhost:3000/api/time-management-tools', payload)
                .then(response => {
                    console.log(response.data);
                    alert('Tool added successfully!');
                    this.clearForm();
                })
                .catch(error => {
                    console.error(error);
                    alert('Error adding tool');
                });
        },
        clearForm() {
            // Reset form fields
            this.form = {
                title: "",
                description: "",
                link: "",
            };
        },
    },
};
</script>

<style scoped>
.container {
    max-width: 600px;
}
</style>
