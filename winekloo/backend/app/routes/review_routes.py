from flask import Blueprint, request, jsonify, session
from datetime import date
import jwt
from app.repositories.reviews_repo import ReviewRepository
SECRET_KEY = "key"

reviews_bp = Blueprint('reviews_bp', __name__,)


@reviews_bp.route('/reviews/<int:id>', methods = ['GET'])
def get_all_reviews_of_restaurateurs(id):
    reviews_with_full_name = ReviewRepository.get_all_reviews(id)
    
    formatted_reviews = []
    for review, foodie_name in reviews_with_full_name:
        formatted_reviews.append(review.to_json(foodie_name))
    
    return jsonify(formatted_reviews)


@reviews_bp.route('/add/review/<int:restaurateur_id>', methods=['POST'])
def add_review_route(restaurateur_id):
    auth_header = request.headers.get("Authorization")
    if not auth_header:
        return jsonify({"error": "Unauthorized"}), 401

    token = auth_header.split(" ")[1]
    try:
        decoded = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
        foodie_id = decoded["Foodie_id"]

    except jwt.ExpiredSignatureError:
        return jsonify({"error": "Token expired"}), 401
    except jwt.InvalidTokenError:
        return jsonify({"error": "Invalid token"}), 401

    data = request.json
    comment = data.get("Comment")
    rating = data.get("Rating")

    if not rating:
        return jsonify({"error": "Rating is required"}), 400

    review = ReviewRepository.add_review(
        foodie_id=foodie_id,
        restaurateur_id=restaurateur_id,
        comment=comment,
        rating=rating
    )

    return jsonify({
        "message": "Review added successfully",
        "ReviewID": review.ReviewID,
        "Date": review.Date.isoformat()
    }), 201
