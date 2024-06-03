class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    def index
        begin
            @posts = Post.all
            Rails.logger.info("\nDEEZNUT: Fetched all posts ==============================\n")
            #Rails.logger.info("\nDEEZNUT: Fetched all posts\n", { user_id: 100 })
        rescue => e
            Rails.logger.error("\nDEEZNUT: #{e.message} ==============================\n")
            redirect_to root_path, alert: 'Failed to fetch posts.'
        end
    end

    def show
        Rails.logger.info("\nDEEZNUT: Post (#{@post.id}) viewed ==============================\n")
    end

    def new
        @post = Post.new
        @categories = Category.all
    end

    def edit
        begin
            @post = Post.find(params[:id])
            @categories = Category.all
            Rails.logger.info("\nDEEZNUT: Post (#{@post.id}) edit initiated... ==============================\n")
        rescue => e
            Rails.logger.error("\nDEEZNUT: #{e.message} ==============================\n")
            redirect_to @post, alert: 'Failed to initiate post edit.'
        end
    end

    def create
        @post = Post.new(post_params)
        begin
            if @post.save
                Rails.logger.info("\nDEEZNUT: Post (#{@post.id}) created ==============================\n")
                redirect_to @post, notice: 'Post was successfully created.'
            else
                @categories = Category.all
                render :new
            end
        rescue => e
            Rails.logger.error("\nDEEZNUT: #{e.message} ==============================\n")
            redirect_to new_post_path, alert: 'Failed to create post.'
        end
    end

    def update
        begin
            if @post.update(post_params)
                Rails.logger.info("\nDEEZNUT: Post (#{@post.id}) updated ==============================\n")
                redirect_to @post, notice: 'Post was successfully updated.'
            else
                @categories = Category.all
                render :edit
            end
        rescue => e
            Rails.logger.error("\nDEEZNUT: #{e.message} ==============================\n")
            redirect_to edit_post_path(@post), alert: 'Failed to update post.'
        end
    end

    def destroy
        begin
            @post.destroy
            Rails.logger.info("\nDEEZNUT: Post deleted ==============================\n")
            redirect_to posts_url, notice: 'Post was successfully destroyed.'
        rescue => e
            Rails.logger.error("\nDEEZNUT: #{e.message} ==============================\n")
            redirect_to posts_url, alert: 'Failed to delete post.'
        end
    end

    private

    def set_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:title, :content, :category_id)
    end
end