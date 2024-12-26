<template>
  <div class="container mt-5">
    <h2 class="text-center mb-4">Mindfulness Techniques</h2>
    <div v-if="mindfulnessTechniques.length > 0">
      <ul class="list-group">
        <li v-for="technique in mindfulnessTechniques" :key="technique.techniqueId"
          class="list-group-item d-flex justify-content-between align-items-center">
          <div>
            <strong>{{ technique.techniqueName || "Unnamed Technique" }}</strong>
          </div>
          <div>
            <button v-if="this.healthProfessional == technique.healthProfId" class="btn btn-link btn-sm"
              @click="goToEditTechnique(technique.techniqueId)">
              Edit
            </button>
            <button class="btn btn-primary btn-sm" @click="viewTechnique(technique.techniqueId)">
              View
            </button>

          </div>

        </li>
      </ul>
    </div>

    <!-- No Techniques Message -->
    <div v-else class="text-center text-muted mt-3">
      <p>No mindfulness techniques available.</p>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      mindfulnessTechniques: [], // Holds the list of techniques
    };
  },
  methods: {
    fetchMindfulnessTechniques() {
      axios
        .get("http://localhost:3000/api/mindfulness-techniques")
        .then((response) => {
          this.mindfulnessTechniques = response.data.map((technique) => ({
            ...technique,
            techniqueName: technique.title || technique.techniqueName || "Unnamed Technique",
          }));
        })
        .catch((error) => {
          console.error("Error fetching mindfulness techniques:", error);
        });
    },
    viewTechnique(techniqueId) {
      this.$router.push(`/techniques/${techniqueId}`);
    },
    goToEditTechnique(techniqueId) {
      this.$router.push(`/edit-technique/${techniqueId}`);
    }
  },
  mounted() {
    this.fetchMindfulnessTechniques();
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
