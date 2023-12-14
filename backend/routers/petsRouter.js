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
    try {
        const userCollectionRef = collection(db, "User");
        const pets = [];

        const userSnapshot = await getDocs(userCollectionRef);
        const promises = userSnapshot.docs.map(async (userDoc) => {
            const petsCollectionRef = collection(userDoc.ref, "Pets");
            const petsSnapshot = await getDocs(petsCollectionRef);

            petsSnapshot.forEach((petDoc) => {
                pets.push({ ...petDoc.data(), id: petDoc.id });
                console.log("PET WITH INDEX", petDoc.data());
            });
        });

        await Promise.all(promises);

        console.log("pets calling");
        console.log(pets);
        res.json({ status: true, data: pets });

        // res.json({ status: true, data: pets });
        // const usersSnapshot = db.collection("User").get();
        // for (const userDoc of usersSnapshot.docs) {
        //     const userPetsSnapshot = await userDoc.ref.collection("Pets").get();

        //     userPetsSnapshot.forEach((petDoc) => {
        //         pets.push({ ...petDoc.data(), id: petDoc.id });
        //     });
        // }
        // console.log("pets calling");
        // console.log(pets);
    } catch (error) {
        console.error("Error retrieving pets:", error);
        res.status(500).json({ error: "Failed to retrieve pets." });
    }
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
