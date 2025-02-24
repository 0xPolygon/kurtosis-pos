#!/usr/bin/env bash
set -euo pipefail

# Discover the different participants of a PoS devnet inside a Kurtosis enclave.
# Get the different services names as well as L2 CL RPC/API and L2 EL RPC urls.

TMP_FOLDER="tmp"
mkdir -p "${TMP_FOLDER}"

L1_RPC_FILE="l1_rpc.txt"
L2_CL_RPCS_FILE="l2_cl_rpcs.txt"
L2_CL_APIS_FILE="l2_cl_apis.txt"
L2_EL_RPCS_FILE="l2_el_rpcs.txt"

# Check the environment variables.
if [[ -z "${ENCLAVE}" ]]; then
  echo "Error: ENCLAVE environment variable is not set"
  exit 1
fi

# Get L1 EL rpc url.
echo -n "Getting L1 EL RPC url... "
l1_rpc_url="http://$(kurtosis port print "${ENCLAVE}" el-1-geth-lighthouse rpc)"
if [[ "${l1_rpc_url}" == "" ]]; then
  echo "Error: Unable to get the L1 RPC URL... Is the L1 devnet deployed?"
  exit 1
fi
echo "Found."
echo "${l1_rpc_url}" >${TMP_FOLDER}/${L1_RPC_FILE}
echo "Saved at ${TMP_FOLDER}/${L1_RPC_FILE}"

# Get L2 CL rpc urls.
echo -n "Getting L2 CL RPC and API urls... "
declare -a cl_services
declare -a cl_rpc_urls
declare -a cl_api_urls
while IFS= read -r cl_service; do
  cl_services+=("${cl_service}")
  rpc_url=$(kurtosis --cli-log-level info port print "${ENCLAVE}" "${cl_service}" rpc)
  api_url=$(kurtosis --cli-log-level info port print "${ENCLAVE}" "${cl_service}" http)
  cl_rpc_urls+=("${rpc_url}")
  cl_api_urls+=("${api_url}")
done < <(kurtosis --cli-log-level info enclave inspect "${ENCLAVE}" --full-uuids | grep RUNNING |
  grep -E "l2-cl-[0-9]+-.*" |
  grep -v "rabbitmq" |
  awk '{print $2}')

# Sanity check.
if [ "${#cl_services[@]}" -eq 0 ]; then
  echo "Error: Unable to get any l2 CL rpc service or rpc url... Are there any CL nodes deployed?"
  exit 1
fi
if [ "${#cl_services[@]}" -ne "${#cl_rpc_urls[@]}" ]; then
  echo "Error: The numbers of CL services (${#cl_services[@]}) is not the same as the number of CL RPC URLs (${#cl_rpc_urls[@]})."
  exit 1
fi
if [ "${#cl_services[@]}" -ne "${#cl_api_urls[@]}" ]; then
  echo "Error: The numbers of CL services (${#cl_services[@]}) is not the same as the number of CL API URLs (${#cl_api_urls[@]})."
  exit 1
fi
echo "Found ${#cl_services[@]} node."

# Save CL services and urls to file.
{
  for i in "${!cl_services[@]}"; do
    echo "${cl_services[$i]}=${cl_rpc_urls[$i]}"
  done
} >"${TMP_FOLDER}/${L2_CL_RPCS_FILE}"
echo "Saved at ${TMP_FOLDER}/${L2_CL_RPCS_FILE}"
{
  for i in "${!cl_services[@]}"; do
    echo "${cl_services[$i]}=${cl_api_urls[$i]}"
  done
} >"${TMP_FOLDER}/${L2_CL_APIS_FILE}"
echo "Saved at ${TMP_FOLDER}/${L2_CL_APIS_FILE}"

# Get L2 EL rpc urls.
echo -n "Getting L2 EL RPC urls... "
declare -a el_services
declare -a el_rpc_urls
while IFS= read -r el_service; do
  el_services+=("${el_service}")
  rpc_url=$(kurtosis --cli-log-level info port print "${ENCLAVE}" "${el_service}" rpc)
  el_rpc_urls+=("${rpc_url}")
done < <(kurtosis --cli-log-level info enclave inspect "${ENCLAVE}" --full-uuids | grep RUNNING |
  grep -E "l2-el-[0-9]+-.*-(validator|rpc)" |
  grep -v "config" |
  awk '{print $2}')

# Sanity checks.
if [ "${#el_services[@]}" -eq 0 ]; then
  echo "Error: Unable to get any L2 EL rpc service or rpc url... Are there any EL nodes deployed?"
  exit 1
fi
if [ "${#el_services[@]}" -ne "${#el_rpc_urls[@]}" ]; then
  echo "The numbers of EL services (${#el_services[@]}) is not the same as the number of EL RPC URLs (${#el_rpc_urls[@]})."
  exit 1
fi
echo "Found ${#el_services[@]} node."

# Save EL services and urls to file.
{
  for i in "${!el_services[@]}"; do
    echo "${el_services[$i]}=${el_rpc_urls[$i]}"
  done
} >"${TMP_FOLDER}/${L2_EL_RPCS_FILE}"
echo "Saved at ${TMP_FOLDER}/${L2_EL_RPCS_FILE}"
