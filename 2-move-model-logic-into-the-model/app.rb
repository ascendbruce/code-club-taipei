require './setup.rb'

class Post < FakeModel
  attr_reader   :id
  attr_accessor :author, :visit_count, :fake_visit_count
  alias_method :fake_visit_count?, :fake_visit_count

  def initialize(post_params)
    @fake_visit_count = post_params[:fake_visit_count]
    @id = 1
  end

  def publish(author)
    self.author = author

    if fake_visit_count?
      self.visit_count = rand(1000..3000)
    else
      self.visit_count = 0
    end

    save
  end
end

class PostsController < FakeController
  def create
    @post = Post.new(params[:post])

    @post.publish(current_user)
    redirect_to post_path(@post)
  end
end

require './tests' if __FILE__ == $0
