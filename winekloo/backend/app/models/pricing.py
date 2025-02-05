from app.db import db
from sqlalchemy.dialects.postgresql import NUMERIC

class Pricing(db.Model):
    __tablename__ = 'pricing'

    PricingID = db.Column(db.BigInteger, primary_key=True, name="PricingID")
    PriceValue = db.Column(NUMERIC, nullable=True, name="PriceValue")

    def __repr__(self):
        return f"<Pricing {self.PriceValue}>"

    def to_json(self):
        return {
            "PricingID": self.PricingID,
            "PriceValue": float(self.PriceValue) if self.PriceValue else None
        }