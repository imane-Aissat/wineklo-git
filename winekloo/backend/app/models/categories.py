from app.db import db

class Categories(db.Model):
    __tablename__ = 'categories'

    CategoryID = db.Column(db.BigInteger, primary_key=True, autoincrement=True, name="CategoryID")
    CategoryName = db.Column(db.Text, nullable=True, name="CategoryName")

    def __repr__(self):
        return f"<Categories {self.CategoryName}>"

    def to_json(self):
        return {
            "CategoryID": self.CategoryID,
            "CategoryName": self.CategoryName
        }