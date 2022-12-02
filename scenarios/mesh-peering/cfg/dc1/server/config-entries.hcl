
config_entries {
  bootstrap {
    Kind = "exported-services"
    Name = "default"
    
    Services = [
      {
        Name = "counting"
	Consumers = [
	  {
	    Peer = "dc2"
	  }
	]
      }
    ]
  }
}
