<template>
  <div class="container my-4">
    <!-- Bootstrap Tabs -->
    <ul class="nav nav-tabs">
      <li class="nav-item" v-if="!isHealthProfessional">
        <a class="nav-link" :class="{ active: activeTab === 'forYou' }" @click="activeTab = 'forYou'">
          Recommendations for You
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" :class="{ active: activeTab === 'madeByYou' }" @click="activeTab = 'madeByYou'">
          Recommendations Made by You
        </a>
      </li>
    </ul>

    <div class="tab-content">
      <!-- Recommendations for You -->
      <div v-show="activeTab === 'forYou' && !isHealthProfessional" id="userRecommendations">
        <h3>Recommendations for You</h3>
        <table class="table table-bordered mt-3" v-if="recommendationsForYou.length">
          <thead>
            <tr>
              <th>Recommendation Type</th>
              <th>Recommendation Title</th>
              <th>Description</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="recommendation in recommendationsForYou" :key="recommendation.techniqueId">
              <td>{{ recommendation.type }}</td>
              <td>{{ recommendation.title }}</td>
              <td>{{ recommendation.description }}</td>
              <td>
                <button class="btn btn-primary" @click="recommendation.type === 'mindfulness' ? viewTechnique(recommendation.techniqueId) :
                  recommendation.type === 'time-management' ? viewTool(recommendation.techniqueId) : null">
                  View Resource
                </button>
              </td>
            </tr>
          </tbody>
        </table>
        <p v-else>No recommendations available.</p>
      </div>

      <!-- Recommendations Made by You -->
      <div v-show="activeTab === 'madeByYou'" id="madeByUserRecommendations">
        <h3>Recommendations Made by You</h3>
        <table class="table table-bordered mt-3" v-if="recommendationsMadeByYou.length">
          <thead>
            <tr>
              <th>Recommendation Type</th>
              <th>Recipient</th>
              <th>Recommendation Title</th>
              <th>Description</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="recommendation in recommendationsMadeByYou" :key="recommendation.techniqueId">
              <td>{{ recommendation.type }}</td>
              <td>{{ recommendation.recipient }}</td>
              <td>{{ recommendation.title }}</td>
              <td>{{ recommendation.description }}</td>
              <td>
                <button class="btn btn-primary w-100" @click="recommendation.type === 'mindfulness' ? viewTechnique(recommendation.techniqueId) :
                  recommendation.type === 'time-management' ? viewTool(recommendation.techniqueId) : null">
                  View Resource
                </button>
                <button class="btn btn-danger w-100"
                  @click="recommendation.type === 'mindfulness' ? deleteMindfulnessRecommendation(recommendation.recommendationId) :
                    recommendation.type === 'time-management' ? deleteTimeManagementRecommendation(recommendation.recommendationId) : null">
                  Delete
                </button>
              </td>
            </tr>
          </tbody>
        </table>
        <p v-else>No recommendations made by you.</p>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  props: {
    employeeId: String,
    healthProfId: String,
  },
  data() {
    return {
      activeTab: 'forYou',
      recommendationsForYou: [],
      recommendationsMadeByYou: [],
    };
  },
  computed: {
    isHealthProfessional() {
      return localStorage.getItem('healthProfId') !== null;
    },
  },
  mounted() {
    if (!this.isHealthProfessional) {
      this.fetchRecommendationsForYou();
    }
    this.fetchRecommendationsMadeByYou();
  },
  methods: {
    fetchRecommendationsForYou() {
      axios
        .get(`http://localhost:3000/api/recommendations/for-user/${this.employeeId}`)
        .then(response => {
          this.recommendationsForYou = response.data;
          console.log(this.recommendationsForYou);
        })
        .catch(error => {
          console.error("Error fetching recommendations for you:", error);
        });
    },
    fetchRecommendationsMadeByYou() {
      const userId = this.healthProfId || this.employeeId;
      console.log("Fetching recommendations made by:", userId);

      axios
        .get(`http://localhost:3000/api/recommendations/made-by/${userId}`)
        .then(response => {
          this.recommendationsMadeByYou = response.data;
          console.log(this.recommendationsMadeByYou);
        })
        .catch(error => {
          console.error("Error fetching recommendations made by you:", error);
        });
    },
    deleteMindfulnessRecommendation(recommendationId) {
      if (confirm("Are you sure you want to delete mindfulness recommendation? This action cannot be undone.")) {
        axios.delete(`http://localhost:3000/api/mindfulnessrecommendations/${recommendationId}`)
          .then(response => {
            console.log(response.data);
            alert('Recommendation deleted successfully!');
            this.fetchRecommendationsMadeByYou();
          })
          .catch(error => {
            console.error(error);
            alert('Error deleting recommendation');
          });
      }
    },
    deleteTimeManagementRecommendation(recommendationId) {
      if (confirm("Are you sure you want to delete time management recommendation? This action cannot be undone.")) {
        axios.delete(`http://localhost:3000/api/timemanagementrecommendations/${recommendationId}`)
          .then(response => {
            console.log(response.data);
            alert('Recommendation deleted successfully!');
            this.fetchRecommendationsMadeByYou();
          })
          .catch(error => {
            console.error(error);
            alert('Error deleting recommendation');
          });
      }
    },
    viewTool(toolId) {
      console.log(toolId);
      this.$router.push(`/tools/${toolId}`);
    },
    viewTechnique(techniqueId) {
      console.log(techniqueId);
      this.$router.push(`/techniques/${techniqueId}`);
    },
  },
};
</script>
