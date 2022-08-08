require 'faraday'

require 'lita/adapters/slack/team_data'
require 'lita/adapters/slack/slack_im'
require 'lita/adapters/slack/slack_user'
require 'lita/adapters/slack/slack_channel'

module Lita
  module Adapters
    class Slack < Adapter
      # @api private
      class API
        def initialize(config, stubs = nil)
          @config = config
          @stubs = stubs
          @post_message_config = {}
          @post_message_config[:parse] = config.parse unless config.parse.nil?
          @post_message_config[:link_names] = config.link_names ? 1 : 0 unless config.link_names.nil?
          @post_message_config[:unfurl_links] = config.unfurl_links unless config.unfurl_links.nil?
          @post_message_config[:unfurl_media] = config.unfurl_media unless config.unfurl_media.nil?
        end

        def im_open(user_id)
          response_data = call_api("im.open", user: user_id)

          SlackIM.new(response_data["channel"]["id"], user_id)
        end

        def channels_info(channel_id)
          call_api("channels.info", channel: channel_id)
        end

        def channels_list
          call_api("channels.list")
        end

        def groups_list
          call_api("groups.list")
        end

        def mpim_list
          call_api("mpim.list")
        end

        def im_list
          call_api("im.list")
        end

        def send_attachments(room_or_user, attachments)
          call_api(
            "chat.postMessage",
            as_user: true,
            channel: room_or_user.id,
            attachments: MultiJson.dump(attachments.map(&:to_hash)),
          )
        end

        def send_messages(channel_id, messages)
          call_api(
            "chat.postMessage",
            **post_message_config,
            as_user: true,
            channel: channel_id,
            text: messages.join("\n"),
          )
        end

        def set_topic(channel, topic)
          call_api("channels.setTopic", channel: channel, topic: topic)
        end

        def rtm_start
          response_data = call_api("rtm.connect")
          ims_data = [{
            "id" => "D9RHN7RKJ",
            "created" => 1521471026,
            "is_archived" => false,
            "is_im" => true,
            "is_org_shared" => false,
            "context_team_id" => "T02AY8YGS",
            "user" => "USLACKBOT",
            "last_read" => "0000000000.000000",
            "is_open" => true,
            "has_pins" => false,
            "priority" => 0
          }, {
            "id" => "D9RHN86JU",
            "created" => 1521471027,
            "is_archived" => false,
            "is_im" => true,
            "is_org_shared" => false,
            "context_team_id" => "T02AY8YGS",
            "user" => "U037Y9EPP",
            "last_read" => "1551873825.000100",
            "is_open" => false,
            "has_pins" => false,
            "priority" => 0
          }, {
            "id" => "D9RLMRF5F",
            "created" => 1521471027,
            "is_archived" => false,
            "is_im" => true,
            "is_org_shared" => false,
            "context_team_id" => "T02AY8YGS",
            "user" => "U13D95KAR",
            "last_read" => "1569938868.001600",
            "is_open" => false,
            "has_pins" => false,
            "priority" => 0
          }, {
            "id" => "D9S4ML9EX",
            "created" => 1521471027,
            "is_archived" => false,
            "is_im" => true,
            "is_org_shared" => false,
            "context_team_id" => "T02AY8YGS",
            "user" => "U634LTEBW",
            "last_read" => "0000000000.000000",
            "is_open" => true,
            "has_pins" => false,
            "priority" => 0
          }, {
            "id" => "D9S4MLCE7",
            "created" => 1521471027,
            "is_archived" => false,
            "is_im" => true,
            "is_org_shared" => false,
            "context_team_id" => "T02AY8YGS",
            "user" => "U03QLNQ1X",
            "last_read" => "1574869991.001600",
            "is_open" => true,
            "has_pins" => false,
            "priority" => 0
          }, {
            "id" => "D9S4MLCTD",
            "created" => 1521471027,
            "is_archived" => false,
            "is_im" => true,
            "is_org_shared" => false,
            "context_team_id" => "T02AY8YGS",
            "user" => "U02AXFSBZ",
            "last_read" => "1568213043.003500",
            "is_open" => true,
            "has_pins" => false,
            "priority" => 0
          }, {
            "id" => "D9S6LKRB6",
            "created" => 1521471027,
            "is_archived" => false,
            "is_im" => true,
            "is_org_shared" => false,
            "context_team_id" => "T02AY8YGS",
            "user" => "U0B2F71MX",
            "last_read" => "0000000000.000000",
            "is_open" => false,
            "has_pins" => false,
            "priority" => 0
          }, {
            "id" => "D9S6LKYTW",
            "created" => 1521471028,
            "is_archived" => false,
            "is_im" => true,
            "is_org_shared" => false,
            "context_team_id" => "T02AY8YGS",
            "user" => "U02AXFRND",
            "last_read" => "1536830191.000100",
            "is_open" => true,
            "has_pins" => false,
            "priority" => 0
          }, {
            "id" => "D9S7JGW4A",
            "created" => 1521471027,
            "is_archived" => false,
            "is_im" => true,
            "is_org_shared" => false,
            "context_team_id" => "T02AY8YGS",
            "user" => "U02AYA5GZ",
            "last_read" => "0000000000.000000",
            "is_open" => true,
            "has_pins" => false,
            "priority" => 0
          }, {
            "id" => "D9SB2UVB7",
            "created" => 1521471026,
            "is_archived" => false,
            "is_im" => true,
            "is_org_shared" => false,
            "context_team_id" => "T02AY8YGS",
            "user" => "U02AY8YGU",
            "last_read" => "1572017525.002100",
            "is_open" => true,
            "has_pins" => false,
            "priority" => 0
          }, {
            "id" => "D9T8Z1ETH",
            "created" => 1521471027,
            "is_archived" => false,
            "is_im" => true,
            "is_org_shared" => false,
            "context_team_id" => "T02AY8YGS",
            "user" => "U0AKH5P3R",
            "last_read" => "0000000000.000000",
            "is_open" => false,
            "has_pins" => false,
            "priority" => 0
          }, {
            "id" => "DMNRQB3E2",
            "created" => 1566467407,
            "is_archived" => false,
            "is_im" => true,
            "is_org_shared" => false,
            "context_team_id" => "T02AY8YGS",
            "user" => "UMGER47NC",
            "last_read" => "1566467408.000100",
            "is_open" => true,
            "has_pins" => false,
            "priority" => 0
          }]

          TeamData.new(
            SlackIM.from_data_array(ims_data),
            SlackUser.from_data(response_data["self"]),
            [],
            [],
            response_data["url"],
          )
        end

        private

        attr_reader :stubs
        attr_reader :config
        attr_reader :post_message_config

        def call_api(method, post_data = {})
          response = connection.post(
            "https://slack.com/api/#{method}",
            { token: config.token }.merge(post_data)
          )

          data = parse_response(response, method)

          raise "Slack API call to #{method} returned an error: #{data["error"]}." if data["error"]

          data
        end

        def connection
          if stubs
            Faraday.new { |faraday| faraday.adapter(:test, stubs) }
          else
            options = {}
            unless config.proxy.nil?
              options = { proxy: config.proxy }
            end
            Faraday.new(options)
          end
        end

        def parse_response(response, method)
          unless response.success?
            raise "Slack API call to #{method} failed with status code #{response.status}: '#{response.body}'. Headers: #{response.headers}"
          end

          MultiJson.load(response.body)
        end
      end
    end
  end
end
