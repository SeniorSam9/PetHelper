import { initializeApp, cert } from "firebase-admin/app";
import { getFirestore } from "firebase-admin/firestore";
import { serviceAccount } from "./petHelper_creds.json";

initializeApp({ credential: cert(serviceAccount) });

const db = getFirestore();

export { db };
