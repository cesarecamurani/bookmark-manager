
feature '.list_all' do
  scenario "It shows a list of saved websites" do
    visit '/bookmarks'
    expect(page).to have_content("Bookmarks:")
    expect(page).to have_content("https://www.google.co.uk/")
    expect(page).to have_content("https://it.wikipedia.org/")
    expect(page).to have_content("https://www.cb01.news/")
  end
end
