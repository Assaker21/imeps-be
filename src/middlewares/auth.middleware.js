import jwt from "jsonwebtoken";
import prisma from "../prisma.js";

export default async function auth(req, res, next) {
  try {
    const token = req.headers["authorization"];

    console.log("TOKEN: ", token);

    const decodedToken = jwt.verify(token, "asd");

    const id = decodedToken.id;
    const user = await prisma.user.findUnique({
      where: {
        id,
        deletedAt: null,
      },
    });

    if (!user) throw new Error("User was deleted");

    req.user = user;
    next();
  } catch (err) {
    console.log(err);
    res.status(401).send("Unauthorized");
  }
}
