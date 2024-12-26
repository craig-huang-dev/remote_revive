<template>
    <div class="container mt-5">
        <h5 class="text-muted mb-4 border-bottom pb-3">
            Mindfulness techniques are important because they help reduce stress, improve focus, and promote emotional
            well-being. They encourage staying present, improving clarity, and enhancing overall mental and physical
            health.
        </h5>
        <h2 class="text-center mb-4">Edit Mindfulness Technique</h2>
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
                <div class="col-md-6">
                    <label for="duration" class="form-label">Duration (in minutes)</label>
                    <input type="number" id="duration" v-model="form.duration" class="form-control" required min="1"
                        step="1" />
                </div>
                <div class="col-md-6">
                    <label for="difficultyLevel" class="form-label">Difficulty Level</label>
                    <select id="difficultyLevel" v-model="form.difficultyLevel" class="form-select" required>
                        <option value="" disabled>Select difficulty</option>
                        <option value="easy">Easy</option>
                        <option value="medium">Medium</option>
                        <option value="hard">Hard</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-12">
                    <label for="link" class="form-label">Link</label>
                    <input type="url" id="link" v-model="form.link" class="form-control" required />
                </div>
            </div>
            <div class="d-flex mt-4" style="justify-content: space-between; width: 100%;">
                <button class="btn btn-danger" type="button" @click="deleteTechnique()">Delete</button>
                <button type="submit" class="btn btn-primary">Save</button>
            </div>
        </form>
    </div>
</template>

<script>
import axios from 'axios';
export default {
    props: {
        techniqueId: {
            type: String,
            required: true,
        },
    },
    mounted() {
        if (this.techniqueId) {
            this.fetchTechnique();
        }
    },
    data() {
        return {
            form: {
                title: "",
                description: "",
                duration: "",
                difficultyLevel: "",
                link: "",
            },
        };
    },
    methods: {
        submitForm() {
            // POST request with form data
            const payload = {
                title: this.form.title,
                description: this.form.description,
                duration: this.form.duration,
                difficultyLevel: this.form.difficultyLevel,
                link: this.form.link,
            };

            console.log("Submitting form:", payload);
            axios.put(`http://localhost:3000/api/mindfulness-techniques/${this.techniqueId}`, payload)
                .then(response => {
                    console.log(response.data);
                    alert('Technique updated successfully!');
                })
                .catch(error => {
                    console.error(error);
                    alert('Error updating technique');
                });
        },
        fetchTechnique() {
            axios
                .get(`http://localhost:3000/api/mindfulness-techniques/${this.techniqueId}`)
                .then(response => {
                    // Prepopulate the form with fetched data
                    const technique = response.data;
                    this.form.title = technique.title;
                    this.form.description = technique.description;
                    this.form.duration = technique.duration;
                    this.form.difficultyLevel = technique.difficultyLevel;
                    this.form.link = technique.link;
                })
                .catch(error => {
                    console.error("Error fetching technique data:", error);
                });
        },
        deleteTechnique() {
            if (confirm("Are you sure you want to delete this mindfulness technique?")) {
                axios
                    .delete(`http://localhost:3000/api/mindfulnesstechniques/${this.techniqueId}`)
                    .then(() => {
                        alert("Mindfulness technique deleted successfully.");
                        this.$router.push('/techniques');
                    })
                    .catch((error) => {
                        console.error("Error deleting mindfulness technique:", error);
                    });
            }
        }
    },
};
</script>

<style scoped>
.container {
    max-width: 600px;
}
</style>
