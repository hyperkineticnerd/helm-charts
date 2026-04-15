#!/usr/bin/python3

import os
import time
import asyncio
import json
import openshift_client as oc


OBJECT = os.getenv("OBJECT_NAME")
TIMEOUT= os.getenv("TIMEOUT") or 60
PATCH = os.getenv("PATCH")

async def resource_object():
    object = None
    while not object:
        selector = oc.selector(
            [f"{OBJECT}"]
        )
        if selector.objects():
            object = selector.objects()[0]
    return object

async def wait_for_resource(selector):
    await selector.objects()


def patch(object: oc.APIObject, patch: str):
    return object.patch(patch, strategy="merge", cmd_args=["-o=yaml"])


def json_string_to_dict(json_string):
    return json.loads(json_string)


async def main():
    object = resource_object(OBJECT)
    json_patch = json.loads(PATCH)
    asyncio.wait_for(wait_for_resource(object), timeout=TIMEOUT)
    patch(object, json_patch)


if __name__ == "__main__":
    asyncio.run(main())
