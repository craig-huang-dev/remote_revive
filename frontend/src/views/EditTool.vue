<template>
	<div class="container mt-5">
		<h5 class="text-muted mb-4 border-bottom pb-3">
			Time management tools help employees stay organized, meet deadlines, and work more efficiently, leading to
			less stress and better productivity.
		</h5>
		<h2 class="text-center mb-4">Edit Time Management Tool</h2>
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

			<div class="d-flex mt-4" style="justify-content: space-between; width: 100%;">
				<button class="btn btn-danger" type="button" @click="deleteTool()">Delete</button>
				<button type="submit" class="btn btn-primary">Save</button>
			</div>
		</form>
	</div>
</template>

<script>
import axios from 'axios';

export default {
	props: {
		toolId: {
			type: String,
			required: true,
		},
	},
	mounted() {
		if (this.toolId) {
			this.fetchTool();
		}
	},
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
			const payload = {
				title: this.form.title,
				description: this.form.description,
				link: this.form.link,
			};

			console.log("Submitting form:", payload);
			axios.put(`http://localhost:3000/api/time-management-tools/${this.toolId}`, payload)
				.then(response => {
					console.log(response.data);
					alert('Tool updated successfully!');
				})
				.catch(error => {
					console.error(error);
					alert('Error updating tool');
				});
		},
		fetchTool() {
			axios
				.get(`http://localhost:3000/api/time-management-tools/${this.toolId}`)
				.then(response => {
					// Prepopulate the form with fetched data
					const tool = response.data;
					this.form.title = tool.title;
					this.form.description = tool.description;
					this.form.duration = tool.duration;
					this.form.difficultyLevel = tool.difficultyLevel;
					this.form.link = tool.link;
				})
				.catch(error => {
					console.error("Error fetching tool data:", error);
				});
		},
		deleteTool() {
			if (confirm("Are you sure you want to delete this mindfulness technique?")) {
				axios
					.delete(`http://localhost:3000/api/timemanagementtools/${this.toolId}`)
					.then(() => {
						alert("Time management tool deleted successfully.");
						this.$router.push('/tools');
					})
					.catch((error) => {
						console.error("Error deleting time management tool:", error);
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
