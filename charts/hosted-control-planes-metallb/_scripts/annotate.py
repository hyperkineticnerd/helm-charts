#!/usr/bin/python

import os
import ose_utils

NAMESPACE_NAME = os.getenv("NAMESPACE") or ose_utils.error_and_exit(
    "env is missing expected value: NAMESPACE", 2
)
OBJECT_NAME = os.getenv("OBJECT") or ose_utils.error_and_exit(
    "env is missing expected value: OBJECT", 2
)
ANNOTATION_KEY = os.getenv("ANNOTATION_KEY") or ose_utils.error_and_exit(
    "env is missing expected value: ANNOTATION_KEY", 2
)
ANNOTATION_VALUE = os.getenv("ANNOTATION_VALUE") or ose_utils.error_and_exit(
    "env is missing expected value: ANNOTATION_VALUE", 2
)

print()
print("********************************************************************")
print("* START Annotator")
print(f"*\t- NAMESPACE_NAME: {NAMESPACE_NAME}")
print(f"*\t- OBJECT_NAME: {OBJECT_NAME}")
print(f"*\t- ANNOTATION_KEY: {ANNOTATION_KEY}")
print(f"*\t- ANNOTATION_VALUE: {ANNOTATION_VALUE}")
print("********************************************************************")

patch_object = ose_utils.wait_object(OBJECT_NAME)
print(f"object = {patch_object.model.metadata.name}")

old_annotations = ose_utils.get_annotations(patch_object)
print(f"old annotations = {old_annotations}")

add_annotation = ose_utils.patch_annotations(patch_object, ANNOTATION_KEY, ANNOTATION_VALUE)
print(f"result = {add_annotation}")

new_annotations = ose_utils.get_annotations(patch_object)
print(f"new annotations = {new_annotations}")

check = ose_utils.verify_annotation(patch_object, ANNOTATION_KEY, ANNOTATION_VALUE)
if not check:
    ose_utils.error_and_exit(
        f"ERROR: Failed to get Subscription ({OBJECT_NAME}) UID. This really shouldn't happen."
    )
