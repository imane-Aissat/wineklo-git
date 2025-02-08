from app.db import db
from datetime import date

class Foodie(db.Model):
    __tablename__ = 'foodie'

    FoodieID = db.Column(db.BigInteger, primary_key=True, autoincrement=True, name="FoodieID")
    Email = db.Column(db.Text, nullable=True, name="Email")
    PhoneNumber = db.Column(db.Text, nullable=True, name="PhoneNumber")
    Password = db.Column(db.Text, nullable=True, name="Password")
    Birthday = db.Column(db.Date, nullable=True, name="Birthday")
    Gender = db.Column(db.Text, nullable=True, name="Gender")
    Wilaya = db.Column(db.Text, nullable=True, name="Wilaya")
    Photo = db.Column(db.Text, nullable=True, name="Photo")
    FoodieCategories = db.Column(db.BigInteger, db.ForeignKey('categories."CategoryID"', onupdate="CASCADE", ondelete="SET NULL"), nullable=True, name="FoodieCategories")
    FoodiePreferences = db.Column(db.BigInteger, db.ForeignKey('dietarypreferences."PreferenceID"', onupdate="CASCADE", ondelete="SET NULL"), nullable=True, name="FoodiePreferences")
    FoodiePricing = db.Column(db.BigInteger, nullable=True, name="FoodiePricing")
    full_name = db.Column(db.Text, nullable=True, name="full_name")
    verified = db.Column(db.Boolean, nullable=True, default=False, name="verified")

    def __init__(self, email=None, phone_number=None, password=None, birthday=None, gender=None, wilaya=None, 
                 photo=None, foodie_categories=None, foodie_preferences=None, foodie_pricing=None, 
                 full_name=None, verified=False):
        self.Email = email
        self.PhoneNumber = phone_number
        self.Password = password
        self.Birthday = birthday
        self.Gender = gender
        self.Wilaya = wilaya
        self.Photo = photo
        self.FoodieCategories = foodie_categories
        self.FoodiePreferences = foodie_preferences
        self.FoodiePricing = foodie_pricing
        self.full_name = full_name
        self.verified = verified

    @staticmethod
    def from_json(json_data):
        return Foodie(
            FoodieID=json_data.get('FoodieID'),
            Email=json_data.get('Email'),
            PhoneNumber=json_data.get('PhoneNumber'),
            Password=json_data.get('Password'),
            Birthday=date.fromisoformat(json_data['Birthday']) if json_data.get('Birthday') else None,
            Gender=json_data.get('Gender'),
            Wilaya=json_data.get('Wilaya'),
            Photo=json_data.get('Photo'),
            FoodieCategories=json_data.get('FoodieCategories'),
            FoodiePreferences=json_data.get('FoodiePreferences'),
            FoodiePricing=json_data.get('FoodiePricing'),
            full_name=json_data.get('full_name'),
            verified=json_data.get('verified', False)
        )

    def to_json(self):
        return {
            'FoodieID': self.FoodieID,
            'Email': self.Email,
            'PhoneNumber': self.PhoneNumber,
            'Password': self.Password,
            'Birthday': self.Birthday.isoformat() if self.Birthday else None,
            'Gender': self.Gender,
            'Wilaya': self.Wilaya,
            'Photo': self.Photo,
            'FoodieCategories': self.FoodieCategories,
            'FoodiePreferences': self.FoodiePreferences,
            'FoodiePricing': self.FoodiePricing,
            'full_name': self.full_name,
            'verified': self.verified
        }


    def to_dict(self):
        return {
            'FoodieID': self.FoodieID,
            'Email': self.Email,
            'PhoneNumber': self.PhoneNumber,
            'Password': self.Password,
            'Birthday': self.Birthday.isoformat() if self.Birthday else None,
            'Gender': self.Gender,
            'Wilaya': self.Wilaya,
            'Photo': self.Photo,
            'FoodieCategories': self.FoodieCategories,
            'FoodiePreferences': self.FoodiePreferences,
            'FoodiePricing': self.FoodiePricing,
            'full_name': self.full_name,
            'verified': self.verified
        }
