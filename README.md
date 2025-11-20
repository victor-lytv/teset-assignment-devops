# Test: Nginx + PHP-FPM, Terraform, Ansible

## Local Run (to be filled after completion)
```bash
# example
cd terraform
terraform init
terraform apply -auto-approve

cd ../ansible
ansible-playbook -i inventory/containers.ini playbooks/site.yml
```

### Testing
```bash
curl http://localhost:8080/healthz
# expected JSON:
# {"status":"ok","service":"nginx","env":"dev"}
```

## Useful Links
- Full task description: [INSTRUCTIONS.md](./INSTRUCTIONS.md)
- Solution rationale: `Decisions.md`

## CI/CD results
- Terraform: https://github.com/victor-lytv/teset-assignment-devops/actions/runs/19529337893
- Ansible: https://github.com/victor-lytv/teset-assignment-devops/actions/runs/19529337893

