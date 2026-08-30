import csv
from collections import defaultdict
from pathlib import Path


PROJECT_ROOT = Path(__file__).resolve().parents[2]
PROCESSED_DIR = PROJECT_ROOT / "data" / "processed"
DASHBOARD_EXPORTS_DIR = PROJECT_ROOT / "dashboard" / "exports"


def read_csv_rows(file_path):
    if not file_path.exists():
        raise FileNotFoundError(f"Missing processed file: {file_path}")

    with file_path.open(mode="r", newline="", encoding="utf-8") as file:
        reader = csv.DictReader(file)
        return list(reader)


def write_csv_rows(file_path, rows, fieldnames):
    if not rows:
        raise ValueError(f"No rows available to write for {file_path.name}")

    DASHBOARD_EXPORTS_DIR.mkdir(parents=True, exist_ok=True)

    with file_path.open(mode="w", newline="", encoding="utf-8") as file:
        writer = csv.DictWriter(file, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def create_top_skills_export():
    rows = read_csv_rows(PROCESSED_DIR / "onet_role_skills.csv")
    importance_rows = [row for row in rows if row["Scale Name"] == "Importance"]
    importance_rows.sort(
        key=lambda row: (row["Title"], -float(row["Data Value"]), row["Element Name"])
    )

    export_rows = [
        {
            "role_title": row["Title"],
            "skill_name": row["Element Name"],
            "importance_score": row["Data Value"],
        }
        for row in importance_rows
    ]

    write_csv_rows(
        DASHBOARD_EXPORTS_DIR / "top_skills_by_role.csv",
        export_rows,
        ["role_title", "skill_name", "importance_score"],
    )


def create_shared_skills_export():
    rows = read_csv_rows(PROCESSED_DIR / "onet_role_skills.csv")
    importance_rows = [row for row in rows if row["Scale Name"] == "Importance"]

    skill_scores = defaultdict(list)
    for row in importance_rows:
        skill_scores[row["Element Name"]].append(float(row["Data Value"]))

    export_rows = []
    for skill_name, scores in skill_scores.items():
        if len(scores) == 3:
            export_rows.append(
                {
                    "skill_name": skill_name,
                    "role_count": len(scores),
                    "avg_importance_score": round(sum(scores) / len(scores), 2),
                }
            )

    export_rows.sort(key=lambda row: (-row["avg_importance_score"], row["skill_name"]))

    write_csv_rows(
        DASHBOARD_EXPORTS_DIR / "shared_skills_across_roles.csv",
        export_rows,
        ["skill_name", "role_count", "avg_importance_score"],
    )


def create_software_tools_export():
    rows = read_csv_rows(PROCESSED_DIR / "onet_role_software_skills.csv")
    rows.sort(
        key=lambda row: (
            row["Title"],
            row["In Demand"] != "Y",
            row["Hot Technology"] != "Y",
            row["Workplace Example"],
        )
    )

    export_rows = [
        {
            "role_title": row["Title"],
            "software_or_tool": row["Workplace Example"],
            "software_category": row["Element Name"],
            "hot_technology": row["Hot Technology"],
            "in_demand": row["In Demand"],
        }
        for row in rows
    ]

    write_csv_rows(
        DASHBOARD_EXPORTS_DIR / "software_tools_by_role.csv",
        export_rows,
        [
            "role_title",
            "software_or_tool",
            "software_category",
            "hot_technology",
            "in_demand",
        ],
    )


def main():
    create_top_skills_export()
    create_shared_skills_export()
    create_software_tools_export()

    print("Dashboard exports created:")
    for file_path in sorted(DASHBOARD_EXPORTS_DIR.glob("*.csv")):
        print(f"- {file_path}")


if __name__ == "__main__":
    main()
