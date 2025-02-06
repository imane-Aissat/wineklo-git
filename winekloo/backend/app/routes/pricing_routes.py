from flask import Blueprint, request, jsonify
from app.repositories.pricingrepo import PricingRepository
from app.models.pricing import Pricing

pricing_bp = Blueprint('pricing_bp', __name__)

@pricing_bp.route('/pricing', methods=['GET'])
def get_all_pricings():
    pricings = PricingRepository.get_all_pricings()
    return jsonify([pricing.to_json() for pricing in pricings]), 200

@pricing_bp.route('/pricing/<int:pricing_id>', methods=['GET'])
def get_pricing_by_id(pricing_id):
    pricing = PricingRepository.get_pricing_by_id(pricing_id)
    if pricing:
        return jsonify(pricing.to_json()), 200
    else:
        return jsonify({"error": "Pricing not found"}), 404

@pricing_bp.route('/pricing', methods=['POST'])
def create_pricing():
    data = request.get_json()
    if not data:
        return jsonify({"error": "No data provided"}), 400
    pricing = PricingRepository.create_pricing(data)
    return jsonify(pricing.to_json()), 201

@pricing_bp.route('/pricing/<int:pricing_id>', methods=['PUT'])
def update_pricing(pricing_id):
    data = request.get_json()
    if not data:
        return jsonify({"error": "No data provided"}), 400
    pricing = PricingRepository.update_pricing(pricing_id, data)
    if pricing:
        return jsonify(pricing.to_json()), 200
    else:
        return jsonify({"error": "Pricing not found"}), 404

@pricing_bp.route('/pricing/<int:pricing_id>', methods=['DELETE'])
def delete_pricing(pricing_id):
    success = PricingRepository.delete_pricing(pricing_id)
    if success:
        return jsonify({"message": "Pricing deleted successfully"}), 200
    else:
        return jsonify({"error": "Pricing not found"}), 404