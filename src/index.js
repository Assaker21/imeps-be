import express from "express";
import entities from "./entities.js";
import generateRouter from "./routes/basic.route.js";
import authRoutes from "./routes/auth.route.js";
import cors from "cors";

const app = express();
app.use(cors());
app.use(express.json());

app.use(authRoutes);

entities.forEach((entity) => {
  app.use(generateRouter(entity));
});

app.use((err, req, res, next) => {
  console.error(err.stack);

  res.status(err.status || 500).json({
    success: false,
    message: err.message || "Internal Server Error",
  });
});

app.listen(3000, () => {
  console.log("Server is running: 3000");
});
