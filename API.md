# API документация

## Аутентификация

### POST /signup

**Описание**  
Создаёт нового пользователя.

**Авторизация**  
Не требуется.

**Request**
```json
{
  "user": {
    "email": "user@example.com",
    "password": "password"
  }
}

**Возвращает**
```json
{
    "user": {
        "id": 25,
        "email": "testы@mail.ru",
        "created_at": "2026-10-01T07:10:20.878Z"
    }
}
```

### POST /oauth/token

**Описание**  
Получение OAuth access token.

**Авторизация** 
Требуются данные OAuth-клиента.

**Request** 

application/x-www-form-urlencoded

grant_type=password
username=user@example.com
password=password
client_id=<client_id>
client_secret=<client_secret>

**Возвращает**

```json
{
    "access_token": "access_token",
    "token_type": "Bearer",
    "expires_in": 7200,
    "refresh_token": "refresh_token",
    "scope": "public",
    "created_at": 1790835247
}
```

## Книги

### GET /books

**Описание**  
Возвращает список книг.

```json
{
    "books": [
        {
            "id": 2,
            "title": "Сумерки",
            "weight": 0,
            "pages_count": 0,
            "description": null,
            "isbn13": "1234567899999",
            "isbn10": "1234567899",
            "published_in": "2010-09-09",
            "publisher_name": "publisher",
            "authors": [
                {
                    "first_name": "djdk",
                    "last_name": "dkjdnkj"
                },
                {
                    "first_name": "djdccck",
                    "last_name": "dkjdcccnkj"
                }
            ],
            "genres": []
        },
        {
            "id": 6,
            "title": "valid bookddssaassss",
            "weight": 0,
            "pages_count": 0,
            "description": null,
            "isbn13": "1234567899999",
            "isbn10": "1234567899",
            "published_in": "2010-09-09",
            "publisher_name": "publisher",
            "authors": [
                {
                    "first_name": "djdk",
                    "last_name": "dkjdnkj"
                },
```



**Авторизация** 
Не требуется.


### GET /books/:id
**Описание** 
Возвращает книгу по id.

```json
{
    "book": {
        "id": 21,
        "title": "книга юзера 24",
        "weight": 0,
        "pages_count": 0,
        "description": null,
        "isbn13": "1234567899999",
        "isbn10": "1234567899",
        "published_in": "2010-09-09",
        "publisher_name": "publisher",
        "authors": [
            {
                "first_name": "djdk",
                "last_name": "dkjdnkj"
            },
            {
                "first_name": "djdccck",
                "last_name": "dkjdcccnkj"
            }
        ],
        "genres": []
    }
}

```

**Авторизация** 
Не требуется.