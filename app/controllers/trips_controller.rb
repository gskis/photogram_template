class TripsController < ApplicationController
  def index
    @trips = Trip.all

    render("trip_templates/index.html.erb")
  end

  def show
    @trip = Trip.find(params.fetch("id_to_display"))

    render("trip_templates/show.html.erb")
  end

  def new_form
    @trip = Trip.new

    render("trip_templates/new_form.html.erb")
  end

  def create_row
    @trip = Trip.new

    @trip.country_name = params.fetch("country_name")
    @trip.image = params.fetch("image")
    @trip.owner_id = params.fetch("owner_id")
    @trip.city_visited = params.fetch("city_visited")
    @trip.rating = params.fetch("rating")
    @trip.must_do = params.fetch("must_do")

    if @trip.valid?
      @trip.save

      redirect_back(:fallback_location => "/trips", :notice => "Trip created successfully.")
    else
      render("trip_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @trip = Trip.find(params.fetch("prefill_with_id"))

    render("trip_templates/edit_form.html.erb")
  end

  def update_row
    @trip = Trip.find(params.fetch("id_to_modify"))

    @trip.country_name = params.fetch("country_name")
    @trip.image = params.fetch("image")
    @trip.owner_id = params.fetch("owner_id")
    @trip.city_visited = params.fetch("city_visited")
    @trip.rating = params.fetch("rating")
    @trip.must_do = params.fetch("must_do")

    if @trip.valid?
      @trip.save

      redirect_to("/trips/#{@trip.id}", :notice => "Trip updated successfully.")
    else
      render("trip_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row_from_owner
    @trip = Trip.find(params.fetch("id_to_remove"))

    @trip.destroy

    redirect_to("/users/#{@trip.owner_id}", notice: "Trip deleted successfully.")
  end

  def destroy_row
    @trip = Trip.find(params.fetch("id_to_remove"))

    @trip.destroy

    redirect_to("/trips", :notice => "Trip deleted successfully.")
  end
end
