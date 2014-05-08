class VotesController < ApplicationController

  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all
  end

  # POST /votes
  # POST /votes.json
  def create
    @vote = Vote.new(vote_params)

    now = Time.now
    one_hour = 60*60
    hour_ago = now - one_hour

    if current_user then
      @vote.user = current_user
      if Vote.where(user: current_user, created_at: hour_ago..now).size > 0 then
        redirect_to root_url, alert: 'You have voted recently.'
        return
      end
    else
      request_ip = request.remote_ip
      @vote.ip = request_ip
      if Vote.where(ip: request_ip).size > 0 then
        redirect_to root_url, alert: 'Someone has voted recently from this IP.'
        return
      end
    end

    if @vote.save
      redirect_to root_url, notice: 'Vote was successfully created.'
    else
      redirect_to root_url, alert: 'Failed to add a new vote.'
    end
  end

  private

  def vote_params
    params.permit(:open)
  end
end
