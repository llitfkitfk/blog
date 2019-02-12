workflow "Deploy workflow" {
  on = "push"
  resolves = ["push blog image to docker hub"]
}

action "build blog image" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  runs = "docker build -t llitfkitfk/blog ."
}

action "login my docker hub" {
  uses = "actions/docker/login@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  secrets = ["GITHUB_TOKEN", "DOCKER_USERNAME", "DOCKER_PASSWORD"]
  needs = ["build blog image"]
}

action "push blog image to docker hub" {
  uses = "actions/docker/login@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  runs = "docker push llitfkitfk/blog"
  needs = ["login my docker hub"]
}
