<template>
  <div class="container mt-5">
    <h2 class="text-center mb-4">Time Management Tools</h2>

    <!-- Bootstrap List -->
    <div v-if="timeManagementTools.length > 0">
      <ul class="list-group">
        <li v-for="tool in timeManagementTools" :key="tool.toolId"
          class="list-group-item d-flex justify-content-between align-items-center">
          <div>
            <strong>{{ tool.title || "Unnamed Tool" }}</strong>
          </div>
          <div>
            <button v-if="this.healthProfessional == tool.healthProfId" class="btn btn-link btn-sm"
              @click="goToEditTool(tool.toolId)">
              Edit
            </button>
            <button class="btn btn-primary btn-sm" @click="viewTool(tool.toolId)">
              View
            </button>

          </div>

        </li>
      </ul>
    </div>

    <!-- No Tools Message -->
    <div v-else class="text-center text-muted mt-3">
      <p>No time management tools available.</p>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      timeManagementTools: [], // Holds the list of tools
    };
  },
  methods: {
    fetchTimeManagementTools() {
      axios
        .get("http://localhost:3000/api/time-management-tools") // API endpoint
        .then((response) => {
          this.timeManagementTools = response.data;
        })
        .catch((error) => {
          console.error("Error fetching time management tools:", error);
        });
    },
    viewTool(toolId) {
      // Navigate to the tool details page
      this.$router.push(`/tools/${toolId}`);
    },
    goToEditTool(toolId) {
      this.$router.push(`/edit-tool/${toolId}`);
    }
  },
  mounted() {
    this.fetchTimeManagementTools(); // Fetch tools on component mount
  },
  computed: {
    healthProfessional() {
      return localStorage.getItem('healthProfId') || null;
    },
  },
};
</script>

<style scoped>
.container {
  max-width: 800px;
  margin: 0 auto;
}

h2 {
  font-size: 1.5rem;
  color: #333;
}

.list-group-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px;
  border-radius: 8px;
  background-color: #f8f9fa;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  margin-bottom: 10px;
}

.list-group-item:hover {
  background-color: #e9ecef;
}

.btn-primary {
  background-color: #007bff;
  border-color: #007bff;
  font-size: 1rem;
}

.btn-primary:hover {
  background-color: #0056b3;
  border-color: #004085;
}
</style>
