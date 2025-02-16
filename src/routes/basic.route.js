import express from "express";
import basicController from "../controllers/basic.controller.js";
import auth from "../middlewares/auth.middleware.js";

function generateRouter(entity) {
  const router = express.Router();
  router.get(`/${entity.url}`, auth, basicController.getEntities(entity));
  router.post(`/${entity.url}`, auth, basicController.createEntity(entity));
  router.put(`/${entity.url}/:id`, auth, basicController.updateEntity(entity));
  router.delete(
    `/${entity.url}/:id`,
    auth,
    basicController.deleteEntity(entity)
  );
  return router;
}

export default generateRouter;
