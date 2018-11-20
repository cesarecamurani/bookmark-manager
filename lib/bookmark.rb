require 'pg'

class Bookmark

  def self.list_all

    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect :dbname => 'bookmark_manager_test'
    else
      connection = PG.connect :dbname => 'bookmark_manager'
    end

    result = connection.exec "SELECT * FROM bookmarks;"
    result.map { |bookmark| bookmark['url'] }

  end

end




# class Bookmark
#
#   def self.list_all
#     [ "https://www.google.co.uk/",
#       "https://it.wikipedia.org/",
#       "https://www.cb01.news/" ]
#   end
#
# end
