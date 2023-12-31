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

// add favorite
petsRouter.post("/favorite", async (req, res) => {
    try {
        const { petId, userId } = req.body;
        const favoritesRef = collection(db, "User", userId, "Favorites");
        await addDoc(favoritesRef, { petId, userId });
        res.json({ status: true });
    } catch (error) {
        console.error("Error adding favorite:", error);
        res.status(500).json({ error: "Failed to add favorite." });
    }
});

// delete favorite
petsRouter.delete("/favorite", async (req, res) => {
    try {
        const { petId, userId } = req.body;
        const favoritesRef = collection(db, "User", userId, "Favorites");
        const querySnapshot = await getDocs(favoritesRef);
        const favoriteDoc = querySnapshot.docs.find(
            (doc) => doc.data().petId === petId && doc.data().userId === userId
        );

        if (favoriteDoc) {
            await deleteDoc(doc(favoritesRef, favoriteDoc.id));
            res.json({
                status: true,
                message: "Favorite deleted successfully.",
            });
        } else {
            res.status(404).json({ error: "Favorite not found." });
        }
    } catch (error) {
        console.error("Error deleting favorite:", error);
        res.status(500).json({ error: "Failed to delete favorite." });
    }
});

// Assuming you have a route like "/favorites/:userId" where ":userId" is the user ID
petsRouter.get("/favorites/:userId", async (req, res) => {
    try {
        const userId = req.params.userId;
        const favoritesRef = collection(db, "User", userId, "Favorites");
        const querySnapshot = await getDocs(favoritesRef);

        const favoritePets = querySnapshot.docs.map((doc) => {
            // Assuming each document contains a "petId" field
            return { petId: doc.data().petId };
        });
        console.log("FAV: ", favoritePets);

        res.json({ status: true, data: favoritePets });
    } catch (error) {
        console.error("Error getting favorite pets:", error);
        res.status(500).json({ error: "Failed to get favorite pets." });
    }
});
