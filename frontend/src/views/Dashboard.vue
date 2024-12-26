<template>
  <div>
    <div v-if="localEmployeeId">
      <EmployeeWellnessLog :employeeId="localEmployeeId" class="mt-4" />
    </div>

    <SupervisedEmployeeWellness :supervisedEmployeeWellness="supervisedEmployeeWellness" />
  </div>
</template>

<script>
import EmployeeWellnessLog from '../components/EmployeeWellnessLog.vue';
import SupervisedEmployeeWellness from '../components/SupervisedEmployeeWellness.vue';
import LogsTable from '../components/LogsTable.vue';

export default {
  components: {
    EmployeeWellnessLog,
    SupervisedEmployeeWellness,
    LogsTable
  },
  props: {
    employeeId: {
      type: String,
      default: null
    },
    healthProfId: {
      type: String,
      default: null
    }
  },
  data() {
    return {
      localEmployeeId: this.employeeId || localStorage.getItem('employeeId'),
      localHealthProfId: this.healthProfId || localStorage.getItem('healthProfId'),
      supervisedEmployeeWellness: []
    };
  },
  mounted() {
    this.fetchSupervisedEmployeeWellness();
  },
  methods: {
    fetchSupervisedEmployeeWellness() {
      if (this.localEmployeeId) {
        fetch(`http://localhost:3000/api/employee-wellness-logs/supervisor/${this.localEmployeeId}`)
          .then(response => response.json())
          .then(data => {
            this.supervisedEmployeeWellness = data;
          })
          .catch(error => {
            console.error("Error fetching wellness logs for supervised employees:", error);
          });
      } else if (this.localHealthProfId) {
        fetch(`http://localhost:3000/api/employee-wellness-logs/health-professional/${this.localHealthProfId}`)
          .then(response => response.json())
          .then(data => {
            this.supervisedEmployeeWellness = data;
          })
          .catch(error => {
            console.error("Error fetching wellness logs for supervised employees:", error);
          });
      }
    }
  }
};
</script>

<style>
.supervised-employees {
  display: flex;
  flex-direction: column;
  padding: 0;
}
</style>
