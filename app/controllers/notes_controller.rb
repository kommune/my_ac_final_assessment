class NotesController < ApplicationController
  before_action :authenticate_user!, except: [:home]
  before_action :set_note, only: [:show, :edit, :update, :destroy, :like, :dislike]

  def home
    @notes = Note.all
    @users = User.all
  end

  def index
    @users = current_user.followings
    @following_notes = Note.where(user_id: @users.ids)
    @notes = current_user.notes
  end

  def new
    @note = Note.new
  end

  def create
    @note = current_user.notes.new(note_params)
    if @note.save
      flash[:notice] = "Note was successfully saved!"
      redirect_to notes_path
    else
      flash.now[:alert] = "Failed to create note"
      render :new
    end

  end

  def show
    
  end

  def edit
    
  end

  def update
    if @note.update(note_params)
      flash[:notice] = "Note was successfully updated!"
      redirect_to notes_path
    else
      flash.now[:alert] = "Failed to update note"
      render :edit
    end
  end

  def destroy
    @note.destroy
    redirect_to notes_path
    flash[:alert] = "Note was deleted"
  end

  def like
    @like = Like.new(user: current_user, note_id: params[:id])
    @note = Note.find(params[:id])
    @user = @note.user
    if @like.save
      UserMailer.like_email(@user).deliver_later
      redirect_to notes_path
    end
  end

  def unlike
    @like = Like.find_by(user: current_user, note_id: params[:id] )
    @like.destroy
    @note = Note.find(params[:id])
    @user = @note.user
    UserMailer.unlike_email(@user).deliver_later
    redirect_to notes_path
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :body)
  end
end
