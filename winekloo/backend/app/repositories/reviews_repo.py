from app.db import db
from app.models.reviews import Reviews
from app.models.foodie_model import Foodie
from flask import jsonify
from sqlalchemy.orm import Session
from datetime import date

class ReviewRepository:
    @staticmethod
    def add_review(foodie_id, restaurateur_id, comment, rating):
        new_review = Reviews(
            FoodieID=foodie_id,
            RestaurateurID=restaurateur_id,
            Comment=comment,
            Rating=rating,
            Date=date.today()
        )
        db.session.add(new_review)
        db.session.commit()
        return new_review


    @staticmethod
    def get_all_reviews(restaurateurID):
        reviews_with_full_name = (
            db.session.query(Reviews, Foodie.full_name)
            .join(Foodie, Reviews.FoodieID == Foodie.FoodieID)
            .filter(Reviews.RestaurateurID == restaurateurID)
            .all()
        )
        return reviews_with_full_name

