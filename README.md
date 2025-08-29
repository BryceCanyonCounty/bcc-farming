# BCC Farming 🌱

*Advanced Agricultural System for RedM*

**Transform your RedM server with immersive farming mechanics** - from planting seeds to harvesting crops, with realistic gameplay elements.

---

## 🌟 Key Features

### **🌿 Core Farming System**

- **Unlimited Custom Crops**: Create any number of plant types with unique growth cycles and yields
- **Resource Management**:
  - Soil requirements with configurable amounts
  - Fertilizer system for growth acceleration
  - Watering mechanics with bucket depletion (auto-replaced with empty buckets)
- **Ownership System**: Configurable plant locking (planter-only or public access)

### **🔧 Advanced Configuration**

- **Job Restrictions**: Lock plants to specific professions (farmer, outlaw, etc.)
- **Zone Control**: Town proximity restrictions with adjustable radii
- **Tool Requirements**: Specify required equipment per crop type
- **Economic Balancing**: Configure required seed and soil amounts as well as harvest yields
- **Player Limits**: Set maximum plants per player

### **💻 Technical Implementation**

- **Database Backed**: Persistent storage across server restarts
- **Localization Ready**: Full multilingual support
- **Update Notifications**: Built-in version checker

### **🎮 Gameplay Enhancements**

- **Interactive UI**: Intuitive prompts for all farming actions
- **Debug System**: Color-coded logging for easy troubleshooting

*Every feature is configurable through simple, well-documented config files.*

---

## 📋 Requirements

### **Core Dependencies**

- [vorp_core](https://github.com/VORPCORE/vorp-core-lua)
- [vorp_inventory](https://github.com/VORPCORE/vorp_inventory-lua)
- [vorp_character](https://github.com/VORPCORE/vorp_character-lua)
- [bcc-utils](https://github.com/BryceCanyonCounty/bcc-utils)

### **Recommended Addon**

- [bcc-water](https://github.com/BryceCanyonCounty/bcc-water) *(for bucket filling functionality)*

---

## 🛠 Installation Guide

### **1. Prepare Your Server**

```bash
# Ensure all dependencies are installed and updated
ensure vorp_core
ensure vorp_inventory
ensure vorp_character
ensure bcc-utils
```

### **2. Install BCC Farming**

1. Place the `bcc-farming` folder in your `resources` directory
2. Add to your `server.cfg`:

   ```cfg
   ensure bcc-farming
   ```

### **3. Database Setup**

Import the included SQL file: `bcc-farming.sql`

### **4. Asset Installation**

Copy images to your inventory system:
```
\vorp_inventory\html\img\items\*.png
```

### **5. Final Steps**

- Configure settings in `config.lua`
- Restart your server

---

## 🙏 Credits & Inspiration

Original concept inspired by 'prp_farming' - completely rebuilt with enhanced features and optimizations.

**Maintained by:** [BryceCanyonCounty](https://github.com/BryceCanyonCounty)

---
*For support, issues, or contributions, visit our [Discord](https://discord.gg/bNDpwruqwX) or [GitHub repository](https://github.com/BryceCanyonCounty/bcc-farming)*

---
