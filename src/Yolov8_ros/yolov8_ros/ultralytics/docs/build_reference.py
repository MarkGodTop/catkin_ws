# Ultralytics YOLO 🚀, AGPL-3.0 license
"""
Helper file to build Ultralytics Docs reference section. Recursively walks through ultralytics dir and builds an MkDocs
reference section of *.md files composed of classes and functions, and also creates a nav menu for use in mkdocs.yaml.

Note: Must be run from repository root directory. Do not run from docs directory.
"""

import os
import re
from collections import defaultdict
from pathlib import Path
from ultralytics.yolo.utils import ROOT

NEW_YAML_DIR = ROOT.parent
CODE_DIR = ROOT
REFERENCE_DIR = ROOT.parent / 'docs/reference'


def extract_classes_and_functions(filepath):
    with open(filepath, 'r') as file:
        content = file.read()

    class_pattern = r"(?:^|\n)class\s(\w+)(?:\(|:)"
    func_pattern = r"(?:^|\n)def\s(\w+)\("

    classes = re.findall(class_pattern, content)
    functions = re.findall(func_pattern, content)

    return classes, functions


def create_markdown(py_filepath, module_path, classes, functions):
    md_filepath = py_filepath.with_suffix('.md')

    md_content = [f"# {class_name}\n---\n:::{module_path}.{class_name}\n<br><br>\n" for class_name in classes]
    md_content.extend(f"# {func_name}\n---\n:::{module_path}.{func_name}\n<br><br>\n" for func_name in functions)
    md_content = "\n".join(md_content)

    os.makedirs(os.path.dirname(md_filepath), exist_ok=True)
    with open(md_filepath, 'w') as file:
        file.write(md_content)

    return md_filepath.relative_to(NEW_YAML_DIR)


def nested_dict():
    return defaultdict(nested_dict)


def sort_nested_dict(d):
    return {
        key: sort_nested_dict(value) if isinstance(value, dict) else value
        for key, value in sorted(d.items())
    }


def create_nav_menu_yaml(nav_items):
    nav_tree = nested_dict()

    for item_str in nav_items:
        item = Path(item_str)
        parts = item.parts
        current_level = nav_tree['reference']
        for part in parts[2:-1]:  # skip the first two parts (docs and reference) and the last part (filename)
            current_level = current_level[part]

        md_file_name = parts[-1].replace('.md', '')
        current_level[md_file_name] = item

    nav_tree_sorted = sort_nested_dict(nav_tree)

    def _dict_to_yaml(d, level=0):
        yaml_str = ""
        indent = "  " * level
        for k, v in d.items():
            if isinstance(v, dict):
                yaml_str += f"{indent}- {k}:\n{_dict_to_yaml(v, level + 1)}"
            else:
                yaml_str += f"{indent}- {k}: {str(v).replace('docs/', '')}\n"
        return yaml_str

    with open(NEW_YAML_DIR / 'nav_menu_updated.yml', 'w') as file:
        yaml_str = _dict_to_yaml(nav_tree_sorted)
        file.write(yaml_str)


def main():
    nav_items = []
    for root, _, files in os.walk(CODE_DIR):
        for file in files:
            if file.endswith(".py") and file != "__init__.py":
                py_filepath = Path(root) / file
                classes, functions = extract_classes_and_functions(py_filepath)

                if classes or functions:
                    py_filepath_rel = py_filepath.relative_to(CODE_DIR)
                    md_filepath = REFERENCE_DIR / py_filepath_rel
                    module_path = f"ultralytics.{py_filepath_rel.with_suffix('').as_posix().replace('/', '.')}"
                    md_rel_filepath = create_markdown(md_filepath, module_path, classes, functions)
                    nav_items.append(str(md_rel_filepath))

    create_nav_menu_yaml(nav_items)


if __name__ == "__main__":
    main()
