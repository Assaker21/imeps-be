import prisma from "../prisma.js";

async function getEntities(entity, query) {
  const prismaQuery = (await entity?.get?.buildPrismaQuery?.(query)) || {
    where: {
      deletedAt: null,
    },
  };
  const result = await prisma[entity.name].findMany(prismaQuery);
  return (await entity?.get?.formatResult?.(result)) || result;
}

async function createEntity(entity, data, user) {
  const prismaQuery = (await entity?.create?.buildPrismaQuery?.(
    data,
    user
  )) || {
    data,
  };
  const result = await prisma[entity.name].create(prismaQuery);
  return (await entity?.create?.formatResult?.(result)) || result;
}

async function updateEntity(entity, query, data) {
  const prismaQuery = (await entity.update?.buildPrismaQuery?.(
    query,
    data
  )) || {
    where: { deletedAt: null, id: query.id },
    data,
  };
  const result = await prisma[entity.name].update(prismaQuery);
  return (await entity?.update?.formatResult?.(result)) || result;
}

async function deleteEntity(entity, query) {
  const prismaQuery = (await entity.delete?.buildPrismaQuery?.(query)) || {
    where: { deletedAt: null, id: query.id },
    data: {
      deletedAt: new Date(),
    },
  };
  const result = await prisma[entity.name].update(prismaQuery);
  return (await entity?.delete?.formatResult?.(result)) || result;
}

export default {
  getEntities,
  createEntity,
  updateEntity,
  deleteEntity,
};
