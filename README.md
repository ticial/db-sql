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
    }    
    Genre {
        int id PK
        string name
    }
    Country {
        int id PK
        string name
    }
    User ||--o| File : avatar
    User ||--o{ Movie : favorites
    User {
        int id PK
        string username
        string first_name
        string last_name
        string email
        string password
    }
    Movie }|--|| Country : filmed_in
    Movie ||--o| File : poster
    Movie }|--|{ Genre : has
    Movie }|--|{ Character : roles
    Movie }|--|{ Person : actors
    Movie }|--|| Person : director
    Movie {
        int id PK
        string title
        text description
        numeric budget
        date release_date
        int duration
    }
    Person ||--o{ File : photos
    Person ||--|| File : primary_photo
    Person }|--|| Country : born_in
    Person {
        int id PK
        string first_name
        string last_name
        text biography
        date date_of_birth
        string gender
    }
    Character {
        int id PK
        string name
        text description
        string role
    }