<template>
	<div class="container mt-5">
		<h1 class="text-center mb-4">My Current Wellness</h1>

		<div v-if="wellnessLogData && Object.keys(wellnessLogData).length > 0">
			<div class="card shadow-sm p-4">
				<table class="table table-bordered table-striped">
					<thead class="table-light">
						<tr>
							<th>Mood</th>
							<th>Stress</th>
							<th>Symptoms</th>
							<th>Comments</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>{{ wellnessLogData[0].mood }}</td>
							<td>{{ wellnessLogData[0].stress }}</td>
							<td>{{ wellnessLogData[0].physicalSymptoms }}</td>
							<td>{{ wellnessLogData[0].comments }}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<div v-else class="text-center text-muted mt-3">
			<p>No wellness data available.</p>
		</div>

		<div v-if="isCurrentUser" class="text-center mt-4">
			<button class="btn btn-primary btn-lg" @click="editWellness">Edit Wellness</button>
		</div>
	</div>
</template>

<script>
export default {
	props: ['employeeId'],
	mounted() {
		this.fetchWellnessLog();
	},
	data() {
		return {
			wellnessLogData: null,
		};
	},
	computed: {
		isCurrentUser() {
			return this.employeeId === localStorage.getItem('employeeId');
		}
	},
	methods: {
		fetchWellnessLog() {
			fetch(`http://localhost:3000/api/employee-wellness-logs/${this.employeeId}`)
				.then(response => response.json())
				.then(data => {
					console.log("Fetched wellness log data:", data);
					this.wellnessLogData = data;
				})
				.catch(error => {
					console.error("Error fetching wellness log:", error);
				});
		},
		formatDate(isoDateString) {
			const date = new Date(isoDateString);
			return date.toLocaleDateString();
		},
		editWellness() {
			this.$router.push('/log-employee-wellness');
		}
	},
};
</script>

<style scoped>
.container {
	max-width: 800px;
	margin: 0 auto;
}

.card {
	background-color: #f8f9fa;
	border-radius: 10px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.card table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

.card th,
.card td {
	padding: 12px;
	text-align: center;
}

.card th {
	background-color: #30d5c8;
	color: white;
}

.card td {
	font-size: 1.1rem;
}

.card .table-striped tbody tr:nth-child(odd) {
	background-color: #f2f2f2;
}

.btn-primary {
	font-size: 1.1rem;
	font-weight: 600;
	padding: 12px 24px;
}

.text-muted {
	font-size: 1.1rem;
	font-weight: 500;
}

h1 {
	font-size: 2.25rem;
	color: #343a40;
}
</style>
