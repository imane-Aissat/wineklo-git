from flask import Blueprint, request, jsonify
from app.repositories.specialfeaturesrepo import SpecialFeaturesRepository
from app.models.specialfeatures import SpecialFeatures

specialfeatures_bp = Blueprint('specialfeatures_bp', __name__)

@specialfeatures_bp.route('/specialfeatures', methods=['GET'])
def get_all_features():
    features = SpecialFeaturesRepository.get_all_features()
    return jsonify([feature.to_json() for feature in features]), 200

@specialfeatures_bp.route('/specialfeatures/<int:feature_id>', methods=['GET'])
def get_feature_by_id(feature_id):
    feature = SpecialFeaturesRepository.get_feature_by_id(feature_id)
    if feature:
        return jsonify(feature.to_json()), 200
    else:
        return jsonify({"error": "Feature not found"}), 404

@specialfeatures_bp.route('/specialfeatures', methods=['POST'])
def create_feature():
    data = request.get_json()
    if not data:
        return jsonify({"error": "No data provided"}), 400
    feature = SpecialFeaturesRepository.create_feature(data)
    return jsonify(feature.to_json()), 201

@specialfeatures_bp.route('/specialfeatures/<int:feature_id>', methods=['PUT'])
def update_feature(feature_id):
    data = request.get_json()
    if not data:
        return jsonify({"error": "No data provided"}), 400
    feature = SpecialFeaturesRepository.update_feature(feature_id, data)
    if feature:
        return jsonify(feature.to_json()), 200
    else:
        return jsonify({"error": "Feature not found"}), 404

@specialfeatures_bp.route('/specialfeatures/<int:feature_id>', methods=['DELETE'])
def delete_feature(feature_id):
    success = SpecialFeaturesRepository.delete_feature(feature_id)
    if success:
        return jsonify({"message": "Feature deleted successfully"}), 200
    else:
        return jsonify({"error": "Feature not found"}), 404