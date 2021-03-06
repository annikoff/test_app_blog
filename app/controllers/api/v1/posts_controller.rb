# frozen_string_literal: true
module API
  module V1
    class PostsController < ApplicationController
      before_action :find_post, only: [:show, :update, :destroy]

      def index
        scope = posts.offset(offset).limit(limit).order(published_at: :desc)
        response.set_header('posts_count', posts_count)
        response.set_header('pages', pages)
        render json: scope
      end

      def show
        render json: @post
      end

      def create
        post = posts.build post_params
        if post.save
          render json: post
        else
          render_validation_error post
        end
      end

      def update
        if @post.update_attributes post_params
          render json: @post
        else
          render_validation_error @post
        end
      end

      def destroy
        @post.destroy
        render json: {}
      end

      private

      def post_params
        params.permit(:title, :body, :published_at)
      end

      def find_post
        @post = posts.find_by id: params[:id]
        render_error 404 if @post.blank?
      end

      def posts
        @user.posts
      end

      def offset
        offset = (params[:page].to_i - 1) * limit
        offset.negative? ? 0 : offset
      end

      def pages
        return 1 if limit.zero?
        (posts_count / limit.to_f).ceil
      end

      def limit
        @limit ||= (params[:per_page] || posts_count).to_i
      end

      def posts_count
        @posts_count ||= posts.size
      end
    end
  end
end
