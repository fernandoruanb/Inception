
<p align="center">
  <img src="https://www.rocketseat.com.br/blog/_next/image?url=https%3A%2F%2Fstorage.googleapis.com%2Fstar-lab%2Fblog%2FOGs%2Fdocker.png&w=1200&q=75" alt="Inception cover" width="100%">
</p>

<h1 align="center">
  <a href="https://github.com/fernandoruanb/inception">
    <img src="https://github.com/ayogun/42-project-badges/raw/main/badges/inceptione.png" alt="Inception badge" width="200">
  </a>
  <br>
  Inception
  <br>
</h1>

<h4 align="center">
  A Docker-based infrastructure project focused on containerization, service orchestration, persistence, secrets management, and the deployment of a small multi-service web architecture.
</h4>

<p align="center">
  <img src="https://img.shields.io/badge/Final%20Score-100%2F125-00C853?style=for-the-badge" alt="Final Score 100/125">
  <img src="https://img.shields.io/badge/Technology-Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Technology Docker">
  <img src="https://img.shields.io/badge/Orchestration-Docker%20Compose-blueviolet?style=for-the-badge" alt="Docker Compose">
  <img src="https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge" alt="Status Completed">
</p>

<p align="center">
  <a href="#about-the-project">About</a> •
  <a href="#from-servers-to-vms-to-containers">From Servers to VMs to Containers</a> •
  <a href="#why-containerization-matters">Why Containerization Matters</a> •
  <a href="#project-scope">Project Scope</a> •
  <a href="#folder-structure">Folder Structure</a> •
  <a href="#architecture-and-services">Architecture and Services</a> •
  <a href="#docker-compose-and-orchestration">Docker Compose and Orchestration</a> •
  <a href="#persistence-and-volumes">Persistence and Volumes</a> •
  <a href="#secrets-and-configuration">Secrets and Configuration</a> •
  <a href="#folder-design-and-practical-organization">Folder Design and Practical Organization</a> •
  <a href="#what-this-project-teaches">What This Project Teaches</a> •
  <a href="#team">Team</a>
</p>

---

## About the Project

<html>
<p align="center">
  <img src="./assets/inception_architecture.png" alt="Inception architecture" width="100%">
</p>
<p align="center">
  <sub>Illustrative Docker-based architecture used in the project</sub>
</p>
</html>

**Inception** is an introduction to **Docker** and to the idea of building infrastructure through **containers** instead of relying only on traditional system installation.

The project teaches how to assemble a small web architecture using isolated services that communicate with each other in a controlled way.

More than just running Docker commands, the real purpose of the project is to understand:

- what containers are
- why they became so important
- how service isolation works
- how orchestration connects multiple services
- how persistence must be preserved outside the container
- how configuration and secrets should be handled
- how a multi-service environment can be started, stopped, rebuilt, and maintained cleanly

This makes **Inception** a major conceptual step.

It is the moment where infrastructure starts to become something modular, reproducible, and much closer to the kinds of architectures later used in real teams and production-oriented projects.

---

## From Servers to VMs to Containers

To understand **Inception**, it helps to compare it with the logic introduced earlier in projects related to Linux and virtualization.

At first, before virtualization and containerization became common, companies often needed one or more physical servers for each service or operating system they wanted to maintain.

That led to many problems:

- high hardware cost
- wasted physical space
- idle computational power
- high energy consumption
- expensive maintenance
- duplicated effort in updates and management

Then came **virtual machines**.

Instead of needing multiple physical servers, it became possible to run multiple isolated systems on the same host machine through a hypervisor.

This was a huge improvement because it reduced cost and gave teams a safe way to test different systems and environments in isolation.

But virtual machines still have a cost.

Each VM includes an entire operating system, consumes more storage and memory, and often keeps many resources allocated even when the workload is relatively small.

That is where **containers** become especially powerful.

---

## Why Containerization Matters

Containerization proposes a lighter model.

Instead of creating a full independent operating system every time, containers share the **host kernel** while keeping applications and their dependencies isolated from each other.

This opens many advantages:

