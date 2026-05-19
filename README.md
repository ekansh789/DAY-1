* Added IAM policy for Load Balancer integration in Terraform and created a new association.

* Installed and explored Helm charts by reviewing the repository structure, including `values.yaml`, `helpers`, `templates`, and metadata files, which are conceptually similar to Chef cookbooks or Ansible roles.

* Deployed applications using Helm and updated configurations using both override values files and external `values.yaml` files.

* Observed that pods automatically restart during container image updates, but changes in ConfigMaps or normal variables do not trigger automatic pod restarts and require manual rollout restart.

* Tested rollback functionality using `helm rollback <release-name> <revision-number>`.

* Worked with commonly used Helm commands:

  * `helm list`
  * `helm install`
  * `helm upgrade`
  * `helm template <service-name>`
  * `helm show`
  * `helm uninstall`
