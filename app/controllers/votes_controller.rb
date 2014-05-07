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
