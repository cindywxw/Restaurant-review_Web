=======
Final Project week 7:

I did some stupid commands and lost my work during last work. Unfortunately, I didn't get those codes recovered even with Prof. Cohen's help. So I had to rewrote the codes. Sorry for the late submission.
So far the project fulfill the following:
1. Classes: Restaurant, User, Reservation, Review, Table. I dropped tables Openhour and Administrator.
2. User can sign up, log in, and log out to/from the TinyTable system.
3. General user (e.g. "Cookie Monster".) can view and edit his profile, including name, password, email address (can only view his TinyTable points). He can make a reservation between 11am-10pm and write a review for a restaurant. He can view his reviews and reservations. For security: When a user changes his profile, he needs to authenticate himself using his password. A user can't view other people's profile, reservation or review.
Problem: So far, making a reservation have bugs. I'm still working on it. (formatting and openhour limitaion)
4. Administrator (e.g. "Justin Bieber") can do all the things that a general user can do. In addtion, he can add, edit and delete restaurants. He can view reservations for a restaurant or for all restaurants.



# MPCS 52553 - Final Project Starting Point

* Download the ZIP of this repository to start your project.  
* Rename your folder to `mpcs52553-final`

<hr>

Or, you can create a new Rails app yourself and follow these steps:

1. Generate a new Rais app: `rails new mpcs52553-final --skip-bundle`
2. Add `gem 'ez'` inside the `Gemfile`
3. `bundle install`
4. Then customize the `config/development.rb` as follows:

    ```
      config.assets.debug = false
      config.assets.digest = false
    ```

Now you can start developing.  Happy coding!
