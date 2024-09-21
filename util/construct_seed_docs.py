# Write a python script that will read the csv files in a directory and constrict a yaml list of there columns

import os
import csv
import yaml

def read_csv_columns(directory):
    column_data = {}

    for filename in os.listdir(directory):
        if filename.endswith(".csv"):
            filepath = os.path.join(directory, filename)
            with open(filepath, "r") as csvfile:
                reader = csv.reader(csvfile)
                headers = next(reader, None)
                if headers:
                    column_data[filename] = headers

    return column_data

def construct_yaml_list(column_data):
    yaml_data = []
    for filename, columns in column_data.items():
        seed_name = filename.replace(".csv", "")
        column_data = []
        for column in columns:
            column_data.append({"name": column.lower().strip(), "description": ""})

        yaml_data.append({"name": seed_name, "description": "", "columns": column_data})

    return yaml_data

def main():
    directory = input("Enter the directory in the seeds folder containing seed files: ")

    base_dir = os.getcwd()
    directory = os.path.join(base_dir, "seeds", directory)

    print(directory)

    if not os.path.isdir(directory):
        print("Invalid directory path.")
        return

    column_data = read_csv_columns(directory)
    yaml_list = construct_yaml_list(column_data)

    sorted_yaml_list = sorted(yaml_list, key=lambda k: k["name"])

    output_file = "seed_columns.yaml"
    with open(output_file, "w") as yamlfile:
        yaml.dump(sorted_yaml_list, yamlfile, default_flow_style=False, sort_keys=False)

    print(
        f"A schema file compatible list of seed columns has been written to {output_file}"
    )

if __name__ == "__main__":
    main()