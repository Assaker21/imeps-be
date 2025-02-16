export default [
  {
    name: "user",
    url: "users",

    get: {
      buildPrismaQuery: (query) => {
        if (query.user.role == "NORMAL") {
          return {
            where: {
              deletedAt: null,
              id: query.user.id,
            },
          };
        } else {
          return {
            where: {
              deletedAt: null,
            },
          };
        }
      },
    },
  },
  {
    name: "country",
    url: "countries",
  },
  {
    name: "university",
    url: "universities",
    get: {
      buildPrismaQuery: (query) => {
        return {
          where: {
            deletedAt: null,
          },
          include: {
            country: true,
          },
        };
      },
    },
  },
  {
    name: "diploma",
    url: "diplomas",
    get: {
      buildPrismaQuery: (query) => {
        return {
          where: {
            deletedAt: null,
          },
          include: {
            university: {
              select: {
                name: true,
              },
            },
          },
        };
      },
    },
  },
  {
    name: "scholarship",
    url: "scholarships",
    get: {
      buildPrismaQuery: (query) => {
        return {
          where: {
            deletedAt: null,
          },
          include: {
            diplomas: true,
          },
        };
      },
    },
    update: {
      buildPrismaQuery: (query, data) => {
        return {
          where: {
            deletedAt: null,
            id: query.id,
          },
          data: {
            ...data,
            diplomas: {
              set: [],
              connect: data.diplomas.map((id) => ({ id })),
            },
          },
        };
      },
    },
    create: {
      buildPrismaQuery: (data) => {
        return {
          data: {
            ...data,
            diplomas: {
              connect: data.diplomas.map((id) => ({ id })),
            },
          },
        };
      },
    },
  },
  {
    name: "user",
    url: "users",
  },
  {
    name: "application",
    url: "applications",
    get: {
      buildPrismaQuery: (query) => {
        if (query.user.role == "NORMAL") {
          return {
            where: {
              deletedAt: null,
              userId: query.user.id,
            },
            include: {
              diploma: true,
              user: true,
            },
          };
        } else {
          return {
            where: {
              deletedAt: null,
            },
            include: {
              diploma: true,
              user: true,
            },
          };
        }
      },
    },
    create: {
      buildPrismaQuery: (query, data) => {
        if (query.user.role == "NORMAL") {
          return { data: { ...data, userId: query.user.id } };
        } else return data;
      },
    },
    update: {
      buildPrismaQuery: (query, data) => {
        return {
          where: {
            id: query.id,
            deletedAt: null,
          },
          data: {
            diploma: {
              connect: { id: data.diplomaId },
            },
            programType: data.programType,
            admitted: data.admitted,
            nominated: data.nominated,
            status: data.status,
          },
        };
      },
    },
  },
  {
    name: "applicationScholarship",
    url: "scholarshipApplications",
    get: {
      buildPrismaQuery: (query) => {
        if (query.user.role == "NORMAL") {
          return {
            where: {
              deletedAt: null,
              application: {
                userId: query.user.id,
              },
            },
            include: {
              application: true,
              scholarship: true,
            },
          };
        } else {
          return {
            where: {
              deletedAt: null,
            },
            include: {
              application: true,
              scholarship: true,
            },
          };
        }
      },
    },
    create: {
      buildPrismaQuery: (data) => {
        return {
          data: {
            application: {
              connect: {
                id: data.applicationId,
              },
            },
            scholarship: {
              connect: {
                id: data.scholarshipId,
              },
            },
            status: data.status,
          },
        };
      },
    },

    update: {
      buildPrismaQuery: (query, data) => {
        return {
          where: {
            id: query.id,
            deletedAt: null,
          },
          data: {
            application: {
              connect: {
                id: data.applicationId,
              },
            },
            scholarship: {
              connect: {
                id: data.scholarshipId,
              },
            },
            status: data.status,
          },
        };
      },
    },
  },
];
