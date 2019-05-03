# VxWorks® 7 Client for Azure IoT SDK for C

## Overview

This document provides a quick summary of how to build and run the **Azure IoT** device software development kit (SDK) for C that resides in VxWorks 7 on your device. The SDK is an embedded C client library for interacting with the Azure IoT platform. This client library is not provided in VxWorks 7 RPM packages or on the VxWorks 7 product DVDs. You need to manually install this library on VxWorks 7.

Release note:
    The version 1.0.0.x has been validated with VxWorks 7 SR0610.

### Project License

The license for this project is the MIT License. Text of MIT license and other applicable license notices can be found in the LICENSE_NOTICES.txt file in the top level directory. Each source files should include a license notice that designates the licensing terms for the respective file.

### Prerequisite

You must have a subscription to Azure Cloud to try the samples.  To create an Azure free account please visit https://azure.microsoft.com/ and click the "Start free >" button.

Before installing the SDK prepare the development environment.
1. Install git and ensure it operates from the command line.
2. Install cmake and ensure it operates from the command line.
3. Ensure the VxWorks 7 DVD is installed.
4. Ensure the **Azure IoT** device SDK for C source code is available from the following location:

   https://github.com/Azure/azure-iot-sdk-c/

## Installing the SDK

1. Download the **VxWorks 7 Azure IoT SDK** layer from the following location:

   git clone https://github.com/Wind-River/vxworks7-layer-for-azure-iot-sdk-c

2. Set WIND_LAYER_PATHS to point to the vxworks7-layer-for-azure-iot-sdk-c directory.  Command-line
   users may set this directly using export on Linux or set on Windows.  Developers working on a Microsoft Windows host may also set the system environment variables.  On Microsoft Windows 10, these can be found in the Control Panel under View advanced system Settings.  Click the "Advanced" tab to find the "Environment Variables" button.  From here you may set WIND_LAYER_PATHS to point to the vxworks7-layers-for-azure-iot-sdk-c.  Please refer to the VxWorks documentation for details on the WIND_LAYER_PATHS variable.

3. Confirm the layer is present in your VxWorks 7 installation.

   In a VxWorks development shell, you may run "vxprj vsb listAll" and look for AZURE_IOT_SDK_1_0_0_0 to confirm that the layer has been found.

## Creating the VSB and VIP Using WrTool

Create the VxWorks 7 VxWorks source build (VSB) and VxWorks image project (VIP) using either the Wind River Workbench environment or the command line tool **WrTool**. This procedure uses the *vxsim_linux* board support package (BSP) as an example.

1. Set the environment variable and change the directory.

        export WIND_WRTOOL_WORKSPACE=$HOME/WindRiver/workspace
        cd $WIND_WRTOOL_WORKSPACE

2. Create the VSB using the **WrTool**.

        wrtool prj vsb create -force -bsp vxsim_linux myVSB -S
        cd myVSB
        wrtool prj vsb add AZURE_IOT_SDK
        make -j[jobs]  <-- set the number of parallel build jobs, typically 2, 4, 8
        cd ..

3. Create the VIP using the **WrTool**.

        wrtool prj vip create -force -vsb myVSB -profile PROFILE_STANDALONE_DEVELOPMENT vxsim_linux llvm myVIP
        cd myVIP
        wrtool prj vip component add INCLUDE_SHELL INCLUDE_NETWORK INCLUDE_IFCONFIG INCLUDE_PING INCLUDE_IPDNSC
        wrtool prj vip component add INCLUDE_POSIX_PTHREAD_SCHEDULER  INCLUDE_DEFAULT_TIMEZONE
        wrtool prj vip parameter set DNSC_PRIMARY_NAME_SERVER   "\"1.1.1.1\""
        wrtool prj vip parameter set DNSC_SECONDARY_NAME_SERVER "\"1.0.0.1\""
        cd ..

The test sample is provided in the Azure IoT SDK as *iothub_client/samples/iothub_convenience_sample/iothub_convenience_sample.c*. It can be used to connect your device to the Azure IoT cloud, publish telemetry to the cloud and to receive commands from the Azure IoT cloud. To enable this sample, you need to create an RTP project.

## Creating the RTP Using WrTool

1. Create an RTP project based on myVSB.

        wrtool prj rtp create -vsb myVSB myRTP

2. Add the file for iothub_convenience_sample.

        wrtool prj file add $WIND_WRTOOL_WORKSPACE/myVSB/3pp/AZURE_IOT_SDK/src/iothub_client/samples/iothub_convenience_sample/iothub_convenience_sample.c

3. Delete the sample rtp.c file

        wrtool prj file delete rtp.c

3. Add the sample trusted certificates.

        wrtool prj file add $WIND_WRTOOL_WORKSPACE/myVSB/3pp/AZURE_IOT_SDK/src/certs/certs.h
        wrtool prj file add $WIND_WRTOOL_WORKSPACE/myVSB/3pp/AZURE_IOT_SDK/src/certs/certs.c

4. Add the azureiot include directory.

        wrtool prj include add '-I$(VSB_DIR)/usr/h/public/azureiot' myRTP

5. Add the usr/lib/common library directory.

        wrtool prj lib add '-L$(VSB_DIR)/usr/lib/common' myRTP

6. Add the static library dependencies.

        wrtool prj lib add '-liothub_client' myRTP
        wrtool prj lib add '-laziotsharedutil' myRTP
        wrtool prj lib add '-lOPENSSL' myRTP
        wrtool prj lib add '-lHASH' myRTP
        wrtool prj lib add '-lcurl' myRTP
        wrtool prj lib add '-lzlib' myRTP
        wrtool prj lib add '-lparson' myRTP
        wrtool prj lib add '-lnet' myRTP
        wrtool prj lib add '-lumqtt' myRTP
        wrtool prj lib add '-liothub_client_mqtt_transport' myRTP

7. Build the RTP

        wrtool prj build myRTP

8. Follow the instructions on the Azure IoT Hub Quickstart to set up the Azure Cloud.

    https://docs.microsoft.com/en-us/azure/iot-hub/quickstart-send-telemetry-c

9. Copy the connection string created by Azure Cloud for your device.
10. Open the sample file iothub_convenience_sample.c in myRTP.
11. Paste the connection string into the connectionstring variable on line 52.
12. Deploy it to your target

## Viewing the Device Information on the Azure IoT Dashboard

Follow the remaining instructions in the Azure IoT Hub Quickstart to log into Azure Cloud
and use the Azure Cloud Shell to monitor the events coming from your device.

* For information on what Azure IoT is, see the following information:

    https://azure.microsoft.com/en-ca/services/iot-hub/

* For information on how to use the C SDK, see the following information:
    https://github.com/Azure/azure-iot-sdk-c

### Legal Notices

All product names, logos, and brands are property of their respective owners. All company, product and service names used in this software are for identification purposes only. Wind River and VxWorks are a registered trademarks of Wind River Systems. Microsoft and Azure are registered trademarks of the Microsoft Corporation.

Disclaimer of Warranty / No Support: Wind River does not provide support and maintenance services for this software, under Wind River’s standard Software Support and Maintenance Agreement or otherwise. Unless required by applicable law, Wind River provides the software (and each contributor provides its contribution) on an “AS IS” BASIS, WITHOUT WARRANTIES OF ANY KIND, either express or implied, including, without limitation, any warranties of TITLE, NONINFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE. You are solely responsible for determining the appropriateness of using or redistributing the software and assume ay risks associated with your exercise of permissions under the license.
