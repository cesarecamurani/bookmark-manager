require 'pg'
require_relative 'database_connection'

class Bookmark
  attr_reader :id, :url, :title

  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
  end

  def self.list_all
    bookmarks = DatabaseConnection.query "SELECT * FROM bookmarks;"
    bookmarks.map do |bookmark|
      Bookmark.new(
                   id: bookmark['id'],
                   title: bookmark['title'],
                   url: bookmark['url']
                  )
    end
  end

  def self.create(title:, url:)
    result = DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, title, url;")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id}")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.update(id:, title:, url:)
    if title == '' && url == ''
      return
    elsif title == ''
      DatabaseConnection.query("UPDATE bookmarks SET url = '#{url}' WHERE id = #{id}")
    elsif url == ''
      DatabaseConnection.query("UPDATE bookmarks SET title = '#{title}' WHERE id = #{id}")
    else
      DatabaseConnection.query("UPDATE bookmarks SET title = '#{title}', url = '#{url}' WHERE id = #{id}")
    end
  end

end
