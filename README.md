# mnist-train

Here is the basic scenario:

Make update to the model:
  - update mnistParams.json - this file contains parameters for mnist model
  - make commit

CI workflow will be triggered which is configured using GitHub Actions. The workflow consist of 3 jobs:
  - build-model
  - build-push
  - pipeline

Build-model - as a result you will have image which contain your model which will be used in the pipeline to train it:
  - checkout repo
  - build docker image with new changes using model.Dockerfile
  - push docker image to the Docker registry

Build-push - as a result you will have image which contain script to push trained model from PVC to external repo (mnist-serve in this case):
  - checkout repo
  - build docker image with new changes using push.Dockerfile
  - push docker image to the Docker registry

Pipeline:
  - checkout repo
  - install python 3
  - change tokens in the mnist_train_pipeline.py file using secrets
  - compile pipeline
  - check step to verify that all was changed
  - download kfplctl tool - needed to work with Kubeflow from CLI
  - create new pipeline in the Kubeflow
  - create new experiment if it doesn't exist
  - create new run using new pipeline and experiment

After this you need to go to Kubeflow and wait until your run will finish.
As a result of the run you will get:
  - trained model with parameters you provided in mnistParams.json file
  - this model is pushed to mnist-serve repo

Next will be triggered CI workflow on the mnist-serve repo:
  - build
  - deploy

Build:
  - checkout repo
  - build new image based on tensorflow/serving with new model
  - push new image to the Docker registry

Deploy:
  - create deployment and service in the k8s provided with new image/model

As a result you will have your model served by tensoflow serving server in your k8s cluster and configured access to it.
Now let's move to the last step - mnist-web-ui repo. It will not be triggered automatically, but if you will do some commit to it - it will trigger its CI. It also consist with two steps: build and deploy.

Build:
  - build new image with server/client which will connect to the tensorflow serving server in the same cluster.
  - push new image to the registry

Deploy:
  - create deployment and service in the k8s provided with new image/model

As a result you will have external IP address which you can hit and see web-ui connected to your latest model.
