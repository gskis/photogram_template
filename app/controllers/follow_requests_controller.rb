class FollowRequestsController < ApplicationController
  before_action :current_user_must_be_follow_request_sender, :only => [:edit_form, :update_row, :destroy_row]

  def current_user_must_be_follow_request_sender
    follow_request = FollowRequest.find(params["id_to_display"] || params["prefill_with_id"] || params["id_to_modify"] || params["id_to_remove"])

    unless current_user == follow_request.sender
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @follow_requests = current_user.sent_follow_requests.page(params[:page]).per(10)

    render("follow_request_templates/index.html.erb")
  end

  def show
    @follow_request = FollowRequest.find(params.fetch("id_to_display"))

    render("follow_request_templates/show.html.erb")
  end

  def new_form
    @follow_request = FollowRequest.new

    render("follow_request_templates/new_form.html.erb")
  end

  def create_row
    @follow_request = FollowRequest.new

    @follow_request.sender_id = params.fetch("sender_id")
    @follow_request.recipient_id = params.fetch("recipient_id")

    if @follow_request.valid?
      @follow_request.save

      redirect_back(:fallback_location => "/follow_requests", :notice => "Follow request created successfully.")
    else
      render("follow_request_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @follow_request = FollowRequest.find(params.fetch("prefill_with_id"))

    render("follow_request_templates/edit_form.html.erb")
  end

  def update_row
    @follow_request = FollowRequest.find(params.fetch("id_to_modify"))

    
    @follow_request.recipient_id = params.fetch("recipient_id")

    if @follow_request.valid?
      @follow_request.save

      redirect_to("/follow_requests/#{@follow_request.id}", :notice => "Follow request updated successfully.")
    else
      render("follow_request_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row_from_sender
    @follow_request = FollowRequest.find(params.fetch("id_to_remove"))

    @follow_request.destroy

    redirect_to("/users/#{@follow_request.sender_id}", notice: "FollowRequest deleted successfully.")
  end

  def destroy_row_from_recipient
    @follow_request = FollowRequest.find(params.fetch("id_to_remove"))

    @follow_request.destroy

    redirect_to("/users/#{@follow_request.recipient_id}", notice: "FollowRequest deleted successfully.")
  end

  def destroy_row
    @follow_request = FollowRequest.find(params.fetch("id_to_remove"))

    @follow_request.destroy

    redirect_to("/follow_requests", :notice => "Follow request deleted successfully.")
  end
end
