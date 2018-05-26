.PHONY: all build deploy swarm stop config export import

build:
	docker build -t local/donkey .
