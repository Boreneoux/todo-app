# To-Do App Using FastAPI & Flutter

## Background

Aplikasi ini adalah aplikasi To-Do yang dapat melakukan fungsi CRUD kedalam database dari aplikasi mobile yang dibangun menggunakan flutter dan terintegrasi dengan api yang dibangun menggunakan FastAPI

## Requirements

- Flutter 3.24.0 SDK
- Python3
- PostgreSQL

## Instructions

```shell
git clone
```

### Menjalankan back-end terlebih dahulu

```shell
Buat database baru pada PostgreSQL anda bernamakan tododb
```

```shell
cd api
```

```shell
pip install requirements.txt
```

```shell
rename .env.example to .env or duplicate
```

```shell
> fastapi dev main.py
```

```
go to http://127.0.0.1:8000/docs for API Documentation
```

### Menjalankan aplikasi mobile

```shell
cd todo_app
```

```shell
flutter clean
```

```shell
flutter pub get
```

- Look at lib/providers/todo_provider.dart
- adjust the address and the port with the backend that already running before (if using customized port when running the api)

```shell
- Start Debugging (F5 in Visual Studio Code)
```

## Project Structure

- Backend

```
└── api/
    ├── main.py -> file utama, router declaration, business logic
    ├── database.py -> database declaration
    ├── models.py -> database model
    ├── schemas.py -> pydantic model
    ├── requirements.txt -> development dependencies
    └── .env
```

- Mobile (Flutter)

```
└── lib/
    ├── models/
    │   └── todo.dart -> data models todo
    ├── screens/
    │   ├── todo_list_screen.dart -> screen utama
    │   └── todo_form_screen.dart -> screen form
    ├── providers/
    │   └── todo_provider.dart -> fetch data from API & state management
    └── main.dart
```
