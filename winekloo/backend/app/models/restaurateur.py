from app.db import db
from sqlalchemy.dialects.postgresql import JSONB, ARRAY

class Restaurateur(db.Model):
    __tablename__ = 'restaurateur'

    RestaurateurID = db.Column(db.BigInteger, primary_key=True, autoincrement=True, name="RestaurateurID")
    DiningType = db.Column(db.Text, nullable=True, name="DiningType")
    Name = db.Column(db.Text, nullable=True, name="Name")
    Email = db.Column(db.Text, nullable=True, name="Email")
    PhoneNumber = db.Column(db.Text, nullable=True, name="PhoneNumber")
    Password = db.Column(db.Text, nullable=True, name="Password")
    Location = db.Column(db.Text, nullable=True, name="Location")
    Photo = db.Column(db.Text, nullable=True, name="Photo")
    WorkingHours = db.Column(JSONB, nullable=True, name="WorkingHours")
    WorkingDays = db.Column(ARRAY(db.Text), nullable=True, name="WorkingDays")
    Description = db.Column(db.Text, nullable=True, name="Description")
    RatingValueAverage = db.Column(db.Text, nullable=True, name="RatingValueAverage")
    MenuFilePDF = db.Column(db.Text, nullable=True, name="MenuFilePDF")
    Categories = db.Column(db.BigInteger, db.ForeignKey('categories."CategoryID"', onupdate="CASCADE", ondelete="SET NULL"), nullable=True, name="Categories")
    DietaryPreferences = db.Column(db.BigInteger, db.ForeignKey('dietarypreferences."PreferenceID"', onupdate="CASCADE", ondelete="SET NULL"), nullable=True, name="DietaryPreferences")
    SpecialFeatures = db.Column(db.BigInteger, db.ForeignKey('specialfeatures."FeatureID"', onupdate="CASCADE", ondelete="SET NULL"), nullable=True, name="SpecialFeatures")
    Pricing = db.Column(db.BigInteger, db.ForeignKey('pricing."PricingID"', onupdate="CASCADE", ondelete="SET NULL"), nullable=True, name="Pricing")
    verified = db.Column(db.Boolean, nullable=True, default=False, name="verified")

    def __repr__(self):
        return f"<Restaurateur {self.Name}>"

    def to_json(self):
        return {
            "RestaurateurID": self.RestaurateurID,
            "DiningType": self.DiningType,
            "Name": self.Name,
            "Email": self.Email,
            "PhoneNumber": self.PhoneNumber,
            "Password": self.Password,
            "Location": self.Location,
            "Photo": self.Photo,
            "WorkingHours": self.WorkingHours,
            "WorkingDays": self.WorkingDays,
            "Description": self.Description,
            "RatingValueAverage": self.RatingValueAverage,
            "MenuFilePDF": self.MenuFilePDF,
            "Categories": self.Categories,
            "DietaryPreferences": self.DietaryPreferences,
            "SpecialFeatures": self.SpecialFeatures,
            "Pricing": self.Pricing,
            "verified": self.verified
        }