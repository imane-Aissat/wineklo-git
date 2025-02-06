from flask import Blueprint, request, jsonify
from app.repositories.dietarypreferencesrepo import DietaryPreferencesRepository
from app.models.dietarypreferences import DietaryPreferences

dietarypreferences_bp = Blueprint('dietarypreferences_bp', __name__)

@dietarypreferences_bp.route('/dietarypreferences', methods=['GET'])
def get_all_preferences():
    preferences = DietaryPreferencesRepository.get_all_preferences()
    return jsonify([preference.to_json() for preference in preferences]), 200

@dietarypreferences_bp.route('/dietarypreferences/<int:preference_id>', methods=['GET'])
def get_preference_by_id(preference_id):
    preference = DietaryPreferencesRepository.get_preference_by_id(preference_id)
    if preference:
        return jsonify(preference.to_json()), 200
    else:
        return jsonify({"error": "Preference not found"}), 404

@dietarypreferences_bp.route('/dietarypreferences', methods=['POST'])
def create_preference():
    data = request.get_json()
    if not data:
        return jsonify({"error": "No data provided"}), 400
    preference = DietaryPreferencesRepository.create_preference(data)
    return jsonify(preference.to_json()), 201

@dietarypreferences_bp.route('/dietarypreferences/<int:preference_id>', methods=['PUT'])
def update_preference(preference_id):
    data = request.get_json()
    if not data:
        return jsonify({"error": "No data provided"}), 400
    preference = DietaryPreferencesRepository.update_preference(preference_id, data)
    if preference:
        return jsonify(preference.to_json()), 200
    else:
        return jsonify({"error": "Preference not found"}), 404

@dietarypreferences_bp.route('/dietarypreferences/<int:preference_id>', methods=['DELETE'])
def delete_preference(preference_id):
    success = DietaryPreferencesRepository.delete_preference(preference_id)
    if success:
        return jsonify({"message": "Preference deleted successfully"}), 200
    else:
        return jsonify({"error": "Preference not found"}), 404