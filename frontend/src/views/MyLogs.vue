<template>
  <div>
    <!-- Bar Chart -->
    <div class="chart-container mt-4">
      <canvas id="logsBarChart"></canvas>
    </div>

    <!-- Logs Table -->
    <LogsTable :employeeId="localEmployeeId" />
  </div>
</template>

<script>
import LogsTable from "../components/LogsTable.vue";
import { Chart, registerables } from "chart.js";

export default {
  components: {
    LogsTable,
  },
  data() {
    return {
      localEmployeeId: localStorage.getItem("employeeId"),
      mindfulnessLogCount: 0,
      timeManagementLogCount: 0,
      chart: null, // Chart instance
    };
  },
  methods: {
    async fetchLogCounts() {
      try {
        const mindfulnessLogsResponse = await fetch(
          `http://localhost:3000/api/mindfulness-logs-count/${this.localEmployeeId}`
        );
        const timeManagementLogsResponse = await fetch(
          `http://localhost:3000/api/time-management-logs-count/${this.localEmployeeId}`
        );

        const mindfulnessLogs = await mindfulnessLogsResponse.json();
        const timeManagementLogs = await timeManagementLogsResponse.json();

        // Extract the counts grouped by techniqueId/toolId
        this.mindfulnessLogCount = mindfulnessLogs.reduce((sum, log) => sum + log.logCount, 0);
        this.timeManagementLogCount = timeManagementLogs.reduce((sum, log) => sum + log.logCount, 0);

        this.updateChart();
      } catch (error) {
        console.error("Error fetching log counts:", error);
      }
    }
    ,
    updateChart() {
      if (this.chart) {
        this.chart.destroy(); // Destroy the previous chart instance
      }

      const ctx = document.getElementById("logsBarChart").getContext("2d");

      this.chart = new Chart(ctx, {
        type: "bar",
        data: {
          labels: ["Mindfulness Logs", "Time Management Logs"], // These remain unchanged
          datasets: [
            {
              label: "Log Counts",
              data: [this.mindfulnessLogCount, this.timeManagementLogCount],
              backgroundColor: ["rgba(75, 192, 192, 0.2)", "rgba(255, 99, 132, 0.2)"],
              borderColor: ["rgba(75, 192, 192, 1)", "rgba(255, 99, 132, 1)"],
              borderWidth: 1,
            },
          ],
        },
        options: {
          responsive: true,
          plugins: {
            legend: {
              display: true,
              position: "top",
            },
            title: {
              display: true,
              text: "Comparison of Mindfulness and Time Management Logs",
            },
          },
          scales: {
            y: {
              beginAtZero: true,
              title: {
                display: true,
                text: "Number of Logs",
              },
            },
          },
        },
      });

    },
  },
  mounted() {
    Chart.register(...registerables); // Register Chart.js components
    this.fetchLogCounts(); // Fetch the log counts on component mount
  },
};
</script>

<style>
.chart-container {
  width: 100%;
  max-width: 600px;
  margin: 0 auto;
}
</style>
