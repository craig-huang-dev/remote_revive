<template>
	<div class="container mt-5">
		<h1 class="text-center mb-4">Supervised Employee Wellness</h1>

		<!-- Display wellness log data if available -->
		<div v-if="supervisedEmployeeWellness && supervisedEmployeeWellness.length > 0">
			<div class="card shadow-sm p-4">
				<table class="table table-bordered table-striped">
					<thead class="table-light">
						<tr>
							<th>Name</th>
							<th>Mood</th>
							<th>Stress</th>
							<th>Symptoms</th>
							<th>Comments</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<tr v-for="(wellness, index) in supervisedEmployeeWellness" :key="index">
							<td>{{ wellness.firstName }} {{ wellness.lastName }}</td>
							<td>{{ wellness.mood }}</td>
							<td>{{ wellness.stress }}</td>
							<td>{{ wellness.physicalSymptoms }}</td>
							<td>{{ wellness.comments }}</td>
							<td>
								<button class="btn btn-primary" @click="goToProfile(wellness.employeeId)">
									View Profile
								</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<!-- Message if no wellness log data is available -->
		<div v-else class="text-center text-muted mt-3">
			<p>No wellness data available.</p>
		</div>
	</div>
</template>

<script>
export default {
	props: {
		supervisedEmployeeWellness: {
			type: Array,
			required: true
		}
	},
	methods: {
		goToProfile(id) {
			this.$router.push(`/employees/${id}`);
		}
	}
};
</script>

<style scoped>
.container {
	max-width: 900px;
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
