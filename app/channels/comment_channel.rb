class CommentChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'comments'
  end

  def unsubscribed; end
end
