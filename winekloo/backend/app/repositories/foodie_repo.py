from flask import jsonify
from app.db import db
from app.models.foodie_model import Foodie
from sqlalchemy.orm import Session
from sqlalchemy import update, delete
from sqlalchemy.exc import SQLAlchemyError
import json
from app.models.categories import Categories 
from app.models.pricing import Pricing  
from app.models.dietarypreferences import DietaryPreferences 
from app.models.pricing import Pricing  


class FoodieRepository:
    @staticmethod
    def add_foodie(data):
        try:
            categories_ids = []
            if data.get("categories"):
                for category_name in data.get("categories"):
                    category = Categories.query.filter_by(CategoryName=category_name).first()
                    if category:
                        categories_ids.append(category.CategoryID)
                    else:
                        print(f"Category '{category_name}' not found.")
            
            # Lookup PreferenceID for each dietary preference in the 'dietarypreferences' table
            preferences_ids = []
            if data.get("dietaryOptions"):
                for preference_name in data.get("dietaryOptions"):
                    preference = DietaryPreferences.query.filter_by(PreferenceName=preference_name).first()
                    if preference:
                        preferences_ids.append(preference.PreferenceID)
                    else:
                        print(f"Dietary preference '{preference_name}' not found.")
            
            # Lookup PricingID for each pricing option in the 'pricing' table
            pricing_ids = []
            if data.get("pricing"):
                for pricing_name in data.get("pricing"):
                    pricing = Pricing.query.filter_by(PriceValue=pricing_name).first()
                    if pricing:
                        pricing_ids.append(pricing.PricingID)
                    else:
                        print(f"Pricing option '{pricing_name}' not found.")
            
            # Lookup PricingID for each pricing option in the 'pricing' table
            pricing_ids = []
            if data.get("pricingOptions"):
                for pricing_name in data.get("pricingOptions"):
                    pricing = Pricing.query.filter_by(PricingName=pricing_name).first()
                    if pricing:
                        pricing_ids.append(pricing.PricingID)
                    else:
                        print(f"Pricing option '{pricing_name}' not found.")
            
            new_foodie = Foodie(
                full_name=data.get("full_name"),
                email=data.get("email"),
                phone_number=data.get("phone"),
                password=data.get("password"),
                gender=data.get("gender"),
                wilaya=data.get("wilaya"),
                foodie_categories=categories_ids,  # List of CategoryIDs
                foodie_preferences=preferences_ids,  # List of PreferenceIDs
                foodie_pricing=pricing_ids, # Use the PricingID from the database
            )

            db.session.add(new_foodie)
            db.session.commit()

            if new_foodie.FoodieID is None:
                raise ValueError("Foodie object not saved")
            print(f"Foodie created with ID: {new_foodie.FoodieID}")
            return new_foodie

        except SQLAlchemyError as e:
            db.session.rollback()
            print(f"Database Error: {e}")
            return None

    @staticmethod
    def get_foodie_by_id(foodie_id):
        return Foodie.query.filter_by(FoodieID=foodie_id).first()

    @staticmethod
    def get_foodie_by_email(email):
        return Foodie.query.filter_by(Email=email).first()

    @staticmethod
    def get_all_foodies():
        response = db.table("foodie").select("*").execute()
        return response.data if response.data else None

    def delete_foodie(foodie_id):
        with db.session.begin():  
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
