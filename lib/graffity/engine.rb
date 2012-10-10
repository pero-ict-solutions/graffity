require 'sequel'
module Graffity
  class Engine < ::Rails::Engine

    initializer "graffity.start_subscriber" do

      #in memory db
      DB = Sequel.sqlite
      DB.create_table :actions do
        primary_key :id
        String :req_id
        String :name
        String :controller
        Timestamp :start
        Timestamp :finish
      end

      DB.create_table :templates do
        primary_key :id
        String :req_id
        String :name
        String :identifier
        String :virtual_path
        Timestamp :start
        Timestamp :finish
        boolean :partial
        String :layout
      end

      ActiveSupport::Notifications.subscribe "start_processing.action_controller" do |name, start, finish, id, payload|
        Rails.logger.debug ["[Notification] ", id, name, payload.inspect].join(" ")
        controller = payload[:controller]
        unless controller === "InspectorController"
          Graffity::Action.delete
          Graffity::Template.delete

          action = payload[:action]
          the_action = Graffity::Action.where(:name => action, :controller => controller).first
          Rails.logger.debug ["[Notification CONT] ", controller].join(" ")
          if the_action
            the_action.update(:req_id => id, :start => start, :finish => finish)
          else
            Graffity::Action.create(:req_id => id, :name => action, :controller => controller, :start => start, :finish => finish)
          end
        end
      end

      ActiveSupport::Notifications.subscribe /^render_/ do |name, start, finish, id, payload|
        Rails.logger.debug ["[Notification] ", id, name, payload.inspect].join(" ")
        identifier = payload[:identifier]
        virtual_path = identifier[/app\/views\/(.*)/,1].split('.').first
        action = Graffity::Action.where(:req_id => id)

        unless virtual_path.match(/_graffity/)
          if action
            row = {:req_id => id, :name => name, :identifier => identifier, :virtual_path => virtual_path, :start => start, :finish => finish}
            if payload.has_key?(:layout)
              row.merge!({:partial => false, :layout => payload[:layout]})
            else
              row.merge!({:partial => true })
            end
            Graffity::Template.create(row)
          end
        end
      end

    end

  end
end
