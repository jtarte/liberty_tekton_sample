# liberty_tekton_sample


The java web application that is used to support the demonstration is the Application Moderinisation Resorts. You could find the original application at this [github repository](https://github.com/ibm/appmod-resorts).


## Prerequisites

* An OpenShift cluster (the tests were made on a OCP 4.7)
* Red Hat Pipelines operator is deployed on the the OCP cluster with `all namesapces` scope.
* Access to an image registry. (For the test, I used docker hub) 


## Prepare 

Clone the git repo on your laptop 


Create the namespace that will be used for the demo
```
oc new-project liberty
```

For this demo, all the work is done inside the same namespace. It is simpler.  But if you are willing to separe the pipeline work from the apllication, you may use different namespace. But in this case, yu may have to configure some service account to ensure resource deployment. (cf [First pipeline with Tekton on IBM Cloud Pak for Applications](https://medium.com/@jerome_tarte/first-pipeline-with-tekton-on-ibm-cloud-pak-for-application-e82ea7b8a6b1) article could give some informations on this topic)

Create a secret with the credentials on the image registry where the image will be pushed. In my case, it is the docker hub using an access token.
```
oc create secret generic dockerhub-secret --from-literal=user=<your user> --from-literal=token=<your token>
```

Create the docker image pipelineresource to define your target image
```
apiVersion: tekton.dev/v1alpha1
kind: PipelineResource
metadata:
  name: docker-image
spec:
  params:
  - name: url
    value: docker.io/jtarte/app-modresort:2.1
  type: image
```
You may change the value of url param to reflect your image name and your image registry. 

Deploy it on the cluster 
```
oc apply -f tekton/docker-image.yaml
```










## Reference 

* [First tasks with Tekton on IBM Cloud Pak for Applications](https://medium.com/@jerome_tarte/first-tasks-with-tekton-on-ibm-cloud-pak-for-application-88c8f496723d)
* [First pipeline with Tekton on IBM Cloud Pak for Applications](https://medium.com/@jerome_tarte/first-pipeline-with-tekton-on-ibm-cloud-pak-for-application-e82ea7b8a6b1)
* [Additional Tekton tips for your pipelines](https://medium.com/@jerome_tarte/additional-tekton-tips-for-your-pipelines-7dd662140e8f)
* [Application Modernisation repositroy](https://github.com/ibm/appmod-resorts)
