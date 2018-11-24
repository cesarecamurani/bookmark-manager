
feature '.update' do
  scenario 'Updates a bookmark from the bookmarks database' do
    bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
    visit('/bookmarks')
    click_button 'Find'
    expect(bookmark.title).to eq('Makers Academy')
    expect(bookmark.url).to eq('http://www.makersacademy.com')
    expect(page).to have_content("Enter new Title:")
    fill_in("title", with: 'Makers')
    click_button 'Update Bookmark'
    expect(page).to have_content("Makers")
  end

  scenario 'The bookmark must be a valid URL' do
    bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
    visit('/bookmarks')
    click_button 'Find'
    fill_in('url', with: 'not a real bookmark')
    click_button('Update Bookmark')
    expect(page).not_to have_content "not a real bookmark"
    expect(page).to have_content "Please submit a valid URL."
  end
end
