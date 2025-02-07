from app.db import db
from app.models.menu import Menu

class MenuRepository:
    @staticmethod
    def get_all_menus():
        return Menu.query.all()

    @staticmethod
    def get_menu_by_id(menu_id):
        return Menu.query.get(menu_id)

    @staticmethod
    def create_menu(data):
        menu = Menu(**data)
        db.session.add(menu)
        db.session.commit()
        return menu

    @staticmethod
    def update_menu(menu_id, data):
        menu = Menu.query.get(menu_id)
        if not menu:
            return None
        for key, value in data.items():
            setattr(menu, key, value)
        db.session.commit()
        return menu

    @staticmethod
    def delete_menu(menu_id):
        menu = Menu.query.get(menu_id)
        if not menu:
            return False
        db.session.delete(menu)
        db.session.commit()
        return True
    @staticmethod
    def get_menu_by_restaurateur(restaurateur_id):
        return Menu.query.filter_by(RestaurateurID=restaurateur_id).all()