require 'pg'

class Bookmark
  attr_reader :id, :url, :title

  if ENV['ENVIRONMENT'] == 'test'
    @connection = PG.connect :dbname => 'bookmark_manager_test'
  else
    @connection = PG.connect :dbname => 'bookmark_manager'
  end

  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
  end

  def self.list_all
    bookmarks = @connection.exec "SELECT * FROM bookmarks;"
    bookmarks.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  def self.create(title:, url:)
    result = @connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, title, url;")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.delete(id:)
    @connection.exec("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.find(id:)
    result = @connection.exec("SELECT * FROM bookmarks WHERE id = #{id}")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.update(id:, title:, url:)
    if title == '' && url == ''
      return
    elsif title == ''
      @connection.exec("UPDATE bookmarks SET url = '#{url}' WHERE id = #{id}")
    elsif url == ''
      @connection.exec("UPDATE bookmarks SET title = '#{title}' WHERE id = #{id}")
    else
      @connection.exec("UPDATE bookmarks SET title = '#{title}', url = '#{url}' WHERE id = #{id}")
    end
  end

end
