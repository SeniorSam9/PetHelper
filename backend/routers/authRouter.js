import express from "express";
import { auth, signInWithEmailAndPassword } from "../firebase/firebase";

export const authRouter = express.Router();

authRouter.post("/login", async (req, res) => {
  const { email, password } = req.body;

  try {
    signInWithEmailAndPassword(auth, email, password)
      .then((userCreds) => {
        console.log("user creds are", userCreds);
        res.status(201).json({ success: true });
      })
      .catch((e) => {
        console.log("error in sigining in ", e);
        res.status(401).json({ success: false });
      });
  } catch (error) {
    console.error("Server Internal Error:", error);
    res.status(401).json({ success: false });
  }
});
