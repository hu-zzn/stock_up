// routes/routes.js
import express from "express";
import { Item, List } from "../models/models.js";

const router = express.Router();

//ITEM ROUTES

// Get all unique categories
router.get("/categories", async (req, res) => {
  try {
    console.log("Route hit");
    const categories = await Item.distinct("category");
    console.log("Categories:", categories);
    res.json(categories);
  } catch (err) {
    console.error("Error fetching categories:", err);
    res.status(500).json({ error: err.message });
  }
});


// Get all items in a specific category
router.get("/items/:category", async (req, res) => {
  try {
    const items = await Item.find({ category: req.params.category });
    res.json(items);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

//LIST ROUTES

// Create new list
router.post("/lists", async (req, res) => {
  try {
    const newList = new List(req.body);
    await newList.save();
    res.status(201).json(newList);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// Get all lists
router.get("/lists", async (req, res) => {
  try {
    const lists = await List.find();
    res.json(lists);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Get single list by ID
router.get("/lists/:id", async (req, res) => {
  try {
    const list = await List.findOne({ id: req.params.id });
    if (!list) return res.status(404).json({ message: "List not found" });
    res.json(list);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

export default router;
