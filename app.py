from pathlib import Path

import pandas as pd
import streamlit as st


PROJECT_ROOT = Path(__file__).resolve().parent
EXPORTS_DIR = PROJECT_ROOT / "dashboard" / "exports"


@st.cache_data
def load_export(file_name):
    file_path = EXPORTS_DIR / file_name

    if not file_path.exists():
        st.error(f"Missing dashboard export: {file_path}")
        st.stop()

    return pd.read_csv(file_path)


def format_role_label(role_name):
    role_labels = {
        "Business Intelligence Analysts": "BI Analyst",
        "Data Scientists": "Data Analyst",
        "Software Developers": "Software Developer",
    }
    return role_labels.get(role_name, role_name)


def main():
    st.set_page_config(
        page_title="FirstGen Career Compass",
        page_icon="FG",
        layout="wide",
    )

    top_skills = load_export("top_skills_by_role.csv")
    shared_skills = load_export("shared_skills_across_roles.csv")
    role_comparison = load_export("role_skill_comparison.csv")
    software_summary = load_export("software_tool_summary.csv")
    software_categories = load_export("software_categories_by_role.csv")

    role_options = top_skills["role_name"].drop_duplicates().tolist()
    role_labels = {format_role_label(role): role for role in role_options}

    st.title("FirstGen Career Compass")
    st.caption("O*NET-based career-readiness analytics for first-generation students exploring technical career paths.")

    selected_label = st.sidebar.selectbox(
        "Target role",
        options=list(role_labels.keys()),
    )
    selected_role = role_labels[selected_label]

    role_skills = top_skills[top_skills["role_name"] == selected_role].copy()
    role_skills = role_skills.sort_values("importance_score", ascending=False)

    tab_role, tab_shared, tab_compare, tab_software = st.tabs(
        [
            "Role Skills",
            "Shared Skills",
            "Role Comparison",
            "Software Tools",
        ]
    )

    with tab_role:
        st.subheader(f"Top Essential Skills: {selected_label}")
        st.bar_chart(
            role_skills.set_index("skill_name")["importance_score"],
            horizontal=True,
        )
        st.dataframe(
            role_skills[
                [
                    "skill_name",
                    "importance_score",
                    "level_score",
                    "evidence_label",
                ]
            ],
            use_container_width=True,
            hide_index=True,
        )

    with tab_shared:
        st.subheader("Shared Essential Skills Across All Roles")
        st.bar_chart(
            shared_skills.set_index("skill_name")["avg_importance_score"],
            horizontal=True,
        )
        st.dataframe(shared_skills, use_container_width=True, hide_index=True)

    with tab_compare:
        st.subheader("Skill Importance Comparison")
        comparison_chart = role_comparison.set_index("skill_name")
        st.bar_chart(comparison_chart)
        st.dataframe(role_comparison, use_container_width=True, hide_index=True)

    with tab_software:
        st.subheader("Software Tool Summary")
        st.dataframe(software_summary, use_container_width=True, hide_index=True)

        selected_categories = software_categories[
            software_categories["role_name"] == selected_role
        ].copy()
        selected_categories = selected_categories.sort_values("tool_count", ascending=False)

        st.subheader(f"Major Software Categories: {selected_label}")
        st.bar_chart(
            selected_categories.set_index("software_category")["tool_count"],
            horizontal=True,
        )
        st.dataframe(
            selected_categories,
            use_container_width=True,
            hide_index=True,
        )


if __name__ == "__main__":
    main()
