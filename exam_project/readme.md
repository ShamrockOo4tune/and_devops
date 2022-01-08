# and_exam
Andersen DevOps courses exam project
This project is a result of 2 month study at DevOps courses provided by Andersen in the end of 2021

The project is to setup and automate application CI/CD using docker containers
Application: 2 webapp on two different languages.
I have selected Python - Flask and Golang - Gin. The apps files are staged in separate folders: py_program_1 and go_program_2 

The structure of the project repo:
.
├── .github/workflows
│   └── docker-image.yml ## file name doesnt reflect actual intentions
├── dockerfiles
│   ├── GoDockerfile
│   └── PyDockerfile
├── go_program_2
│   ├── go.mod
│   ├── go.sum
│   └── main.go
├── py_program_1
│   ├── app.py
│   └── requirements.txt
└── README.md

The CI/CD tool used is GitHub actions. Github actions are initiated by the 
.yml file in the .github/workflows directory. It is set to run the workflow on push to master branch of the repo.

Once the workflow triggered
