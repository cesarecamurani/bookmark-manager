class Bookmark

  def self.list_all
    begin
      con = PG.connect :dbname => 'bookmark_manager'
      rs = con.exec "SELECT * FROM bookmarks"
      rs.each do |row|
        puts "%s %s" % [ row['id'], row['url'] ]
      end
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
