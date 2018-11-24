require 'pg'
require_relative './tag'
require_relative 'comment'
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
    return false unless is_url?(url)
    bookmark = DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, title, url;")
    Bookmark.new(id: bookmark[0]['id'], title: bookmark[0]['title'], url: bookmark[0]['url'])
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.find(id:)
    bookmark = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id}")
    Bookmark.new(id: bookmark[0]['id'], title: bookmark[0]['title'], url: bookmark[0]['url'])
  end

  def self.update(id:, title:, url:)
    return false unless is_url?(url)
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

  def comments(comment_class = Comment)
    comment_class.where(bookmark_id: id)
  end

  def tags(tag_class = Tag)
    tag_class.where(bookmark_id: id)
  end

  def self.where(tag_id:)
    bookmarks = DatabaseConnection.query("SELECT id, title, url FROM bookmarks_tags INNER JOIN bookmarks ON bookmarks.id = bookmarks_tags.bookmark_id WHERE bookmarks_tags.tag_id = '#{tag_id}';")
    bookmarks.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  private

  def self.is_url?(url)
    url =~ URI::DEFAULT_PARSER.regexp[:ABS_URI]
  end
end
