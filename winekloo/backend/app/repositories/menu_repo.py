from app.db import db
from app.models.menu import Menu

class MenuRepository:
    @staticmethod
    def get_all():
        return Menu.query.all()

    @staticmethod
    def get_by_id(menu_id):
        return Menu.query.filter_by(MenuID=menu_id).first()

    @staticmethod
    def get_menu_by_restaurateur(restaurateur_id):
        return Menu.query.filter_by(RestaurateurID=restaurateur_id).all()

    @staticmethod
    def create(menu_data):
        menu = Menu(**menu_data)
        db.session.add(menu)
        db.session.commit()
        return menu

    @staticmethod
    def update(menu_id, menu_data):
        menu = MenuRepository.get_by_id(menu_id)
        if not menu:
            return None
        for key, value in menu_data.items():
            setattr(menu, key, value)
        db.session.commit()
        return menu

    @staticmethod
    def delete(menu_id):
        menu = MenuRepository.get_by_id(menu_id)
        if not menu:
            return None
        db.session.delete(menu)
        db.session.commit()
        return menu
