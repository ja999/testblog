class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.json
  expose(:post)
  expose(:comment)
  expose(:comments)
  expose(:votes) {comment.votes}
  expose(:vote) { votes.detect { |v| v.user_id == current_user.id } || Vote.new(comment_id: comment.id) }

  def index
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    comment.post_id=post.id
    comment.user_id=current_user.id
    if comment.save
      render action: :index
    else
      render :new
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    if comment.save
      render action: :index
    else
      render :edit
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    if comment.user_id==current_user.id
      unless comment.destroy
        flash[:error] = "Nie dziala..."
      end
    end
    render action: :index
  end

  def up
    vote.user_id=current_user.id
    vote.value=true
    vote.save
    opin
    redirect_to action: :index
  end

  def down
    vote.user_id=current_user.id
    vote.value=false
    vote.save
    opin
    redirect_to action: :index
  end

  def opin
    comment.opinion = 2*(comment.votes.partition{|it| it.value })[0].size - comment.votes.size
    abusive
    comment.save
  end

  def abusive
    if comment.opinion <= -3
      comment.abusive = true
    else
      comment.abusive = false
    end
  end

  def not_abusive
    comment.abusive=false
    comment.save
    redirect_to action: :index
  end
end