- lighter environments
- faster startup
- easier replication
- cleaner service isolation
- lower overhead than full virtual machines
- better resource usage for many web and service-oriented workloads

In practice, that means a service can run with only what it actually needs.

A container does not need an entire operating system installation to exist in the same way a VM does.

That reduction in overhead is one of the reasons Docker became so influential.

It changed the way teams think about infrastructure.

Instead of imagining one giant machine doing everything, we start to imagine **many isolated services**, each responsible for one part of the system.

That mindset becomes even more important later in bigger projects involving **microservices**, such as systems with authentication, chat, API gateways, databases, user management, and other independent modules communicating through APIs.

In that sense, **Inception** becomes an early bridge between basic infrastructure and the broader modern service-based mentality.

---

## Project Scope

In **Inception**, the goal is to build a small web infrastructure using **Docker** and **Docker Compose**, respecting strict project rules.

The focus is not merely to “make something run,” but to do it with the expected architecture and with a correct separation of concerns.

The project explores:

- service isolation
- container lifecycle
- networking between services
- reverse proxy logic
- database separation
- persistence through volumes
- secure configuration handling
- project reproducibility
- startup automation through scripts and configuration files

A very important point is that the infrastructure must be intentionally assembled.

This is not a project about clicking buttons or relying on magic defaults.

It is about understanding how each service is created, configured, connected, and persisted.

---

## Folder Structure

A clear folder design was essential in this project, because each service needed its own build logic, configuration files, and startup scripts.

