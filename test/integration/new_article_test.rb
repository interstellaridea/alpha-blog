require 'test_helper'

class NewArticleTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "test", email: "test@test.com", password: "password")
  end


  test "get new article form and create new article" do
    #use method from test_helper
    sign_in_as(@user, 'password')

    get new_article_path
    assert_template 'articles/new'

    # checks count after test article was made
    assert_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: { title: "TEST ARTICLE",
        description: "this is the integration test for creating articles"}
      end
    # redirect and look for title of test article
    assert_template 'articles/show'
    assert_match 'TEST ARTICLE', response.body
  end


  test "invalid article submission results in failure" do
    sign_in_as(@user, 'password')

    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do
      post articles_path, article: { title: ' ', description: ' '}
    end
    # look for danger flash message to render
    assert_template 'articles/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'

  end

end