from app.db import db

class RestaurateurRepository:
    
    @staticmethod
    def create_restaurateur(new_restaurateur):
        response = db.table('restaurateur').insert({
            'DiningType': new_restaurateur['diningType'],
            'Name': new_restaurateur['name'],
            'Email': new_restaurateur['email'],
            'PhoneNumber': new_restaurateur['phoneNumber'],
            'Password': new_restaurateur['password'],
            'Location': new_restaurateur['location'],
            'Photo': new_restaurateur['photo'],
            'WorkingHours': new_restaurateur['workingHours'],
            'WorkingDays': new_restaurateur['workingDays'],
            'Description': new_restaurateur['description'],
            'RatingValueAverage': new_restaurateur['ratingValueAverage'],
            'MenuFilePDF': new_restaurateur['menuFilePDF'],
            'Categories': new_restaurateur['restaurateurCategories'],
            'DietaryPreferences': new_restaurateur['restaurateurPreferences'],
            'SpecialFeatures': new_restaurateur['restaurateurSpecialFeatures'],
            'Pricing': new_restaurateur['restaurateurPricing']
        }).execute()

        return response.data if response.data else None

    @staticmethod
    def get_restaurateurs():
        response = db.table('restaurateur').select('*').execute()
        return response.data if response.data else None

    @staticmethod
    def get_one_restaurateur(restaurateur_id):
        response = db.table('restaurateur').select('*').eq('RestaurateurID', restaurateur_id).single().execute()
        return response.data if response.data else None

    @staticmethod
    def update_restaurateur(updated_restaurateur):
        response = db.table('restaurateur').update(updated_restaurateur).eq('RestaurateurID', updated_restaurateur['restaurateurID']).execute()
        return response.data if response.data else None

    @staticmethod
    def delete_restaurateur(restaurateur_id):
        response = db.table('restaurateur').delete().eq('RestaurateurID', restaurateur_id).execute()
        return response.data if response.data else None
