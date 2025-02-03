from app.db import db
from app.models.reviews_model import Review

class ReviewRepository:
    
    @staticmethod
    def create_review(new_review):
        response = db.table('reviews').insert(new_review.to_dict()).execute()
        return response.data if response.data else None

    @staticmethod
    def get_all_reviews():
        response = db.table('reviews').select('*').execute()
        return response.data if response.data else None

    @staticmethod
    def delete_review(review_id):
        response = db.table('reviews').delete().eq('ReviewID', review_id).execute()
        return response.data if response.data else None
