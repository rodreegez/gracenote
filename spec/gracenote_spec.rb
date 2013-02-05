require 'spec_helper'

describe Gracenote do

  def stub_register_api
    @register_api_response = {
      "RESPONSES" => {
        "RESPONSE" => {
          "USER" => "111111111111111111-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
        }
      }
    }
    xml =<<EOF
    <RESPONSES>
      <RESPONSE STATUS="OK">
        <USER>111111111111111111-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA</USER>
      </RESPONSE>
    </RESPONSES>
EOF
    Gracenote.any_instance.stub(:post).and_return xml
  end

  it 'should have a version number' do
    Gracenote::VERSION.should_not be_nil
  end

  describe 'Gracenote.initialize' do
    it 'should set @client_id' do
      stub_register_api
      client = Gracenote.new('test-id')
      expect(client.client_id).to eq('test-id')
    end

    context 'user_id is not given' do
      it 'should set @user_id via REGISTER API' do
        stub_register_api
        client = Gracenote.new('test-id')
        uid = @register_api_response["RESPONSES"]["RESPONSE"]["USER"]
        expect(client.user_id).to eq(uid)
      end
    end

    context 'user_id is given' do
      it 'should set given @user_id' do
        Gracenote.any_instance.should_not_receive(:post)
        client = Gracenote.new('test-client-id', 'test-user-id')
        expect(client.user_id).to eq('test-user-id')
      end
    end
  end

  describe 'Gracenote.basic_track_search' do
    it 'should call Gracenote#post with correct XML' do
      client = Gracenote.new('test-client-id', 'test-user-id')
      xml =<<EOF
<QUERIES>
      <LANG>eng</LANG>
      <AUTH>
        <CLIENT>test-client-id</CLIENT>
        <USER>test-user-id</USER>
      </AUTH>
      <QUERY CMD="ALBUM_SEARCH">
        <TEXT TYPE="ARTIST">test_artist</TEXT>
        <TEXT TYPE="ALBUM_TITLE">test_album</TEXT>
        <TEXT TYPE="TRACK_TITLE">test_title</TEXT>
      </QUERY>
    </QUERIES>
EOF
      result_xml =<<EOF
      <RESPONSES>
        <RESPONSE STATUS="OK">
          <ALBUM>
            <GN_ID>TEST-GN-ID</GN_ID>
          </ALBUM>
        </RESPONSE>
      </RESPONSES>
EOF
      result = {
        "RESPONSES" => {
          "RESPONSE" => {
            "STATUS" => "OK",
            "ALBUM" => {
              "GN_ID" => "TEST-GN-ID" } } } }

      client.should_receive(:post).with(xml.chomp).and_return result_xml
      expect( client.basic_track_search('test_artist', 'test_album', 'test_title') ).to eq(result)
    end
  end

  describe 'Gracenote.artist_image' do
    it 'should call Gracenote#post with correct XML' do
      client = Gracenote.new('test-client-id', 'test-user-id')
      xml =<<EOF
<QUERIES>
      <AUTH>
        <CLIENT>test-client-id</CLIENT>
        <USER>test-user-id</USER>
      </AUTH>
      <LANG>eng</LANG>
      <COUNTRY>usa</COUNTRY>
      <QUERY CMD="ALBUM_FETCH">
        <GN_ID>TEST-GN-ID</GN_ID>
        <OPTION>
          <PARAMETER>SELECT_EXTENDED</PARAMETER>
          <VALUE>ARTIST_IMAGE</VALUE>
        </OPTION>
      </QUERY>
    </QUERIES>
EOF
      result_xml =<<EOF
      <RESPONSES>
        <RESPONSE STATUS="OK">
          <ALBUM>
            <GN_ID>TEST-GN-ID</GN_ID>
            <URL TYPE="ARTIST_IMAGE">http://te.st/test.jpg</URL>
          </ALBUM>
        </RESPONSE>
      </RESPONSES>
EOF
      result = "http://te.st/test.jpg"
      client.should_receive(:post).with(xml.chomp).and_return result_xml
      expect( client.artist_image('TEST-GN-ID') ).to eq(result)
    end
  end
end
