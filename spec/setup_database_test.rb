require 'pg'

def empty_database
  p "Setting up test database..."
  connection = PG.connect(dbname: 'bookmark_manager_test')
  connection.exec("TRUNCATE bookmarks;")
end
