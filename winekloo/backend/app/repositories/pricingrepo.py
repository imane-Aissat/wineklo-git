from app.db import db
from app.models.pricing import Pricing

class PricingRepository:
    @staticmethod
    def get_all_pricings():
        return Pricing.query.all()

    @staticmethod
    def get_pricing_by_id(pricing_id):
        return Pricing.query.get(pricing_id)

    @staticmethod
    def create_pricing(data):
        pricing = Pricing(**data)
        db.session.add(pricing)
        db.session.commit()
        return pricing

    @staticmethod
    def update_pricing(pricing_id, data):
        pricing = Pricing.query.get(pricing_id)
        if not pricing:
            return None
        for key, value in data.items():
            setattr(pricing, key, value)
        db.session.commit()
        return pricing

    @staticmethod
    def delete_pricing(pricing_id):
        pricing = Pricing.query.get(pricing_id)
        if not pricing:
            return False
        db.session.delete(pricing)
        db.session.commit()
        return True