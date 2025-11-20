## Current decisions and tradeoffs

### Terraform

- `docker_container` and `docker_network` resources use `${var.project_name}` prefix in their names to avoid possible duplications in the host system.
- Nginx and PHP containers share the docker network named "${var.project_name}-network". 
- Containers also share the docker volume named '${var.project_name}-www' where index.php is stored, so both nginx and php-fpm can serve it.
- Terraform passes APP_ENV env variable into PHP docker container so we can pass it into php script.

### Ansible

- Operates with nginx container only from the local environment.
- TCP FastCGI connection with PHP-FPM allows to avoid additional configuration of php-fpm container. But unix socket connection generally has a better performance, since it has less overhead.
- `terraform output` commands are used to retrieve the container names for use in the next tasks.
- To avoid privilege escalation on the host machine, all files (configs, index.php) are copied into the container using `docker cp` (community.docker.docker_container_copy_into`
