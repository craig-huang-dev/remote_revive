import { createRouter, createWebHistory } from "vue-router";
import LandingPage from "../views/Registration/LandingPage.vue";
import EmployeeRegistration from "../views/Registration/EmployeeRegistration.vue";
import HealthProfRegistration from "../views/Registration/HealthProfRegistration.vue";
import CreateMindfulnessTechnique from "../views/ToolsTechniques/CreateMindfulnessTechnique.vue";
import CreateTimeManagementTool from "../views/ToolsTechniques/CreateTimeManagementTool.vue";
import EmployeeLogin from "../views/Login/EmployeeLogin.vue";
import HealthProfLogin from "../views/Login/HealthProfLogin.vue";
import Dashboard from "../views/Dashboard.vue";
import EditEmployeeProfile from "@/views/EditEmployeeProfile.vue";
import EmployeeProfile from "@/views/EmployeeProfile.vue";
import RecommendMindfulnessTechnique from "@/views/RecommendMindfulness.vue";
import RecommendTimeManagementTool from "@/views/RecommendTimeManagement.vue";
import LogTimeManagementActivity from "@/views/LogTimeManagementActivity.vue";
import LogMindfulnessActivity from "@/views/LogMindfulnessActivity.vue";
import EditMindfulnessLog from "../views/EditMindfulnessLog.vue";
import EditTimeManagementLog from "../views/EditTimeManagementLog.vue";
import HealthProfessionalProfile from "@/views/HealthProfessionalProfile.vue";
import EditHealthProfessionalProfile from "@/views/EditHealthProfessionalProfile.vue";
import LogEmployeeWellness from "@/views/LogEmployeeWellness.vue";
import SupervisorLookup from "@/components/SupervisorLookup.vue";
import HealthProfessionalLookup from "@/components/HealthProfessionalLookup.vue";
import ToolsList from "@/views/ToolsList.vue";
import ToolDetails from "@/views/ToolDetails.vue";
import TechniquesList from "@/views/TechniquesList.vue";
import TechniqueDetails from "@/views/TechniqueDetails.vue";
import MyLogs from "@/views/MyLogs.vue";
import Recommendations from "@/views/Recommendations.vue";
import EditTechnique from "@/views/EditTechnique.vue";
import EditTool from "@/views/EditTool.vue";

const routes = [
    {
        path: "/",
        name: "Landing Page",
        component: LandingPage
    },
    {
        path: "/register-employee",
        name: "Employee Registration",
        component: EmployeeRegistration,
    },
    {
        path: "/register-health-prof",
        name: "Health Professional Registration",
        component: HealthProfRegistration,
    },
    {
        path: "/login-employee",
        name: "Employee Login",
        component: EmployeeLogin
    },
    {
        path: "/login-health-prof",
        name: "Health Professional Login",
        component: HealthProfLogin,
    },
    {
        path: "/create-mindfulness-technique",
        name: "Create Mindfulness Technique",
        component: CreateMindfulnessTechnique,
    },
    {
        path: "/create-time-management-tool",
        name: "Create Time Management Tool",
        component: CreateTimeManagementTool,
    },
    {
        path: "/dashboard",
        name: "Dashboard",
        component: Dashboard,
    },
    {
        path: '/tools',
        name: 'timeManagementTools',
        component: ToolsList,
    },
    {
        path: '/techniques',
        name: 'mindfulnessTechniques',
        component: TechniquesList,
    },
    {
        path: "/techniques/:techniqueId",
        name: "TechniqueDetails",
        component: TechniqueDetails,
        props: true,
    },
    {
        path: "/edit-employee-profile/:employeeId",
        name: "Edit Employee Profile",
        component: EditEmployeeProfile,
    },
    {
        path: "/tools/:toolId",
        name: "ToolDetails",
        component: ToolDetails,
        props: true,
    },
    {
        path: "/employees/:employeeId",
        name: "Employee Profile",
        component: EmployeeProfile,
        props: true,
    },
    {
        path: "/recommend-mindfulness",
        name: "Recommend Mindfulness",
        component: RecommendMindfulnessTechnique,
    },
    {
        path: "/recommend-time-management",
        name: "Recommend Time Management",
        component: RecommendTimeManagementTool,
    },
    {
        path: "/log-time-management-activity",
        name: "Log Time Management Activity",
        component: LogTimeManagementActivity,
    },
    {
        path: "/log-mindfulness-activity",
        name: "Log Mindfulness Activity",
        component: LogMindfulnessActivity,
    },
    {
        path: "/edit-time-management-log/:logId",
        name: "Edit Time Management Log",
        component: EditTimeManagementLog,
        props: true,
    },
    {
        path: "/edit-mindfulness-log/:logId",
        name: "Edit Mindfulness Log",
        component: EditMindfulnessLog,
        props: true,
    },
    {
        path: "/health-professional/:healthProfId",
        name: "Health Professional Profile",
        component: HealthProfessionalProfile,
        props: true,
    },
    {
        path: "/edit-health-professional-profile/:healthProfId",
        name: "Edit Health Professional Profile",
        component: EditHealthProfessionalProfile,
    },
    {
        path: "/log-employee-wellness",
        name: "Log Employee Wellness",
        component: LogEmployeeWellness,
    },
    {
        path: "/supervisor-lookup",
        name: "Supervisor Lookup",
        component: SupervisorLookup,
    },
    {
        path: "/health-professional-lookup",
        name: "Health Professional Lookup",
        component: HealthProfessionalLookup,
    },
    {
        path: "/my-logs",
        name: "My Logs",
        component: MyLogs,
    },
    {
        path: "/recommendations",
        name: "Recommendations",
        component: Recommendations,
    },
    {
        path: "/edit-technique/:techniqueId",
        name: "Edit Technique",
        component: EditTechnique,
        props: true,
    },
    {
        path: "/edit-tool/:toolId",
        name: "Edit Tool",
        component: EditTool,
        props: true,
    },
];
const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;
