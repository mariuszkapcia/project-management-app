class EstimateProjectService < ProjectService
  def initialize(event_store:)
    @event_store = event_store
  end

  def call(command)
    with_project(command.uuid) do |project|
      project.estimate(command.hours)
    end
  end
end
