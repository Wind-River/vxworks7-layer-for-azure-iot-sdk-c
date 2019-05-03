# Copyright (c) 2019 Wind River Systems, Inc.
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the ""Software""), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

CMAKE_FILES = \
$(VSBL_SRC_DIR)/$(PKG_SRC_DIR)/c-utility/configs/azure_iot_build_rules.cmake \
$(VSBL_SRC_DIR)/$(PKG_SRC_DIR)/deps/uhttp/CMakeLists.txt \
$(VSBL_SRC_DIR)/$(PKG_SRC_DIR)/deps/azure-ctest/CMakeLists.txt \
$(VSBL_SRC_DIR)/$(PKG_SRC_DIR)/deps/umock-c/CMakeLists.txt \
$(VSBL_SRC_DIR)/$(PKG_SRC_DIR)/CMakeLists.txt \
$(VSBL_SRC_DIR)/$(PKG_SRC_DIR)/provisioning_client/tests/common_prov_e2e/prov_hsm/CMakeLists.txt \
$(VSBL_SRC_DIR)/$(PKG_SRC_DIR)/provisioning_client/samples/custom_hsm_example/CMakeLists.txt

LIBRARY_FILES = \
$(VSBL_SRC_DIR)/$(PKG_BUILD_DIR)/c-utility/libaziotsharedutil.a \
$(VSBL_SRC_DIR)/$(PKG_BUILD_DIR)/deps/uhttp/libuhttp.a \
$(VSBL_SRC_DIR)/$(PKG_BUILD_DIR)/iothub_client/libiothub_client.a \
$(VSBL_SRC_DIR)/$(PKG_BUILD_DIR)/iothub_client/libiothub_client_amqp_transport.a \
$(VSBL_SRC_DIR)/$(PKG_BUILD_DIR)/iothub_client/libiothub_client_amqp_ws_transport.a \
$(VSBL_SRC_DIR)/$(PKG_BUILD_DIR)/iothub_client/libiothub_client_http_transport.a \
$(VSBL_SRC_DIR)/$(PKG_BUILD_DIR)/iothub_client/libiothub_client_mqtt_transport.a \
$(VSBL_SRC_DIR)/$(PKG_BUILD_DIR)/iothub_client/libiothub_client_mqtt_ws_transport.a \
$(VSBL_SRC_DIR)/$(PKG_BUILD_DIR)/serializer/libserializer.a \
$(VSBL_SRC_DIR)/$(PKG_BUILD_DIR)/uamqp/libuamqp.a \
$(VSBL_SRC_DIR)/$(PKG_BUILD_DIR)/umqtt/libumqtt.a \
$(VSBL_SRC_DIR)/$(PKG_BUILD_DIR)/iothub_service_client/libiothub_service_client.a \
$(VSBL_SRC_DIR)/$(PKG_BUILD_DIR)/deps/umock-c/libumock_c.a \
$(VSBL_SRC_DIR)/$(PKG_BUILD_DIR)/libparson.a \
