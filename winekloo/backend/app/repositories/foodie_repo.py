from app.db import db
from app.models.foodie_model import Foodie

class FoodieRepository:
    @staticmethod
    def add_foodie(data):
        response = db.table("foodie").insert(data).execute()
        return response.data if response.data else None

    @staticmethod
    def get_foodie_by_id(foodie_id):
        return Foodie.query.filter_by(FoodieID=foodie_id).first()
       

    @staticmethod
    def get_all_foodies():
        response = db.table("foodie").select("*").execute()
        return response.data if response.data else None

    @staticmethod
    def delete_foodie(foodie_id):
        response = db.table("foodie").delete().eq("FoodieID", foodie_id).execute()
        return response.data if response.data else None

    @staticmethod
    def update_foodie(foodie_id, updates):
        response = db.table("foodie").update(updates).eq("FoodieID", foodie_id).execute()
        return response.data if response.data else None
