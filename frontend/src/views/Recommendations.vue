<template>
    <div>
        <!-- Bar Chart -->
        <div class="chart-container mt-4">
            <canvas id="recommendationsBarChart"></canvas>
        </div>

        <!-- Recommendations Table -->
        <RecommendationsTable :employeeId="localEmployeeId" :healthProfId="localHealthProfId" />
    </div>
</template>
  
<script>
import RecommendationsTable from "../components/RecommendationsTable.vue";
import { Chart, registerables } from "chart.js";

export default {
    components: {
        RecommendationsTable,
    },
    props: {
        employeeId: {
            type: String,
            default: null,
        },
        healthProfId: {
            type: String,
            default: null,
        },
    },
    data() {
        return {
            localEmployeeId: this.employeeId || localStorage.getItem("employeeId"),
            localHealthProfId: this.healthProfId || localStorage.getItem("healthProfId"),
            recommendationsForYouCount: 0,
            recommendationsByYouCount: 0,
            chart: null, // Chart instance
        };
    },
    methods: {
        async fetchRecommendationCounts() {
            try {
                const response = await fetch(
                    `http://localhost:3000/api/recommendations-count/${this.localEmployeeId}/${this.localHealthProfId}`
                );
                const data = await response.json();

                // Extract grouped counts for "recommendationsForYou" and "recommendationsByYou"
                this.recommendationsForYouCount = data
                    .filter((item) => item.type === "recommendationsForYou")
                    .reduce((sum, item) => sum + item.count, 0);

                this.recommendationsByYouCount = data
                    .filter((item) => item.type === "recommendationsByYou")
                    .reduce((sum, item) => sum + item.count, 0);

                this.updateChart();
            } catch (error) {
                console.error("Error fetching recommendation counts:", error);
            }
        }
        ,
        updateChart() {
            if (this.chart) {
                this.chart.destroy(); // Destroy the previous chart instance
            }

            const ctx = document.getElementById("recommendationsBarChart").getContext("2d");

            this.chart = new Chart(ctx, {
                type: "bar",
                data: {
                    labels: ["Recommendations For You", "Recommendations By You"], // These remain unchanged
                    datasets: [
                        {
                            label: "Recommendation Counts",
                            data: [this.recommendationsForYouCount, this.recommendationsByYouCount],
                            backgroundColor: ["rgba(153, 102, 255, 0.2)", "rgba(54, 162, 235, 0.2)"],
                            borderColor: ["rgba(153, 102, 255, 1)", "rgba(54, 162, 235, 1)"],
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
                            text: "Comparison of Recommendations For You and By You",
                        },
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: "Number of Recommendations",
                            },
                        },
                    },
                },
            });

        },
    },
    mounted() {
        Chart.register(...registerables); // Register Chart.js components
        this.fetchRecommendationCounts(); // Fetch the recommendation counts on component mount
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
  