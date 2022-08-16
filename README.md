# dtml-simple-gitops

Made to make updating a single variable in a YAML file easy.  

## Usage:  

```yaml
jobs:
  Push-to-gitops-repo:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout GitOps Repo
        uses: actions/checkout@v3
        with:
          repository: # path to your gitops repo 
          ref: # branch 
          path: # directory to clone to. usually "gitops" 
          ssh-key: # SSH-KEY 
      - name: dtml-simple-gitops
        uses: datamole-ai/simple-gitops@python
        with:
          key: # key to look for 
          value: # new value. not mandatory. github.sha by default
          valuesFile: # path to values file in gitops repo
          commitMessage: # not mandatory. copies commit msg by default


```  