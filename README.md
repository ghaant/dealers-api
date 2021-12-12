# Dealers API
Dealers API is a simple API intended for fetching the dealers data (name, phone number and addresses) from the remote server storing it with ability to search through the stored data.

## Endpoints and features
 1. **GET   /sync_data** - the endpoint calling which a user can sync the local data with the data on the remote server. This includes creating new records when there are some on the server, updating existing ones in case anything changed and deleting local records if they are not present on the server anymore.
 2. **GET  /index** - the endpoint calling which a user can search through the local data by the following parameters: *name, phone, street, city, zipcode. country*. Despite the fact that one dealer can have many addresses, this endpoint returns only one address per user (the first one). Searching by parameters *name, phone, street* it is possible to input only a part on the value ("nar" as *name* if we want to find a dealer with the name "Leoanrd Smith" for example), while the rest parameters accept only full values.

# Technical details
* Programming language: Ruby 2.7.1,
* Framework: Rails 6.0.4.1
* DBMS: PostgreSQL
* ORM Framework: ActiveRecord
* Testing tool: Rspec

# How to run the app

 1. Clone the repository from GitHub / extract it from the archive.
 2. Navigate to the app folder.
 3. Make sure PostgreSQL and Ruby 2.7.1 are installed on your machine.
 4. Run in the command line 'bundle install'.
 5. Rename the file '.../config/database.yml.example' to '.../config/database.yml', Open it and put there a real DB credentials valid for your local database.
 6. Run 'bin/rails db:create'.
 7. Run 'bin/rails db:migrate'.
 8. Run 'bin/rails server'

To run the specs navigate to the app folder and run 'bundle exec rspec' in the command line,
