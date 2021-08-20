# butterfly

<div align="center">
  <img src="https://user-images.githubusercontent.com/58193906/130270620-8226315d-1a02-49b2-836f-bfac96b519fa.gif" width=300 height=auto/>
</div>

<br>

<div align="center">
  <p>Butterfly is an event sharing and registration app. Inspired by the term "social butterfly", it originated from a problem we wanted to solve. We wanted to make an app that we could tie into our lives and that we would actually use. After passing around ideas, we came up Butterfly, an app that builds communities around events.
</p>
  <p href="https://butterflyapp.tech">https://butterflyapp.tech</p>
</div>

## System requirements
App:
* Have Flutter installed (ideally with xcode or android studio)

Website:
* Have Flask installed

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

## Run the website
```
cd webpage
gunicorn --bind 127.0.0.1:5000 wsgi:app
```
* Troubleshooting
 * FAQ
 * Maintainers
