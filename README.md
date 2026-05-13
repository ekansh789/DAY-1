
Tasks Completed

Created and deployed a StatefulSet YAML successfully.
Configured a ConfigMap and injected environment variables using envFrom.
Created a Headless Service for the StatefulSet by defining the serviceName parameter under the StatefulSet metadata/spec.
Verified successful deployment using:
kubectl get svc
kubectl get endpointslices
Created a Deployment along with a ClusterIP Service and verified the resources successfully.


ClusterIP Service
Like calling a customer-care number:


Any available agent can answer your call.
You are connected to the service, not a specific person.



Headless Service
Like having direct phone numbers:


You can call Person A, Person B, or Person C specifically.
You directly connect to a particular person.

Why Stateful Applications Need Headless Services
Stateful applications need direct communication with specific Pods because each Pod has its own identity and data.
