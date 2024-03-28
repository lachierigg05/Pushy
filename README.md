# Pushy: A POSIX-Compliant Shell-Based Version Control System

Pushy is a unique and experimental project that demonstrates the power and flexibility of shell scripting. It provides the core concepts of version control (adding, committing, tracking changes, etc.) entirely within a POSIX-compliant shell environment.

## Key Features

* **Local File Tracking:** Manage versions of your files directly on your local system.
* **Commit History:**  Create snapshots of your project at different points in time.
* **Change Management:** Track modifications, deletions, and additions to your files.
* **POSIX Focus:** Emphasizes portability and compatibility across different Unix-like systems.

## Getting Started

1. **Clone the repository:** `git clone https://github.com/your_username/pushy`

2. **Familiarize yourself with the scripts:**
    * `pushy-add`
    * `pushy-commit`
    * `pushy-rm`
    * `pushy-status`
    * `pushy-init`
    * `pushy-log`

3. **Experiment!** Use Pushy commands to manage a test project and see how it tracks changes.

## Technical Notes

* **Shell Implementation:**  Pushy is built using Dash (a POSIX-compliant shell) and primarily leverages standard shell commands and techniques.
* **File Storage:** Hidden directories (e.g., `.pushy`) are used to store versioning information.

## Project Status

Pushy is an ongoing learning project and might not be suitable for production environments. Feel free to explore, experiment, and contribute!

## Disclaimer

Pushy is not intended as a replacement for robust version control systems like Git. It serves as a learning tool and exploration of shell scripting capabilities. 

## Feedback Welcome

If you have questions, suggestions, or find interesting use cases for Pushy, please open an issue or discussion on the repository. 
