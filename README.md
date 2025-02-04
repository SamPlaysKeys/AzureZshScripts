# AZ CLI Automation Scripts for Entra, Intune, and Azure

Welcome to the **AZ CLI Automation Scripts** repository! This collection of Zsh scripts is designed to streamline processes related to Entra, Intune, and Azure. The scripts are intended to be run independently and have been tested on MacOS using the Zsh shell.

## Table of Contents

-  [Features](#features)
-  [Requirements](#requirements)
-  [Installation](#installation)
-  [Usage](#usage)
-  [Scripts Overview](#scripts-overview)
-  [Contributing](#contributing)
-  [License](#license)

## Features

-  Automate common tasks with Entra, Intune, and Azure.
-  Simple, independent scripts for quick execution.
-  Tested on MacOS with Zsh for compatibility.

## Requirements

Before running the scripts, ensure you have the following:

-  **Zsh**: Make sure you are using Zsh as your shell. You can check this by running:
  ```bash
  echo $SHELL
  ```
-  **AZ CLI**: The Azure CLI must be installed and authenticated. To install, follow the instructions on the [official Azure CLI documentation](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
-  **Dependencies**: Some scripts may require additional packages. These will be noted within the scripts themselves.

## Installation

1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/SamPlaysKeys/AzureZshScripts.git
   ```
2. Change to the script directory:
   ```bash
   cd AzureZshScripts
   ```

## Usage

Each script can be executed independently from the command line. To run a script, use the following command:
```bash
./script_name.sh
```

Make sure to replace `script_name.sh` with the actual name of the script you want to execute. You may need to give execute permissions to the script by running:
```bash
chmod +x script_name.sh
```

## Scripts Overview

Here's a brief overview of the scripts included in this repository:

### 1. `get_ca_policy_groups.sh`

-  **Description**: List groups and users assigned to a specific Conditional Access policy or all Conditional Access policies
-  **Usage**:
  ```bash
  ./get_ca_policy_groups.sh
  ```
  ```bash
  ./get_ca_policy_groups.sh -p [policy name]
  ```


## Contributing

Contributions are welcome! If you have suggestions for improvements or new features, please fork the repository and create a pull request. Ensure that your code adheres to the following guidelines:

-  Follow the existing code style.
-  Clearly document any new features or changes.
-  Test your scripts on MacOS with Zsh.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Feel free to reach out if you have any questions or need further assistance! Happy scripting!


