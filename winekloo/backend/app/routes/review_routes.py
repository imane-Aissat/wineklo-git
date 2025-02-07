from flask import Blueprint, request, jsonify, session
from datetime import date
from app.repositories.reviews_repo import ReviewRepository

reviews_bp = Blueprint('reviews_bp', __name__,)


@reviews_bp.route('/reviews/<int:id>', methods = ['GET'])
def get_all_reviews_of_restaurateurs(id):
    reviews_with_full_name = ReviewRepository.get_all_reviews(id)
    
    formatted_reviews = []
    for review, foodie_name in reviews_with_full_name:
        formatted_reviews.append(review.to_json(foodie_name))
    
    return jsonify(formatted_reviews)


@reviews_bp.route('/add/review/<int:restaurateur_id>', methods = ['POST'])

def add_review_route(restaurateur_id):
    data = request.json
    comment = data.get("Comment")
    rating = data.get("Rating")

    if not rating:
        return jsonify({"error": "Rating is required"}), 400

    review = ReviewRepository.add_review(
        foodie_id=data.get("FoodieID"),  
        restaurateur_id=restaurateur_id,
        comment=comment,
        rating=rating
    )

    return jsonify({
        "message": "Review added successfully",
        "ReviewID": review.ReviewID,
        "Date": review.Date.isoformat()
    }), 201
