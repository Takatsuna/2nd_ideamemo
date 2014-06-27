require 'test_helper'

class LoginTest < AcceptanceTest

   # [正常系] 妥当なユーザ情報を入力してサインアップ -> サインアウト
  # users テーブルにレコードを追加して、メニュー画面に遷移することを確認
  test "sign up with valid user information and then sign out" do
    visit_root
    ensure_browser_size

      save_screenshot "scenario-01-01.png"

    click_link "Sign up"

      save_screenshot "scenario-01-02.png"

      
    assert_difference "User.count" do
      fill_in "user_username", with: "YA900001"
      fill_in "user_email", with: "ya900001@test.org"
      fill_in "user_password", with: "passpass"
      fill_in "user_password_confirmation", with: "passpass"
      save_screenshot "scenario-01-03.png"
      click_button "Sign up"
      save_screenshot "scenario-01-04.png"
      assert_equal '/ideas', current_path
    end

    new_user = User.find_by_username("YA900001")
    assert_not_nil new_user
    assert_equal "ya900001@test.org", new_user.email
    assert_not_nil new_user.last_sign_in_at

    sign_out
  end
    
end
