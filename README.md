# AR Relationships: The more you know

This is a rails demo app used to demonstrate some of the more confusing Active Record relationships.

PLEASE do not just copy the completed code.   It is there for your reference, I encourage you to re-create
this app from scratch (follow the README tutorial below) and type the syntax out.  This should help us learn
these great tools that Rails provides, much quicker.

## Quick Review of the simple relations
In our demo app our User model has a few relationships.  Here's the code for the User model:

```ruby
class User < ApplicationRecord
  validates :email, presence: true
  validates :email, uniqueness: true

  has_one :profile  # FK is in the users table: users.profile_id -->  HAS ONE
  # is the same
  # has_one(:profile)

  has_many :emails  # FK is in the emails table: emails.user_id --> HAVE MANY
end
```

The location of the foreign key (FK) is determined by the kind of relationship.  We have two here in the User model.

- user HAS MANY emails (makes sense, right ?) and the FK is located in the emails table (emails.user_id).

- user HAS ONE profile and the FK is in the users table (users.profile_id)

## UML of our models / relationships
I find UML diagrams incredibly useful for viewing database table relationships in an easy visual manner.  We are about discuss a confusing relationship, so please open up there diagrams in another tab.

- [Users and Tasks UML Diagram](https://drive.google.com/file/d/1AT7H5BNciXAvq71cqLbCaQSbnKCp-N9Y/view?usp=sharing)

And you can imagine that the join table (users_tasks) might look something like this:

```
--------------------
|     user_tasks   |
--------------------
| user_id | task_id|   
| 1       |  1     |
| 1       |  2     |
| 2       |  1     |
--------------------
```


## Many to Many Relationships

Rails handles this many to many relationship through the `has_many` macro method, but it also accepts an option called `through: <some other relationship>`.  Let's look at the updated User model code that will use this relationship:


```ruby
class User < ApplicationRecord
  validates :email, presence: true
  validates :email, uniqueness: true

  has_one :profile  # FK is in the users table: users.profile_id -->  HAS ONE

  has_many :emails  # FK is in the emails table: emails.user_id --> HAVE MANY

  has_many :user_tasks, dependent: :destroy # dependent: :destroy deletes orphaned rows
  has_many :tasks, through: :user_tasks
end
```

We notice that we have 2 `has_many` relationships around the tasks fetching.  The first has_man is pointing at our join table. The following `has_many` takes advantage of the existing `has_many` (that would be `has_many :user_tasks`), and creates a new relationship that leverages our existing has_many relationship.

`has_many tasks, through: :user_tasks`

The end result is we can all methods like this: `user.tasks` and it will return a list of tasks, by querying all 3 tables.  Of course, you have to play around in console to see that AR does generate the proper joins SQL statement.

Don't worry if you are confused, this is confusing stuff.  Just google around StackOverflow and you will find lots of confused people on this topic.

At this point we should be able to play around in console.  I __STRONGLY__ encourage playing around with your new schema when starting a project.  Rails console makes this very easy.  You  might unearth some ideas or problems that would be __MUCH MORE DIFFICULT__ to debug in the context of a full stack application.

## What are Orphaned Rows

If we return to our join table here:

```
--------------------
|     user_tasks   |
--------------------
| user_id | task_id|   
| 1       |  1     |
| 1       |  2     |
| 2       |  1     |
--------------------
```

Imagine if user #1 deletes his account and we delete his row in the users table.  The first 2 rows of the user_tasks are now considered "orphaned rows" or "orphaned data".  In this case, it might not break our app for basic features.  But later down the line, orphaned rows can lead to very misleading data.

Even worse, there could be bugs.  Imagine if we delete task #1. Rows 1 and 3 of user_tasks are now orphaned.  But they can cause bugs.  When user #1 logs in and asks for the list of tasks, Rails will try and query the tasks table for task #1, which no longer exists.  Boom!  Bug.

Of course, people can write code to gracefully handle orhpans, but why do the extra work.  Practice good DB habits.  And surprise!  Rails makes it easy to prevent orphan rows.

This example is from the User model:

```ruby
has_many :user_tasks, dependent: :destroy
```
The dependent option will ask us:  Hey, what do you want to do with these dependents (orphan rows) ?  The most common option available is `:destroy`.  Destory the orphan row.

Besides sounding harsh, it makes sense.  If user #1 deletes his account and we delete that row in the database, there is no longer a user #1.  All the rows in the user_tasks table that have user_id = 1 should be destroyed to avoid orphans.  That's the Rails magic and best practices coming together.
