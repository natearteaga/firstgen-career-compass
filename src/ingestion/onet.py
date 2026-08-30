import csv
from pathlib import Path

from target_roles import load_target_roles


PROJECT_ROOT = Path(__file__).resolve().parents[2]
RAW_ONET_DIR = PROJECT_ROOT / "data" / "raw" / "onet"
PROCESSED_DIR = PROJECT_ROOT / "data" / "processed"

ONET_CODE_COLUMN = "O*NET-SOC Code"

RAW_TO_PROCESSED_FILES = {
    "occupation_data.csv": "onet_role_occupation_data.csv",
    "essential_skills.csv": "onet_role_skills.csv",
    "knowledge.csv": "onet_role_knowledge.csv",
    "task_statements.csv": "onet_role_tasks.csv",
    "software_skills.csv": "onet_role_software_skills.csv",
}


def get_target_codes():
    roles = load_target_roles()
    return {role["onet_code"] for role in roles}


def read_csv_rows(file_path):
    if not file_path.exists():
        raise FileNotFoundError(f"Missing raw O*NET file: {file_path}")

    with file_path.open(mode="r", newline="", encoding="utf-8-sig") as file:
        reader = csv.DictReader(file)

        if ONET_CODE_COLUMN not in (reader.fieldnames or []):
            raise ValueError(f"{file_path.name} is missing required column: {ONET_CODE_COLUMN}")

        return list(reader), reader.fieldnames


def write_csv_rows(file_path, rows, fieldnames):
    if not rows:
        raise ValueError(f"No rows available to write for {file_path.name}")

    PROCESSED_DIR.mkdir(parents=True, exist_ok=True)

    with file_path.open(mode="w", newline="", encoding="utf-8") as file:
        writer = csv.DictWriter(file, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def filter_rows_for_target_roles(rows, target_codes):
    return [row for row in rows if row[ONET_CODE_COLUMN] in target_codes]


def validate_target_coverage(rows, target_codes, dataset_name):
    found_codes = {row[ONET_CODE_COLUMN] for row in rows}
    missing_codes = target_codes - found_codes

    if missing_codes:
        raise ValueError(f"{dataset_name} is missing target codes: {sorted(missing_codes)}")


def process_onet_file(raw_file_name, processed_file_name, target_codes):
    raw_file_path = RAW_ONET_DIR / raw_file_name
    processed_file_path = PROCESSED_DIR / processed_file_name

    rows, fieldnames = read_csv_rows(raw_file_path)
    filtered_rows = filter_rows_for_target_roles(rows, target_codes)

    if not filtered_rows:
        raise ValueError(f"No target-role rows found in {raw_file_name}")

    validate_target_coverage(filtered_rows, target_codes, raw_file_name)
    write_csv_rows(processed_file_path, filtered_rows, fieldnames)

    return len(filtered_rows), processed_file_path


def main():
    target_codes = get_target_codes()

    print("Filtering O*NET data for target roles:")
    for raw_file_name, processed_file_name in RAW_TO_PROCESSED_FILES.items():
        row_count, processed_file_path = process_onet_file(
            raw_file_name,
            processed_file_name,
            target_codes,
        )
        print(f"- {raw_file_name}: wrote {row_count} rows to {processed_file_path}")


if __name__ == "__main__":
    main()
