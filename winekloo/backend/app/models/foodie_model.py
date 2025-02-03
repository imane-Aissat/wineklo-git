from app.db import db
from datetime import date

class Foodie(db.Model):
    __tablename__ = 'foodie'

    FoodieID = db.Column(db.BigInteger, primary_key=True, autoincrement=True, name="FoodieID")
    email = db.Column(db.Text, nullable=True, name="Email")
    phone_number = db.Column(db.Text, nullable=True, name="PhoneNumber")
    password = db.Column(db.Text, nullable=True, name="Password")
    birthday = db.Column(db.Date, nullable=True, name="Birthday")
    gender = db.Column(db.Text, nullable=True, name="Gender")
    wilaya = db.Column(db.Text, nullable=True, name="Wilaya")
    photo = db.Column(db.Text, nullable=True, name="Photo")
    foodie_categories = db.Column(db.BigInteger, db.ForeignKey('categories."CategoryID"', onupdate="CASCADE", ondelete="SET NULL"), nullable=True, name="FoodieCategories")
    foodie_preferences = db.Column(db.BigInteger, db.ForeignKey('dietarypreferences."PreferenceID"', onupdate="CASCADE", ondelete="SET NULL"), nullable=True, name="FoodiePreferences")
    foodie_pricing = db.Column(db.BigInteger, nullable=True, name="FoodiePricing")
    full_name = db.Column(db.Text, nullable=True, name="full_name")
    verified = db.Column(db.Boolean, nullable=True, default=False, name="verified")

    def __init__(self, email=None, phone_number=None, password=None, birthday=None, gender=None, wilaya=None, 
                 photo=None, foodie_categories=None, foodie_preferences=None, foodie_pricing=None, 
                 full_name=None, verified=False):
        self.email = email
        self.phone_number = phone_number
        self.password = password
        self.birthday = birthday
        self.gender = gender
        self.wilaya = wilaya
        self.photo = photo
        self.foodie_categories = foodie_categories
        self.foodie_preferences = foodie_preferences
        self.foodie_pricing = foodie_pricing
        self.full_name = full_name
        self.verified = verified

    @staticmethod
    def from_json(json_data):
        return Foodie(
            FoodieID=json_data.get('FoodieID'),
            email=json_data.get('Email'),
            phone_number=json_data.get('PhoneNumber'),
            password=json_data.get('Password'),
            birthday=date.fromisoformat(json_data['Birthday']) if json_data.get('Birthday') else None,
            gender=json_data.get('Gender'),
            wilaya=json_data.get('Wilaya'),
            photo=json_data.get('Photo'),
            foodie_categories=json_data.get('FoodieCategories'),
            foodie_preferences=json_data.get('FoodiePreferences'),
            foodie_pricing=json_data.get('FoodiePricing'),
            full_name=json_data.get('full_name'),
            verified=json_data.get('verified', False)
        )

    def to_json(self):
        return {
            'FoodieID': self.FoodieID,
            'Email': self.email,
            'PhoneNumber': self.phone_number,
            'Password': self.password,
            'Birthday': self.birthday.isoformat() if self.birthday else None,
            'Gender': self.gender,
            'Wilaya': self.wilaya,
            'Photo': self.photo,
            'FoodieCategories': self.foodie_categories,
            'FoodiePreferences': self.foodie_preferences,
            'FoodiePricing': self.foodie_pricing,
            'full_name': self.full_name,
            'verified': self.verified
        }
