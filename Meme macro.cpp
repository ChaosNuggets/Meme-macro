#include <windows.h>
#include <unordered_map>
#include <chrono>
#include <thread>
#include <vector>
#include <iostream>

const char* getTypeStr(DWORD type)
{
    if (type == RIM_TYPEMOUSE) return "mouse";
    else if (type == RIM_TYPEKEYBOARD) return "keyboard";
    else return "HID";
}

void sendKey(const HWND window, const HANDLE keyboard, const WPARAM key, const bool down = true) {
    const std::unordered_map<WPARAM, LPARAM> lParams = { // What LParam each WParam should correspond to
        {'W', 0x00110001},
        {'E', 0x00120001},
        {'S', 0x001F0001}
    };
    
    if (down) {
        HGLOBAL hRaw = ::GlobalAlloc(GHND, sizeof(RAWINPUT));
        RAWINPUT *pRaw = reinterpret_cast<RAWINPUT*>(::GlobalLock(hRaw));

        // initialize the structure using pRaw
        char c = 'W';
        //header
        pRaw->header.dwSize = sizeof(RAWINPUT);
        pRaw->header.dwType = RIM_TYPEKEYBOARD;
        pRaw->header.wParam = 0; //(wParam & 0xff =0 => 0)
        pRaw->header.hDevice = keyboard;

        //data
        pRaw->data.keyboard.Reserved = 0;
        pRaw->data.keyboard.Flags = RI_KEY_MAKE;      //Key down
        pRaw->data.keyboard.MakeCode = static_cast<WORD>(MapVirtualKeyEx(c, MAPVK_VK_TO_VSC, GetKeyboardLayout(0)));
        pRaw->data.keyboard.Message = WM_KEYDOWN;
        pRaw->data.keyboard.VKey = VkKeyScanEx(c, GetKeyboardLayout(0));
        pRaw->data.keyboard.ExtraInformation = 0;         //???
        ::GlobalUnlock(hRaw);

        // use hRaw as the LPARAM
        PostMessageA(window, WM_INPUT, 0, (LPARAM)hRaw);
        PostMessageA(window, WM_KEYDOWN, key, lParams.at(key));
    } else {
        PostMessageA(window, WM_KEYUP, key, lParams.at(key) + 0xC0000000);
    }
}

int main() {
    using namespace std::this_thread;
    using namespace std::chrono_literals;

    UINT32 deviceCnt;
    int keyboardNum;
    std::string input;

    // Log the connected devices.
    GetRawInputDeviceList(nullptr, &deviceCnt, sizeof(RAWINPUTDEVICELIST));

    std::vector<RAWINPUTDEVICELIST> devices{ deviceCnt };
    GetRawInputDeviceList(devices.data(), &deviceCnt, sizeof(RAWINPUTDEVICELIST));

    for (int i = devices.size() - 1; i >= 0; i--) {
        if (devices[i].dwType != RIM_TYPEKEYBOARD) {
            devices.erase(devices.begin() + i);
        }
    }

    for (int i = 0; i < devices.size(); i++) {
        printf("%s %d: [0x%p] active\n", getTypeStr(devices[i].dwType), i, devices[i].hDevice);
    }

    std::cout << "Choose a keyboard -> ";
    std::getline(std::cin, input);
    keyboardNum = stoi(input);

    LPCSTR window_name = "Roblox";
    // LPCSTR window_name = "*Untitled - Notepad";

    HWND window = FindWindowA(NULL, window_name);

    sleep_for(3s);
    sendKey(window, devices[keyboardNum].hDevice, 'W');
    sleep_for(1.5s);
    sendKey(window, devices[keyboardNum].hDevice, 'W', false);

    return 0;
}