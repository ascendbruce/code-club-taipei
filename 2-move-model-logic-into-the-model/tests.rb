#!/usr/bin/env ruby -w
require "minitest"
require "minitest/autorun"

class TestPostsController < Minitest::Test
  def setup
    @user = User.new("Bob")
    @params = {
      post: {
        title:   "Hello world",
        content: "Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
        fake_visit_count: false
      }
    }
  end

  def test_create_will_assign_author
    @controller = PostsController.new(@params)
    @controller.current_user = @user

    @controller.create

    assert_equal @controller.post.author, @user
  end

  def test_create_for_fake_visit_count
    @params[:post][:fake_visit_count] = true

    @controller = PostsController.new(@params)
    @controller.current_user = @user

    @controller.create

    assert @controller.post.visit_count > 1000
  end

  def test_create_for_non_fake_visit_count
    @controller = PostsController.new(@params)
    @controller.current_user = @user

    @controller.create

    assert_equal @controller.post.visit_count, 0
  end
end
