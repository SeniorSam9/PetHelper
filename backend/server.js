import express from "express";
import cors from "cors";
import dotenv from "dotenv";
// server configs
const server = express();
const port = 3300;
dotenv.config();

// allow requests from anywhere
server.use(cors());

// use json data format
server.use(express.json());

// pet helper test entry router
server.get("/", (req, res) => {
  res.send("Welcome, it is PetHelper app.");
});

// any unmatched router handler
server.use("*", (req, res) => {
  res.status(404).json({
    msg: "Not Found!",
  });
});

// init server socket
server.listen(port, () => {
  console.log(`⚡ server is listening at http://localhost:${port}`);
});
