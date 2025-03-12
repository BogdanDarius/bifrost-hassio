### 2025-03-11: `chrivers/zigbee-docs`

This merge request introduces significant enhancements to the documentation of the Bifrost project, specifically focusing on the reverse engineering and detailed description of the Hue Zigbee message formats.

1. **New Document: Hue Zigbee Clusters**
    - Added `hue-zigbee-clusters.md`, providing comprehensive information on custom Zigbee messages for Hue devices, focusing on lights.
    - Covers clusters such as Hue Button events, Entertainment zones, Gradients, Effects, and Animations.
    - Includes detailed descriptions of cluster-specific commands and attributes with byte structures and examples.

2. **Entertainment Clusters Documentation**
    - Detailed documentation of the Entertainment cluster (0xFC01), describing commands for updating entertainment zones, synchronizing entertainment zones, retrieving segment mappings, and configuring segments for entertainment mode.
    - Provides byte structures and examples for these commands.

3. **Gradients, Effects, and Animations Clusters**
    - Descriptions of the Gradients, Effects, and Animations cluster (0xFC03), including combined state commands and various attributes.
    - Sample values and descriptions help identify properties supported by different Hue devices.

4. **Enhancements to Existing Documentation**
    - Updated `hue-zigbee-format.md` with clarifications and additional details.
    - Improvements include specifying `zigbee::EffectType`, adding examples for unpacking and packing color coordinates, and refining scaling values for color coordinates.
