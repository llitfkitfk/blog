workflow "Deploy workflow" {
  on = "push"
  resolves = ["Docker Registry"]
}

action "GitHub Action for Docker" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  runs = "docker build -t llitfkitfk/blog ."
}

action "Docker Registry" {
  uses = "actions/docker/login@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["GitHub Action for Docker"]
  secrets = ["GITHUB_TOKEN", "DOCKER_USERNAME", "DOCKER_PASSWORD"]
}
