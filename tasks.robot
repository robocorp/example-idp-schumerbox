*** Settings ***
Documentation       Read files from input work items.
...                 Extract Schumer box data from pdf, jpg and png files.
...                 Store output as artifact, and summarize in output work item.
Library             RPA.Robocorp.WorkItems
Library             RPA.FileSystem
Library             RPA.Robocorp.Vault
Library             RPA.DocumentAI.Base64AI
Library             RPA.JSON

*** Variables ***
# Supported extensions
@{extensions}       .jpg    .jpeg    .png    .pdf

*** Tasks ***
Read Schumer Boxes from input work item files
    For Each Input Work Item    Extract Schumer Boxes

*** Keywords ***
Extract Schumer Boxes
    [Documentation]
    ...     Extract Schumer box data from pdf, jpg and png files.
    ...     Write cleaned output to output work item.
    ...     Store original response as artifact.

    ${paths}=    Get Work Item Files    *

    FOR    ${path}    IN    @{paths}

        # Take only file extension
        ${fileext}=    Get File Extension    ${path}

        IF     $fileext.lower() in $extensions
            Log To Console    Working on file: ${path}

            # Base64.ai authentication
            ${base64_secret}=    Get Secret    Base64
            Set Authorization  ${base64_secret}[email]   ${base64_secret}[api-key]

            ${response}=  Scan Document File
            ...  ${path}
            ...  model_types=finance/credit_card_terms

            Log    Extracted using model ${response}[0][model]

            # Take the name of the file to use for resulting json
            ${filename}=    Get File Stem    ${path}
            Save JSON to file    ${response}[0]    ${OUTPUT_DIR}${/}${filename}.json

            ${short_output}=    Results cleanup    ${response}
            Create Output Work Item    variables=${short_output}
            Save Work Item
        ELSE
            Log To Console    Skipping file: ${path}
        END

    END
    Release Input Work Item    DONE

Results cleanup
    [Documentation]    Creates a simplified output work item that
    ...                contains only key fields from the extracted data.
    [Arguments]        ${response}

    # TODO: Implement more complex logic to extract only the relevant fields.
    ${output}=         Set Variable    ${response}[0][fields]
    [Return]           ${output}