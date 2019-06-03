# map helpers

module Sinatra
  module UMDIO
    module Helpers
      def get_buildings db
        db.find({},{fields: {:_id => 0}}).map { |e| e }
      end

      def get_buildings_by_id db, id
        building_ids = id.upcase.split(",")
        building_ids.each { |building_id| halt 400, bad_url_error(bad_id_message) unless is_building_id? building_id }

        # find building ids or building codes
        expr = {
          '$or' => [
            { building_id: { '$in' => building_ids} },
            { code: { '$in' => building_ids} },
          ]
        }

        buildings = db.find(expr, { fields: {:_id => 0} }).to_a

        # throw 404 if empty
        if buildings == []
          halt 404, {
            error_code: 404,
            message: "Building number #{params[:building_id]} isn't in our database, and probably doesn't exist.",
            available_buildings: "https://api.umd.io/map/buildings",
            docs: "https://umd.io/map"
          }.to_json
        end

        buildings
      end

      # is it a building id? We don't know until we check the database. This determines if it is at least possible
      def is_building_id? string
        string.length < 6 && string.length > 2
      end

      # can this be a more general helper method? Where else can we use that?
      def bad_url_error message
        message ||= "Check your url! It doesn't seem to correspond to anything on the umd.io api. If you think it should, create an issue on our github page."
        {error_code: 400,
         message: message,
         docs: "https://umd.io/maps/"}.to_json
      end

    end
  end
end