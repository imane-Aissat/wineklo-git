from flask import Blueprint, request, jsonify
from app.repositories.restaurateurrepo import RestaurateurRepository
from app.models.restaurateur import Restaurateur

restaurateur_bp = Blueprint('restaurateur_bp', __name__)

@restaurateur_bp.route('/restaurateur/<int:id>', methods=['GET'])
def get_restaurateur_by_id(id):
    restaurateur = RestaurateurRepository.get_restaurateur_by_id(id)
    if restaurateur:
        return jsonify(restaurateur.to_json()), 200
    else:
        return jsonify({"error": "Restaurateur not found"}), 404
    

@restaurateur_bp.route('/all/restaurateurs/', methods = ['GET'])
def get_all_restaurateurs():
    try:
        restaurateurs = RestaurateurRepository.get_all_restaurateurs()

        result = [ 
                {
                "RestaurateurID": restaurateur.RestaurateurID,
                "DiningType": restaurateur.DiningType,
                "Name": restaurateur.Name,
                "Email": restaurateur.Email,
                "PhoneNumber": restaurateur.PhoneNumber,
                "Password": restaurateur.Password,
                "Location": restaurateur.Location,
                "Photo": restaurateur.Photo,
                "WorkingHours": restaurateur.WorkingHours,
                "WorkingDays": restaurateur.WorkingDays,
                "Description": restaurateur.Description,
                "RatingValueAverage": restaurateur.RatingValueAverage,
                "MenuFilePDF": restaurateur.MenuFilePDF,
                "Categories": restaurateur.Categories,
                "DietaryPreferences": restaurateur.DietaryPreferences,
                "SpecialFeatures": restaurateur.SpecialFeatures,
                "Pricing": restaurateur.Pricing,
                "verified": restaurateur.verified
            }
            for restaurateur in restaurateurs
        ]
        print(result)

        return jsonify({"message": "All restaurateurs fetched successfully"}), 200
    except Exception as e:
        print(f"Error: {e}")  
        return jsonify({"error": "Internal server error"}), 500
