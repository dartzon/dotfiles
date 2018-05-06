import sys

class VStringPrinter:
    def __init__(self, val):
        self.val = val

    def to_string (self):

        if not self.val:
            return "0x0"

        fString = self.val["fString"]
        fLength = self.val["fLength"]

        strVal = "{\"" + fString.cast(gdb.lookup_type('char16_t').pointer()).string() + "\"";
        strVal += ", length = " + str(fLength) + "}"

        return strVal

class VErrorPrinter:
    def __init__(self, val):
        self.val = val

    def to_string (self):

        strVal = ""

        if self.val == 0:
            strVal = "OK"
        else:
            strVal = "Error"

        return strVal

class VFilePrinter:
    def __init__(self, val):
        self.val = val

    def to_string (self):

        if not self.val:
            return "0x0"

        fFullPath = self.val['fPath']['fFullPath']

        return fFullPath

class VPathPrinter:
    def __init__(self, val):
        self.val = val

    def to_string (self):

        if not self.val:
            return "0x0"

        fFullPath = self.val['fFullPath']

        return fFullPath

class VFolderPrinter:
    def __init__(self, val):
        self.val = val

    def to_string (self):

        if not self.val:
            return "0x0"

        fPath = self.val['fPath']

        return fPath

def lookup_type (val):
    if "VFilePath" in str(val.type):
        return VPathPrinter(val)

    if "VFile" in str(val.type):
        return VFilePrinter(val)

    if "VFolder" in str(val.type):
        return VFolderPrinter(val)

    if "VString" in str(val.type):
        return VStringPrinter(val)

    elif "VError" in str(val.type):
        return VErrorPrinter(val)

    return None

gdb.pretty_printers.append (lookup_type)
