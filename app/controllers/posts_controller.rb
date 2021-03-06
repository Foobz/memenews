class PostsController < ApplicationController

  # GET /posts
  # GET /posts.json
  def index
    
    @posts =  Post.all :include => [:user]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end


  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comments = @post.comments
  
      respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end
  

 def create
    @post = Post.create!(params[:post])
    flash[:notice] = "Thank you, your post is going through the publication."
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.js
    end
  end
  
  
  # delete post ajaxified
  def destroy
     @post = Post.find(params[:id])
     @post.destroy

     respond_to do |format|
       format.html { redirect_to posts_path }
       format.js
     end
   end
  
   # posts/:id/up
  def countUp
    Post.increment_counter(:count_up, params[:id])
    @post = Post.find(params[:id])
     respond_to do |format|
       format.js
     end
  end
  
  # posts/:id/down
  def countDown
    Post.increment_counter(:count_down, params[:id])
    @post = Post.find(params[:id])
     respond_to do |format|
       format.js
     end
  end
  

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

end
