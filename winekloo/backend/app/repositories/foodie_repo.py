from app.db import db
from app.models.foodie_model import Foodie
from sqlalchemy.orm import Session
from sqlalchemy import update, delete


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

    def delete_foodie(foodie_id):
        with db.session.begin():  # Use session to handle transactions
            stmt = delete(Foodie).where(Foodie.FoodieID == foodie_id)
            result = db.session.execute(stmt)
            db.session.commit()

        if result.rowcount > 0:
            print("Deletion successful")
            return {"message": "Foodie deleted successfully"}
        else:
            print("No records deleted")
            return {"error": "Foodie not found"}

    def update_foodie(foodie_id, updates):
        try:
            print("Database Columns:", {column.name for column in Foodie.__table__.columns})
            print("Updates Dictionary:", updates.keys())
            stmt = update(Foodie).where(Foodie.FoodieID == foodie_id).values(**updates)
            result = db.session.execute(stmt) 
            db.session.commit() 

            if result.rowcount > 0:  
                print("Update successful")
                return {"message": "Profile updated successfully"}
            else:
                print("No records updated")
                return {"error": "Foodie not found or no changes made"}
                

        except Exception as e:
            print(f"Database update error: {e}")  
            db.session.rollback() 
            return {"error": "Internal server error"}
