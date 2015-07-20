$:.unshift(File.dirname(__FILE__))

require 'test_helper'

class MqttSnPubTest < MiniTest::Unit::TestCase

  def test_publish_qos_n1
    fake_server do |fs|
      @packet = fs.wait_for_publish do
        @cmd_result = run_cmd(
          'mqtt-sn-pub',
          '-q' => -1,
          '-T' => 10,
          '-m' => 'Hello',
          '-p' => fs.port
        )
      end
    end

    assert_empty @cmd_result
    assert_equal 10, @packet.topic_id
    assert_equal :predefined, @packet.topic_id_type
    assert_equal 'Hello', @packet.data
    assert_equal -1, @packet.qos
  end

end
