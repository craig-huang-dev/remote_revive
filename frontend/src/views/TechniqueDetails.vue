<template>
  <div class="container mt-5">
    <h2 class="text-center mb-4">Technique Details</h2>

    <!-- Details Table -->
    <table class="table table-bordered">
      <tbody>
        <tr>
          <th>Technique Name</th>
          <td>{{ technique.title }}</td>
        </tr>
        <tr>
          <th>Description</th>
          <td>{{ technique.description }}</td>
        </tr>

        <tr>
          <th>Difficulty</th>
          <td>{{ technique.difficultyLevel }}</td>
        </tr>
        <tr>
          <th>Duration (in minutes)</th>
          <td>{{ technique.duration }}</td>
        </tr>
        <tr>
          <th>Created At</th>
          <td>{{ technique.createdAt }}</td>
        </tr>
        <tr>
          <th>Created By</th>
          <td>{{ technique.healthProfName }}</td>
        </tr>
        <tr>
          <th>Link</th>
          <td><a :href="technique.link" target="_blank">{{ technique.link }}</a></td>
        </tr>
      </tbody>
    </table>

    <!-- Buttons -->
    <div class="text-center mt-4">
      <button class="btn btn-primary me-3" @click="showRecommendModal = true">
        Recommend
      </button>
      <button v-if="localEmployeeId && !localHealthProfId" class="btn btn-info" @click="showLogModal = true">
        Log Technique
      </button>
    </div>

    <!-- Recommend Modal -->
    <div v-if="showRecommendModal" class="modal fade show" style="display: block; background: rgba(0, 0, 0, 0.5);">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h6 class="modal-title">Recommend this to your supervised employees:</h6>
            <button type="button" class="btn-close" @click="closeRecommendModal"></button>
          </div>
          <div class="modal-body">
            <!-- Check if there are no supervised employees -->
            <div v-if="supervisedEmployees.length === 0">
              <p>No supervised employees found.</p>
            </div>

            <!-- List of supervised employees if there are any -->
            <ul v-else class="list-group">
              <li v-for="employee in supervisedEmployees" :key="employee.id"
                class="list-group-item d-flex justify-content-between align-items-center">
                {{ employee.firstName }} {{ employee.lastName }}
                <button class="btn btn-sm btn-primary" @click="recommendToEmployee(employee.employeeId)">
                  Recommend
                </button>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>


    <!-- Log Modal -->
    <div v-if="showLogModal" class="modal fade show" style="display: block; background: rgba(0, 0, 0, 0.5);">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h6 class="modal-title">What did you think about this technique?</h6>
            <button type="button" class="btn-close" @click="closeLogModal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <!-- Form for submitting feedback -->
            <form @submit.prevent="submitForm">
              <div class="mb-3">
                <label for="comments" class="form-label">Comments:</label>
                <textarea id="comments" v-model="form.comments" class="form-control" rows="4"
                  placeholder="Write your comments here..." required></textarea>
              </div>
              <div class="d-flex justify-content-end">
                <button type="submit" class="btn btn-primary">Save Activity</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { v4 as uuidv4 } from 'uuid';

export default {
  data() {
    return {
      localEmployeeId: this.employeeId || localStorage.getItem('employeeId'),
      localHealthProfId: this.healthProfId || localStorage.getItem('healthProfId'),
      technique: {}, // Technique details
      supervisedEmployees: [], // List of supervised employees
      showRecommendModal: false, // Modal visibility state
      showLogModal: false, // Modal visibility state
      form: {
        comments: '',
      }
    };
  },
  methods: {
    fetchTechniqueDetails() {
      const techniqueId = this.$route.params.techniqueId;
      axios
        .get(`http://localhost:3000/api/mindfulness-techniques/${techniqueId}`)
        .then((response) => {
          this.technique = response.data;
          this.getHealthProf(this.technique.healthProfId);
        })
        .catch((error) => {
          console.error("Error fetching technique details:", error);
        });
    },
    fetchSupervisedEmployees() {
      if (this.localEmployeeId) {
        fetch(`http://localhost:3000/api/employees/supervised/${this.localEmployeeId}`)
          .then(response => response.json())
          .then(data => {
            this.supervisedEmployees = data;
          })
          .catch(error => {
            console.error("Error fetching supervised employees:", error);
          });
      } else if (this.localHealthProfId) {
        fetch(`http://localhost:3000/api/health-professionals/supervised-professional/${this.localHealthProfId}`)
          .then(response => response.json())
          .then(data => {
            this.supervisedEmployees = data;
          })
          .catch(error => {
            console.error("Error fetching supervised employees:", error);
          });
      }
    },
    getHealthProf(healthProfId) {
      axios
        .get(`http://localhost:3000/api/health-professionals/${healthProfId}`)
        .then((response) => {
          const healthProf = response.data;
          this.technique.healthProfName = `${healthProf.firstName} ${healthProf.lastName}`;
        })
        .catch((error) => {
          console.error("Error fetching health professional details:", error);
          this.technique.healthProfName = "Unknown";
        });
    },
    recommendToEmployee(employeeId) {
      const recommendationId = uuidv4();
      const recommendedAt = new Date().toISOString().slice(0, 19).replace('T', ' ');
      const payload = {
        recommendationId,
        techniqueId: this.technique.techniqueId,
        employeeId: employeeId,
        supervisorId: localStorage.getItem('employeeId') || null,
        healthProfId: localStorage.getItem('healthProfId') || null,
        recommendedAt,
      };

      axios
        .post("http://localhost:3000/api/mindfulness-recommendations", payload)
        .then(() => {
          alert("Recommendation sent successfully!");
        })
        .catch((error) => {
          console.error("Failed to recommend technique:", error);
          alert("Error: Could not send recommendation.");
        });
    },
    closeRecommendModal() {
      this.showRecommendModal = false;
    },
    closeLogModal() {
      this.showLogModal = false;
    },

    submitForm() {
      const logId = uuidv4();
      const timestamp = new Date().toISOString().slice(0, 19).replace('T', ' ');
      const payload = {
        logId,
        techniqueId: this.technique.techniqueId,
        comments: this.form.comments,
        timestamp,
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
        comments: '',
      };
    },
  },

  mounted() {
    this.fetchTechniqueDetails();
    this.fetchSupervisedEmployees();
  },
};
</script>

<style scoped>
.container {
  max-width: 800px;
  margin: 0 auto;
}

.table {
  margin-top: 20px;
}

button {
  font-size: 1rem;
  font-weight: 500;
}

.modal-content {
  border-radius: 8px;
  padding: 20px;
}

.list-group-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
