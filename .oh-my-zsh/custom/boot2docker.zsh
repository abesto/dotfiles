export_boot2docker() {
    export DOCKER_HOST=$(boot2docker ip 2>/dev/null)
}

start_boot2docker() {
    boot2docker ip 2>/dev/null >/dev/null || boot2docker up
    export_boot2docker
}

export_boot2docker
