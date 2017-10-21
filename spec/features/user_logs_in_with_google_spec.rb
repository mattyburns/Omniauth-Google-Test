require 'rails_helper'


def stub_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
    provider: "google",
    uid: "12345678910",
    info: {
      email: "jesse@mountainmantechnologies.com",
      first_name: "Jesse",
      last_name: "Spevack"
    },
    credentials: {
      token: "abcdefg12345",
      refresh_token: "12345abcdefg",
      expires_at: DateTime.now,
    }
  })
end


feature "user logs into app" do
  scenario "user has google account and logs in using oauth2" do
    stub_omniauth
    visit root_path

    expect(page).to have_link ("Sign in with Google")
    click_link "Sign in with Google"
    expect(page).to have_content ("Matty Burns")
    expect(page).to have_link("Logout")
  end
end
