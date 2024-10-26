import os
import re
import subprocess

# Define target directory and output files
TARGET_DIR = "/root/nix-project"
DOT_FILE = "dependencies.dot"
OUTPUT_IMAGE = "dependencies.png"

# Initialize DOT file content
dot_content = ["digraph dependencies {"]

# Traverse the directory to find .nix files
for root, _, files in os.walk(TARGET_DIR):
    for file in files:
        if file.endswith(".nix"):
            nix_path = os.path.join(root, file)
            
            # Read the .nix file content
            with open(nix_path, 'r') as f:
                content = f.read()

                # Extract the "name" attribute
                name_match = re.search(r'name\s*=\s*"([^"]+)"', content)
                if name_match:
                    name = name_match.group(1)
                    
                    # Extract "buildInputs" dependencies
                    build_inputs_match = re.search(r'buildInputs\s*=\s*\[(.*?)\];', content, re.DOTALL)
                    if build_inputs_match:
                        dependencies = build_inputs_match.group(1)
                        # Add each dependency to the DOT file content
                        for dep in dependencies.split():
                            dep = dep.strip()
                            if dep:  # Check if dependency is not empty
                                dot_content.append(f'  "{name}" -> "{dep}";')

# Finalize DOT file content
dot_content.append("}")

# Write content to the .dot file
with open(DOT_FILE, 'w') as f:
    f.write("\n".join(dot_content))

# Use Graphviz to generate the dependency image
subprocess.run(["dot", "-Tpng", DOT_FILE, "-o", OUTPUT_IMAGE])

print(f"Dependency graph generated: {OUTPUT_IMAGE}")
