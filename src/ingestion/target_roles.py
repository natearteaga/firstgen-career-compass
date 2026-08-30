import csv
from pathlib import Path

# define the path to the target roles CSV file
# .parents[2] goes up two levels from the current file's directory to reach the project root
PROJECT_ROOT = Path(__file__).resolve().parents[2]
TARGET_ROLES_FILE = PROJECT_ROOT / "data" / "reference" / "target_roles.csv"

# function to read the target roles from the CSV file
def load_target_roles():
    with TARGET_ROLES_FILE.open(mode="r", newline="",encoding="utf-8") as file:
        reader = csv.DictReader(file)
        required_columns = {"project_role", "onet_occupation", "onet_code", "notes"}
        actual_columns = set(reader.fieldnames or [])
        missing_columns = required_columns - actual_columns

        if missing_columns:
            raise ValueError(f"Missing required columns: {missing_columns}")

        roles = list(reader)

        if not roles:
            raise ValueError("No target roles found in {TARGET_ROLES_FILE}")
        return roles

# main function to demonstrate reading the target roles
def main():
    roles = load_target_roles()
    print("Target Roles for FirstGen Career Compass:")
    for role in roles:
        print(f"- {role['project_role']} maps to O*NET {role['onet_code']} ({role['onet_occupation']})")

if __name__ == "__main__":
    main()
