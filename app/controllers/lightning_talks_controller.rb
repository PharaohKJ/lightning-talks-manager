class LightningTalksController < ApplicationController
  before_action :set_event

  def create
    @lightning_talk = @event.lightning_talks.build(lightning_talk_params)

    respond_to do |format|
      if @lightning_talk.save
        format.turbo_stream
        format.html { redirect_to @event, notice: "Lightning talk was successfully created." }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("lightning_talk_form", partial: "lightning_talks/form", locals: { event: @event, lightning_talk: @lightning_talk }) }
        format.html { render "events/show", status: :unprocessable_entity }
      end
    end
  end

  def update
    @lightning_talk = @event.lightning_talks.find(params[:id])
    if params[:position]
      @lightning_talk.insert_at(params[:position].to_i)
    else
      @lightning_talk.update(lightning_talk_params)
    end

    head :no_content
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def lightning_talk_params
    params.require(:lightning_talk).permit(:speaker_name, :title, :duration)
  end
end
