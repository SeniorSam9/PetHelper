import express from "express";
import {
    auth,
    signInWithEmailAndPassword,
    createUserWithEmailAndPassword,
    setDoc,
    doc,
    db,
} from "../firebase/firebase.js";

export const authRouter = express.Router();

authRouter.post("/login", async (req, res) => {
    const { email, password } = req.body;

    try {
        signInWithEmailAndPassword(auth, email, password)
            .then((userCreds) => {
                console.log("user creds are", userCreds);
                res.status(201).json({
                    success: true,
                    data: userCreds.user.uid,
                });
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

authRouter.post("/signup", async (req, res) => {
    const { name, email, password } = req.body;

    try {
        createUserWithEmailAndPassword(auth, email, password)
            .then((userCreds) => {
                const user = userCreds.user;
                setDoc(doc(db, "User", user.uid), { name, email })
                    .then((data) =>
                        console.log("user is added successfully ", data)
                    )
                    .catch((e) => {
                        console.log("failed in adding new user ", e);
                        return res.status(401).json({ success: false });
                    });
                res.status(201).json({ success: true });
            })
            .catch((e) => {
                console.log("error in creating new account in ", e);
                res.status(401).json({ success: false });
            });
    } catch (error) {
        console.error("Server Internal Error:", error);
        res.status(401).json({ success: false });
    }
});
