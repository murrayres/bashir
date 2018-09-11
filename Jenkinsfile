node {
   stage "pull dockerfiles"
    git branch: 'master', credentialsId: '6bdce35d-763b-4a79-b668-b03d2e2054c8', url: 'git@github.com:octanner/bashir.git'
    registry_url    = "https://quay.octanner.io"
    docker_creds_id = "quay.octanner.io-developer"
    org_name        = "developer"

   stage "build image"
    docker.withRegistry("${registry_url}", "${docker_creds_id}") {
        build_tag = "1.0.${env.BUILD_NUMBER}"
        container_name = "bashir"
        container = docker.build("${org_name}/${container_name}:${build_tag}")
        container.push()
        container.push 'latest'

     } 
    stage 'Email Results'
         step([$class: 'Mailer', recipients: 'murray.resinski@octanner.com'])
}



