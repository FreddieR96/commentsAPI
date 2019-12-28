class CommentsController < ApplicationController
before_action :check_header, only: [:show, :index, :create]
def show
@comment = Comment.find(params[:id])
if @comment
render json: { status: 'Success', data: @comment.body }
end 
end
def index
@comments = Comment.where(deleted: false)
@comment_bodies = []
@comments.each do |x|
	@comment_bodies.push(x.body)
end
render json: { status: 'Success', data: @comment_bodies }
end
def create
@comment = Comment.create(comment_params)
end
def check_header
if request.headers["Password"] == "APIComments"
	return true
else
	puts "A request was denied"
	head :ok
end
end
private
def comment_params
	params.permit(:body, :deleted)
end
end
