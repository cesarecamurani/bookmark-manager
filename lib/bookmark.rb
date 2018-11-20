class Bookmark

  def self.list_all
    begin
      connection = PG.connect :dbname => 'bookmark_manager'
      result = connection.exec "SELECT * FROM bookmarks;"
      result.map { |bookmark| bookmark['url'] }
    end
  end

  def self.list_all_test
    begin
      connection = PG.connect :dbname => 'bookmark_manager_test'
      result = connection.exec "SELECT * FROM bookmarks;"
      result.map { |bookmark| bookmark['url'] }
    end
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
