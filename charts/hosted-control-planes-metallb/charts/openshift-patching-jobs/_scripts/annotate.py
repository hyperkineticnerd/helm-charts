#!/usr/bin/python

import os
import ose_utils

NAMESPACE_NAME = os.getenv("NAMESPACE") or ose_utils.logging.error_and_exit(
    "env is missing expected value: NAMESPACE", 2
)
RESOURCE_NAME = os.getenv("RESOURCE") or ose_utils.logging.error_and_exit(
    "env is missing expected value: RESOURCE", 2
)
ANNOTATION_KEY = os.getenv("ANNOTATION_KEY") or ose_utils.logging.error_and_exit(
    "env is missing expected value: ANNOTATION_KEY", 2
)
ANNOTATION_VALUE = os.getenv("ANNOTATION_VALUE") or ose_utils.logging.error_and_exit(
    "env is missing expected value: ANNOTATION_VALUE", 2
)

print()
print("********************************************************************")
print("* START Annotator")
print(f"*\t- NAMESPACE_NAME: {NAMESPACE_NAME}")
print(f"*\t- OBJECT_NAME: {RESOURCE_NAME}")
print(f"*\t- ANNOTATION_KEY: {ANNOTATION_KEY}")
print(f"*\t- ANNOTATION_VALUE: {ANNOTATION_VALUE}")
print("********************************************************************")

patch_object = ose_utils.resources.wait(RESOURCE_NAME)
print(f"resource = {patch_object.model.metadata.name}")

old_annotations = ose_utils.annotations.get(patch_object)
print(f"old annotations = {old_annotations}")

add_annotation = ose_utils.annotations.patch(patch_object, ANNOTATION_KEY, ANNOTATION_VALUE)
print(f"result = {add_annotation}")

new_annotations = ose_utils.annotations.get(patch_object)
print(f"new annotations = {new_annotations}")

check = ose_utils.annotations.verify(patch_object, ANNOTATION_KEY, ANNOTATION_VALUE)
if not check:
    ose_utils.logging.error_and_exit(
        f"ERROR: Resource ({RESOURCE_NAME}) annotation ({ANNOTATION_KEY}) mismatched value. This really shouldn't happen."
    )
