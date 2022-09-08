
config_entries {
  bootstrap {
    Kind = "exported-services"
    Name = "default"
    
    Services = [
      {
        Name = "counting"
	Consumers = [
	  {
	    PeerName = "dc2"
	  }
	]
      }
    ]
  }
}
