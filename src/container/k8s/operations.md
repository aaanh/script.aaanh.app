# Operations

## Namespace

- GET: All resources in the default namespace

  > Note: Use the `-n` option followed by the specific namespace to scope to it

  ```
  kubectl get all -n default
  ```

  Example output:

  ```
  NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
  service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   3m34s
  ```

- GET: Existing namespaces

  ```
  kubectl get ns
  ```

  Example output:

  ```
  NAME              STATUS   AGE
  default           Active   4m16s
  kube-node-lease   Active   4m17s
  kube-public       Active   4m17s
  kube-system       Active   4m18s
  ```

- CREATE: A new namespace

  ```
  kubectl create ns <namespace>
  ```

  Example output:

  ```
  namespace/<namespace> created
  ```

- DELETE: A namespace

  ```
  kubectl d ns/<namespace>
  ```

## Custom Resource Definitions (CRDs)

> For brevity, the following examples will use a `secretproviderclass` CRD called `azure-secrets`.

- GET: All resources of a CRD

  ```sh
  kubectl get secretproviderclass # optionally, use -o wide or -o yaml
  ```

  Example output:

  ```
  NAME           AGE
  azure-secrets  3m
  azure-certs    3m
  ```

- GET: Manifest of the CRD

  ```
  kubectl get secretproviderclass/azure-secrets
  ```

  Example output:

  ```yaml
  apiVersion: secrets-store.csi.x-k8s.io/v1alpha1
  kind: SecretProviderClass
  metadata:
    name: azure-secrets
  spec:
    provider: azure
    parameters:
      usePodIdentity: "false"
      keyvaultName: <keyvault-name>
      cloudName: "" # [OPTIONAL for Azure] if not provided, azure environment will default to AzurePublicCloud
      objects:  |
        array:
          - |
            objectName: <secret-name>
            objectType: secret
            objectVersion: "" # [OPTIONAL] object versions can be specified here, current version will be used if empty
          - |
            objectName: <cert-name>
            objectType: cert
            objectVersion: "" # [OPTIONAL] object versions can be specified here, current version will be used if empty
      tenantId: <tenant-id>
      subscriptionId: <subscription-id>
      resourceGroup: <resource-group>
      vmType: vmss # [OPTIONAL] vmss or standard. If not provided, it will default to standard
      useVMManagedIdentity: "false" # [OPTIONAL for Azure] if not provided, it will default to "false"
      userAssignedIdentityID: "" # [OPTIONAL for Azure] if provided, use this Virtual Machine's Managed Identity to access keyvault
      keyvaultSecretName: <keyvault-secret-name> # [OPTIONAL for Azure] if provided, will store the keyvault secret name in the pod annotation "secrets-store.csi.k8s.io/azure-secrets/<secret-name>=<keyvault-secret-name>"
      keyvaultSecretVersion: "" # [OPTIONAL for Azure] if provided, will store the keyvault secret version in the pod annotation "secrets-store.csi.k8s.io/azure-secrets/<secret-name>-ver=<keyvault-secret-version>"
      objects:  |
        array:
          - |
            objectName: <secret-name>
            objectType: secret
            objectVersion: "" # [OPTIONAL] object versions can be specified here, current version will be used if empty
          - |
            objectName: <cert-name>
            objectType: cert
            objectVersion: "" # [OPTIONAL] object versions can be specified here, current version will be used if empty
      tenantId: <tenant-id>
      subscriptionId: <subscription-id>
      resourceGroup: <resource-group>
      vmType: vmss # [OPTIONAL] vmss or standard. If not provided, it will default to standard

  ...
  ```

- CREATE: A new CRD

  - For a non-existing resource, will error if CRD already exists

    ```
    kubectl create -f <crd-manifest>.yaml
    ```

  - For both existing and non-existing, this will also update the resource

    ```
    kubectl apply -f <crd-manifest>.yaml
    ```

- DELETE: A CRD

  ```
  kubectl delete secretproviderclass/azure-secrets
  ```

- DESCRIBE: A CRD

  ```
  kubectl describe secretproviderclass/azure-secrets
  ```

  Example output:

  ```
  Name:         azure-secrets
  Namespace:    default
  Labels:       <none>
  Annotations:  <none>
  API Version:  secrets-store.csi.x-k8s.io/v1alpha1
  Kind:         SecretProviderClass
  Metadata:
    Creation Timestamp:  2020-10-14T18:50:00Z
    Generation:          1
    Resource Version:    123456
    Self Link:           /apis/secrets-store.csi.x-k8s.io/v1alpha1/namespaces/default/secretproviderclasses/azure-secrets
    UID:                 123456
  Spec:
    Objects:
      Array:
        Object Name:      <secret-name>
        Object Type:      secret
        Object Version:
        Object Name:      <cert-name>
        Object Type:      cert
        Object Version:
    Provider:            azure
    Parameters:
      Cloud Name:
      Keyvault Name:     <keyvault-name>
      Resource Group:    <resource-group>
      Subscription Id:   <subscription-id>
      Tenant Id:         <tenant-id>
      Use Pod Identity:  false
      Use VM Managed Identity:  false
      User Assigned Identity ID:
      VM Type:           vmss
  Events:                <none>
  ```

## Pods

- GET: All pods

  ```
  kubectl get pods
  ```

  Example output:

  ```
  NAME                                READY   STATUS    RESTARTS   AGE
  nginx-deployment-5f6f6d65c7-4j4q4   1/1     Running   0          3m
  nginx-deployment-5f6f6d65c7-5q2q2   1/1     Running   0          3m
  nginx-deployment-5f6f6d65c7-6q2q2   1/1     Running   0          3m
  ```

- EXEC: Run a command in a pod

  Only really works if the pod is _**not**_ built from a scratch image with no shell.

  In other words, you could basically _"ssh"_ into the pod.

  ```
  kubectl exec -it <pod-name> -- <command>
  ```

  Example output:

  ```
  root@nginx-deployment-5f6f6d65c7-4j4q4:/# ls
  bin   dev  home  lib64  mnt  proc  run   srv  tmp  var
  boot  etc  lib   media  opt  root  sbin  sys  usr
  ```
