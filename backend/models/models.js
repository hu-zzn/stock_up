// models/models.js
import mongoose from "mongoose";

const { Schema } = mongoose;

const ItemSchema = new Schema({
  id: { type: String, required: true, unique: true },
  name: { type: String, required: true },
  category: { type: String, required: true },
  defaultUnit: { type: String, required: true },
  brand: { type: String, default: "" },
  isFavorite: { type: Boolean, default: false },
});

const SelectedItemSchema = new Schema({
  itemId: { type: String, required: true },
  quantity: { type: Number, required: true },
  unit: { type: String, required: true },
  brand: { type: String, default: "" },
  notes: { type: String, default: "" },
});

const ListSchema = new Schema({
  id: { type: String, required: true, unique: true },
  title: { type: String, required: true },
  createdAt: { type: Date, default: Date.now },
  items: [SelectedItemSchema],
});

export const Item = mongoose.model("Item", ItemSchema);
export const List = mongoose.model("List", ListSchema);
