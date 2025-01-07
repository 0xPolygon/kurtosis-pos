#!/usr/bin/env bash
set -euo pipefail

# Discover the different participants of a PoS devnet inside a Kurtosis enclave.
# Get the different services names as well as the L1, L2 EL/CL rpc urls.

TMP_FOLDER="tmp"
mkdir -p "${TMP_FOLDER}"

CL_SERVICES_FILE="cl_services.txt"
EL_SERVICES_FILE="el_services.txt"

# Check the environment variables.
if [[ -z "${ENCLAVE}" ]]; then
  echo "Error: ENCLAVE environment variable is not set"
  exit 1
fi

# Get CL rpc urls.
echo -n "Getting CL rpc urls... "
declare -a cl_services
declare -a cl_rpc_urls
while IFS= read -r cl_service; do
  cl_services+=("${cl_service}")
  url=$(kurtosis --cli-log-level info port print "${ENCLAVE}" "${cl_service}" rpc)
  cl_rpc_urls+=("${url}")
done < <(kurtosis --cli-log-level info enclave inspect "${ENCLAVE}" --full-uuids \
  | grep -E "l2-cl-[0-9]+-.*-(validator|rpc)" \
  | grep -v "config" \
  | awk '{print $2}')

# Sanity check.
if [ "${#cl_services[@]}" -ne "${#cl_rpc_urls[@]}" ]; then
  echo "Error: The numbers of CL services is not the same as the number of CL RPC URLs."
  exit 1
fi
if [ "${#cl_services[@]}" -eq 0 ]; then
  echo "Error: Unable to get any l2 CL rpc service or rpc url... Are there any CL nodes deployed?"
  exit 1
fi

echo "Found ${#cl_services[@]}."

# Save CL services and urls to file.
{
  for i in "${!cl_services[@]}"; do
    echo "${cl_services[$i]}=${cl_rpc_urls[$i]}"
  done
} > "${TMP_FOLDER}/${CL_SERVICES_FILE}"
echo "Saved at ${TMP_FOLDER}/${CL_SERVICES_FILE}"

# Get EL rpc urls.
echo -n "Getting EL rpc urls... "
declare -a el_services
declare -a el_rpc_urls
while IFS= read -r el_service; do
  el_services+=("${el_service}")
  url=$(kurtosis --cli-log-level info port print "${ENCLAVE}" "${el_service}" rpc)
  el_rpc_urls+=("${url}")
done < <(kurtosis --cli-log-level info enclave inspect "${ENCLAVE}" --full-uuids \
  | grep -E "l2-el-[0-9]+-.*-(validator|rpc)" \
  | grep -v "config" \
  | awk '{print $2}')

# Sanity checks.
if [ "${#el_services[@]}" -ne "${#el_rpc_urls[@]}" ]; then
  echo "The numbers of EL services is not the same as the number of EL RPC URLs."
  exit 1
fi
if [ "${#el_services[@]}" -eq 0 ]; then
  echo "Error: Unable to get any L2 EL rpc service or rpc url... Are there any EL nodes deployed?"
  exit 1
fi
if [ "${#cl_services[@]}" -ne "${#el_services[@]}" ]; then
  echo "The numbers of EL services is not the same as the number of CL services."
  exit 1
fi

echo "Found ${#el_services[@]}."

# Save EL services and urls to file.
{
  for i in "${!el_services[@]}"; do
    echo "${el_services[$i]}=${el_rpc_urls[$i]}"
  done
} > "${TMP_FOLDER}/${EL_SERVICES_FILE}"
echo "Saved at ${TMP_FOLDER}/${EL_SERVICES_FILE}"
echo
