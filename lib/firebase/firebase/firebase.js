import {
  getFirestore,
  collection,
  getDocs,
  getDoc,
  deleteDoc,
  doc,
  query,
  orderBy,
  where,
  addDoc,
  setDoc,
  updateDoc,
  onSnapshot,
} from "firebase/firestore";
import { initializeApp } from "firebase/app";
import {
  getAuth,
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  signInWithCustomToken,
  signOut,
} from "firebase/auth";
import { initializeAuth } from "firebase/auth";
const firebaseConfig = {
  apiKey: "AIzaSyAtHSciFbQDdX-KvHb7VQymWv25bO5ycPE",
  authDomain: "pet-helper-d7674.firebaseapp.com",
  projectId: "pet-helper-d7674",
  storageBucket: "pet-helper-d7674.appspot.com",
  messagingSenderId: "808605250051",
  appId: "1:808605250051:web:570001d5fc3e289610d436",
};

const app = initializeApp(firebaseConfig);
const db = getFirestore(app);
const auth = initializeAuth(app);

export {
  auth,
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  signInWithCustomToken,
  signOut,
  db,
  collection,
  getDocs,
  getDoc,
  doc,
  setDoc,
  orderBy,
  query,
  where,
  addDoc,
  deleteDoc,
  updateDoc,
  onSnapshot,
};
