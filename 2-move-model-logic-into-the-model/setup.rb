
class FakeModel
  def save
    true
  end
end

class User < FakeModel
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class FakeController
  attr_accessor :current_user, :params, :flash_msg
  attr_accessor :post

  def initialize(params)
    @params = params
  end

  protected

  def redirect_to(path)
    true
  end

  def post_path(post)
    "/posts/#{post.id}"
  end
end
