## Database Structure

The following Mermaid ER diagram illustrates the structure of the database:

```mermaid
erDiagram
    File {
        int id PK
        string file_name
        string mime_type
        string key
        string url
        boolean is_public
        timestamp created_at
        timestamp updated_at
    }

    Country {
        int id PK
        string name
        timestamp created_at
        timestamp updated_at
    }

    Genre {
        int id PK
        string name
        timestamp created_at
        timestamp updated_at
    }

    Person {
        int id PK
        string first_name
        string last_name
        text biography
        date date_of_birth
        string gender
        int country_id FK
        int primary_photo_id FK
        timestamp created_at
        timestamp updated_at
    }

    Person_Photo {
        int id PK
        int person_id FK
        int file_id FK
        timestamp created_at
        timestamp updated_at
    }

    Character {
        int id PK
        string name
        text description
        string role
        timestamp created_at
        timestamp updated_at
    }

    Movie {
        int id PK
        string title
        text description
        numeric budget
        date release_date
        int duration
        int director_id FK
        int country_id FK
        int poster_id FK
        timestamp created_at
        timestamp updated_at
    }

    Movie_Genre {
        int id PK
        int movie_id FK
        int genre_id FK
        timestamp created_at
        timestamp updated_at
    }

    Movie_Character_Actor {
        int id PK
        int movie_id FK
        int character_id FK
        int actor_id FK
        timestamp created_at
        timestamp updated_at
    }

    Favorite_Movie {
        int id PK
        int user_id FK
        int movie_id FK
        timestamp created_at
        timestamp updated_at
    }

    %% Relationships
    File ||--o{ Person : has
    File ||--o{ Movie : has
    File ||--o{ Person_Photo : has
    Genre ||--o{ Movie_Genre : has
    Movie ||--o{ Movie_Genre : has
    Movie ||--o{ Movie_Character_Actor : has
    Person ||--o{ Movie_Character_Actor : acts_in
    Person ||--o{ Person_Photo : has
    Person ||--o{ Movie : directs
    Movie ||--o{ Favorite_Movie : is_favorite
    Person ||--o{ Favorite_Movie : favorites
    Character ||--o{ Movie_Character_Actor : includes
    Country ||--o{ Person : has
    Country ||--o{ Movie : has