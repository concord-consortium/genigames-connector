require 'fakeweb'
FakeWeb.allow_net_connect = false

FakeWeb.register_uri(:get, "http://foo.com/activities.json", :body => <<JSON)
[
  {"activity":{"author_name":"Aaron Unger","created_at":"2012-07-10T20:30:31Z","id":1,"name":"one","owner_id":1,"updated_at":"2012-07-10T20:30:31Z"}},
  {"activity":{"author_name":"Aaron Unger","created_at":"2012-07-11T20:30:31Z","id":2,"name":"two","owner_id":1,"updated_at":"2012-07-11T20:30:31Z"}},
  {"activity":{"author_name":"Aaron Unger","created_at":"2012-07-12T20:30:31Z","id":3,"name":"three","owner_id":1,"updated_at":"2012-07-12T20:30:31Z"}}
]
JSON
FakeWeb.register_uri(:get, "http://foo.com/activities/34.json", :status => ["404", "Not Found"])

