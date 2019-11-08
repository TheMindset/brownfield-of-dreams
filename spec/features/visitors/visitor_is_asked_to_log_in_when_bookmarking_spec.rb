# frozen_string_literal: true

require 'rails_helper'

describe 'visitor visits video show page' do
  it 'clicks on the bookmark page and is sent to the log in page' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    expect(page).to_not have_content("Bookmark")

    expect(page).to have_link(href: login_path)
  end
end
