# Read Credict Card Schumer Boxes using Base64.ai

This example demonstrates how to use RPA Frameworks' RPA.DocumentAI library to extract structured data from credit card [Schumber Box](https://en.wikipedia.org/wiki/Schumer_box). The implementation uses a pre-trained model provided by the [Base64.ai](https://base64.ai/).

## Prerequisites

- Robocorp [Control Room](https://cloud.robocorp.com/) account
- [Base64.ai](https://base64.ai/) account (free trial plans available at the time of creating this example)
- Base64.ai API credentials configured to Control Room Vault under name `Base64` with two keys: `email` and `api-key`.

## Running the example

The example is isolated to only demonstrate the data extraction part, and does not contain any document ingestion or further business logic. These parts would be contextual to your own use case.

The example contains an input work item that has three example Schumber Boxes. When running in either VS Code or after setting up the process in Control Room, use the input work item files to input documents to the process. Robot supports jpg, png and pdf files.

The robot writes extracted and summarized data from each of the input work item files in the output work item, and the full extraction result in the output artifacts with `original-file-name.json`.