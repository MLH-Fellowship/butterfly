# butterfly

## Make and activate virtual environment

```
python3 -m venv butterfly-venv
source butterfly-venv/bin/activate
```

## Install requirements

```
pip install -r requirements.txt
```

## Run the backend

```
cd backend
python3 manage.py makemigrations users
python3 manage.py migrate users
python3 manage.py runserver
```

## Run the app

```
cd frontend
flutter run --no-sound-null-safety
# you'll be prompted to select a device-we suggest chrome if you don't have a mobile emulator
```
