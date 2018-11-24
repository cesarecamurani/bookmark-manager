
feature 'Adding and viewing tags' do
  feature 'a user can add and then view a tag' do
    scenario 'a comment is added to a bookmark' do
      bookmark = Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
      visit '/bookmarks'
      click_button 'Add Tag'
      expect(current_path).to eq "/bookmarks/#{bookmark.id}/tags/new"
      fill_in 'tag', with: 'test tag'
      click_button 'Submit'
      expect(current_path).to eq '/bookmarks'
      expect(page).to have_content 'test tag'
    end
  end
end

feature 'a user can filter bookmarks by tag' do
  scenario 'adding the same tag to multiple bookmarks then filtering by tag' do
    Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    Bookmark.create(url: 'http://www.destroyallsoftware.com', title: 'Destroy All Software')
    Bookmark.create(url: 'http://www.google.com', title: 'Google')

    visit('/bookmarks')

    within page.find('.bookmark:nth-of-type(1)') do
      click_button 'Add Tag'
    end

    fill_in 'tag', with: 'social'
    click_button 'Submit'

    within page.find('.bookmark:nth-of-type(2)') do
      click_button 'Add Tag'
    end

    fill_in 'tag', with: 'software'
    click_button 'Submit'
    click_link 'social'
    expect(page).to have_link 'Makers Academy', href: 'http://www.makersacademy.com'
    expect(page).not_to have_link 'Google', href: 'http://www.google.com'
  end
end
