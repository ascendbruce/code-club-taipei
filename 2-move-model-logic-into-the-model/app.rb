require './setup.rb'

class Post < FakeModel
  attr_reader   :id
  attr_accessor :author, :visit_count, :fake_visit_count
  alias_method :fake_visit_count?, :fake_visit_count

  def initialize(post_params)
    @fake_visit_count = post_params[:fake_visit_count]
    @id = 1
  end
end

class PostsController < FakeController
  def create
    @post = Post.new(params[:post])
    @post.author = current_user

    if @post.fake_visit_count?
      @post.visit_count = rand(1000..3000)
    else
      @post.visit_count = 0
    end

    @post.save
    redirect_to post_path(@post)
  end
end

require './tests' if __FILE__ == $0
