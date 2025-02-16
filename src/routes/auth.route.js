import express from "express";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import prisma from "../prisma.js";
import auth from "../middlewares/auth.middleware.js";

const router = express.Router();

router.post("/login", async (req, res, next) => {
  try {
    const user = await prisma.user.findFirst({
      where: {
        deletedAt: null,
        email: req.body.email.trim(),
      },
    });

    if (!user) throw new Error("User doesn't exist");

    const isSamePassword = bcrypt.compare(req.body.password, user.password);

    if (!isSamePassword) throw new Error("Invalid credentials");

    const token = jwt.sign({ id: user.id, role: user.role }, "asd", {
      expiresIn: "1d",
    });

    res.send({ token });
  } catch (err) {
    next(err);
  }
});

router.post("/register", async (req, res, next) => {
  try {
    let user = await prisma.user.findFirst({
      where: {
        deletedAt: null,
        email: req.body.email.trim(),
      },
    });

    if (user) throw new Error("User already exists");

    const hashedPassword = await bcrypt.hash(req.body.password, 12);

    user = await prisma.user.create({
      data: {
        ...req.body,
        email: req.body.email.trim(),
        password: hashedPassword,
        role: "NORMAL",
      },
    });

    const token = jwt.sign({ id: user.id, role: user.role }, "asd", {
      expiresIn: "1d",
    });

    res.send({ token });
  } catch (err) {
    next(err);
  }
});

router.get("/profile", auth, async (req, res) => {
  res.send(req.user);
});

export default router;
