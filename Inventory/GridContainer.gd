extends GridContainer

func getSlot(path):
	print("path: ", path)
	return get_node(path)