```bash
tree
.
├── Makefile
├── README.md
└── srcs
    ├── docker-compose.yml
    └── requirements
        ├── mariadb
        │   ├── conf
        │   │   └── 50-server.cnf
        │   ├── Dockerfile
        │   └── tools
        │       └── start.sh
        ├── nginx
        │   ├── conf
        │   │   └── nginx.conf
        │   └── Dockerfile
        └── wordpress
            ├── conf
            │   └── www.conf
            ├── Dockerfile
            └── tools
                └── wp-install.sh
````

### Structure Overview

* **Makefile**
  Centralizes the main project commands, making the infrastructure easier to build, start, stop, and manage.

* **README.md**
  Project documentation and architectural explanation.

* **srcs/docker-compose.yml**
  The orchestration file that connects all services, networks, volumes, and startup rules.

* **srcs/requirements/**
  Contains the isolated service definitions required by the project.

#### MariaDB

* **Dockerfile**
  Builds the database container.
* **conf/50-server.cnf**
  Database configuration file.
* **tools/start.sh**
  Startup script used to initialize and prepare the service.

#### NGINX

* **Dockerfile**
  Builds the reverse proxy container.
* **conf/nginx.conf**
  Main NGINX configuration file.

#### WordPress

* **Dockerfile**
  Builds the WordPress container.
* **conf/[www.conf](http://www.conf)**
  PHP-FPM pool configuration used by WordPress.
* **tools/wp-install.sh**
  Startup and installation script for WordPress.

This structure helped keep the project readable and maintainable, especially because each service had its own isolated responsibility inside the infrastructure.

---

## Architecture and Services

The architecture I built was centered around a small but meaningful service stack.

It included:

- **NGINX**
- **WordPress**
- **MariaDB**

Each service had its own role.

### NGINX

**NGINX** acts as the visible entry point of the application.

It is the service exposed to the client and works as the front-facing reverse proxy of the system.

The client only sees NGINX.

Internally, the host machine and the Docker network handle the rest of the communication between services.

### WordPress

**WordPress** is the application layer.

It provides the web content and interacts with the database as part of the service architecture.

### MariaDB

**MariaDB** is isolated as its own database service.

This separation is important because it reflects a core infrastructure principle:

> the application and the database should not be fused into one uncontrolled block.

By isolating the database, the architecture becomes cleaner, easier to reason about, and more aligned with real deployment logic.

---

## Docker Compose and Orchestration

One of the most important parts of the project is **Docker Compose**.

Compose allows the whole environment to be described as a coordinated system rather than as isolated manual commands.

This means we can define:

- which services exist
- how they are built
- how they connect
- which ports are exposed
- which volumes are mounted
- which secrets or configuration files are used
- which internal network is shared between them

This orchestration is what transforms separate containers into a real infrastructure.

Instead of launching pieces randomly, the project becomes a structured environment where services know how to relate to one another.

That is one of the biggest conceptual gains of **Inception**:
we stop thinking only in terms of programs and start thinking in terms of **service architecture**.

---

## Persistence and Volumes

A container is not meant to be treated like permanent storage by itself.

If a container dies and there is no external persistence configured, the data inside it may be lost.

That is especially dangerous in a web application.

A database or application state cannot depend entirely on the internal life of a disposable container.

That is why volumes are essential.

In my project, I configured persistent storage so the infrastructure could preserve important data even when containers were rebuilt or restarted.

This is one of the most practical lessons of the project:

> containers are ephemeral by nature, but data must survive beyond them.

That distinction is fundamental in real infrastructure work.

With proper volume configuration, the system can be brought up again while keeping application and database data intact.

---

## Secrets and Configuration

Another very important point in the project is configuration handling.

In real environments, sensitive information such as credentials, passwords, and internal configuration values should not be exposed carelessly.

That is why I did not rely on simply pushing `.env` files into a public repository.

Instead, in my case, I used **Docker Secrets** to protect sensitive data and configure each service more appropriately.

This was an important practical lesson because it reinforces a real-world principle:

> configuration is necessary, but secrets must be treated carefully.

During evaluation, this configuration can be created manually, typed during the defense, generated on demand, or provided in a controlled way depending on the chosen workflow.

The important part is understanding that infrastructure is not only about making services communicate.

It is also about making them communicate **safely**.

---

## Folder Design and Practical Organization

To make the project more maintainable, the whole structure was organized through a clear folder design.

That matters a lot in **Inception**, because once multiple services, scripts, Dockerfiles, configuration files, volumes, and setup steps start to coexist, a bad structure quickly becomes confusing.

A clean organization helps identify:

- what belongs to each service
- what is build logic
- what is configuration
- what is startup scripting
- what is persistent data
- what is orchestration-level definition

This also makes the project easier to defend during evaluation, because the architecture becomes readable.

Another important constraint of the project is that shortcuts such as leaving containers artificially alive through improper infinite placeholder commands are not the intended solution.

The infrastructure should remain alive because the services themselves are running correctly, not because the project is being held together by an artificial blocking trick.

---

## What This Project Teaches

For me, **Inception** is much more than a Docker introduction.

It is a project about changing the way we think about infrastructure.

It teaches that:

- services should be isolated
- applications should be decomposed into meaningful parts
- databases should be separated
- persistence must be planned
- configuration must be handled responsibly
- orchestration is what turns isolated containers into a real system

It also creates a strong conceptual bridge to larger architectures.

Later, in bigger team projects, this mentality becomes very powerful.

When we begin to work with things like authentication services, API gateways, chat modules, user services, and other independent pieces, the logic introduced in **Inception** becomes even more valuable.

Each service starts to look like a puzzle piece:
independent, replaceable, and easier to debug without collapsing the entire application.

That is one of the greatest lessons containerization brings.

---

## Team

**Inception** is a project developed at **École 42** as part of the Common Core journey.

This version was developed as part of my study of Docker, orchestration, persistence, and service-based infrastructure design.

---

## Final Note

For me, **Inception** was much more than a Docker project.

It was a project about:

- understanding why containerization became so important
- comparing containers with older infrastructure models
- learning how isolated services can form a complete system
- orchestrating communication through Docker Compose
- protecting sensitive configuration with Docker Secrets
- preserving data correctly through volumes
- organizing infrastructure in a clear and maintainable way
- taking a first real step toward modern service-oriented architecture

What makes **Inception** special is that it changes the student's vision of deployment.

You stop thinking only about “running a program.”

You begin to think in terms of **services, communication, persistence, isolation, and infrastructure design**.

**Final result:** `Inception` — **100/125**  
**Status:** Completed

