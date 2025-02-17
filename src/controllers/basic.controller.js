import basicService from "../services/basic.service.js";

function getEntities(entity) {
  return async (req, res, next) => {
    try {
      const result = await basicService.getEntities(entity, {
        ...req.query,
        ...req.params,
        ...req.body,
        user: req.user,
      });

      res.send(result);
    } catch (err) {
      next(err);
    }
  };
}

function createEntity(entity) {
  return async (req, res, next) => {
    try {
      const result = await basicService.createEntity(
        entity,
        {
          ...req.query,
          ...req.params,
          ...req.body,
        },
        req.user
      );

      res.send(result);
    } catch (err) {
      next(err);
    }
  };
}

function updateEntity(entity) {
  return async (req, res, next) => {
    try {
      const result = await basicService.updateEntity(
        entity,
        {
          ...req.query,
          ...req.params,
          user: req.user,
        },
        req.body
      );

      res.send(result);
    } catch (err) {
      next(err);
    }
  };
}

function deleteEntity(entity) {
  return async (req, res, next) => {
    try {
      const result = await basicService.deleteEntity(entity, {
        ...req.query,
        ...req.params,
        ...req.body,
        user: req.user,
      });

      res.send(result);
    } catch (err) {
      next(err);
    }
  };
}

export default {
  getEntities,
  createEntity,
  updateEntity,
  deleteEntity,
};
