from app.db import db
from app.models.restaurateur import Restaurateur

class RestaurateurRepository:
    @staticmethod
    def add_restaurateur(data):
        response = db.table("restaurateur").insert(data).execute()
        return response.data if response.data else None

    @staticmethod
    def get_restaurateur_by_id(restaurateur_id):
        return Restaurateur.query.filter_by(RestaurateurID=restaurateur_id).first()

    @staticmethod
    def get_all_restaurateurs():
        return Restaurateur.query.all()

    @staticmethod
    def delete_restaurateur(restaurateur_id):
        response = db.table("restaurateur").delete().eq("RestaurateurID", restaurateur_id).execute()
        return response.data if response.data else None

    @staticmethod
    def update_restaurateur(restaurateur_id, updates):
        response = db.table("restaurateur").update(updates).eq("RestaurateurID", restaurateur_id).execute()
        return response.data if response.data else None
