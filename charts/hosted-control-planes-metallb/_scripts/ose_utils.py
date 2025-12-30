#!/usr/bin/python

import openshift_client as oc # pyright: ignore[reportMissingImports]
import semver # pyright: ignore[reportMissingImports]
import re
import time
import sys


class resources:
    def get(object_name: str):
        object_selector = oc.selector(
            [f"{object_name}"]
        )
        object = None
        if object_selector.objects():
            object = object_selector.objects()[0]
        return object

    def wait(object_name: str):
        object_selector = oc.selector(
            [f"{object_name}"]
        )
        object = None
        if object_selector.objects():
            object = object_selector.objects()[0]
        else:
            time.sleep(20)
        return object

    def get_status(object: oc.APIObject):
        return object.model.status

class labels:
    def get(object: oc.APIObject):
        return object.model.metadata.labels

    def patch(object: oc.APIObject, key: str, value: str):
        result = object.patch(
            {"metadata": {"labels":{key: value}}}, strategy="merge", cmd_args=["-o=yaml"]
        )
        return result.status() == 0


class logging:
    def success_and_exit(message: str):
        """Print success message and exit"""
        print()
        print(f"SUCCESS: {message}")
        sys.exit(0)

    def error_and_exit(message: str, code: int = 1):
        """Print and error and exit"""
        print()
        print(f"ERROR: {message}")
        sys.exit(code)


class annotations:
    def get(object: oc.APIObject):
        return object.model.metadata.annotations

    def patch(object: oc.APIObject, key: str, value: str):
        result = object.patch(
            {"metadata": {"annotations":{key: value}}}, strategy="merge", cmd_args=["-o=yaml"]
        )
        return result.status() == 0

    def verify(object: oc.APIObject, key: str, value: str):
        search_key = object.model.metadata.annotations[key]
        while search_key is oc.Missing:
            object.refresh()
            time.sleep(10)
        if search_key == value:
            return True
        return False
