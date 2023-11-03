## Project Structure
```
|-- accounts/
| |-- 000000000000/
| |-- 1111111111/
|-- modules/
| |-- groups
| |-- roles
```
- `accounts/`: Contains account-specific Terraform configurations.
- `modules/`: Contains reusable Terraform modules for common AWS resource patterns.


## Getting Started

```bash
cd accounts/< account ID >/

terraform init

terraform apply
```