tag=latest
clean:
	docker rmi archway/k8s-dev:$(tag)
build:
	docker build --tag archway/k8s-dev:$(tag) .
run:
	docker run -d -v ${HOME}/.kube:/home/me/.kube -p 2200:22 archway/k8s-dev:$(tag)