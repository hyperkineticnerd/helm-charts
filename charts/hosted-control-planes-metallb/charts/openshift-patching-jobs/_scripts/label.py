#!/usr/bin/python

import os
import ose_utils

NAMESPACE_NAME = os.getenv("NAMESPACE") or ose_utils.logging.error_and_exit(
    "env is missing expected value: NAMESPACE", 2
)
RESOURCE_NAME = os.getenv("RESOURCE") or ose_utils.logging.error_and_exit(
    "env is missing expected value: RESOURCE", 2
)
LABEL_KEY = os.getenv("LABEL_KEY") or ose_utils.logging.error_and_exit(
    "env is missing expected value: LABEL_KEY", 2
)
LABEL_VALUE = os.getenv("LABEL_VALUE") or ose_utils.logging.error_and_exit(
    "env is missing expected value: LABEL_VALUE", 2
)

print()
print("********************************************************************")
print("* START Annotator")
print(f"*\t- NAMESPACE_NAME: {NAMESPACE_NAME}")
print(f"*\t- OBJECT_NAME: {RESOURCE_NAME}")
print(f"*\t- LABEL_KEY: {LABEL_KEY}")
print(f"*\t- LABEL_VALUE: {LABEL_VALUE}")
print("********************************************************************")

patch_object = ose_utils.resources.wait(RESOURCE_NAME)
print(f"resource = {patch_object.model.metadata.name}")

old_annotations = ose_utils.annotations.get(patch_object)
print(f"old annotations = {old_annotations}")

add_annotation = ose_utils.annotations.patch(patch_object, LABEL_KEY, LABEL_VALUE)
print(f"result = {add_annotation}")

new_annotations = ose_utils.annotations.get(patch_object)
print(f"new annotations = {new_annotations}")

check = ose_utils.annotations.verify(patch_object, LABEL_KEY, LABEL_VALUE)
if not check:
    ose_utils.logging.error_and_exit(
        f"ERROR: Resource ({RESOURCE_NAME}) annotation ({LABEL_KEY}) mismatched value. This really shouldn't happen."
    )
