import express from "express";
import { db } from "../firebase/firebase.js";
export const authRouter = express.Router();

authRouter.post("/login", (req, res) => {
  res.json({ msg: "login api reached" });
});
