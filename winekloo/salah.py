import os

def get_folder_structure(directory, indent=0):
    try:
        items = os.listdir(directory)
    except PermissionError:
        print("  " * indent + "[ACCESS DENIED]")
        return
    
    for item in items:
        path = os.path.join(directory, item)
        print("  " * indent + "|- " + item)
        if os.path.isdir(path):
            get_folder_structure(path, indent + 1)

# Set the directory you want to explore
directory_path = r"C:\Users\salah\wineklo-git\winekloo\backend"
print("Folder Structure:")
print(directory_path)
get_folder_structure(directory_path)