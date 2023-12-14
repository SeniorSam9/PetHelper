import express from "express";
import { db } from "../firebase/firebase.js";
import {
    addDoc,
    collection,
    deleteDoc,
    doc,
    getDocs,
    updateDoc,
} from "firebase/firestore";

export const petsRouter = express.Router();

// get all pets
petsRouter.get("/", async (req, res) => {
    const pets = [];
    // FIXME: get pets from db
    const ref = collection(db, "pets");
    const snapshot = await getDocs(ref);
    snapshot.forEach((doc) => {
        pets.push({ ...doc.data(), id: doc.id });
    });
    console.log(pets);
    res.json({ status: true, data: pets });
});
// add pet

petsRouter.post("/", async (req, res) => {
    const { uid, pet } = req.body;
    console.log(uid, pet);
    const ref = collection(db, "User", uid, "Pets");
    const docRef = await addDoc(ref, pet);
    console.log(docRef);
    res.json({ status: true });
});

// delete pet
petsRouter.delete("/", async (req, res) => {
    const { uid, petId } = req.body;
    const ref = doc(db, "User", uid, "Pets", petId);
    await deleteDoc(ref);
    res.json({ status: true });
});

// update pet
petsRouter.put("/", async (req, res) => {
    const { uid, petId, pet } = req.body;
    const ref = doc(db, "User", uid, "Pets", petId);
    await updateDoc(ref, pet);
    res.json({ status: true });
});
