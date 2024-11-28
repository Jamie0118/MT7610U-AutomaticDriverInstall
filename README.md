
# MT7610U Driver Installation Script

## Description

This script automates the installation of drivers for the **MT7610U chipset-based USB Wi-Fi adapters** on Linux systems. It handles compatibility checks, installs necessary packages, updates the system, and compiles the drivers from the source.

### Supported USB Adapters
The following USB Wi-Fi adapters are supported by this driver:

- **Ralink**: `{USB_DEVICE(0x148F,0x7610)}`
- **MediaTek/Sabrent**: `{USB_DEVICE(0x0E8D,0x7610)}`
- **Cisco Linksys AE6000**: `{USB_DEVICE(0x13B1,0x003E)}`
- **Edimax 7711ULC/7711MAC**: `{USB_DEVICE(0x7392,0xA711)}`
- **Elecom WDC-433SU2M**: `{USB_DEVICE(0x7392,0xB711)}`
- **TP-LINK Archer T2U(H)**: `{USB_DEVICE(0x148F,0x761A)}` (tested, working)
- **TP-LINK**: `{USB_DEVICE(0x148F,0x760A)}`
- **ASUS USB-AC51**: `{USB_DEVICE(0x0B05,0x17D1)}`
- **ASUS USB-AC50**: `{USB_DEVICE(0x0B05,0x17DB)}`
- **Edimax EW-7811UTC AC600 / Sitecom WLA-3100**: `{USB_DEVICE(0x0DF6,0x0075)}`
- **D-Link DWA-171 rev B1**: `{USB_DEVICE(0x2001,0x3D02)}`
- **ZyXEL NWD6505**: `{USB_DEVICE(0x0586,0x3425)}`
- **AboCom AU7212**: `{USB_DEVICE(0x07B8,0x7610)}`
- **IO DATA WN-AC433UK**: `{USB_DEVICE(0x04BB,0x0951)}`
- **Comcast Xfinity KXW02AAA**: `{USB_DEVICE(0x293C,0x5702)}`
- **Planex GW-450D/GW-450D-KATANA**: `{USB_DEVICE(0x2019,0xAB31)}`
- **TRENDnet TEW-806UBH AC600**: `{USB_DEVICE(0x20F4,0x806B)}`

## Usage
  
1. Download the script:
   ```bash
   git clone https://github.com/Jamie0118/Ralink-RT5370N-AutomaticDriverInstall
   cd Ralink-RT5370N-AutomaticDriverInstall
   ```
2. Make the script executable:

   ```bash
   chmod +x Ralink-RT5370N-AutomaticDriverInstall.sh
   ```

3. Run the script with root privileges:

   ```bash
   sudo ./Ralink-RT5370N-AutomaticDriverInstall.sh
   ```

4. Follow the prompts to complete the installation.

5. Reboot the system to apply changes.
