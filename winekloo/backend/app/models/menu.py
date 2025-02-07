from app.db import db

class Menu(db.Model):
    __tablename__ = 'menu'

    MenuID = db.Column(db.BigInteger, primary_key=True, autoincrement=True, name="MenuID")
    RestaurateurID = db.Column(db.BigInteger, db.ForeignKey('restaurateur.RestaurateurID', onupdate="CASCADE", ondelete="CASCADE"), nullable=False, name="RestaurateurID")
    Name = db.Column(db.Text, nullable=True, name="Name")
    Price = db.Column(db.BigInteger, nullable=True, name="Price")
    Details = db.Column(db.Text, nullable=True, name="Details")
    Category = db.Column(db.Text, nullable=True, name="Category")
    Picture = db.Column(db.Text, nullable=True, name="Picture")

    def __repr__(self):
        return f"<Menu {self.Name}>"

    def to_json(self):
        return {
            "MenuID": self.MenuID,
            "RestaurateurID": self.RestaurateurID,
            "Name": self.Name,
            "Price": self.Price,
            "Details": self.Details,
            "Category": self.Category,
            "Picture": self.Picture
        }